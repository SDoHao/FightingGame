local Shot = {
  imgs_list,
  action_id = 4,
  anim_alpha = 0.95,
  anim_rat = 0.05,
  vx = 6,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/IllusionSlash/ShotFront/",1,3,125,197},
    
  },
  audio_effect,
  audio_path = {
  },
  layer_order = 26, --11 bhind self
  Res_Not_Load = true,
  is_spawn = true,
  is_atk = true,
  Physical_Damage = 8.4,
  atk_times = 5,
  atk_delay = 0.15,
  effect = {1.24,6,false,-4},
  atk_file = 'res/PassiveObject/IllusionSlash/Data/SFBox.txt',
  atkbox,
  --id x y value
  spawn = {{7,0,0,3},{8,0,0,3.1},{8,0,-105,3.1},{5,0,0,6}},
}
return Shot