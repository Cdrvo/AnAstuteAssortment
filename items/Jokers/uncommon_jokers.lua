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

SMODS.Joker {
    key = "indef_article",
    atlas = "asa_jokers",
    pos = {x = 1, y = 2},
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    config = {extra = {retriggers = 1, has_unscoring_ace = false}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.retriggers}}
    end,
    calculate = function(self, card, context)
        if context.before then
            for _, c in ipairs(context.full_hand) do
                if c:get_id() == 14 then
                    local in_scoring = false
                    for _, c2 in ipairs(context.scoring_hand) do
                        if c == c2 then
                            in_scoring = true
                            break
                        end
                    end
                    if not in_scoring then
                        card.ability.extra.has_unscoring_ace = true
                    end
                end
            end
        end
        if card.ability.extra.has_unscoring_ace and context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
        if context.after then
            card.ability.extra.has_unscoring_ace = false
        end
    end
}

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
	key = "ds_al_cola",
	cost = 7,
	rarity = 2,
	atlas = "asa_jokers",
	pos = { x = 5, y = 1 },
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.2,
		},
	},
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
		if context.before and not context.blueprint then
			if G.GAME.hands[context.scoring_name] and (to_big(G.GAME.hands[context.scoring_name].played_this_round) > to_big(1)) then
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
				asa.xmult = asa.xmult + asa.xmultg
			end
		end
		if context.joker_main then
			return {
				xmult = asa.xmult,
			}
		end

		if context.setting_blind and not context.blueprint and G.GAME.blind:get_type() == "Small" then
			asa.xmult = 1
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_reset") })
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

	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return {
				numerator = context.numerator - card.ability.extra.odd_remove
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		if #SMODS.find_card("j_oops") > 0 then
			return false
		end
		return true
	end,
})

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
		table.insert(info_queue, G.P_CENTERS.m_gold)
		table.insert(info_queue, G.P_CENTERS.m_steel)
		return {
			vars = {
				asa.retriggers,
			},
		}
	end,

	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.repetition then
			if context.cardarea == G.hand and next(SMODS.get_enhancements(context.other_card))
			and not SMODS.has_enhancement(context.other_card, "m_gold") and not SMODS.has_enhancement(context.other_card, "m_steel") then
				if context.other_card:get_id() == 6 then
					return {
						repetitions = asa.retriggers + 1
					}
				else
					return {
						repetitions = asa.retriggers
					}
				end
			elseif SMODS.has_enhancement(context.other_card, "m_gold") or SMODS.has_enhancement(context.other_card, "m_steel") then
				if context.other_card:get_id() == 6 then
					return {
						repetitions = asa.retriggers + 1
					}
				else
					return {
						repetitions = asa.retriggers
					}
				end
			end
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
			timer = 4,
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
				asa.timer = 4
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
			sevens = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = {
				asa.xmult,
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
