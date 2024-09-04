-- OPENING APPLICATIONS
hs.hotkey.bind(Meh, "d", function()
    hs.application.open("ARC")
end)

hs.hotkey.bind(Meh, "return", function()
    hs.application.open("net.kovidgoyal.kitty")
end)

hs.hotkey.bind(Meh, "e", function()
    local finderApp = hs.application.get("Finder")
    local allWindows = finderApp:allWindows()
    local count = 0
    for _, window in pairs(allWindows) do
        count = count + 1
    end
    if count == 0 then
        finderApp:selectMenuItem({"File", "New Finder Window"})
    end
    hs.application.open("com.apple.Finder")

end)

hs.hotkey.bind(Meh, "s", function()
    hs.application.open("com.microsoft.VSCode")
end)

-- hs.hotkey.bind(Meh, "m", function()
--     hs.application.open("com.apple.mail")
-- end)

-- QUITTING APPLICATIONS
-- close all applications
hs.hotkey.bind(Meh, "q", function()
    local allRunningApps = hs.application.runningApplications()
    for _, app in pairs(allRunningApps) do
        -- check if application is a dock application
        if app:kind() == 1 and app:bundleID() ~= "com.apple.finder" then
            app:kill()
        end
    end
end)

-- -- close all unfocused applications
-- hs.hotkey.bind(Meh, "u", function()
--     local allRunningApps = hs.application.runningApplications()
--     for _, app in pairs(allRunningApps) do
--         -- check if application is a dock application, not finder, and not the frontmost
--         if app:kind() == 1 and app:bundleID() ~= "com.apple.finder" and not app:isFrontmost() then
--             app:kill()
--         end
--     end
-- end)
