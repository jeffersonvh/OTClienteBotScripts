-- Original script by https://trainorcreations.com/coding/otclient

setDefaultTab("Tools")

gpPushDelay = 200 -- safe value: 600ms

macro(gpPushDelay, "Puxar Lixo", "End", function()
        push(0, -1, 0)
        push(0, 1, 0)
        push(-1, -1, 0)
        push(-1, 0, 0)
        push(-1, 1, 0)
        push(1, -1, 0)
        push(1, 0, 0)
        push(1, 1, 0)
end)

function push(x, y, z)
    local position = player:getPosition()
    position.x = position.x + x
    position.y = position.y + y
  
    local tile = g_map.getTile(position)
    local thing = tile:getTopThing()
    if thing and thing:isItem() then
      g_game.move(thing, player:getPosition(), thing:getCount())
    end
end

UI.Separator()