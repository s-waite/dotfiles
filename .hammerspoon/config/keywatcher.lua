local eventtap = require("hs.eventtap")

-- Create an event tap to monitor keyboard events
local keyWatcher = eventtap.new({ eventtap.event.types.keyDown }, function(event)
    print("Key Pressed:", event:getKeyCode())
    local modifiers = event:getFlags()
    print("Modifiers:", modifiers)
    local modifiersString = ""
    for _, modifier in ipairs(modifiers) do
        modifiersString = modifiersString .. modifier .. " "
    end
    print("Modifiers String:", modifiersString)
    print(hs.inspect(eventtap.checkKeyboardModifiers()))
end)

-- Start the event tap
keyWatcher:start()