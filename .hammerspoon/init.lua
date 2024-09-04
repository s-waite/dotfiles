-- global variables
Meh = { "ctrl", "alt", "shift" }
Hyper = { "ctrl", "alt", "cmd", "shift" }

require("config.windowManagement")
require("config.openingApplications")
require("config.applicationActions")
require("config.menubar")
require("config.quickActions")
-- require("config.chooser")
-- require("config.applicationChooser")
-- require("config.indexer")
-- require("config.spotify")

local function generate_random_name()
    local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local name = ""
    for i = 1, 12 do
        local randomIndex = math.random(1, #letters)
        name = name .. letters:sub(randomIndex, randomIndex)
    end
    return name
end

local function isWeekend()
    local weekDay = os.date("*t").wday
    return weekDay == 1 or weekDay == 7 -- 1 = Sunday, 7 = Saturday
end

local holidays = {
    ["01-01"] = true, -- New Year's Day
    ["12-21"] = true, -- Christmas Day
    ["12-22"] = true, -- Christmas Day
    ["12-23"] = true, -- Christmas Day
    ["12-24"] = true, -- Christmas Day
    ["12-25"] = true, -- Christmas Day
    ["12-26"] = true, -- Christmas Day
    ["12-27"] = true, -- Christmas Day
    ["12-28"] = true, -- Christmas Day
    -- Add more holidays here in "MM-DD" format
}

local function isHoliday()
    local today = os.date("%m-%d")
    return holidays[today] or false
end

-- Main function to run the script
local function createCommits()
    print("*************** Creating Commits ***************")
    local repetitions = 0;

    -- 20 percent chance the script runs if its a weekend
    if isWeekend() then
        print("IS WEEKEND")
        if math.random(5) ~= 1 then
            return
        end
        -- less commits on the weekend
        repetitions = math.random(1, 3)
    end

    if isHoliday() then
        print("IS HOLIDAY")
        return
    end

    if math.random(5) == 1 then
        return
    end

    -- Generate a random number between 1 and 6
    repetitions = math.random(1, 6)

    -- Add a small chance that I commit a lot, or a little
    if math.random(10) == 1 then
        print("EXTRA OR LESS")
        if math.random(2) == 1 then
            repetitions = math.random(1, 3)
        else
            repetitions = math.random(4, 11)
        end
    end


    -- Change to the desired directory
    local directory = "/Users/sam/Code/graph"
    local oldDir = hs.fs.currentDir()
    hs.fs.chdir(directory)

    -- Loop for the generated number of repetitions
    for i = 1, repetitions do
        -- Generate a random name for the file
        local filename = generate_random_name()

        print(filename)

        -- Create the file with the generated name
        hs.execute("touch " .. filename)

        -- Stage and commit the changes
        hs.execute("git add .")
        hs.execute("git commit -am 'Added " .. filename .. "'")
    end

    -- Change back to the original directory
    hs.fs.chdir(oldDir)
end

-- Schedule the function with a timer, for example, every day at 8 AM
hs.timer.doAt("10:00", "1d", createCommits)


-- -- reload config on save
-- local function reloadConfig(files)
--     local doReload = false
--     for _,file in pairs(files) do
--         if file:sub(-4) == ".lua" then
--             doReload = true
--         end
--     end
--     if doReload then
--         hs.reload()
--     end
-- end
-- local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.alert.show("Config loaded!")


-- local test = hs.image.imageFromAppBundle("com.spotify.client")
-- hs.notify.new({title="Hammerspoon", informativeText="Config loaded", setIdImage=hs.image.imageFromAppBundle("com.spotify.client") }):send()
