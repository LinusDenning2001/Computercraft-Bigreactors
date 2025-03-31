function create(mon,x,y,w,h,text)
    local box = {
        mon = mon,
        x = x,
        y = y,
        w = w,
        h = h,
        text = tostring(text),
        bgColor = colors.black,
        txColor = colors.white
    }
    
    function box.draw(text)
        local freeX = math.floor(box.w - string.len(box.text .. text))
        local midY = box.y + math.floor(box.h / 2)
    
        box.mon.setBackgroundColor(box.bgColor)
        box.mon.setTextColor(box.txColor)
        for i=0,box.h-1 do
            box.mon.setCursorPos(box.x,box.y+i)
            box.mon.write(string.rep(" ",box.w))
        end
        
        box.mon.setCursorPos(box.x,midY)
        box.mon.write(box.text .. text)
    end
    
    return box
end
