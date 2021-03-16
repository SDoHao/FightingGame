local IceWaveParticleSmoke = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/IceWave/icewaveparticlesmoke/",1,3,48,15},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,    2,2,  0,-1,52,0.02}, --start
    [2] = {2,3,-1,   1,-1,  0,-1,52,0.02}, --start
    
  },
  audio_effect,
  audio_path = {
    'res/Audio/character/newSwordManSkillEffect/icewave_fire.ogg',
  },
  layer_order = 13, --11 bhind self
  is_atk = false,
  Res_Not_Load = true,
}

return IceWaveParticleSmoke
