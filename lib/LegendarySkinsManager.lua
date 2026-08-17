LegendarySkinsManager = LegendarySkinsManager or {}

local M = LegendarySkinsManager
M._installed = M._installed or false

-- Replace or extend these IDs for the game build you use.
M.legendary_skin_ids = M.legendary_skin_ids or {
    "legendary_skin_01",
    "legendary_skin_02",
    "legendary_skin_03",
    "legendary_skin_04"
}

local function add_unique(list, value)
    if type(list) ~= "table" or value == nil then
        return
    end
    for _, existing in ipairs(list) do
        if existing == value then
            return
        end
    end
    list[#list + 1] = value
end

function M.install()
    if M._installed then
        return
    end
    M._installed = true

    -- Cache once; never run this from an update/render loop.
    local blackmarket = managers and managers.blackmarket
    if not blackmarket then
        return
    end

    local inventory = blackmarket._global and blackmarket._global.inventory
    if type(inventory) ~= "table" then
        return
    end

    for _, skin_id in ipairs(M.legendary_skin_ids) do
        add_unique(inventory, skin_id)
    end
end
