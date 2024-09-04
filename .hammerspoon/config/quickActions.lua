-- Function to split a string by a delimiter

print("quit actions loaddded")
function splitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

-- Modified function to handle multiple image paths
function convertImagesWithDialog(pathsString)
    local filePaths = splitString(pathsString, ",") -- Split the pathsString by comma
    -- Proceed with asking for width and max size, then loop over filePaths
    hs.dialog.textPrompt("Enter Width", "Enter the desired width for the images:", "", "OK", "Cancel",
        function(button, width)
            if button == "OK" then
                hs.dialog.textPrompt("Enter Max Size", "Enter the desired maximum file size in KB:", "", "OK", "Cancel",
                    function(button, maxSize)
                        if button == "OK" then
                            for _, inputFile in ipairs(filePaths) do
                                convertImage(inputFile, tonumber(width), tonumber(maxSize) * 1024) -- Convert maxSize to bytes
                            end
                        end
                    end)
            end
        end)
end

function convertImage(inputFile, width, maxSize)
    local outputFile = inputFile:gsub("%.%w+$", ".webp") -- Change the extension to .webp
    local quality = 100
    local tempOutputFile = outputFile .. ".tmp"

    while quality >= 1 do
        local cmd = string.format("/opt/homebrew/bin/magick convert '%s' -resize %dx -quality %d '%s'", inputFile, width,
            quality, tempOutputFile)
        hs.execute(cmd)

        local fileSizeCmd = string.format("stat -f%%z '%s'", tempOutputFile)
        local ok, fileSize = hs.execute(fileSizeCmd)
        fileSize = tonumber(fileSize)

        if fileSize <= maxSize then
            hs.execute(string.format("mv '%s' '%s'", tempOutputFile, outputFile))
            hs.alert.show(string.format("Conversion successful: Quality %d, Size %d bytes", quality, fileSize))
            return
        else
            quality = quality - 5
        end
    end

    hs.execute(string.format("[ -f '%s' ] && rm '%s'", tempOutputFile, tempOutputFile))
    hs.alert.show("Unable to achieve the desired size with acceptable quality.")
end
