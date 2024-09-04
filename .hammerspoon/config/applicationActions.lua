-- FINDER -----------------------------------------------------------
local finderApp = hs.application.get("Finder")
local focusedWindow = finderApp:focusedWindow()
hs.fs.currentDir()

hs.hotkey.bind("option", "t", function()
    -- returns the path of the selected file in finder, or if no file is selected it returns the open folder
    -- TODO add error handling
    local scriptDidExecute, result, errors = hs.osascript.applescriptFromFile('/Users/sam/Code/s-waite/applescripts/open-finder-contents-vscode.applescript')

    if scriptDidExecute then
        -- the 'true' executes it as though it were an interactive shell
        hs.execute('code ' .. result, true)
    else
        print('Script did not execute successfully')
    end
end)

hs.hotkey.bind("option", "g", function()
    local scriptDidExecute, result, errors = hs.osascript.applescriptFromFile('/Users/sam/Code/s-waite/applescripts/run-file-in-kitty.applescript')
end)
