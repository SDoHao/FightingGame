local Front = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/BlastBlood/Front/",1,7,132,318},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2,  0,-1,0,0},
    [2] = {2,7,-1,   2,-1,  0,-1,0,0},
  },
  audio_effect,
  audio_path = {
    'res/Audio/character/newSwordManSkillEffect/p_bloodexp.ogg',
  },
  layer_order = 23, 
  is_atk = true,
  Y_AxisAttackRange = 60,
  atk_file = 'res/PassiveObject/BlastBlood/Data/FrnBox.txt',
  Physical_Damage = 6,
  --0.035*35*0.03*0.5*4*8 = 0.588
  atk_times = 5,
  atk_delay = 0.05,
  effect = {0.8,0,true,-8.4},
  atkbox,
  is_spawn = true,
  spawn = {{42,0,0,1}},--,
  Res_Not_Load = true,
}

return Front