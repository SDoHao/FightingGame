BloodBars = {}


local MaxHPofeachlayer

local var = {
  uid,
  name,
  face_image,
  target,
  Quotient,
  c_type,
  BottomLayer,
  remainder,
  BottomColor,
  TopColor,
  Cur_hp,
  Pre_hp,
  pre_layer,
  hps,
  rat,
  Scaling,
  is_get,
}

local LevelColor

local face_image_collection

local function CalculHPLayer(value)
  return math.floor(value / MaxHPofEachLayer)
end

local function CalculHPVolume(target,hp)
  
  local _quotient
   
  var.BottomLayer = CalculHPLayer(hp)
  var.remainder = hp % MaxHPofEachLayer * var.Scaling
  
  if(var.BottomLayer ~= 0)then
    _quotient = (var.BottomLayer - 1 )% var.c_type + 1
  else
    _quotient = 0
  end
  
  var.BottomColor = LevelColor[_quotient]
  _quotient = _quotient % var.c_type + 1
  var.TopColor = LevelColor[_quotient]
  
  var.Cur_hp = hp
  
end

function BloodBars:init(HPMAX)
  
  LevelColor = 
  {
    [0] = {0,0,0,1},
    [1] = {1,0,0,1},
    [2] = {1,0.38,0,1},
    [3] = {0.2,0.8,0.2,1},
    [4] = {0.117,0.565,1,1},
    [5] = {0.255,0.412,1,1},
  }

  face_image_collection = {}
  
  for i = 1,1 do
    face_image_collection[i] =  L_Graphics.newImage(table.concat({'res/Monster/FaceImage/',i,'.png'}))
  end
  
  var.c_type = #(LevelColor)
  
  var.is_get = fasle
  
  MaxHPofEachLayer = HPMAX * 1.5
  var.Scaling = 300 / MaxHPofEachLayer
  var.hps = 0
  var.rat = 0
end

function BloodBars:getTarget(target)
  if(target and var.uid ~= target.uid )then
    local hp = target:GetHealth()
    if(hp > 0)then
      var.uid = target.uid
      var.target = target
      --var.face_image = target.face_image
      var.name = target:GetName()
      var.face_image = face_image_collection[target:GetFaceImage()]
      
      if(hp <= 0)then
        var.is_get = fasle
      else
        CalculHPVolume(target,hp)
        var.hps = 0
        var.rat = 0
        var.Pre_hp = var.Cur_hp
        var.Pre_layer = var.BottomLayer
        var.is_get = true
      end
    end
  end
end

function BloodBars:draw()
  if(var.is_get)then
    L_Graphics.print('x '..var.BottomLayer ,396,76)
    L_Graphics.draw(var.face_image,60,60)
    L_Graphics.setColor(139/255,69/255,19/255)
    L_Graphics.setColor(var.BottomColor)
    L_Graphics.rectangle('fill',92,76,300,13)
    L_Graphics.setColor(var.TopColor)
    L_Graphics.rectangle('fill',92,76,var.remainder ,13)

    if(var.hps > 0)then
      L_Graphics.setColor(1,1,0)
      L_Graphics.rectangle('fill',92 + var.remainder,76,var.hps,13)
    end
    L_Graphics.setColor(1,1,1)
    L_Graphics.print(var.name,92,60)
    L_Graphics.setColor(1,1,1)
  end
end

function BloodBars:update(dt)
  if(var.is_get)then
    
    if(var.hps > 0)then
      var.hps = var.hps - var.rat
      if(var.hps < 0)then
        var.hps = 0
      end
    end
    
    var.Cur_hp = var.target:GetHealth()
    if(var.Pre_hp ~= var.Cur_hp)then
      if(var.Cur_hp <= 0)then
        var.is_get = fasle
      else
        local BoodLoss = (var.Pre_hp - var.Cur_hp) * var.Scaling
        var.hps = var.hps + BoodLoss
        if(BoodLoss < 0)then  --回血
          
          if(var.hps <= 0)then
            var.hps = 0
          end
        else  --掉血
          var.rat = var.hps / 30
        end

        var.Pre_hp = var.Cur_hp
        CalculHPVolume(var.target,var.Cur_hp)
        if(var.Pre_layer ~= var.BottomLayer)then
          if(var.remainder + var.hps > 300)then
            var.hps = 300 - var.remainder
          end
          var.Pre_layer = var.BottomLayer
        end
      end
    end
  end
end

return BloodBars

