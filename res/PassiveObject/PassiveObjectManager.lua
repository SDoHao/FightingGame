PassiveObjectManager={}

local uid
local uid_available

local PassiveObjectUpdate

local PassiveObject_Holder

local Action_Holder = {}

local function GetUid()
  uid = uid + 1
  if(uid >= 2300)then
    if((#uid_available) > 0)then
      local i = uid_available[1]
      table.remove(uid_available,1)
      return i
    else
      --print("Exceeding the upper limit")
      return -1
    end
  else
    return uid
  end
end

function PassiveObjectManager:init()
  
  uid = 1999
  uid_available = {}
  PassiveObjectUpdate = {}
  PassiveObject_Holder = {}
  
  local List = require("res/PassiveObject/PassiveObjectList")
  local ActList = require("res/PassiveObject/ActionList")
  for k,v in pairs(List)do
    PassiveObject_Holder[k] = require(v)
  end
  for k,v in pairs(ActList)do
    Action_Holder[k] = require(v)
  end
  List = nil
  ActList = nil
end

local function ImageLoad(anim_data)
  local imgs = {}
  local PosData
  local index = 1
  local path
  local x
  local y
  for k,v in pairs(anim_data)do
    path = v[1]
    PosData = io.open(table.concat({path,'pos.txt'}), "r")
    for i = 1,v[3]  do
      if(i < v[2])then
        x = PosData:read("*n")
        y = PosData:read("*n")
      else
        local _img = {}
        _img[1] = L_Graphics.newImage(table.concat({path,i - 1,".png"}))
        _img[2] = PosData:read("*n") - v[4]
        _img[3] = PosData:read("*n") - v[5]
        imgs[index] = _img
        index = index + 1
      end
    end
  end
  io.close(PosData)
  return imgs
end

local function AudioLoad(_audio_path)
  local audio = {}
  for k,v in pairs(_audio_path)  do
    audio[k] = love.audio.newSource(v,"static")
  end
  return audio
end

function PassiveObjectManager:Push(id,x,y,value,target)
  local uid = GetUid()
  if(uid~=-1)then
    local settings = PassiveObject_Holder[id]
    local _action  = Action_Holder[settings.action_id]
    if(settings.Res_Not_Load)then
      
      settings.imgs_list = ImageLoad(settings.anim_data)
      
      settings.audio_effect = AudioLoad(settings.audio_path)
      if(settings.is_atk)then
        settings.atkbox = BoxDataRead(settings.atk_file)
      end
      settings.Res_Not_Load = false
    end
    
    local _new_pobj = _action:init(value,target,settings)
    
    _new_pobj.audio_effect = settings.audio_effect
    _new_pobj.timer = 0

    if(settings.is_atk)then
      _new_pobj.Faction = target.Faction
      _new_pobj.is_atk = true
      _new_pobj.atkbox = settings.atkbox
      _new_pobj.Y_AxisAttackRange = settings.Y_AxisAttackRange or 30
      _new_pobj.Faction = target.Faction
  
      _new_pobj.Physical_Damage = settings.Physical_Damage * target.Physical_Damage * ( 100 - math.random(-10,10)) / 100

      _new_pobj.atk_timer = 0
      if(target.Faction == 1)then
        _new_pobj.atk_group =  cloneTab(APCGroup)
      else
        _new_pobj.atk_group =  cloneTab(EnemyGroup)
      end
      _new_pobj.atk_times = settings.atk_times
      _new_pobj.atk_delay = settings.atk_delay
      _new_pobj.effect = settings.effect
    end

    _new_pobj.x = x
    _new_pobj.y = y
    
    _new_pobj.face = target.face
    
    _new_pobj.uid = uid
    _new_pobj.layer_order = settings.layer_order
    
    table.insert(PassiveObjectUpdate,_new_pobj)

    if(_new_pobj.special)then
      if(settings.AtcEff)then
        target:BuffActivate(_new_pobj)
      end
    else
      ImageOrder:push(_new_pobj,y + settings.layer_order,x,y,uid)
    end
    if(settings.is_spawn)then
      for k,v in pairs(settings.spawn)do
        PassiveObjectManager:Push(v[1],x + target.face * v[2],y + v[3],v[4],_new_pobj)
      end
    end
  end
end

function PassiveObjectManager:update(dt)
  local atkbox
  local _atk_box_x
  local _atk_box_y
  local _hit_hit
  local enemy
  for k,v in pairs(PassiveObjectUpdate)do
    v:update(dt)
    if(v.is_atk)then
      if(v.atk_times > 1)then
        v.atk_timer = v.atk_timer + dt
        if(v.atk_timer >= v.atk_delay)then
          v.atk_timer = 0
          v.atk_group = nil
          if(v.Faction == 1)then
            v.atk_group =  cloneTab(APCGroup)
          else
            v.atk_group =  cloneTab(EnemyGroup)
          end
          
          v.atk_times = v.atk_times - 1
        end
      end
      atkbox = v.atkbox[v.frame]
      _atk_box_x = v.face * atkbox[1] + v.x
      _atk_box_y = atkbox[2] + v.y 
      for i = #(v.atk_group),1,-1 do
        enemy = v.atk_group[i]
        if math.abs(v.y - enemy.y) < v.Y_AxisAttackRange then
          _hit_hit = enemy.HitBox[enemy.frame]
          if math.abs(_hit_hit[1] * enemy.face + enemy.x - _atk_box_x) < _hit_hit[3] + atkbox[3] and math.abs(_hit_hit[2] + enemy.y + enemy.z - _atk_box_y) < _hit_hit[4] + atkbox[4] then
              enemy:Hit(v.face, v.Physical_Damage,unpack(v.effect))
              table.remove(v.atk_group,i)
          end
        end
      end
    end
  end
end

function PassiveObjectManager:Destory(uid)
  for i,v in pairs(PassiveObjectUpdate)do
    if(v.uid == uid)then
      if(v.special)then
        if(v.ae)then
          v.target:BuffVanish(uid)
        end
      else
        ImageOrder:UidPopOnce(uid)
      end
      table.remove(PassiveObjectUpdate, i)
      v = nil
      table.insert(uid_available,uid)
      return
    end
  end
end

return PassiveObjectManager