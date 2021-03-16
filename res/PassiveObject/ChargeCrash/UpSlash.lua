local Slash = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.04,
  anim_alpha = 0.95,  -- -1不变
  vx = 0,
  fade = -0.015,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/ChargeCrash/UpSlash/",1,5,59,196},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,5,1, -1,}, --start
  },

  audio_effect,
  audio_repeat = false,
  audio_path = {
    "res/Audio/character/newSwordManSkillEffect/Charge_Slash_Fall.ogg",
  },
  layer_order = 15, --11 bhind self
  is_spawn = true,
  spawn = {{32,0,0,1.2},},--,
  is_atk = true,
  Physical_Damage = 5,
  atk_times = 1,
  atk_delay = 0.05,
  effect = {0.8,0,true,-10},
  atk_file = 'res/PassiveObject/ChargeCrash/Data/UsDash.txt',
  atkbox,
  Res_Not_Load = true,
}

return Slash
