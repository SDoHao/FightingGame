local GoreCross = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/GoreCross/Cross1/",1,11,160,185},
    {"res/PassiveObject/GoreCross/Drops/",1,3,160,185},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2,  0,-1,0,0}, --start
    [2] = {2,5,2,   3,6,  0,-1,0,0},--start
    [3] = {6,11,-1, 4,12,  0,-1,0,0},
    [4] = {12,14,-1, 4,-1, 0,-1,1,1}, --finsh
  },
  audio_effect,
  audio_path = {
    "res/Audio/character/swordman/slash_down_f.ogg",
    "res/Audio/character/swordman/slash_down_up.ogg",
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/GoreCross/Data/GcBox.txt',
  atkbox,
  Physical_Damage = 2.35,
  atk_times = 3,
  atk_delay = 0.5,
  effect = {0.65,1.25,false,-4},
  Res_Not_Load = true,
}

return GoreCross
