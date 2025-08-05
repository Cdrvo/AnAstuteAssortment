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


--Jokers

SMODS.load_file("items/Jokers/common_jokers.lua")()
SMODS.load_file("items/Jokers/uncommon_jokers.lua")()
SMODS.load_file("items/Jokers/rare_jokers.lua")()

--Consumables
SMODS.load_file("items/Consumables/spectrals.lua")()