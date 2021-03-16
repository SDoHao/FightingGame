HM = {
  hp=70,
  hps=70,
  maxhp=70,
  hp_regen=0,
  zt='N',
  x=3,
  y=410,
  w=38,
  h=70,
  --减少的颜色
  c_r1=1,
  c_g1=1,
  c_b1=1,
  --当前颜色
  c_r2=1,
  c_g2=1,
  c_b2=1,
  brea = false,
} 

local const = 70
local bottom = love.graphics.newImage("res/UI/HMP_bottom.png")

function HM:new() 
  local o =  {} 
  setmetatable(o,self)  
  self.__index = self 
  return o 
end 

function HM:init(hm,hm_max,hm_regen) 
  self.hp=hm*(const/hm_max)
  self.maxhp=hm_max
  self.hp_regen=hm_regen*(const/hm_max)
end

function HM:setcolor(r1,g1,b1,r2,g2,b2) 
   self.c_r1=r1
   self.c_g1=g1
   self.c_b1=b1
   self.c_r2=r2
   self.c_g2=g2
   self.c_b2=b2
end

function HM:update(dt)
  if self.zt=='N' then
    if self.hp < self.hps then
      self.hps=self.hps - dt * 25
    end
  elseif self.zt=='add' then
    if self.brea then
      self.zt='N'
    elseif self.hp<self.hps then
      local newhp=self.hp+dt*150
      if newhp>self.hps then
        self.hp=self.hps
        self.zt='N'
      else
        self.hp=newhp
      end 
    end 
  end
  if(self.hp<const and self.hp>0)then
    self.hp=self.hp+self.hp_regen*dt
  elseif(self.hp>=const)then
    self.hp=const
  elseif(self.hp==0)then
    self.hp=0
  end
end 

function HM:add(val)
  val=val*(const/self.maxhp)
  --print("add",val)
  if (self.hp+val)>const then 
    self.hps=const
    self.zt='add'
  elseif self.zt=='add' then
    if (self.hps+val)>const then 
    self.hps=const
    else
    self.hps=self.hps+val
    end
  else
    self.hps=self.hp+val
    self.zt='add'
  end
end 

function HM:sub(val) 
  val=val*(const/self.maxhp)
  if (self.hp-val)>0 then 
  self.hp=self.hp-val 
  else 
    self.hp=0 
    self.hps=0 
  end 
end 

function HM:draw()
  local L_Graphics = love.graphics
 --bottom
 --print(self.x,self.y)
  L_Graphics.draw(bottom,self.x,self.y)
--边框
  L_Graphics.setPointSize( 3 )
  L_Graphics.setColor(50,50,255)
  L_Graphics.rectangle("line",self.x,self.y,self.w,self.h)
  --当前量
  --L_Graphics.setPointSize( 1 )
  L_Graphics.setColor(self.c_r1,self.c_g1,self.c_b1)
  L_Graphics.rectangle("fill",self.x,(self.y+const-self.hps),self.w,self.hps) 
--最低量

  L_Graphics.setColor(self.c_r2,self.c_g2,self.c_b2)
  L_Graphics.rectangle("fill",self.x,(self.y+ const-self.hp),self.w,self.hp) 
  
  L_Graphics.setColor(255,255,255)
  
end

return HM