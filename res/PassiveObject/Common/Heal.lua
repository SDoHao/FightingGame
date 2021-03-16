local Heal = {
  imgs_list,
  action_id = 2,
  duration = 3,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 1,
  --imgs_list_offset
  down_offset = -1,
  --anim_data_index
  up_imgs = 1,

  _alpha = 0.9,
  rat = 0.08,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/Common/Heal/",1,12,130,237},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) 
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,12,-1,  1,-1, 1},--play_audio
  
  },
  audio_effect,
  layer_order = 0, --11 bhind self
  audio_path = {
  },
  Res_Not_Load = true,
}
return Heal