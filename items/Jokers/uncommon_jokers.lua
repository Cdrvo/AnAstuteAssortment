SMODS.Joker({
	key = "spare_shoes",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 2, y = 0 },
	perishable_compat = false,
	blueprint_compat = true,
	config = {
		extra = {
			chips = 0,
			chipg = 3,
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
	blueprint_compat = true,
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
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 4, y = 0 },
	blueprint_compat = false,
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
		if context.evaluate_poker_hand and context.scoring_name == "Two Pair" and not context.blueprint then
			card.asa_trigger = true
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Hearts") then
					card.asa_trigger = nil
				end
			end
			for k, v in pairs(G.play.cards) do
				if v:is_suit("Hearts") then
					card.asa_trigger = nil
				end
			end
			if card.asa_trigger and not context.blueprint then
				return {
					replace_scoring_name = "Full House",
					replace_display_name = "Full House",
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
	blueprint_compat = false,
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
		if context.final_scoring_step and not context.blueprint then
			card.asa_trigger = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				func = function()
					for i = 1, #context.scoring_hand do
						if
							context.scoring_hand[1]:get_id() == 14
							and context.scoring_hand[#context.scoring_hand]:get_id() == 2
						then
							card.asa_trigger = true
						end
					end
					if card.asa_trigger then
						for k, v in pairs(context.scoring_hand) do
						if v ~= context.scoring_hand[1] and v ~= context.scoring_hand[#context.scoring_hand] then
							v:juice_up()
							v:set_ability("m_glass")
						end
					end
				end
					return true
				end,
			}))
		end
	end,
})

SMODS.Joker({
	key = "attorney",
	cost = 5,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 0, y = 1 },
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 1.5,
			chips = 44,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
				asa.chips,
			},
		}
	end,
	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.joker_main then
			if G.GAME.current_round.discards_left >= G.GAME.current_round.hands_left then
				return {
					xmult = asa.xmult,
				}
			else
				return {
					chips = asa.chips,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "ds_al_cola",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 5, y = 1 },
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.3,
			odds = 14,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
				asa.xmultg,
				(G.GAME.probabilities.normal or 1),
				asa.odds,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			if to_big(G.GAME.hands[context.scoring_name].played_this_round) > to_big(0) then
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
				asa.xmult = asa.xmult + asa.xmultg
			end
		end
		if context.joker_main then
			return {
				xmult = asa.xmult,
			}
		end

		if context.setting_blind and not context.blueprint and not G.GAME.blind.boss then
			if pseudorandom("ds_al_cola") < G.GAME.probabilities.normal / asa.odds then
				asa.xmult = 1
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_reset") })
			end
		end
	end,
})


SMODS.Joker:take_ownership('j_oops',
    { 
	in_pool = function(self, wawa, wawa2)
		if #SMODS.find_card("j_asa_snake_eyes") > 0 then
			return false
		end
		return true
	end,
    },
    true 
)

SMODS.Joker({
	key = "snake_eyes",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 6, y = 1 },
	config = {
		extra = {
			odd_remove = 1,
		},
	},
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.odd_remove,
			},
		}
	end,

	add_to_deck = function(self, card, from_debuff)
		local asa = card.ability.extra
		G.GAME.probabilities.normal = G.GAME.probabilities.normal - asa.odd_remove
	end,
	remove_from_deck = function(self, card, from_debuff)
		local asa = card.ability.extra
		G.GAME.probabilities.normal = G.GAME.probabilities.normal + asa.odd_remove
	end,
		in_pool = function(self, wawa, wawa2)
		if #SMODS.find_card("j_oops") > 0 then
			return false
		end
		return true
	end,
})

