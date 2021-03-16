local Gun = {
  imgs_list,
  action_id = 2,
  duration = 1,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 3,
  --imgs_list_offset
  down_offset = -1,
  --anim_data_index
  up_imgs = 1,

  _alpha = 1,
  rat = 0.15,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/SteyrHeavyRifle/at_gun_front/",7,8,239,326},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index  [5]帧(-1 end) [6]加帧数
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,2,-1,  1,-1, 1},
  },
  audio_effect,
  layer_order = 13, --11 bhind self
  audio_path = {
  },
  is_spawn = true,
  spawn = {{37,0,0,1},},--,
  Res_Not_Load = true,
}
return Gun