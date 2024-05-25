-- Original script by https://trainorcreations.com/coding/otclient

setDefaultTab("Tools")

local treeChange = 3681
macro(100, "Hide Trees", "F2", function()
    for i, tile in ipairs(g_map.getTiles(posz())) do
        for u, item in ipairs(tile:getItems()) do
            if (item) then
                tree_array = { 3625, 3621, 3622, 4433, 6497, 3744, 3742, 3756, 3759, 3757, 3750, 3755, 3747, 6490, 3745, 3743, 3751, 3760, 3753, 3909, 3870, 3871, 3758 }
                if table.find(tree_array, item:getId()) then
                    item:setId(treeChange)
                end
            end
        end
    end
end)

UI.Separator()
