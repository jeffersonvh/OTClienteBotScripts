setDefaultTab("Tools")

singlehotkey("F12", "Stop/Cave", function()
if CaveBot.isOn() or TargetBot.isOn() then
    CaveBot.setOff()
    TargetBot.setOff()
elseif CaveBot.isOff() or TargetBot.isOff() then
    CaveBot.setOn()
    TargetBot.setOn()
 end
end)

UI.Separator()