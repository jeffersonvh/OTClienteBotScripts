-- Original script by https://www.ghostscripts.com.br/

setDefaultTab("Tools")

local summonName = "Nome do summon"

function isSummonOnScreen()
    for _, spec in ipairs(getSpectators()) do
        if not spec:isPlayer() and spec:getName() == summonName then
     return true
    end
   end
end

macro(100, "Summon", function()
      if not isSummonOnScreen() then
          say('Nome da magia de')
   end
end)

UI.Separator()
