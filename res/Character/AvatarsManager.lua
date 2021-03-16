AvatarsManager = {}

AvatarsList = {}

local container_pos

local empty_pos = {}

Avatar_Holder={}

local avatar={pant_id,coat_id,hair_id,shoe_id,skin_id,skin_vid,coat_vid,pant_vid,coat_vid,hair_vid}

function AvatarsManager:NewAvatar()
  return cloneTab(avatar)
end

function AvatarsManager:init()
  container_pos = 0
  AvatarsList = require('res/Character/AvatarsList')
end

function AvatarsManager:load(sk_id)
  local empty_k = 0
  local _AvatarsList = AvatarsList[sk_id]
  if(_AvatarsList.is_load)then
    empty_k = AvatarsList[sk_id].vid
  else
    local img_path = AvatarsList[sk_id].img_path
    local pos_path = AvatarsList[sk_id].pos_path
    local pos_avatar = {}
    local buffer ={
      _list_id,
      cover = false,
      imgs = {},
      layer,
      }
    _AvatarsList.is_load = true
    if #(empty_pos) > 0 then
      empty_k = empty_pos[1]
      table.remove(empty_pos,1)
    else
      container_pos = container_pos + 1
      empty_k = container_pos
    end
    _AvatarsList.vid = empty_k
    buffer._list_id = sk_id
    buffer.layer = _AvatarsList.layer
    if(_AvatarsList.cover)then
      buffer.cover = _AvatarsList.cover
    end
    pos_avatar = io.open(pos_path, "r")
    for i=1,210 do
      local data = {nil,nil,nil}
      data[1] = L_Graphics.newImage(table.concat({img_path,(i - 1),".png"}))
      data[2] = pos_avatar:read("*n") - 232--210-22
      data[3] = pos_avatar:read("*n") - 328
      buffer.imgs[i] = data
    end
    io.close(pos_avatar)
    Avatar_Holder[empty_k] = buffer
  end
    return empty_k
end

return AvatarsManager