MonsterManager = {}

local MonsterImageManager = require('res/Monster/MonsterImageManager')

local uid_available = {}



function MonsterManager:init()
  
  
  
  
  MonsterImageManager:init()

end

local enemy_uid = 1100

local function GetUid()
  
  if(uid >= 2000)then
    if((#uid_available) > 0)then
      local i = uid_available[1]
      table.remove(uid_available,1)
      return i
    else
      --print("Exceeding the upper limit")
      return -1
    end
  else
    return uid
  end
end



return MonsterManager