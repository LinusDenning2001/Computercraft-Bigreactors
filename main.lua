function roundToFive(num)
    return math.floor((num/5)+0.5)*5
end

os.loadAPI("disk/gage.lua")
os.loadAPI("disk/textInfo.lua")
local mon = peripheral.wrap("right")
local react = peripheral.wrap("back")

mon.setBackgroundColor(colors.black)
mon.clear()

local xMax,yMax = mon.getSize()
local meterStart = math.floor(xMax*4/5)
local meter = gage.create(mon,meterStart,1,xMax - meterStart+1, yMax)
local RFDisplay = textInfo.create(mon,1,1,10,1,"Energy Output KRF: ")
local CRDisplay = textInfo.create(mon,1,3,10,1,"Control Rod Level: ")
local TMDisplay = textInfo.create(mon,1,5,10,1,"Core Temperature : ")
local FRDisplay = textInfo.create(mon,1,7,10,1,"Fuel Burnup Rate : ")

local batteryLevel = 0
local RF = 0
local CR = 0
local TM = 0
local FR = 0

local headers = {}

while true do
    batteryLevel = react.getEnergyStored()/10000000
    react.setAllControlRodLevels(roundToFive(batteryLevel*100))
    
    RF = tostring(math.floor((react.getEnergyProducedLastTick()/100)+0.5)/10) .. " kRF/t "
    CR = tostring(react.getControlRodLevel(1)) .. " % "
    FT = tostring(math.floor(react.getFuelTemperature()+0.5)) .. " C "
    FR = tostring(math.floor(react.getFuelConsumedLastTick()*1000+0.5)/1000) .. " mB/t "
            
     
    OnData = "reactorOn=" .. tostring(react.getActive())
    RFData = "RFLastTick=" .. RF
    CRData = "controlLevel=" .. CR
    FTData = "fuelTemp=" .. FT
    FRData = "fuelRate=" .. FR
    
    data = OnData .."&".. RFData .."&".. CRData .."&".. FTData .."&".. FRData
    
    http.post(¨Website Name¨,data)
    
    
    meter.update(batteryLevel)
    RFDisplay.draw(RF)
    CRDisplay.draw(CR)
    TMDisplay.draw(FT)
    FRDisplay.draw(FR)
    
    sleep(2)
end
