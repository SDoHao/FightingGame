local Slash = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.08,
  anim_alpha = 0.95,  -- -1不变
  vx = 0,
  fade = -0.015,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/RapidMoveSlash/slash1/",1,4,74,133},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,4,-1, -1,}, --start
  },
  audio_repeat = false,
  audio_effect,
  audio_path = {
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  Physical_Damage = 10.8,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.75,1.84,false,-4},
  atk_file = 'res/PassiveObject/RapidMoveSlash/Data/Sl1Box.txt',
  atkbox,
  Res_Not_Load = true,
}

return Slash
