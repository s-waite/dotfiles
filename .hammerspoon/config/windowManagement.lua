-- -- -- halfs
-- hs.hotkey.bind(Meh, "f", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --toggle float && /opt/homebrew/bin/yabai -m window --grid 1:1:0:0:1:1")
-- end)
--
-- hs.hotkey.bind(Meh, "r", function()
--     hs.execute("/opt/homebrew/bin/yabai -m space --rotate 90")
-- end)
--
-- hs.hotkey.bind(Meh, "l", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --focus next")
-- end)
--
-- hs.hotkey.bind(Meh, "h", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --focus prev")
-- end)
--
-- hs.hotkey.bind(Hyper, "2", function()
--     hs.execute("/opt/homebrew/bin/yabai -m display --focus 1")
-- end)
--
-- hs.hotkey.bind(Hyper, "1", function()
--     hs.execute("/opt/homebrew/bin/yabai -m display --focus 2")
-- end)
--
-- hs.hotkey.bind(Meh, "1", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --display 2")
-- end)
--
-- hs.hotkey.bind(Meh, "2", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --display 1")
-- end)
hs.hotkey.bind(Meh, "y", function()
    hs.window.frontmostWindow():focusWindowWest()
end)

hs.hotkey.bind(Meh, "o", function()
    hs.window.frontmostWindow():focusWindowEast()
end)

hs.hotkey.bind(Meh, "v", function()
    hs.window.frontmostWindow():moveToScreen(hs.screen.mainScreen():next())
end)

hs.hotkey.bind(Meh, "h", function()
    hs.execute("/opt/homebrew/bin/yabai -m window --grid 1:2:0:0:1:1")
end)

hs.hotkey.bind(Meh, "j", function()
    hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:1:0:1:1:1")
end)

hs.hotkey.bind(Meh, "l", function()
    hs.execute("/opt/homebrew/bin/yabai -m window --grid 1:2:1:0:1:1")
end)

hs.hotkey.bind(Meh, "k", function()
    hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:1:0:0:1:1")
end)

-- fullscreen
hs.hotkey.bind(Meh, "f", function()
    hs.execute(
        "/opt/homebrew/bin/yabai -m window --toggle float && /opt/homebrew/bin/yabai -m window --grid 1:1:0:0:1:1")
end)

-- -- corners
-- hs.hotkey.bind(Meh, "y", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:2:0:0:1:1")
-- end)

-- hs.hotkey.bind(Meh, "u", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:2:1:0:1:1")
-- end)

-- hs.hotkey.bind(Meh, "i", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:2:0:1:1:1")
-- end)

-- hs.hotkey.bind(Meh, "o", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --grid 2:2:1:1:1:1")
-- end)
--
-- -- moving windows to spaces
-- -- space 1
-- hs.hotkey.bind(Hyper, "u", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --space 1")
-- end)
--
-- -- space 2
-- hs.hotkey.bind(Hyper, "i", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --space 2")
-- end)
--
-- -- space 3
-- hs.hotkey.bind(Hyper, "o", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --space 3")
-- end)
--
-- -- space 4
-- hs.hotkey.bind(Hyper, "p", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --space 4")
-- end)
--
-- -- hs.hotkey.bind(Meh, "r", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m space --rotate 90")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "n", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m space --mirror x-axis")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "m", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m space --mirror y-axis")
-- -- end)
--
-- hs.hotkey.bind(Meh, "h", function()
--     hs.execute("/opt/homebrew/bin/yabai -m window --focus west")
-- end)
--
-- -- hs.hotkey.bind(Meh, "j", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --focus south")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "k", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --focus north")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "l", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --focus east")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "f", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen")
-- -- end)
--
-- -- hs.hotkey.bind(Hyper, "h", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --swap west")
-- -- end)
--
-- -- hs.hotkey.bind(Hyper, "j", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --swap south")
-- -- end)
--
-- -- hs.hotkey.bind(Hyper, "k", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --swap north")
-- -- end)
--
-- -- hs.hotkey.bind(Hyper, "l", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m window --swap east")
-- -- end)
--
-- -- hs.hotkey.bind(Meh, "d", function()
-- --     hs.execute("/opt/homebrew/bin/yabai -m space --balance")
-- -- end)
