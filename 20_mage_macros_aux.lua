-- Original script by https://github.com/jeffersonvh/OTClienteBotScripts

setDefaultTab("Tools")

macro(3000, "Auto exeta res", function()
saySpell("exeta res", 200)
delay(1000)
end)

local healtId = 7643
local healtPercent = 72
macro(200, "faster healt potting",  function()
  if (lifepercent() <= healtPercent) then
    usewith(healtId, player) 
  end
end)

UI.Separator()