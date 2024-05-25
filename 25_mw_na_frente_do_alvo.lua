-- Original script by https://www.ghostscripts.com.br/

setDefaultTab("Tools")

local key = "F5" -- Hotkey para tacar mwall
local mwallId = 3180 -- Mwall ID
local squaresThreshold = 2 -- quantidade de sqm a tacar MW frente do char
singlehotkey(key, "Mwall Frente Target", function()
local target = g_game.getAttackingCreature()
      if target then
local targetPos = target:getPosition()
local targetDir = target:getDirection()
local mwallTile
      if targetDir == 0 then -- north
        targetPos.y = targetPos.y - squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 1 then -- east
        targetPos.x = targetPos.x + squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 2 then -- south
        targetPos.y = targetPos.y + squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 3 then -- west
        targetPos.x = targetPos.x - squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      end
   end
end)
