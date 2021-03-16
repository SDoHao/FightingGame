local RedUnder = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/DrawingSword/red_ldodge_under/",1,5,270,270},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2,  0,-1,0,0}, --start
    [2] = {2,5,-1,   2,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
    "res/Audio/character/newSwordManSkillEffect/Drawing_Sword.ogg",
  },
  layer_order = -47, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/DrawingSword/Data/RudBox.txt',
  atkbox,
  Y_AxisAttackRange = 100,
  Physical_Damage = 25.5,
  atk_times = 1,
  atk_delay = 0.04,
  effect = {0.62,1.32,false,-4},
  is_spawn = true,
  spawn = {{44,0,0,1},},
  Res_Not_Load = true,
}

return RedUnder
