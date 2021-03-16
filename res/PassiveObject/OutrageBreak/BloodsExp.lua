local BloodsExp = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/OutrageBreak/BloodsExp1/",1,7,420,300},
    {"res/PassiveObject/OutrageBreak/BloodsExp2/",1,7,470,270},
    {"res/PassiveObject/OutrageBreak/Drop/",1,6,350,278},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,1,1,   3,2,  0,-1,0,0},
    [2] = {8,8,1,   4,9,  0,-1,0,0},
    [3] = {2,7,-1,   5,15,  0,-1,0,0},
    [4] = {9,14,-1,   5,15,  0,-1,0,0},
    
    [5] = {15,20,-1, 3,-1,  0,-1,0,0},
  },

  audio_effect,
  audio_path = {
    'res/Audio/character/newSwordManSkillEffect/outrage_swing.ogg',
  },
  is_atk = true,
  atk_file = 'res/PassiveObject/OutrageBreak/Data/BeBox.txt',
  Physical_Damage = 8,
  atk_times = 2,
  atk_delay = 0.32,
  effect = {0.62,0,true,-3},
  atkbox,
  atk_group,
  layer_order = 13, --11 bhind self

  Res_Not_Load = true,
}

return BloodsExp
