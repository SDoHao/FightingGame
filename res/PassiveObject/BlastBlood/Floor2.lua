local Floor2 = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/BlastBlood/Floor2/",1,6,163,80},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   2,2,  0,-1,0,0},
    [2] = {2,6,-1,   2,-1, 0,6,40,0.5}
  },
  audio_effect,
  audio_path = {
    'res/Audio/character/newSwordManSkillEffect/p_bloodr_fire.ogg',
  },
  layer_order = -100, --floor
  is_atk = false,
  Res_Not_Load = true,
}



return Floor2