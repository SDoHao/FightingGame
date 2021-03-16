ItemManager = {}
weapon_icon = {}

function ItemManager:init()

  for i=1,RULE.WepIconNum do
    weapon_icon[i] = love.graphics.newImage("res/Item/icon/weapon/"..i..".png")
  end

  collectgarbage("collect")
end

return ItemManager