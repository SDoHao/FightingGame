local B_e = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.2,
  anim_alpha = 1,  -- -1不变
  vx = 0,
  fade = -0.02,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/BlastBlood/B_e/",1,2,125,310},
    
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,2,-1, -1,}, --start
  },

  audio_effect,
  audio_path = {
    
  },
  is_atk = false,
  layer_order = -99, --11 bhind self
  Res_Not_Load = true,
}

return B_e
