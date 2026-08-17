if not LegendarySkinsManager then
    dofile(ModPath .. "lib/LegendarySkinsManager.lua")
end

if LegendarySkinsManager and LegendarySkinsManager.install then
    LegendarySkinsManager.install()
end
