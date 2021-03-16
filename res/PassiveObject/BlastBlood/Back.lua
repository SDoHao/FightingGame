local Back = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/BlastBlood/Back/",1,13,346,360},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,13,-1,   1,-1,  0,13,41,4},
  },
  audio_effect,
  audio_path = {
    
  },
  layer_order = -1, --floor
  is_atk = false,
  Res_Not_Load = true,
}

return Back