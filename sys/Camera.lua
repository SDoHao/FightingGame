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
  --[[
  is_shake,
  shifting_x,
  shifting_y,
  amplitude,--震动幅度
  velocity,--震动速度
  weaken,--震动衰减
  duration,
  timer,
  ]]
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
--[[
function Camera:Shake(amplitude,velocity,weaken,duration)
  settings.is_shake=true
  settings.amplitude=amplitude or 4
  settings.velocity=velocity or 5
  settings.weaken=weaken or 800
  settings.duration=duration or 0.5
  settings.timer=0
end

function Camera:update(dt)
  if(settings.is_shake)then
    settings.timer = settings.timer + dt
    Camera.c_x = Camera.c_x - settings.shifting_x
    Camera.c_y = Camera.c_y - settings.shifting_y
    
    if(settings.timer >= settings.duration)then
      settings.is_shake = false
      settings.shifting_x=0
      settings.shifting_y=0
      return
    end
    
    if math.abs(settings.shifting_x) > settings.amplitude then
      settings.shifting_x = settings.amplitude
      settings.shifting_y = settings.amplitude
      settings.weaken = -(settings.weaken)
      settings.velocity = 0
    end
    
    settings.velocity = settings.velocity - settings.weaken*dt
    settings.shifting_x = settings.shifting_x + settings.velocity*dt
    settings.shifting_y = settings.shifting_y + settings.velocity*dt
    Camera.c_x = Camera.c_x + settings.shifting_x
    Camera.c_y = Camera.c_y + settings.shifting_y
  end
end
]]
function Camera:MoveX(speed,p_x,p_y)

  if(p_x < settings.left_border)then
    self.c_x = settings.shifting_x
  elseif(p_x <= settings.right_border)then
    self.c_x = self.c_x - speed
  else--if(p_x > settings.right_border)then
    self.c_x = settings.ci_x + settings.shifting_x
    --[[
    if(self.c_x >= 0) then
      self.c_x = 0
    end
    ]]
  end 
end

function Camera:MoveY(speed,p_x,p_y)
  
  if(p_y < settings.up_border)then
    self.c_y = settings.shifting_y
  elseif(p_y <= settings.down_border)then
    self.c_y = self.c_y - speed
  else--if(p_y > settings.down_border)then
    self.c_y = settings.ci_y + settings.shifting_y
    --[[
    if(self.c_y >= 0) then
      self.c_y = 0
    end
    ]]
  end
end

return Camera



--[[bug
Camera={
  c_x=0,
  c_y=0,
}

local settings={
  left_border,
  right_border,
  up_border,
  down_border,
  is_shake,
  shifting_x,
  shifting_y,
  amplitude,--震动幅度
  velocity,--震动速度
  weaken,--震动衰减
  duration,
  timer,
}

function Camera:init(p_x,p_y)
  
  settings.left_border =  RULE.ScreenWidth / 2
  settings.right_border = Map.X2 - settings.left_border
  settings.up_border =  RULE.ScreenHeight / 2
  settings.down_border = Map.Y2 - settings.up_border
  local ci_x = -Map.X2 + RULE.ScreenWidth
	local ci_y = -Map.Y2 + RULE.ScreenHeight
  
  settings.is_shake = false
  settings.shifting_x = 0
  settings.shifting_y = 0
  
  if(p_x <  settings.left_border)then
    self.c_x = 0
  elseif p_x <= settings.right_border then
    self.c_x = settings.left_border - p_x
  else
    self.c_x = ci_x
    if(self.c_x >= 0) then
      self.c_x = 0
    end
  end
  if(p_y < settings.up_border)then
    self.c_y = 0
  elseif p_y <= settings.down_border then  
    self.c_y = settings.up_border - p_y 
  elseif(p_y > settings.down_border)then
    self.c_y = ci_y
    if(self.c_y >= 0) then
      self.c_y = 0
    end
  end
   
end

function Camera:Shake(amplitude,velocity,weaken,duration)
  settings.is_shake=true
  settings.amplitude=amplitude or 4
  settings.velocity=velocity or 5
  settings.weaken=weaken or 800
  settings.duration=duration or 0.5
  settings.timer=0
end

function Camera:update(dt)
  if(settings.is_shake)then
    settings.timer = settings.timer + dt
    Camera.c_x = Camera.c_x - settings.shifting_x
    Camera.c_y = Camera.c_y - settings.shifting_y
    
    if(settings.timer >= settings.duration)then
      settings.is_shake = false
      settings.shifting_x = 0
      settings.shifting_y = 0
      return
    end
    
    if math.abs(settings.shifting_x) > settings.amplitude then
      settings.shifting_x = settings.amplitude
      settings.shifting_y = settings.amplitude
      settings.weaken = -settings.weaken
      settings.velocity = 0
    end
    
    local v = settings.velocity * dt
    settings.velocity = settings.velocity - settings.weaken * dt
    settings.shifting_x = settings.shifting_x + v
    settings.shifting_y = settings.shifting_y + v
    Camera.c_x = Camera.c_x + settings.shifting_x
    Camera.c_y = Camera.c_y + settings.shifting_y
  end
end

function Camera:MoveX(speed,p_x,p_y)

  if(p_x < settings.left_border)then
    self.c_x = settings.shifting_x
  elseif(p_x <= settings.right_border)then
    self.c_x =  settings.left_border - p_x
  else--if(p_x > settings.right_border)then
    self.c_x = self.c_x + settings.shifting_x
  end 
end

function Camera:MoveY(speed,p_x,p_y)
  
  if(p_y < settings.up_border)then
    self.c_y = settings.shifting_y
  elseif(p_y <= settings.down_border)then
    self.c_y = settings.up_border - p_y 
  else--if(p_y > settings.down_border)then
    self.c_y = self.c_y + settings.shifting_y
  end
end

return Camera

]]