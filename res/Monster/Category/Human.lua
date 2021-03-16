--人形
Human = {
  uid,
  lable,
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
  y,
  z,
  vx,
  avx,
  vz,
  Atk_Speed,
  Move_Speed,
  Physical_Damage,
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
  
  --ai
  target,
  guard_range,
  ai_timer,
}


--debug
--Zombie
local ZombieSequence={
  --起始帧 末尾帧(max--99) 递增 到达末尾帧之后角色状态 帧 是否待机
  [1] = {1,99,0,1,1,true},--stand
  [2] = {14,15,1,3,16,false},--hit
  [3] = {16,99,0,3,16,false},--hit2
  [4] = {16,17,1,5,17,false}, --Strike fly
  [5] = {17,99,0,5,17,false},--Strike fly2
  [6] = {18,19,1,7,19,false},--Fall_to_the_ground
  [7] = {19,99,0,7,19,false},--Fall_to_the_ground2
  [8] = {20,20,1,1,1,true},--stand_up
  [9] = {nil},--idle,
  [10] = {8,14,1,1,8,true},--move
  [11] = {16,18,1,12,19,false},--death
  [12] = {19,99,0,1,8,false},--death2
  [13] = {8,13,1,13,8,true},--move
  }

local CommmonData = {
  stand_rat = 0.2,
  move_rat = 0.1,
  attack_rat = 0.05,
  hit_rat = 0.08,
  dead_rat = 0.15,
}

local DialogeContent = {
  [1] = '祈祷nin~',
  [2] = 'Who disturbs my slumber?              ',
  [3] = '鲜血... ',
  [4] = '脑子... ',
  [5] = '你相信命运吗... ',
  }


