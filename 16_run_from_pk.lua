-- Original script by https://github.com/jeffersonvh/OTClienteBotScripts

setDefaultTab("Tools")

macro(100, "Run from PK", function() 
  for i, spec in ipairs(getSpectators()) do
    if not spec:isLocalPlayer() and not isFriend(spec) then
      if spec:isPlayer() then 
        if spec:isTimedSquareVisible() then
          TargetBot.setOff()
          CaveBot.gotoLabel("RunFromPk")
        end
      end
    end
  end
end)

UI.Separator()