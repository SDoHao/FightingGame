--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月17日]
    [LastModifiedTime: ]
****************************************************************************]]
Player={}

local player={}

--The Chosen One

local PlayerInfo={
  name,
  level,
  --exp,
  job,
}

local equipment = {}

local HP
local MP

function Player:init()
  local settings = {Faction = 0,level=100,HPMAX = 16500,MPMAX = 10000,x=190,y=450,skin_id = 3,coat_id = 4,weapon_id = 1,uid = 1,mp_regen = 20,hp_regen = 10}
  local name = "鬼剑妈耶"
  for i=1,2 do
    equipment[i] = {}
    for j=1,5 do
      equipment[i][j] = -1
    end
  end
  equipment[2][4] = settings.weapon_id or -1
  if(CharacterId==1)then
    player = SwordMan:New(name, settings)
    PlayerInfo.job="鬼剑士"
  end
  PlayerInfo.name = name
  PlayerInfo.level=player.level
  --PlayerInfo.exp = 0
  
  local HM = require("res/Character/HM")
  
  HP = HM:new()
  MP = HM:new()
  HP.x = 43--3
  MP.y = 410
  MP.x = 636
  MP.y = 410
  HP:setcolor(1,192/255,203/255,230/255,48/255,48/255) 
  MP:setcolor(0,191/255,1,65/255,105/255,225/255) 
  HP:init(player.HPMAX,player.hp,player.hp_regen)
  MP:init(player.MPMAX,player.mp,player.mp_regen)
  
  BloodBars:init(player.HPMAX)
end

function Player:ReplaceWeapon(id)
  if(player:ReplaceWeapon(id))then
    equipment.wep_id = id
    return true
  else
    return false
  end
end

local QuickSkill = {
}



function Player:HP_add(val)
  if(HP.hp <= 0)then--rebirth
    HP:add(player.HPMAX)
    player.hp = player.HPMAX
    --player.control = true
    player.unbreakable = false
    player.Stiffness = 0.5
  else
    player.hp = player.hp + val
    if(player.hp > player.HPMAX)then
      player.hp = player.HPMAX
    end
    HP:add(val)
  end
  PassiveObjectManager:Push(45,player.x,player.y,3,player)
end

function Player:MP_add(val)
  MP:add(val)
end

local function HP_sub(val)
  HP:sub(val)
end

local function MP_sub(val)
  MP:sub(val)
end

function Player:GetHealth()
  return  player:GetHealth()
end

function Player:update(dt)
  BloodBars:update(dt)
  player:update(dt)
  if(player.vx ~= 0)then
     Camera:MoveX(player.vx,player:GetPosition())
  end
  if(player.control)then
    if love.keyboard.isDown('x') then
      player:Attack(is_run)
      is_run = false
    elseif love.keyboard.isDown('a') then
      player:JumpBack()
    elseif love.keyboard.isDown('c') then
      player:Jump()
    elseif love.keyboard.isDown('z') then
      player:PerformSkill(35)
      MP_sub(10)
    elseif love.keyboard.isDown('h') then
      player:PerformSkill(63)
      MP_sub(85)
    elseif love.keyboard.isDown('s') then
      player:PerformSkill(64)
      MP_sub(35)
    elseif love.keyboard.isDown('d') then
      player:PerformSkill(73)
      MP_sub(200)
    elseif love.keyboard.isDown('r') then
      player:PerformSkill(66)
      MP_sub(60)
    elseif love.keyboard.isDown('q') then
      player:PerformSkill(37)
      MP_sub(60)
    elseif love.keyboard.isDown('e') then
      player:PerformSkill(33)
      MP_sub(130)
    elseif love.keyboard.isDown('w') then
      player:PerformSkill(21)
      MP_sub(30)
    elseif love.keyboard.isDown('f') then
      player:PerformSkill(49)
      MP_sub(40)
    elseif love.keyboard.isDown('g') then
      player:PerformSkill(29)
      MP_sub(60)
    elseif love.keyboard.isDown('t') then
      player:PerformSkill(25)
      MP_sub(350)
    elseif love.keyboard.isDown('y') then
      player:PerformSkill(40)
      MP_sub(100)
    elseif love.keyboard.isDown('v') then
      player:PerformSkill(31)
      MP_sub(125)
    end
  end
  HP:update(dt)
  MP:update(dt)
end


function Player:Control(dt)
  
end

function Player:Hit(dir,damage,Stiffness,fly,float,float_h)
  HP_sub(damage)
  player:Hit(dir,damage,Stiffness,fly,float,float_h)

  if(player.hp <= 0)then
    HP.hp = 0
  end
end

function Player:MoveLeft(dt)
  Camera:MoveX(player:MoveLeft(dt,is_run),player:GetPosition())
end

function Player:MoveRight(dt)
  Camera:MoveX(player:MoveRight(dt,is_run),player:GetPosition())
end

function Player:MoveUp(dt)
  Camera:MoveY(player:MoveUp(dt,is_run),player:GetPosition())
end

function Player:MoveDown(dt)
  Camera:MoveY(player:MoveDown(dt,is_run),player:GetPosition())
end

function Player:draw()
  --love.graphics.draw(equipment.wep_icon,20,20)
  player:draw()
  --player:ShowBoxEding()
end

function Player:HMdraw()
  HP:draw()
  MP:draw()
end

function Player:GetPlayerControl()
  return player.play_yes
end

function Player:GetJob()
  return PlayerInfo.job
end

function Player:GetLevel()
  if(PlayerInfo.level ~= player.level)then
    player.level = PlayerInfo.level
  end
  return PlayerInfo.level
end

function Player:GetOrder()
  return player:GetOrder()
end

function Player:GetPosition()
  return player:GetPosition()
end

function Player:GetEquipment()
  return equipment
end

function Player:GetPlayerControl()
  return player.control
end

return Player