local Keiga = {
  imgs_list,
  action_id = 2,
  duration = 10,
  AtcEff = true,
  --frame_data_index
  up_index = 1,
  anim_finsh = 4,
  --imgs_list_offset
  down_offset = 17,
  --anim_data_index
  up_imgs = 1,

  _alpha = 0.95,
  rat = 0.1,
  
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/Keiga/Keiga_up/",1,17,110,186},
    --这里是分界线
    {"res/PassiveObject/Keiga/Keiga_down/",1,17,110,186},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index  [5]帧(-1 end) [6]加帧数
  --[Cancel..[7]速率 [8]spawn_frame [9]spawn_id [10]参数] 
    --up
    [1] = {1,1,1,   2,2,  1},--play_audio
    [2] = {2,7,-1,  3,8,  1},--start 1 - 7
    [3] = {8,12,2,  3,8,  1},--loop 8 - 12
    --
    [4] = {13,17,-1, 4,-1,  1},--vanish 13 - 17
    --down
    --[[
    [5] = {1,1,1,   2,2,2,},--play_audio
    [6] = {2,7,-1,  3,2,8,},--start 1 - 7
    [7] = {8,12,2,  3,2,8,},--loop 8 - 12
    [8] = {6,11,-1, 4,2,1,},--vanish 13 - 17
    ]]
  },
  audio_effect,
  layer_order = 13, --11 bhind self
  audio_path = {
    "res/Audio/character/newSwordManSkillEffect/keiga_summon.ogg",
    "res/Audio/character/newSwordManSkillEffect/keiga_shield_loop.ogg",
  },
  Res_Not_Load = true,
}
return Keiga