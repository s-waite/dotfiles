-- functions
local function trim1(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- create a "list" with keys (indicies) starting at one (as per lua convention)
-- each list items is a match of the patten in the given string
local function getTableOfOccurrences(myString, pattern)
    local t = {}
    local index = 1
    for match in string.gmatch(myString, pattern) do
        t[index] = match
        index = index + 1
    end
    return t
end

-- parses through each item in a table and returns the index of the focused screen
local function returnActiveScreenIndex(t)
    for _, value in pairs(t) do
        if string.find(value, "has--focus\":true") ~= nil then
            -- search for index and regex for it
            local spaceIndex = string.sub(string.match(value, "index\":[%d]+"), 8)
            return spaceIndex
        end
    end
end

local function getActiveScreen()
    local handle = io.popen("/opt/homebrew/bin/yabai -m query --spaces")
    local result = trim1(handle:read("*a"))
    handle:close()
    local t = getTableOfOccurrences(result, "{[^}]*")
    local activeScreenIndex = returnActiveScreenIndex(t)
    return activeScreenIndex
end



local activeSpaceMenuBar = hs.menubar.new()
activeSpaceMenuBar:setTitle(getActiveScreen())

local function spaceWatcher()
    activeSpaceMenuBar:setTitle(getActiveScreen())
end

mySpaceWatcher = hs.spaces.watcher.new(spaceWatcher)
mySpaceWatcher:start()
