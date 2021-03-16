--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月16日]
    [LastModifiedTime: ]
****************************************************************************]]
local Voice = require("res/Audio/character/swordman")
local SwordmanSkillVoice = require("res/Audio/character/SwordmanSkillVoice")
local SwordManSequence = require("res/Character/SwordMan/SwordManData")
local skill_datas = require("res/Character/SwordMan/SkillData")


local HitBox
local AtkBox

SwordMan=
{
  name,
  uid,
  Faction,
  --Attribute 
  level,
  hp,
  HPMAX,
  hp_regen,
  mp,
  MPMAX,
  mp_regen,
  speed_x,
  speed_y,
  status,
  face,
  guard_range,
  x,
  y,
  z,
  Restats,
  --buff
  --squatable = false,
  unbreakable = false,
  --internal_variables
  CouldBounce = true,
  avatar={},
  weapon={},
  frame = 1,
  --Sequence,
  -- 普攻相关
  Physical_Damage,
  Atk_Speed,
  gatk_s = 0,
  Gatk_WC = 0,
  atspincre = 0,
  Attack_State = false,
  Y_AxisAttackRange = 35,
  AtkBox = {},
  HitBox = {},
  atk_group,
  --run
  run,
  --jump
  in_air = false,
  jump_pow,
  vx = 0,
  avx = 0,
  vy = 0,
  vz = 0,
  --
  imgs,
  ai_timer = 0,
  timer = 0,
  control = true,
  Stiffness = 0,
  AttachEffect,
  face_image,
  target,
}

--Generic Variable
--common_variables
local int_var = {
  guard = 2,
  category = "human",
  stand_rat = 0.1,
  walk_rat = 0.12,
  run_rat = 0.2,
  hit_rat = 0.08,
  death_rat = 0.05,
  gatk_wait_count = 0.4,
  uid = 1100,
}

local def_set = {--default_settings
  name = "MISSING:\'NAME\'",
  uid=1,
  level=1,
  HPMAX=600,
  hp_regen=0,
  MPMAX=700,
  mp_regen=0,
  speed_x=150,
  Atk_Speed=15,
  jump_pow=-10,
  Physical_Damage = 100,
  status=0,
  face=1,
  guard=0,
  guard_range = 520,
  x=0,
  y=0,
  z=0,
  Restats = 80,
}

local function CharacterSortImage(Target)
  local _Sort = {}
  table.insert(_Sort,Avatar_Holder[Target.avatar.skin_vid])
  if(Avatar_Holder[Target.avatar.skin_vid].layer < 8)then
    table.insert(_Sort,Avatar_Holder[Target.avatar.coat_vid])
    table.insert(_Sort,Avatar_Holder[Target.avatar.pant_vid])
    table.insert(_Sort,Avatar_Holder[Target.avatar.shoe_vid])
    table.insert(_Sort,Avatar_Holder[Target.avatar.hair_vid])
  end
  if not Avatar_Holder[Target.avatar.skin_vid].cover then
      local weapon = Weapon_Holder[Target.weapon.weapon_vid]
      local weap_b = {imgs,layer}
      local weap_c = {imgs,layer}
      weap_b.imgs = weapon.imgs_b
      weap_b.layer = weapon.layer_b
      weap_c.imgs = weapon.imgs_c
      weap_c.layer = weapon.layer_c
      table.insert(_Sort,weap_b)
      table.insert(_Sort,weap_c)
  end
  table.sort(_Sort, function(a,b) return a.layer < b.layer end)
  Target.imgs = {}
  for k,v in pairs(_Sort)do
    Target.imgs[k] = v.imgs
  end
  _Sort = nil
  collectgarbage("collect")
end

function SwordManBoxDataInit()
  HitBox = BoxDataRead("res/Character/SwordMan/hitbox.txt")
  AtkBox = BoxDataRead("res/Character/SwordMan/atkbox.txt")
