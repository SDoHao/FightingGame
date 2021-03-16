buttons = {
  touch_id=-1,
  press_id=-1,
}

local button_list={}

local pre_settings=
{
  quit_img,
  close_img,
  quit_button,
  button_pre1,
}

local button = {
    id,
    img,
    x,
    y,
    w,
    h,
    value,
    set,
    notice,
  }
  
function buttons:init()  
  pre_settings.quit_img=L_Graphics.newImage("res/UI/button/quit.png") 
  pre_settings.button_pre1=L_Graphics.newImage("res/UI/button/button_pre1.png") 
  pre_settings.close_img=L_Graphics.newImage("res/UI/button/common_close.png") 
  button.value=0
end

local function button_new() 
  local o = {}  
  setmetatable(o,button) 
  button.__index = button
  return o 
end 

function buttons:new(img,x,y,notice,set)
  local button = button_new() 
  button.x = x
  button.y = y
  button.notice = notice or ""
  button.set = set or 2
  if(type(img) == 'string')then
    if(img == "quit")then
      button.img = pre_settings.quit_img
      pre_settings.quit_button = button
    elseif img == "pre1" then
      button.img = pre_settings.button_pre1
    elseif img == "close" then
      button.img = pre_settings.close_img
    end
  else
    button.img = img
  end
  button.w = button.img:getWidth()
  button.h = button.img:getHeight()
  table.insert(button_list,button)
  button.id = table.maxn(button_list)
  return button
end

function buttons:draw(Button)
  if(Button.value == 0)then
    L_Graphics.setColor(0.7,0.7,0.7)
  end
  L_Graphics.draw(Button.img,Button.x,Button.y) 
  L_Graphics.setColor(1,1,1)
  L_Graphics.printf(Button.notice,Button.x,Button.y+5,Button.w,"center")
end

function buttons:show() 
  for k,v in pairs(button_list)do
    if(v.value==0)then
      L_Graphics.setColor(0.7,0.7,0.7)
    end
    L_Graphics.draw(v.img,v.x,v.y) 
    L_Graphics.setColor(1,1,1)
    L_Graphics.printf(v.notice,v.x,v.y+5,v.w,"center")
  end
end 
function buttons:update() 
  if MouseEventValue~=101 then
    for k,v in pairs(button_list)do
      if(mouse_x > v.x and mouse_x < v.w+v.x and mouse_y > v.y and mouse_y < v.h+v.y)then
        v.value = 1
       
        buttons.touch_id = k
        if(mp_but == 1)then
          buttons.press_id = k
          v.value = v.set
        end
        
        return
      else
        v.value=0
        buttons.touch_id = -1
        buttons.press_id = -1
      end
    end
  end
end 

function buttons:remove(id) 
  for i,v in pairs(button_list)do
    if(i > id)then
      v.id = v.id - 1
    end
  end
  table.remove(button_list,id)
end

function buttons:delete() 
  button_list = {}
end

return buttons