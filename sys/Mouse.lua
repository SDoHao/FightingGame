_MOUSE={}

local inv = {
  x,
  y,
  --status
  press,
  p_button,
  --img
  cursor,
  press_img,
  show_img,
}

function _MOUSE:getMouseStatus()
  return inv.x,inv.y,inv.press,inv.p_button
end

function _MOUSE:update(dt)
  inv.x = love.mouse.getX()
  inv.y = love.mouse.getY()
end

function love.mousepressed(x,y,key)
  inv.press = true
  inv.show_img = inv.press_img
  inv.p_button = key
end

function love.mousereleased()
  inv.press = false
  inv.p_button = -1
  inv.show_img = inv.cursor
end

function _MOUSE:init()
  MouseEventValue = 0
  inv.press = false
  inv.cursor = L_Graphics.newImage("res/UI/mouse/crosshair.png") --自定义鼠标图片
  inv.press_img  = L_Graphics.newImage("res/UI/mouse/press.png")
  inv.show_img = inv.cursor
  love.mouse.setVisible(false) --设置鼠标不可见
end

function _MOUSE:draw()
  --_MOUSE_Info()
  --L_Graphics.print("Mouse:"..inv.x.." "..inv.y,10,50)
  L_Graphics.print('FPS:',10,75)
  L_Graphics.print(love.timer.getFPS(),40,75)
  --love.graphics.print(love.timer.getDelta(),70,75)
  --绘制鼠标
  if MouseEventValue == 101 then
    L_Graphics.draw(drag.Icon,drag.x,drag.y) 
    --[[
    if drag.StackLimit ~= 0 then
      L_Graphics.print(drag.Stack,drag.x,drag.y) 
    end
    ]]
  end
  L_Graphics.draw(inv.show_img, inv.x, inv.y)
end

return _MOUSE