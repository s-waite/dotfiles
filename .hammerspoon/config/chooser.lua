
FileFinder = hs.chooser.new(function(choice)
	-- If a choice was made
	if choice then
		local filePath = choice["text"]
		if filePath then
			if hs.fs.attributes(filePath, "mode") == "directory" then
				-- Open directories with Finder
				hs.execute("open -R " .. filePath)
			else
				-- Open files with default application
				hs.execute("open " .. filePath)
			end
		end
	end
end)
FileFinder:rows(20)

local fileImage = hs.image.imageFromName(hs.image.systemImageNames.MultipleDocuments)
local folderImage = hs.image.imageFromName(hs.image.systemImageNames.Folder)

local timer = hs.timer.delayed.new(2, function()
	local choices = {}

	local handle = io.popen(
		"/opt/homebrew/bin/fd --type f --type d "
			.. FileChooserQuery
			.. " ~ | awk -F'/' '{print NF-1, length($0), $0}' | sort -n -k1,1 -k2,2 | cut -d' ' -f3- | head -n 20"
	)
	local result = handle:read("*a")
	handle:close()
	print(result)
	for line in string.gmatch(result, "[^\r\n]+") do
		local image
		if hs.fs.attributes(line, "mode") == "directory" then
			image = folderImage
		else
			local uti = hs.fs.fileUTI(line)
			local defaultApp = hs.application.defaultAppForUTI(uti)
			print(defaultApp)
			if defaultApp == nil then
				defaultApp = "com.apple.TextEdit"
			end
			image = hs.image.imageFromAppBundle(defaultApp)
		end
		table.insert(choices, { ["text"] = line, ["image"] = image })
	end
	FileFinder:choices(choices)
end)

local function populateFileChooser(query)
	FileChooserQuery = query
	if timer:running() then
		timer:stop()
	end
	timer:start()
end

FileFinder:queryChangedCallback(populateFileChooser)

hs.hotkey.bind(Meh, "o", function()
	FileFinder:query("")
	FileFinder:show()
	FileFinder:choices({})
end)
