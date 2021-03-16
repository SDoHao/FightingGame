
local IceWaveParticle = {
  imgs_list,
  action_id = 1,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/IceWave/icewaveparticle/",1,68,34,86},
  },
  frame_data = {
  --[1]起始帧 [2]末尾帧 [3]音效索引 [4]frame_index [5]帧(-1 end) [6]速率增长 [7]spawn_frame [8]spawn_id [9]参数 
    [1] = {1,17,-1,   1,-1,  0,-1,0,0}, --start
    [2] = {18,34,-1,   1,-1,  0,-1,0,0}, --start
    [3] = {35,51,-1,   1,-1,  0,-1,0,0}, --start
    [4] = {52,68,-1,   1,-1,  0,-1,0,0}, --start
  },
  audio_effect,
  audio_path = {
    
  },
  layer_order = 1,
  is_atk = false,
  Res_Not_Load = true,
}

return IceWaveParticle