end
--[[
function SM_Battle(battle) 
  if(battle)then
    int_var.guard=2
  else
    int_var.guard=1
  end
end 
]]
function SwordMan:New(name,settings,...)
  
  --_new = cloneTab(SwordMan)
  local _new = {}  
  setmetatable(_new,self) 
  self.__index = self
  
  --数据
  _new.level=settings.level or def_set.level
  _new.name=name or settings.name or def_set.name
  _new.name=table.concat({ "lv ",_new.level.." ",_new.name})
  _new.HPMAX=settings.HPMAX or def_set.HPMAX
  _new.hp=_new.HPMAX
  _new.hp_regen = settings.hp_regen or def_set.hp_regen
  _new.MPMAX=settings.MPMAX or def_set.MPMAX
  _new.mp=_new.MPMAX
  _new.mp_regen=settings.mp_regen or def_set.mp_regen
  _new.speed_x=settings.speed or def_set.speed_x
  _new.speed_y=_new.speed_x/1.2
  _new.Atk_Speed = settings.Atk_Speed or def_set.Atk_Speed
  _new.jump_pow = settings.jump_pow or def_set.jump_pow
  
  _new.Physical_Damage = def_set.Physical_Damage
  
  _new.Restats = (settings.Restats or def_set.Restats ) / 1000
  _new.guard_range = def_set.guard_range
  _new.Faction = settings.Faction
  _new.face = settings.face or def_set.face
  _new.x = settings.x or def_set.x
  _new.y = settings.y or def_set.y
  _new.z = settings.z or def_set.z
  _new.status = 1
  _new.last = 0
  _new.run = false
  _new.rat = 0
  
  --face_image
  _new.face_image = settings.face_image or 1
  --图像
  _new.uid = settings.uid or GetUid()
  _new.avatar = AvatarsManager:NewAvatar()
  _new.avatar.skin_id = settings.skin_id or 1
  _new.avatar.skin_vid = AvatarsManager:load(_new.avatar.skin_id)
  _new.avatar.coat_id = settings.coat_id or 4
  _new.avatar.coat_vid = AvatarsManager:load(_new.avatar.coat_id)
  _new.avatar.pant_id = settings.pant_id or 5
  _new.avatar.pant_vid = AvatarsManager:load(_new.avatar.pant_id)
  _new.avatar.shoe_id = settings.shoe_id or 6
  _new.avatar.shoe_vid = AvatarsManager:load(_new.avatar.shoe_id)
  _new.avatar.hair_id = settings.hair_id or 7
  _new.avatar.hair_vid = AvatarsManager:load(_new.avatar.hair_id)
  _new.weapon = WeaponsManager:NewWeapon()
  _new:EquipWeapon(settings.weapon_id)
 
  _new.imgs = {}
  _new.AttachEffect = {}
  
  _new.HitBox = HitBox
  _new.AtkBox = AtkBox
  
  CharacterSortImage(_new)
  ImageOrder:push(_new,_new:GetOrder())
  
  return _new
end

function SwordMan:EquipWeapon(itemid)
  local weaponid = ItemList[itemid].id
  local wep_vid = WeaponsManager:load(WeaponList[weaponid].Uid)
  self.Atk_Speed = self.Atk_Speed - WeaponList[weaponid].attack_speed
  self.Physical_Damage = self.Physical_Damage + WeaponList[weaponid].equipment_physical_attack
  
  self.weapon.weapon_id = itemid
  self.weapon.weapon_vid = wep_vid
  if(WeaponList[weaponid].e_type==3)then
    self.weapon.atk_effect[1] = sm_Audio.beamatk_01
    self.weapon.atk_effect[2] = sm_Audio.beamatk_02
    self.weapon.atk_effect[3] = sm_Audio.beamatk_03
    self.weapon.jump = sm_Audio.beam_jump
    self.weapon.run_hit = sm_Audio.beam_hit
    --[[
  elseif(WeaponList[weaponid].e_type==4)then
    self.weapon.atk_effect[1] = sm_Audio.lswatk_01
    self.weapon.atk_effect[2] = sm_Audio.lswatk_02
    self.weapon.atk_effect[3] = sm_Audio.lswatk_03
    self.weapon.jump=sm_Audio.lsword_jump
    self.weapon.run_hit=sm_Audio.lsw_hit
    ]]
  else
    self.weapon.atk_effect[1] = sm_Audio.lkaatk_01
    self.weapon.atk_effect[2] = sm_Audio.lkaatk_02
    self.weapon.atk_effect[3] = sm_Audio.lkaatk_03
    self.weapon.jump=sm_Audio.lkat_jump
    self.weapon.run_hit=sm_Audio.lka_hit
  end
