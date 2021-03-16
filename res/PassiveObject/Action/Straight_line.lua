Straight_line = {
  uid,
  x,
  y,
  z,
  face,
  index,
  timer,
  time_span,
  max_swpan,
  max_class,
  c_index,
  s_index,
  rat,
  special = true,
  is_atk,
  atkbox,
  Physical_Damage,
}

function Straight_line:init(value,target,settings)
  
  _new = {}
  setmetatable(_new,self) 
  self.__index = self
  
  
  _new.Physical_Damage = target.Physical_Damage
  _new.max_class = settings.max_class or 1
  _new.max_swpan = value
  _new.s_index = 1
  _new.c_index = settings.class_index or 1 
  _new.index = settings.index
  _new.spawn_span = settings.time_span or 0.35
  _new.distance_interval = target.face * settings.distance_interval
  _new.rat = settings.anim_rat or 0
  --_new.size = settings.size
  _new.z = 0
  return _new
end

function Straight_line:update(dt)
  self.timer = self.timer + dt
  if(self.timer >= self.spawn_span)then
    self.x = self.x + self.distance_interval
    PassiveObjectManager:Push(self.index,self.x,self.y,self.c_index,self)
    if(self.s_index == self.max_swpan)then
      PassiveObjectManager:Destory(self.uid)
      return
    end
    self.timer = 0
    self.s_index = self.s_index + 1
    self.c_index = self.c_index % self.max_class + 1
  end
end

return Straight_line