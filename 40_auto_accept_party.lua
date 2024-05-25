-- Original script by https://github.com/jeffersonvh/OTClienteBotScripts

setDefaultTab("Tools")

macro(4000, "say pt", function()
if player:getShield() > 2 then return end

saySpell("pt", 200)

end)

macro(1000,"Auto Accept Party",function()

  if player:getShield() > 2 then return end

  for s, spec in pairs(getSpectators(false)) do

    if spec:getShield() == 1 then

      g_game.partyJoin(spec:getId())

      TargetBot.setOn()
      CaveBot.setOn()

      delay(1000)

    end

  end

end)

UI.Separator()