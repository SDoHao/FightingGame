local ken = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/HaDouKen/Ken/",1,5,102,245},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2, 0,  -1,0,0}, --start
    [2] = {2,5,-1,   2,-1,0,  4,4,1},--start
  },
  audio_effect,
  audio_path = {
    "res/Audio/character/newSwordManSkillEffect/hadouken.ogg",
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  Physical_Damage = 2,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.65,0.5,false,-4},
  atk_file = 'res/PassiveObject/HaDouKen/Data/keBox.txt',
  atkbox,
  Res_Not_Load = true,
}

return ken