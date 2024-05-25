setDefaultTab("HP")

local EQUIP_DELAY = 300
local EQUIP_ACTION = "equip"
local UNEQUIP_ACTION = "unequip"
local HP = "hp"
local MANA = "mana"

--[[
SlotHead - Head
SlotNeck - Amulet 
SlotBack - Backpack 
SlotBody - Armor 
SlotRight - Right Hand 
SlotLeft - Left Hand  
SlotLeg - Legs 
SlotFeet - Boots 
SlotFinger - Ring 
SlotAmmo - Ammo
--]]

local SET = {
  {slot = SlotNeck, action = EQUIP_ACTION, value = 35, activeId = 12516, unactiveId = 12509, hpOrMana = HP},
  {slot = SlotNeck, action = UNEQUIP_ACTION, value = 85, activeId = 12516, unactiveId = 12509, hpOrMana = MANA},
  {slot = SlotFinger, action = EQUIP_ACTION, value = 35, activeId = 3086, unactiveId = 3049, hpOrMana = HP},  
  {slot = SlotFinger, action = UNEQUIP_ACTION, value = 85, activeId = 3086, unactiveId = 3049, hpOrMana = MANA},  
}

local function equipItemToSlot(slot, action, activeId, unactiveId)
  local slotId = getSlot(slot) and getSlot(slot):getId() or nil
  if (not slotId and action ~= UNEQUIP_ACTION) or (action == EQUIP_ACTION and slotId ~= activeId) or (action == UNEQUIP_ACTION and slotId == activeId) then
    if g_game.getClientVersion() <= 860 then
	  if action == EQUIP_ACTION then
        moveToSlot(unactiveId, slot)
	  else
	    moveToSlot(getSlot(slot), SlotBack)
	  end
	  return true
    else
      g_game.equipItemId(unactiveId)
	  return true
    end
  end
  return false
end

local function isConditionSatisfy(item)
  local hpOrMana = item.hpOrMana == HP and hppercent() or item.hpOrMana == MANA and manapercent()
  return (item.action == EQUIP_ACTION and hpOrMana < item.value) or (item.action == UNEQUIP_ACTION and hpOrMana > item.value)
end

local function hasHigherPriority(itemInSet, itemInMap)
  if itemInSet.action == EQUIP_ACTION then
    if itemInMap.value > itemInSet.value then
	  if isConditionSatisfy(itemInSet) then
	    return true
	  end
	end
  else
    if itemInMap.value < itemInSet.value then
	  if isConditionSatisfy(itemInSet) then
	    return true
	  end
	end
  end
  return false
end

local function getHighestPriorityItems()
  local items = {}
  for i, item in pairs(SET) do
    local itemInMap = items[item.slot]
    if (not itemInMap and isConditionSatisfy(item)) or (itemInMap and hasHigherPriority(item, itemInMap)) then
	  items[item.slot] = item
	end
  end
  return items
end

macro(100, "Equipper -[860 ~ 1200]+", function()
  local items = getHighestPriorityItems()
  for i, item in pairs(items) do
	if equipItemToSlot(item.slot, item.action, item.activeId, item.unactiveId) then
	  delay(EQUIP_DELAY)
	  return
    end
  end
end)

UI.Separator()