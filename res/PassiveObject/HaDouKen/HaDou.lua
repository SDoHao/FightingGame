local ken = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/HaDouKen/HaDou/",1,5,145,224},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,5,-1,   1,-1,0, -1,0,0}, --start
  },
  audio_effect,
  audio_path = {
    
  },
  layer_order = 35, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/HaDouKen/Data/HaBox.txt',
  atkbox,
  Physical_Damage = 2.6,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.85,14,true,-6},
  Res_Not_Load = true,
}

return ken