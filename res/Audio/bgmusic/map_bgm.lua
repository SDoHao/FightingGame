map_bgm = {}

local bg_music = {
  love.audio.newSource("res/Audio/bgmusic/PianoLoran.mp3", "stream"),
}

function GetBgMusic(id)
  return bg_music[id]
end

return map_bgm