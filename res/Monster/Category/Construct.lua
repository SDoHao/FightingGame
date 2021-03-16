--建筑
Construct = {
  uid,
  --Attribute 
  name,
  Faction,
  level,
  hp,
  HPMAX,
  hp_regen,
  face,
  status,
  --last status
  last,
  x,
  fix_x,
  y,
  z,
  avx,
  Atk_Speed,
  Physical_Damage,
  guard_range,
  Stiffness,
  --抗性
  resistance,
  hit_recovery,
  attack_delay,
  
  --buff
  unbreakable,
  superarmor,
  AttachEffect,
    
  --image
  frame,
  timer,
  rat,
  imgs,
  Sequence,
  control,

  HitBox,
  face_image,

}

local CommmonData = {
  stand_rat = 0.2,
  attack_rat = 0.05,
  hit_rat = 0.08,
}

--debug
local DrakeSequence = {
    --103 416
    --起始帧 末尾帧(max--99) 递增 到达末尾帧之后角色状态 帧 是否待机
    [1] = {1,6,1,1,1,true},--stand
    [2] = {1,1,1,3,1,false},--hit
    [3] = {1,1,0,3,1,false},--hit2
    
    [9] = {nil},--idle
}

local function LoadImage(path,max_frame,x_offset,y_offset)
  local _Monster_Image = {}
  local _Pos_File = io.open(table.concat({path,'pos.txt'}) ,"r")
  for i = 1, max_frame do
    local _img = {nil,nil,nil}
    _img[1] = love.graphics.newImage(table.concat({path,i-1,'.png'}))
    _img[2] = _Pos_File:read("*n") - x_offset
    _img[3] = _Pos_File:read("*n") - y_offset
    _Monster_Image[i] = _img
  end
  io.close(_Pos_File)

  return _Monster_Image
end


function Construct:New(uid,x,y,face,settings,ai)
  
  local new_Const = ai or {}  
  setmetatable(new_Const,self) 
  self.__index = self
  
  new_Const.uid = uid
  new_Const.name = settings.name --or table.concat(uid,":MISSING:\'NAME\'",)
  
  new_Const.imgs = {}
  --debug
  new_Const.imgs[1] = LoadImage("res/Monster/Animation/Drake/",20,103,416)
  new_Const.HitBox = BoxDataRead("res/Monster/Animation/Drake/hitbox.txt")
  new_Const.Sequence = DrakeSequence
  
  new_Const.face_image = 1
  new_Const.face = face
  new_Const.frame = 1
  new_Const.timer = 0
  new_Const.rat = 0
  new_Const.status = 1
  new_Const.last = 1
  
  new_Const.control = true
  new_Const.Stiffness = 0
  new_Const.unbreakable = false
  new_Const.hit_recovery = 0.45
  new_Const.hp = 400000
  new_Const.HPMAX = 400000
  new_Const.hp_regen = 10520
  new_Const.level = 200
  
  new_Const.x = x
  new_Const.fix_x = x
  new_Const.y = y
  new_Const.z = 0
  new_Const.vx = 0
  new_Const.avx = 0
  ImageOrder:push(new_Const,new_Const:GetOrder())
  
  return new_Const
end



function Construct:update(dt)

  self.timer = self.timer + dt
  --CRT_frames
  if(self.timer >= self.rat)then
    
    if(self.hp < self.HPMAX and self.hp > 0)then
      self.hp = self.hp + self.hp_regen * self.rat
    end
    
    local frame = self.frame
    local _frames = self.Sequence[self.status]
    self.timer = 0
    if(self.last == self.status)then
        self.frame = self.frame + _frames[3]
        if(self.frame > _frames[2])then
          self.status = _frames[4]
          self.frame = _frames[5]
          self.control = _frames[6]
        end
    else
      self.last = self.status
      self.frame = _frames[1]
    end
    
    if(self.x ~= self.fix_x)then
      if(self.x > self.fix_x)then
        self.x = self.x - self.avx
        if(self.x < self.fix_x)then
          self.x = self.fix_x
        end
      else
        self.x = self.x + self.avx
        if(self.x > self.fix_x)then
          self.x = self.fix_x
        end
      end
    end
    
  end

  
  if(self.control)then
    -- 待机
    self:Await()
  else
    if(self.Stiffness > 0)then
      self.Stiffness = self.Stiffness - dt
      if(self.Stiffness < 0)then
        if(self.status == 7)then
          self.rat = CommmonData.stand_rat
          self.status = 8
        else
          if(self.hp > 0)then
            self.control = true
            self:Await()
          end
        end
        --self.Attack_State = false
      end
    end
  end
end

function Construct:Await()
  if(self.status ~= 9)then
    self.status = 1
    self.rat = CommmonData.stand_rat
  end
end

--necessary
function Construct:Death()
  self.control = false
  self.rat = 100
  self.unbreakable = true
end

function Construct:Hit(dir,damage,Stiffness,Repelling,float,float_v)
  if(self.unbreakable)then
   
  else
    self.control = false
    self.hp = self.hp - damage
    if(self.hp <= 0)then
      self:Death()
      return
    end
    Font:push(damage,self.x - 50,self.y - 75 + self.z,0.5)
    if(Stiffness > 0)then
      self.status = 2
      self.rat = CommmonData.hit_rat
      if(self.rat < 0)then
         self.rat = 0
      end
      self.avx = dir * Repelling 
      self.x = self.x + self.avx / 3
      self.avx = math.abs(self.avx) * 2
      self.Stiffness = self.Stiffness / 4 + Stiffness - self.hit_recovery
      if(self.Stiffness < 0)then
        self.Stiffness = 0
      end
      
      --self.Attack_State = false
      --love.audio.play(Voice.dmg[3])
      self.control = false
    end
  end
end

function Construct:draw()
  local imgs
  local frame = self.frame
  
  for i = 1, #self.imgs do
    imgs = self.imgs[i][frame]
    L_Graphics.draw(imgs[1],self.x + self.face * imgs[2],self.y + imgs[3] + self.z,0,self.face,1)
  end
  
end



function Construct:BuffActivate(AE)
  
end

function Construct:BuffVanish(uid)
  
end

function Construct:GetOrder()
  return self.y,self.x,self.y,self.uid
end

function Construct:GetPosition()
  return self.x,self.y,self.z
end

function Construct:GetName()
  return table.concat({'建筑 Lv:',self.level,' ',self.name})
end

function Construct:AI(dt)
  
end

function Construct:GetHealth()
  return self.hp
end

function Construct:GetFaceImage()
  return self.face_image
end

return Construct