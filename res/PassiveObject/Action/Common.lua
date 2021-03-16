--Anim_list
Common = {
  uid,
  x,
  y,
  z,
  face,
  imgs,
  rat,
  timer,
  frame,
  frame_data,
  audio_effect,
  is_atk,
  atkbox,
  Faction,
  Physical_Damage,
}

function Common:init(value,target,settings)
  
  _new = {}
  setmetatable(_new,self)
  self.__index = self
  
  if(target.random)then
     _new.frame_index = math.random(1,target.class)
  else
    _new.frame_index = 1
  end
  _new.frame = settings.frame_data[_new.frame_index][1]
  
  _new.Faction = target.Faction
  _new.Physical_Damage = target.Physical_Damage
  
  if(target.rat)then
    _new.rat = target.rat * value
  else
    _new.rat = settings.rat
  end
  
  _new.frame_data = settings.frame_data
  _new.imgs = settings.imgs_list
  _new.z = target.z
  return _new
end

function Common:draw()
  L_Graphics.draw(self.imgs[self.frame][1],self.face * self.imgs[self.frame][2] + self.x ,self.imgs[self.frame][3] + self.y + self.z,0,self.face,1)
end

function Common:update(dt)
  
  self.timer = self.timer + dt
  if(self.timer > self.rat)then
    --update
    local _frame_data = self.frame_data[self.frame_index]
    self.rat = self.rat + _frame_data[6]
    if self.frame == _frame_data[7] then
      PassiveObjectManager:Push(_frame_data[8],self.x,self.y,_frame_data[9],self)
    end
    if(self.frame == _frame_data[2])then
      if(_frame_data[5] == -1)then
        PassiveObjectManager:Destory(self.uid)
        return
      end
      if(_frame_data[3] ~= -1)then
        love.audio.play(self.audio_effect[_frame_data[3]])
      end
      self.frame = _frame_data[5]
      self.frame_index = _frame_data[4]
    else
      self.timer = 0
      self.frame = self.frame + 1
    end
  end
end

return Common