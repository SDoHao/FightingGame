local SHRBullet = {
  imgs_list,
  action_id = 4,
  anim_alpha = 0.95,
  anim_rat = 0.05,
  vx = 12,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/SteyrHeavyRifle/bullet/",1,5,82,358},
    
  },
  audio_effect,
  audio_path = {
  },
  layer_order = 26, --11 bhind self
  Res_Not_Load = true,
  is_atk = true,
  Physical_Damage = 1320,
  atk_times = 1,
  atk_delay = 0.3,
  effect = {1,7,false,-4},
  atk_file = 'res/PassiveObject/SteyrHeavyRifle/Data/SbBox.txt',
  atkbox,
}
return SHRBullet