end

function SwordMan:ReplaceWeapon(id)
  if(id==-1)then id = 1 end --default
  if(self.weapon.InCooling)then
    return false  --更替武器失败--  冷却中
  else
    local weaponid = ItemList[id].id
    if(WeaponList[weaponid].minimum_level <= self.level  and  WeaponList[weaponid].usable_job == "鬼剑士")then
      local _wid = ItemList[self.weapon.weapon_id].id
      self.Atk_Speed = self.Atk_Speed + WeaponList[_wid].attack_speed
      self.Physical_Damage = self.Physical_Damage - WeaponList[_wid].equipment_physical_attack
      --WeaponsManager:unload(self.weapon.weapon_vid)
      self:EquipWeapon(id)
      CharacterSortImage(self)
      self.weapon.InCooling = true
      return true --更替武器成功  等级不足 或者 职业不符
    else
      return false
    end
  end
end

--Standby
function SwordMan:Await()
    self.status = int_var.guard
    self.rat = int_var.stand_rat
    --self.frame = frame_datas[self.status][1]
end

--move
function SwordMan:SpeedCtrX(run)
  local speed_x = self.speed_x
  if(self.in_air)then
    speed_x = speed_x / 1.2
  else
    if(run)then
      self.status = 4
      self.rat = int_var.run_rat
      speed_x = speed_x * 1.5
    else
      self.status=3
      self.rat = int_var.walk_rat
    end
  end
  return speed_x
end

function SwordMan:SpeedCtrY(run)
  local speed_y = self.speed_y
  if(self.in_air)then
    speed_y = speed_y / 1.2
  else
    if(run)then
      self.status = 4
      self.rat = int_var.run_rat
      speed_y = speed_y * 1.5
    else
      self.status = 3
      self.rat = int_var.walk_rat
    end
  end
  return speed_y
end

function SwordMan:MoveLeft(dt,run,faceto)
  self.face = faceto or -1
  speed = math.floor(self:SpeedCtrX(run)*dt)
  self.x = self.x - speed
  return -speed
end

function SwordMan:MoveRight(dt,run,faceto)
  speed = math.floor(self:SpeedCtrX(run)*dt)
  self.face = faceto or 1
  self.x = self.x + speed
  return speed
end

function SwordMan:MoveUp(dt,run)
  speed_y = math.floor(self:SpeedCtrY(run)*dt)
  self.y = self.y - speed_y
  return -speed_y
end
  
function SwordMan:MoveDown(dt,run)
  speed_y = math.floor(self:SpeedCtrY(run)*dt)
  self.y = self.y + speed_y
  return speed_y
end

function SwordMan:Attack(run)
  self.control = false
  self.Attack_State = true
  self.atk_group = nil
  if(self.Faction == 1)then
    self.atk_group =  cloneTab(APCGroup)
  else
    self.atk_group =  cloneTab(EnemyGroup)
  end
  if(self.in_air)then
    self.status = 10
    self.gatk_s = 0
    love.audio.play(Voice.jump_atk)
    love.audio.play(self.weapon.jump)
  else
    if(run)then
      self.status = 11
      self.gatk_s = 0
      self.run = false
      love.audio.play(Voice.jue_01)
      love.audio.play(self.weapon.run_hit)
    else
      self.Gatk_WC = 0
      self.gatk_s = self.gatk_s % 3 + 1
      self.status = 6 + self.gatk_s
      love.audio.play(Voice.atk[self.gatk_s])
      love.audio.play(self.weapon.atk_effect[self.gatk_s])
    end
    self.vx = self.face * 1.8
    self.avx = -self.face * 0.25
  end
  self.rat = self.Atk_Speed / 180
