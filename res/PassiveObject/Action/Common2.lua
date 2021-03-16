--Alpha
Common2 = {
  uid,
  x,
  y,
  z,
  face,
  imgs,
  _alpha,
  fade,
  anim_alpha,
  rat,
  timer,
  frame,
  frame_data,
  frame_index,
  imgs_list,
  audio_effect,
  is_atk,
  atkbox,
}

function Common2:init(class,target,settings)
  _new = {}
  setmetatable(_new,self)
  self.__index = self
  _new._alpha = settings.anim_alpha
  _new.rat = settings.anim_rat
  _new.anim_alpha = settings.anim_alpha
  _new.fade = settings.fade
  _new.frame_index = class
  _new.frame_data = settings.frame_data[_new.frame_index]
  _new.frame = _new.frame_data[1]
  if(_new.frame_data[3] ~= -1)then
    if(settings.audio_repeat)then
      love.audio.stop(settings.audio_effect[1])
    else
      settings.audio_repeat = true
    end
     
    love.audio.play(settings.audio_effect[_new.frame_data[3]])
  end
  _new.imgs =  settings.imgs_list
  _new.vx = settings.vx
  _new.z = target.z
  
  
  

  return _new
end

function Common2:draw()
  L_Graphics.setColor(1,1,1,self._alpha)
  L_Graphics.draw(self.imgs[self.frame][1],self.face * self.imgs[self.frame][2] + self.x ,self.imgs[self.frame][3] + self.y + self.z,0,self.face,1)
  L_Graphics.setColor(1,1,1,1)
end

function Common2:update(dt)
  
  self.timer = self.timer + dt
  self._alpha = self._alpha + self.fade
  self.x =  self.x + self.face * self.vx
  if(self.timer > self.rat)then
    --update
    
    if(self.frame == self.frame_data[2])then
      if(self.frame_data[4] == -1)then
        PassiveObjectManager:Destory(self.uid)
        
        return
      end

      self._alpha = self.anim_alpha
    else

      self.timer = 0
      self.frame = self.frame + 1
    end
  end
end

return Common2