local MonsterImageManager = {}

local _ImagePathList

local MonsterImage_Holder = {}

local MonsterHitBox_Holder = {}

local ImageNum

function MonsterImageManager:init()
  _ImagePathList = require('res/Monster/MonsterImageList')
  --for i = 1,#(_ImagePathList[1])do
  --  _ImagePathList[2][i] = -1
  --end
  ImageNum = 0
end

local function LoadImage(path,x_offset,y_offset)
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
  ImageNum = ImageNum + 1
  MonsterImage_Holder[ImageNum] = _Monster_Image
  MonsterHitBox_Holder[ImageNum] = BoxDataRead(table.concat({path,'hitbox.txt'}))
  return ImageNum
end

local function LoadHitBox(id)
  
  
  
  
end

function MonsterImageManager:GetImage(id,max_frame,x_offset,y_offset)
  
  if(_ImagePathList[2][i] == -1)then
    _ImagePathList[2][i] = LoadImage(_ImagePathList[1][i])
  end
  
  return MonsterImage_Holder[_ImagePathList[2][i]]
end

function MonsterImageManager:GetHitBox(id)
  return MonsterHitBox_Holder[_ImagePathList[2][i]]
end


return MonsterImageManager