end

function SwordMan:Jump()
  if(self.status ~= 5 and self.status ~= 6)then
    self.status = 4
    self.gatk_s = 0
    self.vz = self.jump_pow
    self.in_air = true
    self.rat = int_var.stand_rat
    love.audio.play(Voice.jump)
  end
end

function SwordMan:JumpBack()
  if(self.status ~= 5 and self.status ~= 6)then
    self.status = 4
    self.gatk_s = 0
    self.vx = self.face * -5
    self.avx = self.face * 0.25
    self.vz = self.jump_pow / 2
    self.in_air = true
    self.rat = int_var.stand_rat
    love.audio.play(Voice.jump)
  end
end

function SwordMan:Hit(dir,damage,Stiffness,Repelling,float,float_v)
  if(self.unbreakable)then
   
  else
    self.hp = self.hp - damage
    if(self.hp <= 0)then
      if(self.status ~= 18 and self.status ~= 19)then
        self.hp = 0
        self:Death()
        return
      end
    end
    Font:push(damage,self.x,self.y - 100 + self.z,0.5)
    if(Stiffness > 0)then
      if(self.status ~= 16)then
        self.face = -dir
        if(self.in_air or float)then
          self.in_air = true
          if self.status == 17 then
            self.status = 15
          else
            self.status = 14
          end
          self.vz = float_v or -10
          self.vx = dir * Repelling / 2
          self.avx = self.face * 0.2
        else --倒地
          if self.status ~= 17 then
            self.status = 12
          else
            self.status = 16
          end
          self.vx = dir * Repelling
          self.avx = self.face * 0.4
        end
        
        self.rat = int_var.hit_rat
        if(self.rat < 0)then
           self.rat = 0
        end
        
      end

      self.Stiffness = self.Stiffness / 4 + Stiffness - self.Restats
      self.Attack_State = false
      love.audio.play(Voice.dmg[math.random(1,3)])
      self.control = false
    end
  end
end

