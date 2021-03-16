Font = {
  CA_12,
  CA_14,
  --ImageFont,
  DamageFont,
}

local DamageFont
local _float_speed


function Font:init()
  
  FloatDamageFont = {}
  _float_speed = 100
  Font.CA_12 = L_Graphics.newFont("sys/Font/simsun.ttf",12)
  Font.CA_14 = L_Graphics.newFont("sys/Font/simsun.ttf",14)
  Font.DamageFont = L_Graphics.newImageFont("sys/Font/DamageFont.png","0123456789")
  
end

function Font:push(num,x,y,time)
  table.insert(FloatDamageFont,{math.floor(num),x,y,time,_float_speed})
end

function Font:update(dt)
  local _tmp
  for i = #(FloatDamageFont),1,-1 do
    _tmp = FloatDamageFont[i]
    _tmp[3]  = _tmp[3] - _tmp[5] * dt
    _tmp[4] = _tmp[4] - dt
    _tmp[5] = _tmp[5] + 2
    if(_tmp[4] <= 0)then
      table.remove(FloatDamageFont,i)
    end
  end
end

function Font:draw()
  local _tmp
  L_Graphics.setFont(Font.DamageFont,20)
  L_Graphics.setColor(1,1,0)
  for i = #(FloatDamageFont),1,-1 do
    _tmp = FloatDamageFont[i]
    
    L_Graphics.print(_tmp[1],_tmp[2],_tmp[3])
    
  end
  L_Graphics.setColor(1,1,1)
  L_Graphics.setFont(Font.CA_12)
end

return Font