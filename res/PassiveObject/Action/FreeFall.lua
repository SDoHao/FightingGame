FreeFall  = {
  uid,
  x,
  y,
  z,
  vz,
  face,
  imgs,
  imgs_list,
  
  rat,
  timer,
  duration,
  
  frame,
  frame_data,
  frame_index,
  
  audio_effect,
  land_index,
  vanish_index,
  
  status,
  dust_id,
  
  is_atk,
  atkbox,
}

function FreeFall:init(value,target,settings)
  _new = {}
  setmetatable(_new,self)
  self.__index = self
  
  _new.rat = settings.rat
  _new.duration = settings.duration
  _new.vz = settings.vz or 0
  if(value ~= -1)then
    _new.z = value
  else
    _new.z = settings.altitude
  end
  
  _new.status = 0 -- 'fall'
  _new.imgs = settings.imgs_list

  _new.frame_index = 1
  
  _new.frame = settings.frame_data[1][1]
  _new.frame_data = settings.frame_data

  _new.land_index = settings.land_index
  _new.vanish_index = settings.vanish_index
  _new.audio_repeat = settings.audio_repeat
  settings.audio_repeat = true
  _new.dust_id = settings.dust_id
  return _new
  
end

function FreeFall:draw()
  L_Graphics.draw(self.imgs[self.frame][1],self.face * self.imgs[self.frame][2] + self.x ,self.imgs[self.frame][3] + self.y + self.z,0,self.face,1)
end

function FreeFall:update(dt)
  
  self.timer = self.timer + dt
  local _frame_data
  --update
  if(self.status == 0)then
    self.vz = self.vz + 29.4 * dt
    self.z = self.z + self.vz
    if(self.z > 0)then
      self.z = 0
      self.vz = 0
      self.status = 1
      self.frame_index = self.land_index
      _frame_data = self.frame_data[self.land_index]
      self.frame = _frame_data[1]
      PassiveObjectManager:Push(self.dust_id,self.x,self.y,self.rat,self)
      return
    end
  elseif(self.status ~= 2)then
    self.duration = self.duration - dt
    if(self.duration < 0)then
      self.status = 2
      self.frame_index = self.vanish_index
      _frame_data = self.frame_data[self.vanish_index]
      self.frame = _frame_data[1]
      return
    end
  end

  if(self.timer > self.rat)then
    _frame_data = self.frame_data[self.frame_index]
    if(self.frame == _frame_data[2])then
      if(self.status == 2)then
        PassiveObjectManager:Destory(self.uid)
        return
      end
      if(_frame_data[3] ~= -1)then
        if(self.audio_repeat)then
          love.audio.stop(self.audio_effect[1])
        end
        love.audio.play(self.audio_effect[_frame_data[3]])
      end
      self.frame = _frame_data[5]
      self.frame_index = _frame_data[4]
    else
      self.frame = self.frame + _frame_data[6]
    end
    self.timer = 0
  end
end

return FreeFall