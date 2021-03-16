AttachEffect = {
  uid,
  x,
  y,
  z,
  target,
  face,
  _alpha,
  rat,
  timer,
  frame,
  --img
  imgs_list,
  --data
  up_index,
  down_offset,
  frame_data,
  anim_finsh,
  --
  audio_effect,
  
  special = true,
  ae = true,
  is_atk,
  atkbox,
  Faction,
  Physical_Damage,
}

function AttachEffect:init(duration,target,settings)
  _new = {}
  setmetatable(_new,self)
  self.__index = self

  _new.duration = duration or settings.duration
  _new.rat = settings.rat
  _new.frame = settings.up_imgs
  _new.frame_data = settings.frame_data
  _new.imgs_list = settings.imgs_list
  _new.up_index = settings.up_index
  
  _new.Faction = target.Faction
  _new.Physical_Damage = target.Physical_Damage
  
  if(settings.down_offset ~= -1)then
    _new.down_offset = settings.down_offset
  end
  
  _new.target = target
  _new.z = target.z
  _new._alpha = settings._alpha
  _new.anim_finsh = settings.anim_finsh
  
  return _new
  
end

function AttachEffect:draw_up()
  L_Graphics.setColor(1,1,1,self._alpha)
  L_Graphics.draw(self.imgs_list[self.frame][1],self.face * self.imgs_list[self.frame][2] + self.x,self.imgs_list[self.frame][3] + self.y,0,self.face,1)
  L_Graphics.setColor(1,1,1,1)
end

function AttachEffect:draw_down()
  if(self.down_offset)then
    local frame = self.frame + self.down_offset
    L_Graphics.setColor(1,1,1,self._alpha)
    L_Graphics.draw(self.imgs_list[frame][1],self.face * self.imgs_list[frame][2] + self.x,self.imgs_list[frame][3] + self.y ,0,self.face,1)
    L_Graphics.setColor(1,1,1,1)
  end
end

function AttachEffect:update(dt)
  self.timer = self.timer + dt
  local target = self.target
  self.x = target.x
  self.y = target.y + target.z
  self.face = target.face
  if(self.timer > self.rat)then
    --update
    
    local _frame_data = self.frame_data[self.up_index]
    if(self.frame == _frame_data[2])then
      if(_frame_data[5] == -1)then
        PassiveObjectManager:Destory(self.uid)
        return
      end
      if(_frame_data[3] ~= -1)then
        love.audio.play(self.audio_effect[_frame_data[3]])
      end
      if(self.duration < 0)then
        _frame_data = self.frame_data[self.anim_finsh]
        self.up_index = self.anim_finsh
        self.frame = _frame_data[1]
      else
        self.duration = self.duration - self.timer
        self.up_index = _frame_data[4]
        self.frame = _frame_data[5]
      end
     
    else
      self.duration = self.duration - self.timer
      self.timer = 0
      self.frame = self.frame + _frame_data[6]
    end
  end
end

return AttachEffect