--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月29日]
    [LastModifiedTime: ]
****************************************************************************]]

Inventory = {}

local inven_list = {}

local box_img={
  empty,
  _select,
}

local Equipment_Slots={
  package,
  weapon,
}

local in_Var={
  enforce_select,
  is_select,
  
}

local drag_weapon

itembox = 
{
  id,           --格子id
  Name,         --物品名称
  ItemId,       --物品id
  ItemType,     --物品类型
  Stack,        --堆叠数量
  StackLimit,   --堆叠上限 -1无限制 0 不能堆叠
  Weight,       --物品重量
  Icon,         --物品图片
  IsFull,       --是否装入
  IsSelect,     --鼠标是否移动到
  --put_sound,    --拖放物品声音
}

local function itembox_new() 
  o = {} 
  setmetatable(o,itembox)  
  itembox.__index = itembox
  return o 
end 

function Inventory:init()
  itembox.ItemId=-1
  itembox.IsFull=false
  itembox.IsSelect=false
  box_img.empty=L_Graphics.newImage("res/UI/item/box.png")
  box_img._select=L_Graphics.newImage("res/UI/item/selected.png")
  touch.box={}
  touch.box.id=0
  touch.box.Icon=box_img.empty
  touch.drop=false
  in_Var.enforce_select=false
  drag_weapon=0
end

local function Equipment_Slots_make(package)
  Equipment_Slots.package=package
  Equipment_Slots.weapon=package.Array[2][4]
end

function Inventory:new(x,y,row,column,id,enable,special,width,height)
  -- enable 0 all
  local package={}
  package.id=id or 100
  package.x=x
  package.y=y
  package.Enable = enable or 0
  package.width=width or 30
  package.height=height or 30
  package.w=(package.width+1)*column
  package.h=(package.height+1)*row
  package.TotalWeight=0
  package.show=true
  package.openclose=function()
    if(package.show)then
      package.show=false
    else
      package.show=true
    end
  end
  package.draw=function()
    local r
    local c
    r = package.y
    for i,u in pairs(package.Array)do
      c = package.x
      for j,y in pairs(u) do
        L_Graphics.draw(y.Icon,c,r)
        c=package.width+c+1
      end
     r=package.height+r+1
    end
  end
  local Array={}
  for i=1,row do
    Array[i]={}
    for j=1,column do
      local array = itembox_new() 
      array.Icon=box_img.empty
      array.Stack=1
      array.StackLimit=0
      array.Weight=0
      array.id = package.id+j+(i-1)*column
      Array[i][j]=array
    end
  end
  package.Array=Array
  if(special == "equipment")then
    Equipment_Slots_make(package)
    package.special = special
  else
    package.special= "common"
  end
  table.insert(inven_list,package)
  return package
end

function Inventory:load(invent,settings)
  invent.TotalWeight=0
  for r,u in pairs(invent.Array)do
    for c,v in pairs(u) do
      v.ItemId=settings[r][c] or -1
      if(v.ItemId~=-1)then
        v.ItemType=ItemList[v.ItemId].itype
        v.IsFull=true
        local weight
        if(v.ItemType==1)then
          v.Icon=weapon_icon[WeaponList[ItemList[v.ItemId].id].iconid]
          v.Name=WeaponList[ItemList[v.ItemId].id].name
          v.Weight=WeaponList[ItemList[v.ItemId].id].weight
        elseif(v.ItemType==3)then
          local item=consumptions[ItemList[v.ItemId].id]
          v.Icon=consumption_icon[item.iconid]
          v.Name=item.name
          if(item.stack_limit)then
            v.StackLimit=item.stack_limit
            v.Stack=1001
            if(v.Stack>item.stack_limit)then
              v.Stack=item.stack_limit
            end
            v.Weight = item.weight
          else
            v.StackLimit=0
          end
        end
        invent.TotalWeight=invent.TotalWeight + v.Weight*v.Stack
      else
        v.StackLimit=0
        v.IsFull=false
        v.Icon=box_img.empty
      end
    end
  end
end

local function BoxUnableToExchange()
  drag.box.StackLimit=drag.StackLimit
  drag.box.IsFull=true
  drag.box.Icon=drag.Icon
end

local function SelectBox(box)
  touch.box_id=box.id
  box.IsSelect=true
  if not box.IsFull then box.Icon=box_img._select end
  return box
end

local function UnselectBox(box)
  touch.box_id=0
  box.IsSelect=false
  if not box.IsFull then box.Icon = box_img.empty end
  ItemInfo.get=false
end

local function ItemMoveToBox(Box1,Box2)
 
end

local function UseBoxWeapon(package,box)
  return Player:ReplaceWeapon(box.ItemId)
end

