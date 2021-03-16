local Blade = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/HardAttackBlade/Blade/",1,6,129,230},

  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,6,-1,   1,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/HardAttackBlade/Data/HabBox.txt',
  atkbox,
  Physical_Damage = 3.5,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {1.02,14,true,-8},
  Res_Not_Load = true,
}

return Blade
