local Debris = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/OutrageBreak/Debris/",1,1,0,0},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index  [5]帧(-1 end) [6]速率增长 [7]spawn_frame [9]spawn_id [10]参数 
    [1] = {1,1,-1,   1,-1,  0,1,26,0}, --start
  },
  audio_effect,
  audio_path = {
  },
  layer_order = 1, --11 bhind self
  Res_Not_Load = true,
}

return Debris
