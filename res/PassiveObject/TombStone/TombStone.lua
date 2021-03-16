local TombStone = {
  imgs_list,
  action_id = 5,
  vz = 80,
  rat = 0.15,
  altitude = -520,
  duration = 0.8,
  land_index = 2,
  vanish_index = 4,
  dust_id = 10,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/TombStone/tomb/",1,9,50,320},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]frame(-1 end) [6]加帧数
  --若加帧数 0  请配合 末尾帧 -1 或不等于起始帧 达到画帧不变的效果
    [1] = {1,-1,-1,  1,1,0},--falling
    [2] = {2,2,1,   3,2,0},     --landing
    [3] = {2,-1,-1,  3,2,0},      --duration
    [4] = {3,9,-1,  -1,-1,1},    --finsh
  },
  audio_effect,
  audio_repeat = false,
  audio_path = {
    "res/Audio/effects/skill/p_tombstone.ogg"
  },
  layer_order = 13, --11 bhind self
  is_atk = true,
  atk_file = 'res/PassiveObject/Thunderbolt/Data/TsBox.txt',
  atkbox,
  Physical_Damage = 5.52,
  atk_times = 1,
  atk_delay = 0.08,
  effect = {1.1,3,false,-5},
  Res_Not_Load = true,
}

return TombStone