local EarthQuakeRing = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/Common/EarthQuakeRing/",1,5,259,369},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,5,-1,   1,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
    --"res/audio/character/swordman/slash_down_f.ogg",
  },
  is_atk = true,
  atk_file = 'res/PassiveObject/Common/Data/EqrBox.txt',
  atkbox,
  Physical_Damage = 5,
  atk_times = 1,
  atk_delay = 0.34,
  effect = {0.75,8.52,true,-5},
  layer_order = -101, --floor
  Res_Not_Load = true,
}

return EarthQuakeRing