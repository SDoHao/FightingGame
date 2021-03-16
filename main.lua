require("sys/rule")
require("sys/ImageOrder")
require("sys/Camera")
require("sys/Mouse")
require("sys/Font/Font")
require("sys/item/ItemInfo")
require("sys/item/Inventory")
require("sys/BloodBars")
require("res/Map/Map")
require("res/Map/scenes")
require("res/Character/SwordMan")
require("res/Character/Player")
require("res/Character/AvatarsManager")
require("res/Character/WeaponsManager")
require("res/Item/ItemList")
require("res/Item/ItemManager")
require("res/PassiveObject/PassiveObjectManager")

function love.load()
  collectgarbage("setpause",150)
  collectgarbage("setstepmul",150)
  collectgarbage("step",80)
  L_Graphics = love.graphics
  GameSceneId = 1
  CharacterId = 1
  ResIsLoad = false
  Img_loading = L_Graphics.newImage("res/UI/img/nowloading.png")
  Pos_ld_x = RULE.ScreenWidth - Img_loading:getWidth()
  Pos_ld_y = RULE.ScreenHeight - 140
  mouse_x = 0
  mouse_y = 0
  press = false
  mp_but = 0
  is_run = false
  dk_wait=0.3
  cdkw=0
  k_left=false
  dk_left=false
  king_left=false
  k_right=false
  dk_right=false
  king_right=false
  k_up=false
  king_up=false
  dk_up=false
  k_down=false
  dk_down=false
  king_down=false
  _k_left=false
  _k_right=false
  _k_up=false
  _k_down=false
  Test_Empty_Enemy_Uid = 1002
  _MOUSE:init()
  local icon = love.image.newImageData("DNF.png")
  love.window.setIcon(icon)
  Font:init()
  All_Scenes:init() 
  PassiveObjectManager:init()
  AvatarsManager:init()
  WeaponsManager:init()
  SwordManBoxDataInit()
end

local function KeyEventClear()
  k_left=false
  k_right=false
  k_up=false
  k_down=false
end

local function KeyDoubleEventClear()
  dk_left=false
  dk_right=false
  dk_up=false
  dk_down=false
end

function love.keyreleased(key)
  if key == "left"  then
    if(king_left)then
      king_left=false
    else
      k_left=false
      dk_left=true    
    end
  _k_left=false
  end
  if key == "right"  then
    if(king_right)then
      king_right=false
    else
      k_right=false
      dk_right=true
    end
    _k_right=false
  end
  if key == "up" then
    if(king_up)then
      king_up=false
    else
      k_up=false
      dk_up=true
    end
    _k_up=false
  end
  if key == "down" then
    if(king_down)then
      king_down=false
    else
      k_down=false
      dk_down=true
    end
    _k_down=false
  end
  if is_run  and _k_left == false and _k_right == false and _k_up == false and _k_down == false then
    KeyDoubleEventClear()
    is_run=false
    cdkw=0
  end
end

function love.keypressed(key)
  
  if key=="f1"then
    local px,py = Player:GetPosition()
    table.insert(EnemyGroup,SwordMan:New("木偶",{Faction = 1,level=1,HPMAX=5201314,MPMAX = 3000,x = px + 100,y = py - 100,skin_id = 8,weapon_id = 4,uid = Test_Empty_Enemy_Uid,Restats = 400,hp_regen = 2500,face_image = 1}))
    Test_Empty_Enemy_Uid = Test_Empty_Enemy_Uid + 1
  elseif key=="-"then
    Player:MP_add(3000)
  elseif key=="="then
    Player:HP_add(5000)
  end
end

function UpdateWithInout(dt)
  if(Player:GetPlayerControl())then
    if love.keyboard.isDown('left') then
      if(dk_left)then is_run=true end
      k_left=true
      _k_left=true
      if(king_left)then
        KeyEventClear()
      else
        cdkw=cdkw+dt
        if(dk_wait<=cdkw)then
          king_left=true
          KeyEventClear()
          cdkw=0
        end
      end
      Player:MoveLeft(dt)
    elseif love.keyboard.isDown('right') then
      if(dk_right)then is_run=true end
      k_right=true
      _k_right=true
      if(king_right)then
        KeyEventClear()
      else
        cdkw=cdkw+dt
        if(dk_wait<=cdkw)then
          king_right=true
          KeyEventClear()
          cdkw=0
        end
      end
      Player:MoveRight(dt)
    end    
    if love.keyboard.isDown('up') then
      if(dk_up)then is_run=true end
      k_up=true
      _k_up=true    
      if(king_up)then
        KeyEventClear()
      else
        cdkw=cdkw+dt
        if(dk_wait<=cdkw)then
          king_up=true
          KeyEventClear()
          cdkw=0
        end
      end
      Player:MoveUp(dt)
    elseif love.keyboard.isDown('down') then
      if(dk_down)then is_run=true end
      k_down=true
      _k_down=true    
      if(king_down)then
        KeyEventClear()
      else
        cdkw=cdkw+dt
        if(dk_wait<=cdkw)then
          king_down=true
          KeyEventClear()
          cdkw=0
        end
      end
      Player:MoveDown(dt)
    end
  end

 if is_run == false and (dk_left or dk_right or dk_up or dk_down) then
    cdkw=cdkw+dt
    if(dk_wait<=cdkw)then
      KeyDoubleEventClear()
      cdkw = 0
    end
  end
end

function love.update(dt)
  _MOUSE:update(dt)
  mouse_x,mouse_y,press,mp_but = _MOUSE:getMouseStatus()
 
  if GameSceneId == 1 then
    if(ResIsLoad)then
      Inventory:update()
      Map:update(dt)  
      Player:update(dt)
      UpdateWithInout(dt)
      Player:Control()
      for k ,v in pairs(EnemyGroup) do
        v:AI(dt,Player:GetPosition())
        v:update(dt)
      end
      ImageOrder:Sort()
      PassiveObjectManager:update(dt)
      Font:update(dt)
    else
      L_Graphics.setFont(Font.CA_12)
      Map:Initload()
      
      Player:init()
      Camera:init(Player:GetPosition())
      EnemyGroup = {nil}
      Inventory:init()
      local settings_qucik = {{7,2,3,5,6,19}}
      QuickItem = Inventory:new(RULE.ScreenWidth / 2 - 245,RULE.ScreenHeight - 33,1,6,100)
      Player_equipment = Player:GetEquipment()
      Equipment_Slots = Inventory:new(500,30,2,5,0,1,"equipment")
      ItemManager:init()
      Inventory:load(QuickItem,settings_qucik)
      Inventory:load(Equipment_Slots, Player_equipment)
      ResIsLoad = true
    end
  elseif(GameSceneId == 0)then
      CharacterId = 1
      if(CharacterId == 1)then
        GameSceneId = 1
        ResIsLoad = false
      end
  end

end

function love.draw()

  if GameSceneId == 1 then
    if ResIsLoad then
      Map:draw()
      for k, v in pairs(ImageOrder_Holder) do
        v[1]:draw()
        if(v[5]<2000)then
          ImageOrder:update(k,v[1]:GetOrder())
        end
      end
      Font:draw()
      L_Graphics.translate(-Camera.c_x, -Camera.c_y)
      QuickItem:draw()
      BloodBars:draw()
      Player:HMdraw()
      _MOUSE:draw()
      ShowItemInfo()
    else
      L_Graphics.draw(Img_loading,Pos_ld_x, Pos_ld_y)
    end
  end
end

