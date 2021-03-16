Straight_ptl = {
  uid,
  x,
  vx,
  y,
  z,
  face,
  imgs,
  _alpha,
  timer,
  frame,
  max_frame,
  duration,
  audio_effect,
  rat,
  is_atk,
  atkbox,
}

function Straight_ptl:init(duration,target,settings)
  _new = {}
  setmetatable(_new,self)
  self.__index = self
  _new._alpha = settings.anim_alpha
  _new.rat = settings.anim_rat
  _new.duration = duration or settings.duration
  _new.frame = 1
  _new.imgs = settings.imgs_list
  _new.vx = target.face * settings.vx
  _new.max_frame = settings.anim_data[1][3]
  _new.z = target.z
  return _new
end

function Straight_ptl:draw()
  L_Graphics.setColor(1,1,1,self._alpha)
  L_Graphics.draw(self.imgs[self.frame][1],self.face * self.imgs[self.frame][2] + self.x ,self.imgs[self.frame][3] + self.y + self.z,0,self.face,1)
  L_Graphics.setColor(1,1,1,1)
end

function Straight_ptl:update(dt)
  self.timer = self.timer + dt
  self.x =  self.x + self.vx
  if(self.timer > self.rat)then
    self.duration = self.duration - self.rat
    if(self.duration <= 0)then
      PassiveObjectManager:Destory(self.uid)
    end
    self.timer = 0
    self.frame = (self.frame % self.max_frame) + 1
  end
end

return Straight_ptl