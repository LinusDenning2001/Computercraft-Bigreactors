function create(mon,x,y,w,h,text)
    local button = {
        mon = mon,
        x = x,
        y = y,
        w = w,
        h = h,
        text = tostring(text),
        bgColor = colors.lime,
        txColor = colors.black,
        blColor = colors.red
    }
    
    function button.drawFunc(bgColor)
        local freeX = math.floor(button.w - string.len(button.text))
        local midY = button.y + math.floor(button.h / 2)
    
        button.mon.setBackgroundColor(bgColor)
        button.mon.setTextColor(button.txColor)
        for i=0,button.h-1 do
            button.mon.setCursorPos(button.x,button.y+i)
            button.mon.write(string.rep(" ",button.w))
        end
        
        button.mon.setCursorPos(button.x+freeX/2,midY)
        button.mon.write(button.text)
    end
    
    function button.draw()
        button.drawFunc(button.bgColor)
    end

    function button.wasClicked(x,y)
        if x >= button.x and x < button.x + button.w and y >= button.y and y < button.y + button.h then
            return true
        end
        return false
    end
    
    function button.blink()
        button.drawFunc(button.blColor)
        sleep(0.2)
        button.draw()
    end
    
    return button
end

function watch(buttons)
    for i in pairs(buttons) do
        buttons[i].draw()
    end
    
    _,_,x,y = os.pullEvent("monitor_touch")
    for i in pairs(buttons) do
        if buttons[i].wasClicked(x,y) then
            buttons[i].blink()
        end
    end
end
