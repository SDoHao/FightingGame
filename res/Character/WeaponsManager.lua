WeaponsManager = {}

WeaponList = {} --list_id

local container_pos

local empty_pos

Weapon_Holder = {} --Uid = image_uid -> list_id

function WeaponsManager:init()
  empty_pos = {}
  container_pos = 0
  local _list = require('res/Character/WeaponsList')
  for k,v in pairs(_list)do
    WeaponList[k] = require(v)
  end
  _list = nil
  collectgarbage("collect")
end

local weapon = {
  weapon_id,--item id
  weapon_vid,
  Timer = 0,
  CoolTime = 1.5,
  InCooling = false,
  --audio
  atk_effect,
  run_hit,
  lkat_jump,
}

function WeaponsManager:NewWeapon()
  weapon.atk_effect = {}
  return cloneTab(weapon)
end

function WeaponsManager:load(uid) --image_uid
  local empty_k = 0
  if(WeaponList[uid].is_load)then
    local pos = WeaponList[uid].vid
    empty_k = pos
  else
    local path = WeaponList[uid].path
    local buffer =
    {
      uid,
      imgs_b = {},
      imgs_c = {},
      layer_b = 1,
      layer_c = 9,
    }
    WeaponList[uid].is_load=true
    if empty_pos[1] then
      empty_k = empty_pos[1]
      table.remove(empty_pos,1)
    end
    if(empty_k > 0)then
    
    else
      container_pos = container_pos + 1
      empty_k = container_pos
    end
    WeaponList[uid].vid = empty_k
    buffer.uid = uid
    local pos_b = io.open(table.concat({path,'/b.txt'}),"r")
    local pos_c = io.open(table.concat({path,'/c.txt'}),"r")
    for i = 1,210 do
      local j = i - 1
      local t_img_b = {nil,nil,nil}
      local t_img_c = {nil,nil,nil}
      t_img_b[1] = L_Graphics.newImage(table.concat({path,'/b/',j,'.png'}))
      t_img_b[2] = pos_b:read("*n") - 232
      t_img_b[3] = pos_b:read("*n") - 328
      t_img_c[1] = L_Graphics.newImage(table.concat({path,'/c/',j,'.png'}))
      t_img_c[2] = pos_c:read("*n") - 232
      t_img_c[3] = pos_c:read("*n") - 328
      buffer.imgs_b[i] = t_img_b
      buffer.imgs_c[i] = t_img_c
    end
   
    io.close(pos_b)
    io.close(pos_c)
    Weapon_Holder[empty_k] = buffer
  end
  return empty_k
end

return WeaponsManager