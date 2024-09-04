local getAppsScript = [[
tell application "System Events"
    set apps to every process whose background only is false
    set appInfo to {}
    repeat with myApp in apps
        try
            set end of appInfo to "{ \"name\": \"" & displayed name of myApp & "\", \"id\": \"" & bundle identifier of myApp & "\"}"
        end try
    end repeat
    return "[" & my join(appInfo, ",") & "]"
end tell

on join(lst, delim)
    set oldDelims to AppleScript's text item delimiters
    set AppleScript's text item delimiters to delim
    set str to lst as text
    set AppleScript's text item delimiters to oldDelims
    return str
end join
]]

-- Function to get the list of open applications and their bundle IDs
local function getOpenApps()
	local ok, res = hs.osascript.applescript(getAppsScript)
	if not ok then
		hs.alert.show("Error running AppleScript")
		return {}
	end
	return hs.json.decode(res)
end

-- Create the chooser
ApplicationChooser = hs.chooser.new(function(choice)
	-- If a choice was made, activate the selected application
	if choice then
		if choice["bundleId"] == "" then
			hs.application.open(choice["text"])
		end
		hs.application.open(choice["bundleId"])
		ApplicationChooser:refreshChoicesCallback()
		ApplicationChooser:hide()
	end
end)

-- Function to filter and populate the chooser based on the query
local function populateChooser(query)
	-- First, look through open applications
	local choices = {}
	for _, app in pairs(OpenApplications) do
		if string.find(string.lower(app["name"]), string.lower(query or "")) then
			table.insert(
				choices,
				{ ["text"] = app["name"], ["bundleId"] = app["id"], ["image"] = hs.image.imageFromAppBundle(app["id"]) }
			)
		end
	end

	-- Set the choices to just the open applications
	ApplicationChooser:choices(choices)
	-- If the search query filters down to just one application, automatically open it
	if #choices == 1 then
		print("selecting item")
		ApplicationChooser:select(1)
	end

	-- If the search query brings up no results, fallback to all the applications installed
	if #choices == 0 then
		choices = {}
		for _, app in pairs(AllApps) do
			if string.find(string.lower(app["name"]), string.lower(query or "")) then
				table.insert(choices, {
					["text"] = app["name"],
					["bundleId"] = app["id"],
					["image"] = hs.image.imageFromPath(app["icon"]),
				})
			end
		end
		ApplicationChooser:choices(choices)
	end
end

-- Set the queryChangedCallback function
ApplicationChooser:queryChangedCallback(populateChooser)

-- Function to read the existing applications from a JSON file
local function readAppsFromJson(filePath)
	local file = io.open(filePath, "r")
	-- If the file doesn't exist, return an empty table
	if not file then
		return {}
	end
	-- Read the entire content of the file
	local content = file:read("*a")
	file:close()
	-- Decode the JSON content and return it, or an empty table if the content is empty or invalid
	return hs.json.decode(content) or {}
end

-- Function to check if an app with a specific name already exists in the list
local function findApp(apps, appName)
	for _, app in ipairs(apps) do
		if app.name == appName then
			return true
		end
	end
	return false
end

-- Function to list the applications in a directory
local function listApps(directories)
	local files = {}
	for _, directory in ipairs(directories) do
		local stdOut = hs.execute("/bin/ls " .. directory)
		local dirFiles = hs.fnutils.split(stdOut, "\n")
		if dirFiles[#dirFiles] == "" then
			table.remove(dirFiles)
		end
		for _, file in ipairs(dirFiles) do
			table.insert(files, { file, directory })
		end
	end
	return files
end

-- Function to get the name and bundle identifier of an app
local function getAppInfo(file, directory)
	local appName = file:match("(.-)%.app$")
	if appName then
		local plistPath = directory .. "/" .. file .. "/Contents/Info.plist"

		local plistJson = hs.execute('plutil -convert json -o - "' .. plistPath .. '"')
		local plist = hs.json.decode(plistJson)
		local bundleId = plist and plist.CFBundleIdentifier or ""
    local output = hs.execute(
      "/usr/bin/find " .. directory .. "/" .. file .. "/Contents/Resources -name '*.icns' -maxdepth 1"
    )
    local icnsFiles = hs.fnutils.split(output, "\n")
    local icnsPath = icnsFiles[1] or ''

    return { ["name"] = appName, ["id"] = bundleId, ["icon"] = icnsPath }

	end
end

-- Function to write the list of apps to a JSON file
local function writeAppsToJson(apps, filePath)
	-- Encode the apps table into a JSON string
	local appsJson = hs.json.encode(apps)
	-- Open the file in write mode
	local file = io.open(filePath, "w")
	-- Write the JSON string to the file
	file:write(appsJson)
	file:close()
end

-- Function to refresh the apps list and write it to the JSON file
local function refreshApps(jsonFilePath)
	local apps = readAppsFromJson(jsonFilePath)
	local directories = { "/Applications", "/Users/sam/Applications" }
	local files = listApps(directories)

	for _, fileDirPair in ipairs(files) do
		local file = fileDirPair[1]
		local directory = fileDirPair[2]
		local appInfo = getAppInfo(file, directory)
		if appInfo and not findApp(apps, appInfo.name) then
			table.insert(apps, appInfo)
		end
	end

	writeAppsToJson(apps, jsonFilePath)
end

-- Main program

local jsonFilePath = "/Users/sam/.hammerspoon/all_apps.json" -- replace with your desired file path

-- Initial refresh of the apps list
refreshApps(jsonFilePath)

-- Set up a path watcher for the /Applications directory
local appsWatcher = hs.pathwatcher.new("/Applications", function()
	-- Refresh the apps list whenever a change is detected
	refreshApps(jsonFilePath)
end)
local userAppsWatcher = hs.pathwatcher.new("/Users/sam/Applications", function()
	-- Refresh the apps list whenever a change is detected
	refreshApps(jsonFilePath)
end)

-- Start the path watcher
appsWatcher:start()
userAppsWatcher:start()

-- Show the chooser when a hotkey is pressed
hs.hotkey.bind(Hyper, "space", function()
	OpenApplications = getOpenApps()
	AllApps = readAppsFromJson(jsonFilePath)
	print("printing all apps")
	print(hs.inspect(AllApps))
	ApplicationChooser:query("")
	ApplicationChooser:show()
end)
