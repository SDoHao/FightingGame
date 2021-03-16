--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月29日]
    [LastModifiedTime: ]
****************************************************************************]]

MultipleCard={}

local pre_card_img
local cho_card_img

local Multiple_groups={}

local card={
  name,
  img,
  is_selected,
}

local function card_new() 
  o = {}  
  setmetatable(o,card) 
  card.__index = card
  return o 
end 

function MultipleCard:init()
  pre_card_img=love.graphics.newImage("res/UI/window/card_option.png")
  cho_card_img=love.graphics.newImage("res/UI/window/card_choice.png")
end

function MultipleCard:new(img,num,x,y,group,names,name_color)
--------------------------------------------------------------------------------[[[[[[mod:horizontal or Vertical]]
--names: A table of card names
  local card_group={id,visible,name,color,x,y,space,range_x,range_y,set,cards={},draw}
  local name
  local color=name_color or {1,1,1}
  card_group.x=x
  card_group.y=y
  card_group.name=group
  card_group.color=color
  card_group.space=pre_card_img:getWidth()
  card_group.range_x=card_group.space*num
  card_group.range_y=pre_card_img:getHeight()
  card_group.visible=false
  card_group.set=1
  for i=1,num do
    card_group.cards[i]=card_new() 
    name=names[i] or ""
    card_group.cards[i].name=name
    card_group.cards[i].img=pre_card_img
    card_group.cards[i].is_selected=false
  end
  card_group.cards[1].img=cho_card_img
  card_group.cards[1].is_selected=true
  card_group.draw=function()
    local x=card_group.x
    local y=card_group.y
    for k,v in pairs(card_group.cards)do
      L_Graphics.draw(v.img,x,y)
      L_Graphics.setColor(card_group.color)
      L_Graphics.printf(v.name,x,y+2,card_group.space,"center")
      L_Graphics.setColor(1,1,1)
      x=x+card_group.space
    end
  end
  table.insert(Multiple_groups,card_group)
  card_group.id=table.maxn(Multiple_groups)
  return card_group
end

function MultipleCard:Turn(Cards,id)
  Cards.cards[Cards.set].img=pre_card_img
  Cards.cards[Cards.set].is_selected=false
  Cards.set=id
  Cards.cards[id].img=cho_card_img
  Cards.cards[id].is_selected=true
end

function MultipleCard:update()
  if(press and MouseEventValue==0)then
   for k,v in pairs(Multiple_groups)do
      if(mouse_x>v.x and mouse_x<v.range_x+v.x and mouse_y>v.y and mouse_y<v.range_y+v.y)then
        local i=math.ceil((mouse_x-v.x)/v.space)
        if(v.set~=i)then
          v.cards[v.set].is_selected=false
          v.cards[v.set].img=pre_card_img
          v.cards[i].is_selected=true
          v.cards[i].img=cho_card_img
          v.set=i
        end
        return
      end
    end
  end
end

function MultipleCard:draw()
  for k,v in pairs(Multiple_groups)do
    if not v.visible then
      --draw
    end
  end
end
return MultipleCard