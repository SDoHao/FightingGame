Camera={
  c_x = 0,
  c_y = 0,
}

local settings={
  ci_x,
  ci_y,
  left_border,
  right_border,
  up_border,
  down_border,
}

function Camera:init(p_x,p_y)
  
  settings.left_border =  RULE.ScreenWidth / 2
  settings.right_border = Map.X2 - settings.left_border
  settings.up_border =  RULE.ScreenHeight / 2
  settings.down_border = Map.Y2 - settings.up_border
  settings.ci_x = -Map.X2 + RULE.ScreenWidth
	settings.ci_y = -Map.Y2 + RULE.ScreenHeight
  if(settings.ci_x > 0) then
    settings.ci_x = 0
  end
  if(settings.ci_y > 0) then
    settings.ci_y = 0
  end
  
  settings.is_shake = false
  settings.shifting_x = 0
  settings.shifting_y = 0
  
  if(p_x <  settings.left_border)then
    self.c_x = 0
  elseif p_x <= settings.right_border then
    self.c_x = - p_x +  settings.left_border
  else
    self.c_x = settings.ci_x
  end
  if(p_y < settings.up_border)then
    self.c_y = 0
  elseif p_y <= settings.down_border then  
    self.c_y = - p_y + settings.up_border
  elseif(p_y > settings.down_border)then
    self.c_y = settings.ci_y
  end
end

function Camera:MoveX(speed,p_x,p_y)

  if(p_x < settings.left_border)then
    self.c_x = settings.shifting_x
  elseif(p_x <= settings.right_border)then
    self.c_x = self.c_x - speed
  else
    self.c_x = settings.ci_x + settings.shifting_x
  end 
end

function Camera:MoveY(speed,p_x,p_y)
  
  if(p_y < settings.up_border)then
    self.c_y = settings.shifting_y
  elseif(p_y <= settings.down_border)then
    self.c_y = self.c_y - speed
  else
    self.c_y = settings.ci_y + settings.shifting_y
  end
end

return Camera