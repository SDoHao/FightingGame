sm_Audio = {
  jump = love.audio.newSource("res/Audio/character/swordman/sm_jump.ogg", "static"),
  jump_atk = love.audio.newSource("res/Audio/character/swordman/sm_jumpatk_01.ogg", "static"),
  
  atk = {
    love.audio.newSource("res/Audio/character/swordman/sm_atk_01.ogg", "static"),
    love.audio.newSource("res/Audio/character/swordman/sm_atk_02.ogg", "static"),
    love.audio.newSource("res/Audio/character/swordman/sm_atk_03.ogg", "static"),
  },
  
  jue_01=love.audio.newSource("res/Audio/character/swordman/sm_gue_01.ogg", "static"),
  die = love.audio.newSource("res/Audio/character/swordman/sm_die.ogg", "static"),
  
  
  dmg = {
      love.audio.newSource("res/Audio/character/swordman/sm_dmg_01.ogg", "static"),
      love.audio.newSource("res/Audio/character/swordman/sm_dmg_02.ogg", "static"),
      love.audio.newSource("res/Audio/character/swordman/sm_dmg_03.ogg", "static"),
  },

  beam_jump=love.audio.newSource("res/Audio/character/swordman/beamswdb.ogg", "static"),
  beamatk_01=love.audio.newSource("res/Audio/character/swordman/beamswda_01.ogg", "static"),
  beamatk_02=love.audio.newSource("res/Audio/character/swordman/beamswda_02.ogg", "static"),
  beamatk_03=love.audio.newSource("res/Audio/character/swordman/beamswda_03.ogg", "static"),
  beam_hit=love.audio.newSource("res/Audio/character/swordman/beamswdb_hit.ogg", "static"),
  
  lkat_jump=love.audio.newSource("res/Audio/character/swordman/katb.ogg", "static"),
  lkaatk_01=love.audio.newSource("res/Audio/character/swordman/kata_01.ogg", "static"),
  lkaatk_02=love.audio.newSource("res/Audio/character/swordman/kata_02.ogg", "static"),
  lkaatk_03=love.audio.newSource("res/Audio/character/swordman/kata_03.ogg", "static"),
  lka_hit=love.audio.newSource("res/Audio/character/swordman/katb_hit.ogg", "static"),

--[[
  lsword_jump=love.audio.newSource("res/Audio/character/swordman/sqrswdb.ogg", "static"),
  lswatk_01=love.audio.newSource("res/Audio/character/swordman/minswdc_01.ogg", "static"),
  lswatk_02=love.audio.newSource("res/Audio/character/swordman/minswdc_02.ogg", "static"),
  lswatk_03=love.audio.newSource("res/Audio/character/swordman/minswdc_03.ogg", "static"),
  lsw_hit=love.audio.newSource("res/Audio/character/swordman/minswdc_hit.ogg", "static")
  ]]
}


return sm_Audio