local WitchSequence={
  --起始帧 末尾帧(max--99) 递增 到达末尾帧之后角色状态 帧 是否待机
  [1] = {1,8,1,9,17,true},--stand
  [2] = {60,60,1,3,60,false},--hit
  [3] = {60,99,0,3,60,false},--hit2
  [4] = {60,60,1,5,54,false}, --hit_fly
  [5] = {55,55,0,5,55,false},--hit_fly2
  [6] = {56,58,1,7,59,false},--Fall_to_the_ground
  [7] = {59,99,0,7,59,false},--Fall_to_the_ground2
  [8] = {65,65,1,1,1,true},--stand_up,
  [9] = {17,21,1,1,1,true},--idle
  [11] = {61,63,1,12,64,false},--death
  [12] = {64,99,0,1,8,false},--death2
  [13] = {9,16,1,13,9,true},--move
  
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


function Human:New(uid,x,y,z,settings,ai,test)
  
  local new_human = ai or {}  
  setmetatable(new_human,self) 
  self.__index = self
  
  new_human.uid = uid
 
  
  new_human.imgs = {}
  
  --debug
  new_human.lable = test
  if(test == 2)then
    new_human.name = '蓝色女巫'
    
    new_human.imgs[1] = LoadImage("res/Monster/Animation/Witch/bule_witch/",65,190,260)
    new_human.HitBox = BoxDataRead("res/Monster/Animation/Witch/bule_witch/hitbox.txt")
    new_human.Sequence = WitchSequence
    new_human.face_image = 1
  elseif(test == 1)then
    new_human.name = settings.name --or table.concat(uid,":MISSING:\'NAME\'",)
    new_human.imgs[1] = LoadImage("res/Monster/Animation/Zombie/ghoulgwish/",20,90,130)
    new_human.HitBox = BoxDataRead("res/Monster/Animation/Zombie/ghoulgwish/hitbox.txt")
    new_human.Sequence = ZombieSequence
    new_human.face_image = 3
  end
  
  new_human.face = 1
  new_human.frame = 1
  new_human.timer = 0
  new_human.rat = 0
  new_human.status = 1
  new_human.last = 1
  
  new_human.control = true
  new_human.Stiffness = 0
  new_human.unbreakable = false
  new_human.hit_recovery = 0.3
  new_human.hp = 1055200
  new_human.HPMAX = 1055200
  new_human.hp_regen = 5210
  new_human.level = 100
  
  new_human.Move_Speed = 90

  new_human.x = x
  new_human.y = y
  new_human.z = z
  new_human.vx = 0
  new_human.avx = 0
  new_human.vz = 0
  
  new_human.Faction = 1
  new_human.guard_range = 500
  new_human.ai_timer = 0
  
  ImageOrder:push(new_human,new_human:GetOrder())
  
  return new_human
end

function Human:update(dt)
  
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
      if(self.last == 9)then
        Speech:New(self,DialogeContent[1],3)
      end
      self.frame = _frames[1]
    end
  end
  
  if(self.vx ~= 0)then
    if(self.vx > 0)then
      
      self.vx = self.vx + self.avx
      if(self.vx < 0)then
        self.vx = 0
      end
    else
      self.vx = self.vx + self.avx
      if(self.vx > 0)then
        self.vx = 0
      end
    end
    self.x = self.x + self.vx
  end

  if(self.z < 0)then
    self.vz = 29.4 * dt + self.vz
    self.z =  math.modf(self.vz + self.z)
    
    if(self.control)then
      self.control = false
      self.status = 4
      self.Stiffness = 0.5
    end

    if(self.z >= 0)then --landing
      if(self.status == 10)then
        self.control = true
        --self.Attack_State = false
      elseif(self.status == 4 or self.status == 5)then
        self.status = 6
        self.vx = 0
      end
      self.z = 0
      self.vz = 0
    end
  else
    if(self.control)then
      -- 待机
      self:Await()
    else
      if(self.Stiffness > 0)then
        if self.z == 0 then
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
            --self.vx = 0
            --self.Attack_State = false
          end
        end
      end
    end
  end
end

function Human:Await()
  if(self.status ~= 9)then
    self.status = 1
    self.rat = CommmonData.stand_rat
  end
end


--necessary

function Human:Hit(dir,damage,Stiffness,Repelling,float,float_v)
  --print(self.unbreakable,self.frame,self.status)
  if(self.unbreakable)then
   
  else
    self.hp = self.hp - damage
    if(self.hp <= 0)then
      self:Death()
      return
    end
    Font:push(damage,self.x,self.y - 75 + self.z,0.5)
    if(Stiffness > 0)then
      self.control = false
      if(self.status ~= 6)then
        if(self.z < 0 or float)then
          if self.status == 7 then
            self.status = 4
          else
            self.status = 5
          end
          self.vz = float_v or -10
          self.z = self.z + self.vz
          self.vx = dir * Repelling / 2
        else --倒地
          if self.status ~= 7 then
            self.status = 2
          else
            self.status = 7
          end
          self.vx = dir * Repelling
        end
        self.rat = CommmonData.hit_rat
        if(self.rat < 0)then
           self.rat = 0
        end
        self.face = - dir
        self.avx = self.face * 0.1
      end
      
      self.Stiffness = self.Stiffness / 4 + Stiffness - self.hit_recovery
      if(self.Stiffness < 0)then
        self.Stiffness = 0
      end
    end
    --self.Attack_State = false
    --love.audio.play(Voice.dmg[3])
    
  end
end

function Human:draw()
  local imgs
  for i = 1, #self.imgs do
    imgs = self.imgs[i][self.frame]
    L_Graphics.draw(imgs[1],self.x + self.face * imgs[2],self.y + imgs[3] + self.z,0,self.face,1)
  end
  
  --[[
  L_Graphics.setColor(0.5,0.5,0.5)
  L_Graphics.circle('fill',self.x,self.y,20)
  
  local hitdata = self.HitBox[frame]
  L_Graphics.setColor(1,1,0,1)
  L_Graphics.rectangle("line",self.x + self.face * hitdata[1] - hitdata[3],self.y + hitdata[2] + self.z  - hitdata[4], hitdata[3] * 2, hitdata[4] * 2)
  L_Graphics.setColor(1,1,1)
  ]]
end

function Human:Death()
  self.control = false
  self.status = 11
  self.rat = CommmonData.dead_rat
  self.unbreakable = true
  if(self.lable == 2)then
    Speech:New(self,DialogeContent[5],3)
  end
end

function Human:BuffActivate(AE)
  
end

function Human:BuffVanish(uid)
  
end

function Human:GetOrder()
  return self.y,self.x,self.y,self.uid
end

function Human:GetPosition()
  return self.x,self.y,self.z
end

function Human:GetName()
  return table.concat({'人形 Lv:',self.level,' ',self.name})
end

function Human:MoveLeft(dt)
 if(self.control)then
    self.face = -1
    self.status = 13
    self.rat = CommmonData.move_rat
    if (self.y >= Map.wax1) then
      self.x = self.x - self.Move_Speed * dt
    end
  end
end

function Human:MoveRight(dt)
  if(self.control)then
    self.face = 1
    self.status = 13
    self.rat = CommmonData.move_rat
    if (self.y <= Map.wax2) then
      self.x = self.x + self.Move_Speed * dt
    end
  end
end

function Human:MoveUp(dt)
  if(self.control)then
    self.status = 13
    self.rat = CommmonData.move_rat
    if (self.y >= Map.way1) then
      self.y = self.y - self.Move_Speed * dt
    end
  end
end

function Human:MoveDown(dt)
  if(self.control)then
    self.status = 13
    self.rat = CommmonData.move_rat
    if (self.y <= Map.way2) then
      self.y = self.y + self.Move_Speed * dt
    end
  end
end

function Human:AI(dt)
  if(self.hp > 0 and self.target)then
    if(self.target:GetHealth() <= 0)then
      self.target = nil
      return
    end
    local g_range = self.guard_range
    if(self.ai_timer == 0)then
      if(self.lable == 1)then
        Speech:New(self,DialogeContent[math.random(2,4)],4)
      end
      self.ai_timer = 0.1
    elseif(self.ai_timer > 50)then
      if(self.lable == 1)then
        Speech:New(self,DialogeContent[math.random(3,4)],3)
      end
      self.ai_timer = 0.1
    end
    self.ai_timer = self.ai_timer + dt * (math.random(0,8))
    if self.control and self.ai_timer > 10 then
      local close = false
      local x,y
      x,y = self.target:GetPosition()
      if math.abs(self.x - x) < g_range then
        if math.abs(self.y - y) < g_range then
          if(self.x - x < 80)then
            if(x - self.x < 80)then
              --close = true
            else
              self:MoveRight(dt)
            end
          else
            self:MoveLeft(dt)
          end
           if(self.y - y < 10)then
            if(y - self.y < 10)then
            else
              self:MoveDown(dt)
            end
          else
            self:MoveUp(dt)
          end
        end
      else
        self.target = nil
      end
    end
  else
    if(self.Faction == 1)then
      for i = #(APCGroup),1,-1 do
        if(APCGroup[i]:GetHealth() > 0)then
          self.target = APCGroup[i]
          return
        end
      end
      self.target = Player
    else
      for i = #(EnemyGroup),1,-1 do
        if(EnemyGroup[i]:GetHealth() > 0)then
          self.target = EnemyGroup[i]
          return
        end
      end
    end
  end
end

function Human:GetHealth()
  return self.hp
end

function Human:GetFaceImage()
  return self.face_image
end

return Human