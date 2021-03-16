local Dash = {
  imgs_list,
  action_id = 2,
  duration = 2,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 3,
  --imgs_list_offset
  down_offset = -1,
  --anim_data_index
  up_imgs = 1,

  _alpha = 0.8,
  rat = 0.06,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/ChargeCrash/Dash/",1,4,78,100},
    --这里是分界线
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index  [5]帧(-1 end) [6]加帧数
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,1,1,  2,2, 1},
    [2] = {2,4,-1,  2,-1, 1},
  },
  audio_effect,
  layer_order = 15, --11 bhind self
  audio_path = {
    "res/Audio/character/newSwordManSkillEffect/Charge_Clash.ogg",
  },
  is_spawn = true,
  spawn = {{31,0,0,0.7},},--,
  Res_Not_Load = true,
  is_atk = true,
  Physical_Damage = 4,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {0.62,6,false,-4},
  atk_file = 'res/PassiveObject/ChargeCrash/Data/CcDash.txt',
  atkbox,
}
return Dash