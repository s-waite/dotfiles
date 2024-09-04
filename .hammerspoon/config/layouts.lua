local combo = { "cmd", "ctrl", "alt", "shift" }
local choices = {
    {
        ["text"] = "java mvc project",
        ["keyword"] = "javaFinal"
    },
    {
        ["text"] = "Second Option",
        ["subText"] = "I wonder what I should type here?",
        ["uuid"] = "Bbbb"
    },
    {
        ["text"] = hs.styledtext.new("Third Possibility", { font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.green }),
        ["subText"] = "What a lot of choosing there is going on here!",
        ["uuid"] = "III3"
    },
}

local function makeCommand(command, urlTable)
    for _, value in pairs(urlTable) do
        command = command .. " " .. value
    end
    return command
end

local layoutChooser = hs.chooser.new(function(choice)
    local urls = {}
    local paths = {}
    local keyword = choice["keyword"]

    if keyword == "javaFinal" then
        urls = { "https://my.wgu.edu/courses/course/24040006", "https://tasks.wgu.edu/student/001338106/course/24040006/task/2896/overview", "https://srm--c.na127.visual.force.com/apex/coursearticle?Id=kA03x000000yIOaCAM", "https://srm--c.na127.visual.force.com/apex/coursearticle?Id=kA03x000000yIOQCA2" }
        paths = { "/Users/sam/WGU/CP_1/finalProj" }
        hs.application.open("org.mozilla.firefox")
        hs.osascript.applescript('tell application "System Events" to tell process "Firefox" to click menu item "New Window" of menu "File" of menu bar 1')
        hs.execute(makeCommand("open", urls))
        hs.execute(makeCommand("code", paths), true)
    end
end)
layoutChooser:choices(choices)

hs.hotkey.bind(combo, "\\", function()
    layoutChooser:show()
end)
