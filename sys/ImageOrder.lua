--[[************************************************************************
    [Author:MillionShen]
    [CreateDate:2020年2月14日]
    [LastModifiedTime: ]
****************************************************************************]]

ImageOrder={}

ImageOrder_Holder = {}

function ImageOrder:push(obj,z,x,y,uid)
  local order = z or 0
  
  table.insert(ImageOrder_Holder,{obj,order,x,y,uid})

  table.sort(ImageOrder_Holder, function(a,b) return a[2] < b[2] end)

end

function ImageOrder:update(k,z,x,y,uid)
  local _img = ImageOrder_Holder[k]
  _img[2] = z
  _img[3] = x
  _img[4] = y
  --ImageOrder_Holder[k][5]=uid
end

function ImageOrder:Sort()
  table.sort(ImageOrder_Holder, function(a,b) return a[2]<b[2] end)
end

function ImageOrder:UidPop(uid)
  for i = #(ImageOrder_Holder) , 1 , -1 do
    if(ImageOrder_Holder[i][5]==uid)then
      table.remove(ImageOrder_Holder, i)
    end
  end
end

function ImageOrder:UidPopOnce(uid)
  for i = #(ImageOrder_Holder) , 1 , -1 do
    if(ImageOrder_Holder[i][5] == uid)then
      table.remove(ImageOrder_Holder, i)
      return
    end
  end
end

return ImageOrder