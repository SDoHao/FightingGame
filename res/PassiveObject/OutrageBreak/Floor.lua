local Floor = {
  imgs_list,
  action_id = 3,
  anim_rat = 1.2,
  anim_alpha = 1,  -- -1不变
  vx = 0,
  fade = -0.003,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/OutrageBreak/Floor1/",1,1,265,280},
  },
  frame_data = {
    --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,1,-1, -1,}, --start
  },
  audio_effect,
  audio_path = {
    
  },
  layer_order = -101, --floor
  is_atk = true,
  atk_file = 'res/PassiveObject/OutrageBreak/Data/Fl1Box.txt',
  Physical_Damage = 3,
  atk_times = 1,
  atk_delay = 0.05,
  effect = {0.62,2,true,-2},
  atkbox,
  is_spawn = true,
  --27 floor  49 debris
  spawn = {{27,0,0,1},{49,120,0,0.4}},--,
  Res_Not_Load = true,
}



return Floor