function SwordMan:update(dt)
  self.timer = self.timer + dt
  
  if(self.timer >= self.rat)then
    if(self.hp < self.HPMAX and self.hp > 0)then
      self.hp = self.hp + self.hp_regen * self.rat
    end
    --local frame = self.frame
    local _frame_data = SwordManSequence[self.status]
    if(self.weapon.InCooling)then
      self.weapon.Timer = self.weapon.Timer + self.timer
      if(self.weapon.Timer >= self.weapon.CoolTime)then
        self.weapon.InCooling = false
        self.weapon.Timer = 0
      end
    end
    if self.control and self.gatk_s ~= 0 then
      self.Gatk_WC = self.Gatk_WC + self.timer
      if (self.Gatk_WC >= int_var.gatk_wait_count)then
        self.gatk_s = 0
        self.Gatk_WC = 0
      end
    end
    --********************************到达末尾帧之后************************************************
    --[1]起始帧 [2]末尾帧 [3]递增帧数 [4]角色状态  [5]帧 [6]是否待机 [7]速率增长 [8]速率 [9]特效id [10]参数 [11]是否攻击状态
    --参数
    if(self.last == self.status)then
        self.frame = self.frame + _frame_data[3]
        self.rat = self.rat - _frame_data[7]
        if(self.frame > _frame_data[2])then
          self.frame = _frame_data[5]
          if(_frame_data[12] == 0)then
            self.status = _frame_data[4]
            self.control = _frame_data[6]  
            self.Attack_State = _frame_data[11] 
            if(_frame_data[13])then
              love.audio.play(SwordmanSkillVoice[_frame_data[13]])
            end
            if(_frame_data[8] ~= 0)then
               self.rat = _frame_data[8]
            end
            if(_frame_data[9] ~= 0)then
              PassiveObjectManager:Push(_frame_data[9],self.x,self.y,_frame_data[10],self)
            end
          else
            self:PerformSkill(_frame_data[12])
          end
          

      end
    else
      self.last = self.status
      self.frame = _frame_data[1]
    end
    self.timer = 0
    
    if(self.Attack_State)then
      local _atk_box = self.AtkBox[self.frame]
      local _atk_box_x = self.face * _atk_box[1] + self.x
      local _atk_box_y = _atk_box[2] + self.y + self.z
      local _hit_hit
      local emeny
      local v
      if(self.Faction == 0)then
        --self.target = -1
        for i = #(self.atk_group),1,-1 do
          v = self.atk_group[i]
          if math.abs(self.y - v.y) < self.Y_AxisAttackRange then
            _hit_hit = v.HitBox[v.frame]
            if math.abs(_hit_hit[1] * v.face + v.x - _atk_box_x) < _hit_hit[3] + _atk_box[3] and math.abs(_hit_hit[2] + v.y + v.z - _atk_box_y) < _hit_hit[4] + _atk_box[4] then
              self.target = v
              BloodBars:getTarget(self.target)
              table.remove(self.atk_group,i)
              if(self.in_air)then
                v:Hit(self.face, self.Physical_Damage,0.75,10,true,-6)
              elseif(self.gatk_s == 3)then
                v:Hit(self.face, self.Physical_Damage * 1.2,0.68,3,true,-10)
              elseif(self.status == 11)then
                v:Hit(self.face, self.Physical_Damage * 1.35,0.9,7,false,-6)
              elseif(self.status == 35 or self.status == 36)then
                v:Hit(self.face, self.Physical_Damage,0.6,3.5,true,-6)
              elseif(self.status == 82)then
                v:Hit(self.face, self.Physical_Damage,0.7,1.2,false,-6)
              else
                v:Hit(self.face, self.Physical_Damage,0.72,5,false,-5)
              end
            end
            
          end
        end
        --if(type(self.target)~='number')then
          
        --end
      end

    end
    
  elseif(self.last ~= self.status)then
    self.last = self.status
    self.frame = SwordManSequence[self.status][1]
  end
  -- 待机
  
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
  
  
    
  if(self.in_air)then
    self.vz = 29.4 * dt + self.vz
    self.z =  math.modf(self.vz + self.z)
    if(self.control)then
      if(self.vz >= 0)then
        self.status = 6
      else
        self.status = 5
      end
    else
      
    end
if self.z >= 0 then --landing
      
      if self.status == 10 then
        self.control = true
        self.Attack_State = false
      end
      if(self.status == 15)then
        
        if self.CouldBounce and self.vz > 5 then
          if self.hp > 0 then
            self.status = 15
          end
          self.vz = -self.vz / 1.65
          self.z = -1
          self.CouldBounce = false
        else
          self.status = 16
          self.CouldBounce = true
          self.z = 0
          self.vx = 0
          self.vz = 0
          self.in_air = false
        end
      else
        self.vx = 0
        self.z = 0
        self.vz = 0
        self.in_air = false 
      end 
    end
  else
    if(self.control)then
      self:Await()
    else
      if(self.Stiffness > 0)then
        if not self.in_air then
          self.Stiffness = self.Stiffness - dt
          if(self.Stiffness < 0)then
            --self.vx = 0
            self.Attack_State = false
            if(self.hp > 0)then
              self.control = true
              self:Await()
            end
          end
        end
      end
    end
  end
end

