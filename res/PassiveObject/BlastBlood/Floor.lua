local Floor = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/BlastBlood/Floor/",1,1,346,360},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,-1,   1,-1,  0,-1,0,0},
  },
  audio_effect,
  audio_path = {
    
  },
  layer_order = -101, --floor
  is_atk = true,
  Y_AxisAttackRange = 60,
  atk_file = 'res/PassiveObject/BlastBlood/Data/BFlBox.txt',
  Physical_Damage = 3,
  atk_times = 1,
  atk_delay = 0.05,
  effect = {0.8,0,true,-2},
  atkbox,
  is_spawn = true,
  spawn = {{39,0,0,0.03}},--,
  Res_Not_Load = true,
}



return Floor