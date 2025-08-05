SMODS.Joker({
	key = "spare_shoes",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 2, y = 0 },
	perishable_compat = false,
	config = {
		extra = {
			chips = 0,
			chipg = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = { asa.chips, asa.chipg },
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and next(context.poker_hands["Pair"]) then
			asa.chips = asa.chips + asa.chipg
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
		end
		if context.joker_main then
			return {
				chips = asa.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "spare_dress_shirt",
	cost = 5,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 3, y = 0 },
	perishable_compat = false,
	config = {
		extra = {
			dollars = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = { asa.dollars },
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and next(context.poker_hands["Three of a Kind"]) then
			return {
				dollars = asa.dollars,
			}
		end
	end,
})


SMODS.Joker({
	key = "rising_sun_casino",
	cost = 5,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 4, y = 0 },
	perishable_compat = false,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.evaluate_poker_hand and context.scoring_name == "Two Pair" then
            card.asa_trigger = true
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Hearts") then
					card.asa_trigger = nil
				end
			end
			if card.asa_trigger then
				return {
					replace_scoring_name = "Full House", -- necessary
					replace_display_name = "Full House", -- may not be necessary idk
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "klein_bottle",
	cost = 8,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 5, y = 0 },
	perishable_compat = false,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before then
			for i = 1, #context.scoring_hand do
                if context.scoring_hand[1]:get_id() == 14 and context.scoring_hand[#context.scoring_hand]:get_id() == 2 then
                    
                end
			end
		end
	end,
})
