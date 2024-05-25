setDefaultTab("Tools")

followName = "autofollow2"
if not storage[followName] then storage[followName] = { player = 'name', keepDistanceRange = 1} end
if not storage.keepDistanceToggle then storage.keepDistanceToggle = false end
local toFollowPos = {}

UI.Label("Auto Follow")

followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end)

local followChange = macro(200, "Follow Change", function() end)

local followMacro = macro(20, "Follow", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    if player:isWalking() then
        return
    end
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    if target and storage.keepDistanceToggle then
        if autoWalk(p, 20, { ignoreNonPathable = true, precision = 1, marginMin=storage[followName].keepDistanceRange, marginMax=storage[followName].keepDistanceRange + 1 }) then
            delay(100)
        end
    elseif autoWalk(p, 20, { ignoreNonPathable = true, precision = 1}) then
            delay(200)
    end
end)

onPlayerPositionChange(function(newPos, oldPos)
  if followChange:isOff() then return end
  if (g_game.isFollowing()) then
    tfollow = g_game.getFollowingCreature()

    if tfollow then
      if tfollow:getName() ~= storage[followName].player then
        followTE:setText(tfollow:getName())
        storage[followName].player = tfollow:getName()
      end
    end
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature:getName() == storage[followName].player and newPos then
        toFollowPos[newPos.z] = newPos
    end
end)

UI.Label("Keep Distance")
distanceTE = UI.TextEdit(storage[followName].keepDistanceRange or 1, function(widget, newText2)
    storage[followName].keepDistanceRange = tonumber(newText2)
    distanceTO:setColor("red")
end)

distanceTO = UI.Button("Keep Distance", function()
  if storage.keepDistanceToggle then
    distanceTO:setColor("red")
    storage.keepDistanceToggle = false
  else
    distanceTO:setColor("green")
    storage.keepDistanceToggle = true
  end
end )

if storage.keepDistanceToggle then distanceTO:setColor("green") else distanceTO:setColor("red") end