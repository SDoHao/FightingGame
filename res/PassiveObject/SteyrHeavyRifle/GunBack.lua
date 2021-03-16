local GunBack = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/SteyrHeavyRifle/at_gun_back/",1,3,239,326},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,3,-1,   2,3,  0,-1,0,0}, --start
    [2] = {3,3,-1,   2,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
   
  },
  layer_order = 11, --11 bhind self
  is_atk = false,
  Res_Not_Load = true,
}

return GunBack