function SwordMan:PerformSkill(skill_id)
 --vx accelerated vz Stiffness(ms) rat PassiveObject parameter1
 --是否空中发动 x速度 加速度 z速度 后摇 速率 特效id 参数
  local _skill_data = skill_datas[skill_id]
  
  if ( not self.in_air ) or _skill_data[1] then
    self.Attack_State = true
    self.atk_group = nil
    if(self.Faction == 1)then
      self.atk_group =  cloneTab(APCGroup)
    else
      self.atk_group =  cloneTab(EnemyGroup)
    end
    if(_skill_data[10] ~= -1)then
      love.audio.play(SwordmanSkillVoice[_skill_data[10]])
    end
    
    self.control = false
    self.status = skill_id
    self.last = skill_id
    self.frame = _skill_data[9]
    self.timer = 0
    self.gatk_s = 0
    
    self.vx = _skill_data[2] * self.face
    self.avx = _skill_data[3] * self.face
    if( _skill_data[4] < 0)then
      self.vz = _skill_data[4]
      self.in_air = true
    end
    self.Stiffness = _skill_data[5] / 1000
    self.rat = _skill_data[6]
    if(_skill_data[7] ~= 0)then
      PassiveObjectManager:Push(_skill_data[7],self.x,self.y,_skill_data[8],self)
    end
  end
end

--show
function SwordMan:draw()
  local imgs
  
  for k,v in pairs(self.AttachEffect) do
    v:draw_down()
  end
  
  --skin
  for i = 1, #self.imgs do
    imgs = self.imgs[i][self.frame]
    L_Graphics.draw(imgs[1],self.x + self.face * imgs[2],self.y + imgs[3] + self.z,0,self.face,1)
  end

  --name
  L_Graphics.setColor(1,0.84,0)
  L_Graphics.printf(self.name,self.x-75,self.y-125 + self.z,150,"center")
  L_Graphics.setColor(1,1,1)
  
  
  for k,v in pairs(self.AttachEffect) do
    v:draw_up()
  end
  
end

function SwordMan:BuffActivate(AE)
  table.insert(self.AttachEffect,AE)
  --upgrade
  self.speed_x = self.speed_x + 100
  
  
end

function SwordMan:BuffVanish(uid)
  for k,v in pairs(self.AttachEffect) do
    if(v.uid == uid)then
      table.remove(self.AttachEffect,k)
      --degrade
      self.speed_x = self.speed_x - 100
      
      return
    end
  end
end

function SwordMan:GetOrder()
  return self.y + 12,self.x,self.y,self.uid
end

function SwordMan:GetPosition()
  return self.x,self.y,self.z
end

function SwordMan:GetName()
  return table.concat({'人形 ',self.name})
end

function SwordMan:Death()
  self.rat = int_var.death_rat
  self.status = 18
  love.audio.play(Voice.die)
  self.Attack_State = false
  self.control = false
  self.Stiffness = -1
  self.unbreakable = true
  self.vx = 0
end

function SwordMan:GetHealth()
  return self.hp
end

function SwordMan:GetFaceImage()
  return self.face_image
end

function SwordMan:AI(dt)

  if(self.hp > 0 and self.target)then
    if(self.target:GetHealth() <= 0)then
      self.target = nil
      return
    end
    local g_range = self.guard_range
    self.ai_timer = self.ai_timer + dt
    if(self.control)then
      --local close = false
      local x,y
      x,y = self.target:GetPosition()
      if math.abs(self.x - x) < g_range then
        if math.abs(self.y - y) < g_range then
          if(self.x - x < 80)then
            if(x - self.x < 80)then
              --close = true
            else
              self:MoveRight(dt,self.run)
            end
          else
            self:MoveLeft(dt,self.run)
          end
           if(self.y - y < 10)then
            if(y - self.y < 10)then
              
            else
              self:MoveDown(dt,self.run)
            end
          else
            self:MoveUp(dt,self.run)
          end
        end
      else
        self.target = nil
      end
    end
  else
    if(self.Faction == 1)then
      --[[
      for i = #(APCGroup),1,-1 do
        if(APCGroup[i]:GetHealth() > 0)then
          self.target = APCGroup[i]
          return
        end
      end
      ]]
      self.target = Player
      --[[
    else
      for i = #(EnemyGroup),1,-1 do
        if(EnemyGroup[i]:GetHealth() > 0)then
          self.target = EnemyGroup[i]
          return
        end
      end
      ]]
    end
  end
  
end

return SwordMan