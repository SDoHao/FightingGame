--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月27日]
    [LastModifiedTime: ]
****************************************************************************]]

MsgBox={
  num=0,
}

local MsgBox_list={}

local variabl={
  d_x=0,
  d_y=0,
  drag=false,
}
msgbox={
  mod,
  id,
  x,
  y,
  w,
  h,
  string,
  title,
  button1,
  button2,
  button1_x,
  button1_y,
  button2_x,
  button2_y,
  value,
}
local function msgbox_new() 
  o = {}  
  setmetatable(o,msgbox) 
  msgbox.__index = msgbox
  return o 
end 

function MsgBox:new(mod,string,title,x,y,w,h)
  --[[mod
  1 ok
  2 yes_no
  ]]
  local button_x={}
  local button_y={}
  MsgBox.num=MsgBox.num+1
  local msgbox=msgbox_new() 
  msgbox.x=x or RULE.ScreenWidth/2-80
  msgbox.y=y or RULE.ScreenHeight/2-100
  msgbox.w=w or 165
  msgbox.h=h or 100
  msgbox.value=0
  msgbox.string=string
  msgbox.title=title
  msgbox.mod=mod
  if(mod==1)then
    msgbox.button1_x=msgbox.w/2-30
    msgbox.button1_y=70
    msgbox.button1=buttons:new("pre1",msgbox.x+msgbox.button1_x,y+msgbox.button1_y,"确定",2)
  elseif(mod==2)then
    msgbox.button1_x=25
    msgbox.button1_y=70
    msgbox.button2_x=90
    msgbox.button2_y=70
    msgbox.button1=buttons:new("pre1",msgbox.x+ msgbox.button1_x,y+msgbox.button1_y,"确定",2)
    msgbox.button2=buttons:new("pre1",msgbox.x+ msgbox.button2_x,y+msgbox.button2_y,"取消",4)
  end
  msgbox.button_x=button_x
  msgbox.button_y=button_y
  table.insert(MsgBox_list,msgbox)
  msgbox.id=table.maxn(MsgBox_list)
  return msgbox
end

function MsgBox:update()
  if(mp_but==1 and MouseEventValue~=101)then
    if(variabl.drag)then
      local v=MsgBox_list[MsgBox.num]
      v.x=mouse_x-variabl.d_x
      v.y=mouse_y-variabl.d_y
      if(v.mod==1)then
        v.button1.x=v.x+v.button1_x
        v.button1.y=v.y+v.button1_y
      elseif(v.mod==2)then
        v.button1.x=v.x+v.button1_x
        v.button1.y=v.y+v.button1_y
        v.button2.x=v.x+v.button2_x
        v.button2.y=v.y+v.button2_y
      end
    else
      for k,v in pairs(MsgBox_list)do
        if(mouse_x>v.x and mouse_x<v.w+v.x and mouse_y>v.y and mouse_y<20+v.y)then
          MouseEventValue=201
          variabl.drag=true
          variabl.d_x=mouse_x-v.x
          variabl.d_y=mouse_y-v.y
          --前置
          local t_MSGBOX = MsgBox_list[MsgBox.num]
          t_MSGBOX.id=k
          MsgBox_list[MsgBox.num]=MsgBox_list[k]
          MsgBox_list[MsgBox.num].id=MsgBox.num
          MsgBox_list[k]= t_MSGBOX
          return
        elseif(v.mod==1)then
          v.value=v.button1.value
        elseif(v.mod==2)then
          v.value=v.button1.value+v.button2.value
        end
      end
    end
  elseif(MouseEventValue==201)then
    MouseEventValue=0
    variabl.drag=false
  end

end

function MsgBox:release(msgbox)
  local id = msgbox.id
  if id then
    if(MsgBox_list[id].mod==1)then
      buttons:remove(MsgBox_list[id].button1.id) 
    elseif(MsgBox_list[id].mod==2)then
      buttons:remove(MsgBox_list[id].button1.id) 
      buttons:remove(MsgBox_list[id].button2.id) 
    end
    for i=id,#(MsgBox_list)do
      MsgBox_list[i].id=MsgBox_list[i].id-1
    end
    table.remove(MsgBox_list,id)
    MsgBox.num=MsgBox.num-1
  end
end

function MsgBox:show()
  for k,v in pairs(MsgBox_list)do
    L_Graphics.setColor(0.8,0.8,0.8,0.8)
    L_Graphics.rectangle("line",v.x,v.y,v.w,v.h)
    L_Graphics.setColor(0,0,0,0.7)
    L_Graphics.rectangle("fill",v.x,v.y,v.w,v.h)
    L_Graphics.setColor(0.6,0.6,0.6,0.6)
    L_Graphics.line(v.x,v.y+20,v.x+v.w,v.y+20)
    L_Graphics.setColor(1,1,1,1)   
    L_Graphics.printf(v.title,v.x+5,v.y+5,v.w-5,"center")
    L_Graphics.printf(v.string,v.x+5,v.y+25,v.w-5)
    if(v.mod==1)then
      buttons:draw(v.button1)
    elseif(v.mod==2)then
      buttons:draw(v.button1)
      buttons:draw(v.button2)
    end
  end
end

return MsgBox