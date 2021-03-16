AttachEffect2 = {
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
  imgs_up,
  --data
  up_index,
  frame_data,
  anim_finsh,
  --
  audio_effect,
  
  special = true,
  ae = true,
}

function AttachEffect2:init(duration,target,settings)
  
  _new = {}
  setmetatable(_new,self)
  self.__index = self
  
  _new.duration = duration or settings.duration
  _new.rat = settings.rat
  _new.frame_data = settings.frame_data
  _new.imgs_list = settings.imgs_list
  _new.up_index = 1
  _new.imgs_up = settings.imgs_list[1]
 
  _new.target = target
  _new._alpha = settings._alpha
  _new.anim_finsh = settings.anim_finsh
  
  _new.z = target.z
  return _new
  
end

function AttachEffect2:draw_up()
  L_Graphics.setColor(1,1,1,self._alpha)
  L_Graphics.draw(self.imgs_up[self.frame][1],self.face * self.imgs_up[self.frame][2] + self.x ,self.imgs_up[self.frame][3] + self.y + self.z,0,self.face,1)
  L_Graphics.setColor(1,1,1,1)
end

function AttachEffect2:draw_down()
  --nothing
end

function AttachEffect2:update(dt)
  self.timer = self.timer + dt
  local target = self.target
  self.x = target.x
  self.y = target.y + target.z
  self.face = target.face
  if(self.timer > self.rat)then
    --update
    local _frame_data = self.frame_data[self.up_index]
    if(self.frame == _frame_data[2])then
      if(_frame_data[3] ~= -1)then
        love.audio.play(self.audio_effect[_frame_data[3]])
      end
      if(_frame_data[6] == -1)then
        PassiveObjectManager:Destory(self.uid)
        return
      end
      if(self.duration < 0)then
        _frame_data = self.frame_data[self.anim_finsh]
        self.up_index = self.anim_finsh
        self.frame = _frame_data[1]
      else
        self.up_index = _frame_data[4]
        self.frame = _frame_data[6]
      end
      self.imgs_up = self.imgs_list[_frame_data[5]]
    else
      self.duration = self.duration - self.timer
      self.timer = 0
      self.frame = self.frame + 1
    end
  end
end

return AttachEffect2