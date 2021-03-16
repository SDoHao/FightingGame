local Thunderbolt = {
  imgs_list,
  action_id = 1,
  rat = 0.04,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {'res/PassiveObject/Thunderbolt/1/',1,9,50,469},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2,  0,-1,0,0}, --start
    [2] = {2,9,-1,   2,-1,  -0.003,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
    'res/Audio/effects/thunder.ogg',
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/Thunderbolt/Data/Tb1Box.txt',
  atkbox,
  Physical_Damage = 4,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.8,0.5,true,-4},
  Res_Not_Load = true,
}
return Thunderbolt