ASA = SMODS.current_mod

SMODS.Atlas { -- spectral atlas
    key = "asa_spectrals",
    px = 71,
    py = 95,
    path = "spectrals.png"
}
SMODS.Atlas { -- joker atlas
    key = "asa_jokers",
    px = 71,
    py = 95,
    path = "jokers.png"
}


to_big = to_big or function(x)
	return x
end

SMODS.optional_features.cardareas.unscored = true


--Funcs

function ASA.find_highest(area)
    local low = 1
    local card = nil
    for i = 1, #area do
        if area[i].base.id > low then
            low = area[i].base.id
            card = area[i]
        end
    end
    return {low, card}
end


--Jokers
SMODS.load_file("items/Jokers/common_jokers.lua")()
SMODS.load_file("items/Jokers/uncommon_jokers.lua")()
SMODS.load_file("items/Jokers/rare_jokers.lua")()

--Consumables
SMODS.load_file("items/Consumables/spectrals.lua")()