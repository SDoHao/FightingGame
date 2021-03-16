local Slash = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.05,
  anim_alpha = 0.95, 
  vx = 0,
  fade = 0,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/MoonSlash/Slash1/",1,5,116,179},
    {"res/PassiveObject/MoonSlash/Slash2/",1,5,116,219},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,5,1, -1,}, --start
    [2] = {6,10,2, -1,},
  },
   audio_repeat = false,
  audio_effect,
  audio_path = {
    "res/Audio/character/swordman/moon_atk_01.ogg",
    "res/Audio/character/swordman/moon_atk_02.ogg",
    --"res/audio/character/swordman/moon_curtain.ogg",
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/MoonSlash/Data/MsBox.txt',
  atkbox,
  Physical_Damage = 2.31,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.65,1,true,-5},
  Res_Not_Load = true,
}

return Slash
