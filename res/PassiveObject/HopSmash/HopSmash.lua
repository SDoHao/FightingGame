local HopSmash = {
  imgs_list,
  action_id = 2,
  duration = 1,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 2,
  --imgs_list_offset
  down_offset = -1,
  --anim_data_index
  up_imgs = 1,

  _alpha = 0.95,
  rat = 0.08,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/HopSmash/start/",1,1,111,181},
    {"res/PassiveObject/HopSmash/start/",2,2,132,130},
    {"res/PassiveObject/HopSmash/start/",3,4,-75,134},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index  [5]帧(-1 end) [6]加帧数
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,2,-1,  2,3, 1},
    [2] = {3,4,-1,  2,-1, 1},
  },
  audio_effect,
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/HopSmash/Data/HsbBox.txt',
  atkbox,
  Physical_Damage = 2.5,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.8,2.3,true,-4},
  audio_path = {
  },
  Res_Not_Load = true,
}
return HopSmash