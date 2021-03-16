RULE = {
  ScreenWidth = 720,
  ScreenHeight = 480,
  WepIconNum=13,
}


--pubilc function
function cloneTab(tab)  
    local ins = {}  
    for key, var in pairs(tab) do  
        ins[key] = var
    end  
    return ins  
end

function GetStrNum(Str,pattern)
  local count = 0
  for s in string.gmatch(Str, pattern) do
      count = count + 1
  end
  return count
end

function BoxDataRead(path)
  local _read_file = io.open(path, "r")
  local box_data = {}
  for i = 1,210 do
    local data = {nil,nil,nil,nil}
    data[1] = _read_file:read("*n")
    data[2] = _read_file:read("*n")
    data[3] = _read_file:read("*n")
    data[4] = _read_file:read("*n")
    box_data[i] = data
  end
  io.close(_read_file)
  return box_data
end

return RULE