function Inventory:update()
  local touch=touch
  local drag=drag
  if(touch.drop)then
      touch.drop=false
  elseif(MouseEventValue~=201)then
    local box
    local package
    in_Var.is_select=false
    for k ,v in pairs(inven_list) do
      if(v.show)then
        if(mouse_x>v.x and mouse_x<v.w+v.x and mouse_y>v.y and mouse_y<v.h+v.y)then
          package=v
          if(in_Var.enforce_select)then
            box=touch.box
            if(v.special=="common")then
              in_Var.enforce_select=false
              drag.Action=1
              if(drag_weapon==1)then
                drag_weapon=2
              end
            end
          else
            r=math.ceil((mouse_y-v.y)/31)
            c=math.ceil((mouse_x-v.x)/31)
            box = v.Array[r][c]
            if touch.box_id~= box.id then
              UnselectBox(touch.box)
              touch.box=SelectBox(box)
            end
            if(MouseEventValue==101)then
              if(v.special=="equipment")then
                if(drag.Type==1)then
                  UnselectBox(touch.box)

                  touch.box = Equipment_Slots.weapon
                  box=SelectBox(touch.box)
                  in_Var.enforce_select=true
                  drag_weapon=1
                  drag.Action=2
                end
              end
            elseif(MouseEventValue==0)then
              if(box.IsFull)then
                if(press)then
                  ItemInfo.get=false
                  MouseEventValue=101
                  drag.Action=1
                  drag.package=package
                  drag.Enable=package.Enable
                  drag.box=box
                  drag.Name=box.Name
                  drag.Stack=box.Stack
                  drag.StackLimit=box.StackLimit
                  drag.Weight=box.Weight
                  drag.ItemId=box.ItemId
                  drag.Type=box.ItemType
                  drag.Icon=box.Icon
                  box.StackLimit=0
                  box.IsFull=false
                  if(mp_but==1)then
                    if(package.special=="equipment" and drag_weapon==0)then
                      drag_weapon=1
                    end
                    SelectBox(box)
                  elseif(mp_but==2)then
                    if(box.ItemType == 1)then
                      if(Player:ReplaceWeapon(box.ItemId))then
                        UnselectBox(touch.box)
                        touch.box=Equipment_Slots.weapon
                        box=SelectBox(touch.box)
                        package=Equipment_Slots.package
                        press = false
                      end
                    end
                  end
                else
                  GetItemInfo(box.ItemId,box.ItemType,mouse_x,mouse_y)
                end
              end
            end
          end
          in_Var.is_select=true
          break
        end
      end
    end
    if(MouseEventValue==101)then
      if(press)then
        drag.x=mouse_x-14
        drag.y=mouse_y-14
      else
        MouseEventValue=0
        ItemInfo.get=false
        in_Var.enforce_select=false
        if(in_Var.is_select)then
          local CouldExchange = true
          if(drag.Action==2)then
            if(Player:ReplaceWeapon(drag.box.ItemId))then
              drag.Action=1
            else
              BoxUnableToExchange()
            end
          elseif(drag_weapon==2)then
            if(Player:ReplaceWeapon(box.ItemId))then
              drag.Action=1
            else
              drag.Action=2
              BoxUnableToExchange()
            end
            drag_weapon=0
          end
          if(drag.Action==1)then
            if(drag.drag_BoxId ~= box.id)then
              if(package.Enable == 0 or drag.Type==package.Enable)then
                if(box.IsFull)then
                  if(drag.Enable==0 or box.ItemType==drag.Enable)then
                    drag.box.IsFull=true
                    drag.box.Name=box.Name
                    drag.box.Icon=box.Icon
                    drag.box.Weight=box.Weight
                    drag.box.ItemId=box.ItemId
                    drag.box.ItemType=box.ItemType
                    drag.box.Stack=box.Stack
                    drag.box.StackLimit=box.StackLimit
                  else
                    CouldExchange = false
                    BoxUnableToExchange()
                  end
                else
                  drag.box.ItemId=-1 
                  drag.box.StackLimit=0
                  drag.box.Weight=0
                end
                if(CouldExchange)then
                  drag.package.TotalWeight=drag.package.TotalWeight + box.Stack*box.Weight
                  drag.package.TotalWeight = drag.package.TotalWeight - drag.Stack*drag.Weight
                  package.TotalWeight=package.TotalWeight - box.Stack* box.Weight
                  package.TotalWeight=package.TotalWeight + drag.Stack*drag.Weight
                  box.IsFull=true
                  box.Name=drag.Name
                  box.Icon=drag.Icon
                  box.ItemId=drag.ItemId
                  box.ItemType=drag.Type
                  box.Stack=drag.Stack
                  box.StackLimit=drag.StackLimit
                  box.Weight=drag.Weight
                end
              else
                BoxUnableToExchange()
              end
            else
              BoxUnableToExchange()
            end
          end
        else
          BoxUnableToExchange()
        end
      end
    end
    if not in_Var.is_select then
       UnselectBox(touch.box)
       in_Var.enforce_select=false
    end
  end
end
--[[
function Inventory:draw()
  local r
  local c
  for k ,v in pairs(inven_list) do
    print(v.show)
    if(v.show)then
      r=v.y
      for i,u in pairs(v.Array)do
        c=v.x
        for j,y in pairs(u) do
          L_Graphics.draw(y.Icon,c,r)
          if(y.StackLimit~=0)then
            L_Graphics.print(y.Stack,c,r)
          end
          c=v.width+c+1
        end
       r=v.height+r+1
      end
      L_Graphics.print(table.concat({"负重:",(v.TotalWeight/1000),"Kg"}),v.x,r)
    end
  end
end
]]
return Inventory