function create(mon,x,y,w,h)
    local gage = {
        mon = mon,
        x = x,
        y = y,
        w = w,
        h = h,
        bgColor = colors.gray,
        fillColor = colors.red,
        bordColor = colors.white
    }
    
    local function drawBox(x,y,w,h,col)
        gage.mon.setBackgroundColor(col)
        for i=0,h-1 do
            gage.mon.setCursorPos(x,y+i)
            gage.mon.write(string.rep(" ",w))
        end
    end
    
    --[[
    function gage.drawInit()
        local x = gage.x
        local y = gage.y
        local w = gage.w
        local h = gage.h
        drawBox(x,y,w,h,gage.bordColor)
    end
    --]]
    
    function gage.update(fill)
        drawBox(gage.x,gage.y,gage.w,gage.h,gage.bordColor)
    
        local x = gage.x + 1
        local y = gage.y + 1
        local w = gage.w - 2
        local h = gage.h - 2
        drawBox(x,y,w,h,gage.bgColor)
        
        h = math.floor(h*fill+0.5)
        y = y - h + gage.h - 2
        drawBox(x,y,w,h,gage.fillColor)
    end
    
    return gage
end