local retrigger_cards = {}
SMODS.Joker({
	key = "six_uational",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 2, y = 2 },
	blueprint_compat = true,
	config = {
		extra = {
			retriggers = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.retriggers,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			for k, v in pairs(G.hand.cards) do
				if v.ability.set == "Enhanced" then
					if not SMODS.has_enhancement(v, "m_steel") and not SMODS.has_enhancement(v, "m_gold") then
						retrigger_cards[#retrigger_cards + 1] = v
					end
				end
			end

			for k, v in pairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, "m_steel") or SMODS.has_enhancement(v, "m_gold") then
					retrigger_cards[#retrigger_cards + 1] = v
				end
			end
		end

		if context.repetition then
			for k, v in pairs(retrigger_cards) do
				if context.other_card == v and context.other_card:get_id() == 6 then
					return {
						repetitions = asa.retriggers + 1,
					}
				elseif context.other_card == v then
					return {
						repetitions = asa.retriggers,
					}
				end
			end
		end
		if context.final_scoring_step then
			retrigger_cards = {}
		end
	end,
})

local juice_seven = true --I may have overcomplicated this
SMODS.Joker({
	key = "power_of_seven",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 3, y = 2 },
	config = {
		extra = {
			timer = 7,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.timer,
			},
		}
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			card.asa_trigger = nil
			if asa.timer > 0 then
				for k, v in pairs(context.scoring_hand) do
					if v:get_id() == 7 then
						card.asa_trigger = true
					end
				end
				if card.asa_trigger then
					asa.timer = asa.timer - 1
				end
			end
		end
	end,

	update = function(self, card, context)
		local asa = card.ability.extra
		if asa.timer == 0 then
			if juice_seven then
				local eval = function()
					return asa.timer == 0
				end
				juice_card_until(card, eval, true)
				juice_seven = nil
			end

			if G.consumeables.config.card_limit > #G.consumeables.cards then
				SMODS.add_card({
					set = "Spectral",
					area = G.consumeables,
				})
				juice_seven = true
				asa.timer = 7
			end
		end
	end,
})

SMODS.Joker({
	key = "jackpot",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 4, y = 2 },
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 3,
			dollars = 4,
			sevens = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
				asa.dollars,
				asa.sevens,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			asa.sevens = 0
			for k, v in pairs(context.scoring_hand) do
				if v:get_id() == 7 then
					asa.sevens = asa.sevens + 1
				end
			end
		end

		if context.joker_main and asa.sevens >= 3 then
			return {
				xmult = asa.xmult,
				dollars = asa.dollars,
			}
		end
	end,
})

SMODS.Joker({
	key = "pocket_snowmen",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 5, y = 2 },
	config = {
		extra = {
			mult = 0,
			multg = 3,
			eis = 0,
		},
	},
	perishable_compat = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.mult,
				asa.multg,
				asa.eis,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			asa.eis = 0
			for k, v in pairs(context.scoring_hand) do
				if v:get_id() == 8 then
					asa.eis = asa.eis + 1
				end
			end
			if asa.eis >= 2 and ASA.find_highest(context.scoring_hand)[2]:get_id() == 8 then
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
				asa.mult = asa.mult + asa.multg
			end
		end
		if context.joker_main then
			return {
				mult = asa.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "niner_niner",
	cost = 6,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 6, y = 2 },
	config = {
		extra = {
			xmult = 2,
			nines = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
				asa.nines,
			},
		}
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.before and not context.blueprint then
			card.asa_trigger = nil
			asa.nines = 0
			for k, v in pairs(context.scoring_hand) do
				if v:get_id() == 9 then
					asa.nines = asa.nines + 1
				end
			end
			if asa.nines >= 2 then
				card.asa_trigger = true
			end
		end
		if context.joker_main and card.asa_trigger then
			return {
				xmult = asa.xmult,
			}
		end
	end,
})

local suitsold = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if #SMODS.find_card("j_asa_of_all_trades") >= 1 and self:get_id() == 11 then
		return true
	end
	return suitsold(self, suit, bypass_debuff, flush_calc)
end

SMODS.Joker({
	key = "of_all_trades",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 1, y = 3 },
	blueprint_compat = false,
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
	end,
})

SMODS.Joker({
	key = "halberd",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 2, y = 3 },
	perishable_compat = false,
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.1,
		},
	},
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
				asa.xmultg,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.setting_blind and G.GAME.blind.boss and not context.blueprint then
			local jacks = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 11 then
					jacks = jacks + 1
				end
			end
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
			asa.xmult = asa.xmult + (asa.xmultg * jacks)
		end

		if context.joker_main then
			return {
				xmult = asa.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "pizza",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 5, y = 3 },
	eternal_compat = false,
	blueprint_compat = true,
	config = {
		extra = {
			timer = 8,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		local comp = localize("k_incompatible")
		local rightmost
		local c
		if G.jokers and G.jokers.cards then
			rightmost = G.jokers.cards[#G.jokers.cards]
		end
		if rightmost then
			if not (rightmost.config.center.blueprint_compat == false) and rightmost ~= card then
				comp = localize("k_compatible")
				c = G.C.GREEN
			else
				comp = localize("k_incompatible")
				c = G.C.RED
			end
		end
		return {
				main_end = (card.area and card.area == G.jokers) and {
					{
						n = G.UIT.C,
						config = { align = "bm", padding = 0.02 },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "m", colour = c, r = 0.05, padding = 0.05 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = " " .. comp .. " ",
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.3,
											shadow = true,
										},
									},
								},
							},
						},
					},
				},
			vars = {
				asa.timer,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if not G.jokers then
			return nil
		end
		local right_most_e = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				local right_most = G.jokers.cards[#G.jokers.cards]

				if right_most and right_most ~= card and right_most.config.center.blueprint_compat then
					right_most_e = SMODS.blueprint_effect(card, right_most, context)
				end
				break
			end
		end
		if context.after and not context.blueprint then
			if asa.timer > 1 then
				asa.timer = asa.timer - 1
			else
				SMODS.destroy_cards(card)
			end
		end
		if right_most_e then
			return right_most_e
		else
			return nil
		end
	end,
})
