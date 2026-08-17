LegendarySkinsManager = LegendarySkinsManager or {}

local M = LegendarySkinsManager
if M._installed then
    return
end
M._installed = true

local pairs = pairs
local tostring = tostring
local type = type
local find = string.find

local function normalize_inventory_keys(inventory)
    if type(inventory) ~= "table" then
        return
    end

    local numeric_keys = {}
    for key, value in pairs(inventory) do
        if type(key) == "number" then
            numeric_keys[#numeric_keys + 1] = { key = key, value = value }
        end
    end

    for _, entry in ipairs(numeric_keys) do
        local string_key = tostring(entry.key)
        if inventory[string_key] == nil then
            inventory[string_key] = entry.value
        end
        inventory[entry.key] = nil
    end
end

function M.install()
    local blackmarket = managers and managers.blackmarket
    local global = blackmarket and blackmarket._global
    local weapon_skins = tweak_data and tweak_data.blackmarket and tweak_data.blackmarket.weapon_skins
    local inventory = global and global.inventory_tradable

    if type(weapon_skins) ~= "table" or type(inventory) ~= "table" then
        return
    end

    normalize_inventory_keys(inventory)

    local existing = {}
    for instance_id, item in pairs(inventory) do
        if type(item) == "table" and item.category == "weapon_skins" and item.entry then
            existing[item.entry] = true
        end
    end

    local next_id = 1
    for instance_id in pairs(inventory) do
        local numeric_id = tonumber(instance_id)
        if numeric_id and numeric_id >= next_id then
            next_id = numeric_id + 1
        end
    end

    for skin_id, data in pairs(weapon_skins) do
        if not find(skin_id, "color", 1, true) then
            data.locked = false
            if not existing[skin_id] then
                local instance_id = tostring(next_id)
                blackmarket:tradable_add_item(instance_id, "weapon_skins", skin_id, "mint", true, 1)
                existing[skin_id] = true
                next_id = next_id + 1
            end
        end
    end

    local crafted = global.crafted_items
    if type(crafted) == "table" then
        local categories = { crafted.primaries, crafted.secondaries }
        for _, category in ipairs(categories) do
            if type(category) == "table" then
                for _, item in pairs(category) do
                    if type(item) == "table" and item.cosmetics then
                        item.customize_locked = nil
                    end
                end
            end
        end
    end
end

M.install()
