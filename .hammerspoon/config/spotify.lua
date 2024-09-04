local spotifyMenuItem = hs.menubar.new()
local artist
local track
local isPlaying

-- Define a function to update the menubar item with the currently playing track
local function updateMenubar()
    track = hs.spotify.getCurrentTrack()
    artist = hs.spotify.getCurrentArtist()
    isPlaying = hs.spotify.isPlaying()

    if isPlaying then
        -- Update the menubar item with the current track and artist
        spotifyMenuItem:returnToMenuBar()
        spotifyMenuItem:setTitle(track .. " - " .. artist)
    else
        spotifyMenuItem:removeFromMenuBar()
    end
end

-- Update the menubar item initially and then every 5 seconds
-- There is a bug in hs.timer.doEvery() that causes it to only fire a few times
-- Using do while is a workaround
updateMenubar()
hs.timer.doWhile(function() return true end, updateMenubar, 5)
