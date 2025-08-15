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
SMODS.Atlas {
	key = "tuplets_new",
	px = 71,
	py = 95,
	path = "Tuplets.png"
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

function ASA.check_enhancement(area, enhancement)
	local blss = 0
	if area and type(area) == "table" then
		for _, v in pairs(area) do
			if SMODS.has_enhancement(v, enhancement) then
				blss = blss + 1
			end
		end
		return blss
	end
	return 0
end

function ASA.level_up_hand(hand, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
		handname = localize(hand, "poker_hands"),
		chips = G.GAME.hands[hand].chips,
		mult = G.GAME.hands[hand].mult,
		level = G.GAME.hands[hand].level,
	})
	level_up_hand(used_consumable, hand, nil, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, {
		mult = 0,
		chips = 0,
		handname = localize(hand, "poker_hands"),
		level = G.GAME.hands[hand].level,
	})
end


--Jokers
SMODS.load_file("items/Jokers/common_jokers.lua")()
SMODS.load_file("items/Jokers/uncommon_jokers.lua")()
SMODS.load_file("items/Jokers/rare_jokers.lua")()

--Consumables
SMODS.load_file("items/Consumables/spectrals.lua")()