--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月10日]
    [LastModifiedTime:2020年4月10日]
****************************************************************************]]

local WorldMapSettings = require("res/Map/WorldMap/WorldMapList")

WorldMap = {}

local settings =
{
  --全局信息
  worldmap_id = 1,
  WM_W,
  WM_H,
  --当前房间
  cipher_r,
  cipher_c,
  --room_battle,
  --mini_map
  --is_draw,
  --JambPos = {},
  --mini_map_x,
  --mini_map_y,
  --mini_end_x,
  --mini_end_y,
  --minimap_close_button,
}

local WorldMapInitial={
  WM_W = 1,
  WM_H = 1,
  --初始房间信息
  row = 1,
  column = 1,
}

function WorldMap:init(id)
  settings.worldmap_id = id
  settings.cipher_r = WorldMapInitial.row
  settings.cipher_c = WorldMapInitial.column
  settings.WM_W = WorldMapInitial.WM_W
  settings.WM_H = WorldMapInitial.WM_H
  
  
  return WorldMapSettings[settings.cipher_r][settings.cipher_c]
end

function WorldMap:load(direction)--0 left 1 right 2 up 3 down  <-1 NextWorldMap_ID
  local i=settings.cipher_r
  local j=settings.cipher_c
  if(direction==0)then
    if(j==1)then
      return "NoMap"
    else
      if(WorldMapSettings[i][j-1].door~=-1)then
        settings.cipher_c = settings.cipher_c-1
        --m_cipher_x = m_cipher_x - 18
      else
        return "NoMap"
      end
    end
  elseif(direction==1)then
    if(j==settings.WM_W)then
      return "NoMap"
    else
      if(WorldMapSettings[i][j+1].door~=-1)then
        settings.cipher_c = settings.cipher_c+1
         m_cipher_x = m_cipher_x + 18
      else
        return "NoMap"
      end
    end
  elseif(direction==2)then
    if(i==1)then
      return "NoMap"
    else
      if(WorldMapSettings[i-1][j].door~=-1)then
        settings.cipher_r = settings.cipher_r-1
         m_cipher_y = m_cipher_y - 18
      else
        return "NoMap"
      end
    end
  elseif(direction==3)then
    if(i==settings.WM_H)then
      return "NoMap"
    else
      if(WorldMapSettings[i+1][j].door~=-1)then
        settings.cipher_r = settings.cipher_r+1
        m_cipher_y = m_cipher_y + 18
      else
        return "NoMap"
      end
    end
  end

  --FogMapProbe(WorldMapSettings[settings.cipher_r][settings.cipher_c].door)
  
  return WorldMapSettings[settings.cipher_r][settings.cipher_c]
end


return WorldMap