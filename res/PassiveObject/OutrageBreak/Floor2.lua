local Floor2 = {
  imgs_list,
  action_id = 3,
  anim_rat = 0.3,
  anim_alpha = 1,  -- -1不变
  vx = 0,
  fade = -0.01,
  anim_data = {
    --path st ed X-axis_offset  Y-axis_offset
    {"res/PassiveObject/OutrageBreak/Floor1/",2,5,268,275},
  },
  frame_data = {
    --[1]起始帧 [2]末尾帧 [3]音效索引 [4]帧(-1 end)
    [1] = {1,4,-1, -1,}, --start
  },
  audio_effect,
  audio_path = {
    --'res/Audio/character/newSwordManSkillEffect/outrage_ready.ogg',
  },
  layer_order = -100, --floor
  Res_Not_Load = true,
}

return Floor2