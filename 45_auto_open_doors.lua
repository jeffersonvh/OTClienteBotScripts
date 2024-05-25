-- Original script by https://trainorcreations.com/

setDefaultTab("Tools")

if not storage.doorIds then
    storage.doorIds = { 5129, 5102, 5111, 5120, 11246, 386 }
end

local moveTime = 2000     -- Wait time between Move, 2000 milliseconds = 2 seconds
local moveDist = 2        -- How far to Walk
local useTime = 2000     -- Wait time between Use, 2000 milliseconds = 2 seconds
local useDistance = 2     -- How far to Use
local playerIsDown = false
local playerDownPosition = nil

local function properTable(t)
    local r = {}
    for _, entry in pairs(t) do
        table.insert(r, entry.id)
    end
    return r
end

UI.Label("Door IDs")

local doorContainer = UI.Container(function(widget, items)
    storage.doorIds = items
    doorId = properTable(storage.doorIds)
end, true)

doorContainer:setHeight(35)
doorContainer:setItems(storage.doorIds)
doorId = properTable(storage.doorIds)

onPlayerPositionChange(function(newPos, oldPos)
    if (oldPos.z < posz()) then
        playerIsDown = true
        playerDownPosition = newPos;
    else
        if (playerIsDown == true) then
            useTime = 5000
        else
            useTime = 2000
        end
        playerIsDown = false
    end    
end)

clickDoor = macro(1000, "Use Doors", function()
    for i, tile in ipairs(g_map.getTiles(posz())) do
        local item = tile:getTopUseThing()
        if item and table.find(doorId, item:getId()) then
            local tPos = tile:getPosition()
            local distance = getDistanceBetween(pos(), tPos)

            if (distance <= useDistance and not playerIsDown and tPos ~= playerDownPosition) then
                if (item:getId() == 386) then
                    useWith(3003, item)
                else
                    use(item)
                end

                return delay(useTime)
            end

            delay(5000)

            if (distance <= moveDist and distance > useDistance) then
                if findPath(pos(), tPos, moveDist, { ignoreNonPathable = true, precision = 1 }) then
                    autoWalk(tPos, moveTime, { ignoreNonPathable = true, precision = 1 })
                    return delay(waitTime)
                end
            end
        end
    end
end)

UI.Separator()
