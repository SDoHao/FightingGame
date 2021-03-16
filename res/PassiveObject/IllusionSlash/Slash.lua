local Slash = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.25,
  anim_alpha = 0.95, 
  vx = 0.35,
  fade = -0.015,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/IllusionSlash/Slash/",1,2,100,210},
    {"res/PassiveObject/IllusionSlash/Slash/",3,4,100,210},
    {"res/PassiveObject/IllusionSlash/Slash/",5,6,100,210},
    {"res/PassiveObject/IllusionSlash/Slash/",7,8,100,210},
    {"res/PassiveObject/IllusionSlash/Slash/",9,10,60,170},
    {"res/PassiveObject/IllusionSlash/Shot_/",1,2,0,210},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,2,1, -1,}, --start
    [2] = {3,4,1, -1,},
    [3] = {5,6,1, -1,},
    [4] = {7,8,1, -1,},
    [5] = {9,10,1, -1,},
    [6] = {11,12,1, -1,},
  },

  audio_effect,
  audio_repeat = false,
  audio_path = {
    "res/Audio/character/swordman/hoanyoung_wave.ogg",
  },
  is_atk = true,
  atk_file = 'res/PassiveObject/IllusionSlash/Data/SlBox.txt',
  atkbox,
  Physical_Damage = 6.6,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.75,1.2,false,-3},
  layer_order = 13, --11 bhind self
  Res_Not_Load = true,
  
}

return Slash
