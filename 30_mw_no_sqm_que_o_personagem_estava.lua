-- Original script by https://www.ghostscripts.com.br/

setDefaultTab("Tools")

local mw = macro(100, "Mw", "F10",function() end)
onPlayerPositionChange(function(newPos, oldPos)
    if oldPos.z ~= posz() then return end
    if oldPos then
        local tile = g_map.getTile(oldPos)
        if mw.isOn() and tile:isWalkable() then
            useWith(3180, tile:getTopUseThing())
        end
    end
end)