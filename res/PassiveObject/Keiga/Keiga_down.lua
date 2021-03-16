--sm_keiga.ogg
local settings = {
  action_id = 2,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/Keiga/Keiga_down/",1,17,110,186},
  },
  frame_data = {
    --起始帧 末尾帧  audio_index  (到达末尾帧之后)index 帧(-1 end) 速率增长 spawn_frame spawn_id
    [1] = {1,7,-1,2,8,0}, --summon
    [2] = {8,12,-1,2,8,0},  --loop
    [3] = {13,17,-1,-1,-1,0},--finsh
  },
  layer_order = 11, --11 bhind self
  is_load = false,
}