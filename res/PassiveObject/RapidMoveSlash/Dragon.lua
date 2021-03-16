local Dragon = {
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

  _alpha = 0.95,
  rat = 0.1,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/RapidMoveSlash/face/",1,3,80,86},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) 
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,1,1,  2,2, 1},--play_audio
    [2] = {1,3,-1,  2,1, 1},--loop
    [3] = {2,3,-1,  3,-1, 1},--vanish
    --down
    --[[
    [5] = {1,1,1,   2,2,2,},--play_audio
    [6] = {2,7,-1,  3,2,8,},--start 1 - 7
    [7] = {8,12,2,  3,2,8,},--loop 8 - 12
    [8] = {6,11,-1, 4,2,1,},--vanish 13 - 17
    ]]
  },
  audio_effect,
  layer_order = 14, --11 bhind self
  audio_path = {
    "res/Audio/character/swordman/mengryong_atk.ogg",
  },
  is_atk = true,
  atk_file = 'res/PassiveObject/RapidMoveSlash/Data/FcBox.txt',
  atkbox,
  Physical_Damage = 8.8,
  atk_times = 5,
  atk_delay = 0.1,
  effect = {0.73,1.5,false,-5},
  is_spawn = true,
  spawn = {{16,0,0,1},{18,0,0,0.6}},
  Res_Not_Load = true,
}
return Dragon