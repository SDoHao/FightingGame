LightingStome = {
  uid,
  x,
  y,
  z,
  face,
  index,
  timer,
  duration,
  time_span,
  range_x,
  range_y,
  rat,
  special = true,
  is_atk,
  atkbox,
  Physical_Damage,
  
  random,
  class,
}

function LightingStome:init(value,target,settings)
  
  _new = {}
  setmetatable(_new,self) 
  self.__index = self
  
  _new.index = settings.index
  _new.z = settings.altitude
  
  _new.Faction = target.Faction
  _new.Physical_Damage = target.Physical_Damage
  
  _new.duration = settings.duration or 5
  _new.time_span = settings.time_span or 0.35
  _new.range_x = settings.range_x or 120
  _new.range_y = settings.range_y or 60
  _new.rat = settings.anim_rat or 0
  
  if(settings.random)then
    _new.random = true
    _new.class = settings.class
  end
  
  return _new
end

function LightingStome:update(dt)
  self.timer = self.timer + dt
  if(self.timer >= self.time_span)then
    self.duration = self.duration - self.time_span
    
    PassiveObjectManager:Push(self.index,self.x + math.random(-self.range_x,self.range_x),self.y + math.random(-self.range_y,self.range_y),self.z,self)

  if(self.duration < 0)then
    PassiveObjectManager:Destory(self.uid)
  end
    self.timer = 0
  end
end

return LightingStome