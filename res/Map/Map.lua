--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年3月17日]
    [LastModifiedTime: ]
****************************************************************************]]
local WorldMap = require("res/Map/WorldMap/WorldMap")
local map_bgm = require("res/Audio/bgmusic/map_bgm")

Map = {
  X1,
  X2,
  Y1,
  Y2,
  wax1,
  wax2,
  way1,
  way2,
}

local settings={
  id,
  name,
  music,
  --battle=true,
  is_load=false,
  img = {},
  --anims = {},--all anims settings
  size = {},
  set1,
  set2,
  set3,
  --anim_set,
  timer = 0,
}

local L_Graphics = love.graphics

--local AnimsNeedUpdate = {}

local function ImageInsert(num,path)
  local img_tmp
  local img_size = {}
  local x
  local y
  for i = 1,num do
    img_tmp=love.graphics.newImage(table.concat({path,i,".png"}))
    x = img_tmp:getWidth()
    y = img_tmp:getHeight()
    img_size={x,y}
    table.insert(settings.img,img_tmp)
    table.insert(settings.size,img_size)
  end
end

local function MapLoadSettings(map_settings)
  --{id x y}
  --settings.set1 = {}
  --settings.set2 = {}
  --settings.set3 = {}
  
  
  --AnimsNeedUpdate = {}
  local _scene = All_Scenes[map_settings.scene_id]
  
  Map.X1 = map_settings.X1 or _scene.X1
  Map.Y1 = map_settings.Y1 or _scene.Y1
  Map.X2 = map_settings.X2 or _scene.X2
  Map.Y2 = map_settings.Y2 or _scene.Y2
  Map.wax1 = map_settings.wax1 or _scene.wax1
  Map.way1 = map_settings.way1 or _scene.way1
  Map.wax2 = map_settings.wax2 or _scene.wax2
  Map.way2 = map_settings.way2 or _scene.way2
  
  settings.set1 = map_settings.set1
  settings.set2 = map_settings.set2
  settings.set3 = map_settings.set3
end

local function _MapLoadSettings(map_settings)
  local scene_id = map_settings.scene_id
  if(settings.id ~= scene_id)then
    settings.id = scene_id
    local _scene = All_Scenes[scene_id]
    settings.name = _scene.name or'test'
    love.audio.stop(settings.music)
    settings.music = GetBgMusic(scene_id)
    settings.music:setVolume(0.3)
    if(settings.is_load)then
      for _,v in pairs(settings.img)do
        v:release()
      end
      settings.img={}
      settings.size={}
      
      settings.is_load = false
    end
   
    
    ImageInsert(_scene.bk_num,table.concat({_scene.path,"bk"}))
    ImageInsert(_scene.tile_num,table.concat({_scene.path,"tile"}))
      
  
    settings.is_load = true
  end
  MapLoadSettings(map_settings)
  MapCanvas = love.graphics.newCanvas(Map.X2,Map.Y2)
  MapFraImage = love.graphics.newCanvas(Map.X2,Map.Y2)
  MapMidImage = love.graphics.newCanvas(Map.X2,Map.Y2)
  MapFraImage:renderTo(
    function()
      local _image = settings.img
      local set1 = settings.set1
      for i = 1,#set1,3 do
        L_Graphics.draw(_image[set1[i]],set1[i + 1],set1[i + 2])
      end
      
    end
  )
  MapMidImage:renderTo(
    function()
      local _image = settings.img
      local set2 = settings.set2
      for i = 1,#set2,3 do
        L_Graphics.draw(_image[set2[i]],set2[i + 1],set2[i + 2])
      end
    end
  )
  MapCanvas:renderTo(
    function()
      local _image = settings.img
      local set3 = settings.set3
      for i = 1,#set3,3 do
        L_Graphics.draw(_image[set3[i]],set3[i + 1],set3[i + 2])
      end
    end
  )
end

function Map:Initload()
  
  settings.music = GetBgMusic(1)
  _MapLoadSettings(WorldMap:init(1))
end

function Map:load(direction)
  if(direction ~= -1)then
    --过图
    local set = WorldMap:load(direction)
    if(type(set)=='string')then
      
    else
      _MapLoadSettings(set)

    end
  end
end

function Map:update(dt)
  love.audio.play(settings.music)
end

function Map:draw()
  L_Graphics.translate(0,Camera.c_y)
  L_Graphics.draw(MapFraImage, 0, 0)
  --BkAnimDraw()
  L_Graphics.translate(Camera.c_x / 2,0)
  L_Graphics.draw(MapMidImage, 0, 0)
  L_Graphics.translate(Camera.c_x / 2, 0)
  L_Graphics.draw(MapCanvas, 0, 0)
end

return Map