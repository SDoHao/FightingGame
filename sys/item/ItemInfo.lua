--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月26日]
    [LastModifiedTime: ]
****************************************************************************]]

--[[debug
local Player={}

function Player:GetJob()
  local job="鬼剑士"
  return job
end

function Player:GetLevel()
  local lv=85
  return lv
end
--debug]]

ItemInfo={
  get=false,
  coloredtext,
  x,
  y,
  line,
  line_part2,
}

drag={
  package,
  box,
  Name,
  x,
  y,
  Enable,
  Stack,
  StackLimit,
  Weight,
  BoxId,
  ItemId,
  Icon,
  Type,
  Action=1,  --1 拖拽 2 装备 3卸下 4 出售 5 购买
}

touch={
  box,
  box_id,
  drop,
  msgbox_id,
}

local RarityTxt={
  [0]="普通",
  "高级",
  "稀有",
  "神器",
  "史诗",
  "传说",
  "神话",
  "勇者",
}

local RarityColor={
  [0]={1,1,1,1},
  {0,191/255,1,1},
  --{250/255,90/255,150/255,1},
  {179/255,107/255,205/255},
  {243/255,70/255,243/255,1},
  {255/255,165/255,0,1},
  {255/255,99/255,71/255,1},
  {244/255,164/255,96/255,1},
  {144/255,238/255,144/255,1},
}

local function ColorName(name,name2,rarity)
  local _name = table.concat({name,"\n",name2,"\n                          ", RarityTxt[rarity],"\n"})
  return _name,RarityColor[rarity]
end


local StackableType={
  waste="消耗品",
  
  
  }

local function GetStackableType(stacktype)
  return StackableType[stacktype]
end

function ShowItemInfo()
  if(ItemInfo.get)then
    L_Graphics.setColor(1, 1, 1,0.5)
    L_Graphics.rectangle("line",ItemInfo.x-5,ItemInfo.y,190,ItemInfo.line)
    L_Graphics.setColor(0, 0, 0,0.7)
    L_Graphics.rectangle("fill",ItemInfo.x-5,ItemInfo.y,190,ItemInfo.line)
    L_Graphics.setColor(1, 1, 1, 1)
    L_Graphics.printf(ItemInfo.coloredtext,ItemInfo.x,ItemInfo.y+5,180)
    L_Graphics.setColor(0.4,0.4,0.4,0.8)
    L_Graphics.line(ItemInfo.x,ItemInfo.y+ItemInfo.line_part2,ItemInfo.x+180,ItemInfo.y+ItemInfo.line_part2)
    L_Graphics.setColor(1,1,1,1)
  end
end

