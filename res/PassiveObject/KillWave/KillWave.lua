local KillWave = {
  imgs_list,
  action_id = 2,
  duration = 60,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 3,
  --imgs_list_offset
  down_offset = -1,
  --anim_data_index
  up_imgs = 1,

  _alpha = 0.7,
  rat = 0.04,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/Common/EarthQuakeRing/",1,5,259,369},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) 
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,5,-1,  2,1, 1},--play_audio
    [2] = {1,5,-1,  2,1, 1},--loop
    [3] = {1,5,-1,  3,-1, 1},--vanish
  
  },
  audio_effect,
  layer_order = -1001, --11 bhind self
  audio_path = {
  },
  is_atk = true,
  Y_AxisAttackRange = 50,
  atk_file = 'res/PassiveObject/Common/Data/EqrBox.txt',
  atkbox,
  Physical_Damage = 4.2,
  atk_times = 120,
  atk_delay = 0.5,
  effect = {0,0,false,0},
  Res_Not_Load = true,
}
return KillWave