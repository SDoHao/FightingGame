local IceWave = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.25,
  anim_alpha = 0.95,  -- -1不变
  vx = 0,
  fade = -0.003,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/IceWave/icewave2/",1,18,48,195},
    --{"res/PassiveObject/IceWave/icewave2/",4,6,0,0},
    --{"res/PassiveObject/IceWave/icewave2/",7,9,0,0},
    --{"res/PassiveObject/IceWave/icewave2/",10,12,0,0},
    --{"res/PassiveObject/IceWave/icewave2/",13,15,0,0},
    --{"res/PassiveObject/IceWave/icewave2/",16,18,0,0},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,3,1, -1,}, --start
    [2] = {4,6,1, -1,},
    [3] = {7,9,1, -1,},
    [4] = {10,12,1, -1,},
    [5] = {13,15,1, -1,},
    [6] = {16,18,1, -1,},
  },

  audio_effect,
  audio_path = {
     'res/Audio/character/newSwordManSkillEffect/icewave_rise.ogg',
  },
  is_atk = true,
  atk_file = 'res/PassiveObject/IceWave/Data/IcwBox.txt',
  atkbox,
  Physical_Damage = 4.65,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.75,3,false,-2},
  is_spawn = true,
  --id x y value
  spawn = {{51,0,0,1.1},},
  layer_order = 13, --11 bhind self
  Res_Not_Load = true,
}

return IceWave