function GetItemInfo(item_id,item_type,x,y)
  if item_id~=-1 and (not ItemInfo.get)then
    local settings
    local name
    local name_color={}
    local level
    local level_color={}
    local explain
    local explain_color={30/255,144/255,255/255}
    local explain_line
    local flavor
    local flavor_color={131/255,139/255,139/255}
    local flavor_line
    local line=0
    local line_part2
    local tend
    local body=""
    local profe--profession
    local profe_color={}
    if(item_type==1)then
      local e_type
      local ttype
      local temp
      
      local table_body={}
      
      settings=WeaponList[ItemList[item_id].id]
      name,name_color=ColorName(settings.name,settings.name2,settings.rarity)
      e_type=settings.e_type
      if(e_type==1 or e_type==2)then
        ttype="太刀                      武器\n"
      elseif(e_type==3)then
        ttype="光剑                      武器\n"
      elseif(e_type==4)then
        ttype="巨剑                      武器\n"
      elseif(e_type==5)then
        ttype="短剑                      武器\n"
      elseif(e_type==6)then
        ttype="钝器                      武器\n"
      end
      temp=settings.durability
      tdur=table.concat({"耐久度 ",temp,"/",temp,"\n"})
      line=line+70
      if(settings.minimum_level<=Player:GetLevel())then
        level_color={0.3,0.9,0}
      else
        level_color={1,0.1,0}
      end
      level=table.concat({"lv",settings.minimum_level,"以上可以使用\n"})
      line=line+14
      if(settings.usable_job==Player:GetJob())then
        profe_color={0.3,0.9,0}
      else
        profe_color={1,0.1,0}
      end
      profe=table.concat({settings.usable_job,"可以使用\n\n"})
     
      line=line+28
      
      temp=settings.equipment_physical_attack or 0
      if(temp~=0)then
        table.insert(table_body,table.concat{"物理攻击力 +",temp,"\n"})
        line=line+14
      end
      temp=settings.equipment_magical_attack or 0
      if(temp~=0)then
        table.insert(table_body,table.concat{"魔法攻击力 +",temp,"\n"})
        line=line+14
      end
      temp=settings.physical_attack or 0
      if(temp~=0)then
        table.insert(table_body,table.concat{"力量 +",temp,"\n"})
        line=line+14
      end
      temp=settings.magical_attack or 0
      if(temp~=0)then
        table.insert(table_body,table.concat{"智力 +",temp,"\n"})
        line=line+14
      end
      table.insert(table_body,"\n")
      body=table.concat(table_body)
      line=line+14
      
      explain=settings.explain
      if settings.elemental_property then
        if(settings.elemental_property=="fire")then
          explain="火属性攻击\n\n"..explain
        elseif(settings.elemental_property=="ice")then
          explain="冰属性攻击\n\n"..explain
        elseif(settings.elemental_property=="dark")then
          explain="暗属性攻击\n\n"..explain
        elseif(settings.elemental_property=="light")then
          explain="光属性攻击\n\n"..explain
        end
      end
      if explain == "" then
        line=line+14
      else
     
        explain=explain.."\n"
        explain_line=GetLines(explain,"\n")+1

        line=line+14*explain_line
        
      end
      ItemInfo.line_part2=line
      flavor=settings.flavor_text
      if  flavor == "" then
      
      else
        flavor=table.concat({"\n",flavor,"\n"})
        flavor_line=GetLines(flavor,"\n")
        line=line+14*flavor_line
      end
      tend=FormatPrice(settings.price,settings.weight)
      line=line+42
      
      ItemInfo.coloredtext={name_color,name,{1,1,1},ttype,{1,1,1},tdur,level_color,level,profe_color,profe,{1,1,1},body,explain_color,explain,flavor_color,flavor,{1,1,1},tend}
      
    elseif(item_type==3)then --inventory
      local stacklimit
      local stack=""
      local cooltime=""
      settings=consumptions[ItemList[item_id].id]
      name,name_color=ColorName(settings.name,settings.name2,settings.rarity)
      line=line+28
      
      --if(settings.stackable_type=="waste")then
      stack = GetStackableType(settings.stackable_type)
      --end
      if(settings.cool_time>0)then
        cooltime="冷却时间: "..(settings.cool_time/1000).."秒"
        stack=stack..(' '):rep(38-string.len(stack)-string.len(cooltime))
      end
      body=stack..cooltime.."\n"
      line=line+14
      if(settings.stack_limit and settings.stack_limit >0)then
        line=line+14
        stacklimit="携带上限: "..settings.stack_limit.."个\n"
        body=body..(' '):rep(36-string.len(stacklimit))
        body=body..stacklimit
      end
      if(settings.minimum_level>1)then
        if(settings.minimum_level<=Player:GetLevel())then
          level_color={0.3,0.9,0}
        else
          level_color={1,0.1,0}
        end
        level=table.concat({"lv",settings.minimum_level,"以上可以使用\n"})
        line=line+14
      else
        level_color={1,1,1}
        level=""
      end
      if(settings.usable_job=="all")then
        profe_color={1,1,1}
        profe="\n"
        line=line+28
      else
        if(settings.usable_job==Player:GetJob())then
          profe_color={0.3,0.9,0}
        else
          profe_color={1,0.1,0}
        end
        profe=table.concat({settings.usable_job,"可以使用\n\n"})
        line=line+42
      end
      
      explain=settings.explain
      if explain == "" then
        line=line+14
      else
        explain=explain.."\n"
        explain_line=GetLines(explain,"\n")+1
        line=line+14*explain_line     
      end
      ItemInfo.line_part2=line
      flavor=settings.flavor_text
      if  flavor == "" then
      
      else
        flavor=table.concat({"\n",flavor,"\n"})
        flavor_line=GetLines(flavor,"\n")
        line=line+14*flavor_line
      end
      tend=FormatPrice(settings.price,settings.weight)
      line=line+42
      ItemInfo.coloredtext={name_color,name,{1,1,1},body,level_color,level,profe_color,profe,explain_color,explain,flavor_color,flavor,{1,1,1},tend}
    elseif(item_type==4)then --SKILL
      --[[
      settings=sm_skills[Skill_List[item_id].id]
      name=settings.name.." Lv"..settings.level.."\n"..settings.name2.."\n"
      line=42
      line_part2=37

      body="\n释放时间:"
      if(settings.time==0)then
        body=body.."瞬发"
      else
        body=body..(settings.time/1000).."秒"
      end
      if(settings.cooltime==0)then
        
      else
        explain="\n"..settings.explain
      end
      line=line+70
      coloredtext={{1,0.84,0},name,{1,1,1},body,explain_color,explain}
      ]]
    end
    ItemInfo.line=line
    --Boundary

    if(x<0)then
      x=0
    elseif(x+180>RULE.ScreenWidth)then
      x=RULE.ScreenWidth-180
    end
    y=y-line+15
    if(y<0)then
      y=0
    elseif(y+line+15>RULE.ScreenHeight)then
      y=RULE.ScreenHeight-line-15
    end
    ItemInfo.x = x
    ItemInfo.y = y
    --End Boundary
    ItemInfo.get = true
  end
  collectgarbage("collect")
end

function GetLines(Str,pattern)
  local count = 0
  for s in string.gmatch(Str, pattern) do
      count=count+1
  end
  return count
end

function FormatPrice(price,weight)
  local tprice={}
  local tend
  if(price==0)then
    tend=""
  else
    table.insert(tprice,"\n")
    if(price>=1000000)then
      local million=math.floor(price/1000000)
      price=price%1000000
      local thousand=math.floor(price/1000)
      table.insert(tprice,million)
      table.insert(tprice,",")
      if(thousand==0)then
        table.insert(tprice,"000,")
      elseif(thousand<10)then
        table.insert(tprice,"00")
      elseif(thousand<100)then
        table.insert(tprice,"0")
      end
    end
    if(price>=1000)then
      table.insert(tprice,math.floor(price/1000))
      table.insert(tprice,",")
      price=price%1000
      if(price<10)then
        table.insert(tprice,"00")
      elseif(price<100)then
        table.insert(tprice,"0")
      end
    end
    table.insert(tprice,price)
    table.insert(tprice,"金币")
    
  end
  if(weight~=0)then
    table.insert(tprice,table.concat({"\n",(weight/1000),"Kg"}))
  end
  tend=table.concat(tprice)
  return tend
end

return ItemInfo

