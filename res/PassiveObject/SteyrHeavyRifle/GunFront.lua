local GunFront = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/SteyrHeavyRifle/at_gun_front/",1,6,239,326},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,6,-1,   1,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
   
  },
  layer_order = 11, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/SteyrHeavyRifle/Data/AtGFBox.txt',
  atkbox,
  Physical_Damage = 0.52,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.5,5.2,fale,-2},
  is_spawn = true,
  spawn = {{35,0,0,1},},--,
  Res_Not_Load = true,
}

return GunFront
