SMODS.Joker {
    key = "mobius_strip",
    atlas = "asa_jokers",
    pos = {x = 1, y = 0},
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
}
local get_straight_hook = get_straight
function get_straight(hand)
    local has_ff = (next(SMODS.find_card("j_four_fingers")) and 4) or 5
    local has_sc = next(SMODS.find_card("j_shortcut")) ~= nil
    local has_ms = next(SMODS.find_card("j_asa_mobius_strip")) ~= nil
    return get_straight_hook(hand, has_ff, has_sc, has_ms)
end
SMODS.Joker {
    key = "celestial_sheet_music",
    atlas = "asa_jokers",
    pos = {x = 1, y = 1},
    rarity = 1,
    cost = 4,
    config = {extra = {planets_used = {}}},
    loc_vars = function(self, info_queue, card)
        return {vars = {7, #card.ability.extra.planets_used}}
    end,
    blueprint_compat = false,
    eternal_compat = false,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Planet" then
            card.ability.extra.planets_used[#card.ability.extra.planets_used+1] = context.consumeable.config.center.key
            if #card.ability.extra.planets_used >= 7 then
                if card.ability.extra.planets_used[1] == "c_mars"
                and card.ability.extra.planets_used[2] == "c_venus"
                and card.ability.extra.planets_used[3] == "c_mercury"
                and card.ability.extra.planets_used[4] == "c_jupiter"
                and card.ability.extra.planets_used[5] == "c_saturn"
                and card.ability.extra.planets_used[6] == "c_uranus"
                and card.ability.extra.planets_used[7] == "c_neptune" then
                    ease_dollars(7)
                end
                local most_played = 0
                local most_played_hand = "High Card"
                for handname, values in pairs(G.GAME.hands) do
                    if values.played > most_played and SMODS.is_poker_hand_visible(handname) then
                        most_played = values.played
                        most_played_hand = handname
                    end
                end
                ASA.level_up_hand(most_played_hand, 2)
                SMODS.destroy_cards(card)
            end
        end
    end
}
SMODS.Joker {
    key = "tuplets",
    atlas = "tuplets_new",
    pos = {x = 0, y = 0},
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    config = {extra = {chips = 16, mult = 4, money = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3
            or context.other_card:get_id() == 5
            or context.other_card:get_id() == 6
            or context.other_card:get_id() == 7
            or context.other_card:get_id() == 9
            or context.other_card:get_id() == 10 then
                local choice = pseudorandom("asa_tuplets", 1, 3)
                if choice == 1 then
                    return {chips = card.ability.extra.chips}
                elseif choice == 2 then
                    return {mult = card.ability.extra.mult}
                else
                    return {dollars = card.ability.extra.money}
                end
            end
        end
    end
}
SMODS.Joker {
    key = "time_sig",
    atlas = "asa_jokers",
    pos = {x = 3, y = 1},
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    config = {extra = {num_odds = 4, denom_odds = 7}},
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, card.ability.extra.num_odds, card.ability.extra.denom_odds, "asa_time_sig")
        return {vars = {n, d}}
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 4 or context.other_card:get_id() == 7)
        and SMODS.pseudorandom_probability(card, "time_sig", card.ability.extra.num_odds, card.ability.extra.denom_odds, "asa_time_sig") then
            return {
                repetitions = 1
            }
        end
    end
}
SMODS.Joker {
    key = "measure",
    atlas = "asa_jokers",
    pos = {x = 4, y = 1},
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    config = {extra = {chips = 77}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_hand[#context.scoring_hand] == context.full_hand[#context.full_hand]
            and context.scoring_hand[#context.scoring_hand]:get_id() == 7 then
                return {chips = card.ability.extra.chips}
            end
        end
    end
}
SMODS.Joker {
    key = "first_dollar",
    atlas = "asa_jokers",
    pos = {x = 0, y = 2},
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    config = {extra = {money = 1}},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_lucky)
        return {vars = {card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.before then
            if #context.full_hand == 1 and context.full_hand[1]:get_id() == 14 then
                context.full_hand[1]:set_ability("m_lucky")
                return {
                    dollars = card.ability.extra.money
                }
            end
        end
    end
}

SMODS.Joker {
    key = "tenner",
    atlas = "asa_jokers",
    pos = {x = 0, y = 3},
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    config = {extra = {money_odds = 7, lucky_odds = 10, dollars = 10}},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_lucky)
        local n1, d1 = SMODS.get_probability_vars(card, 1, card.ability.extra.money_odds, "tenner_money")
        local n2, d2 = SMODS.get_probability_vars(card, 1, card.ability.extra.lucky_odds, "tenner_lucky")
        return {vars = {n1, d1, card.ability.extra.dollars, n2, d2}}
    end,
    calculate = function(self, card, context)
        if context.before then
            for _, c in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(card, "asa_tenner", 1, card.ability.extra.lucky_odds, "tenner_lucky") and c:get_id() == 10 then
                    c:set_ability("m_lucky")
                end
            end
        end
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "asa_tenner", 1, card.ability.extra.money_odds, "tenner_lucky") and context.other_card:get_id() == 10 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}
SMODS.Joker {
    key = "stick_shift",
    atlas = "asa_jokers",
    pos = {x = 6, y = 3},
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    config = {extra = {subtract = 1, add = 2, used_hands = {}}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.add, card.ability.extra.subtract}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.used_hands = {}
        end
        if context.before then
            if not card.ability.extra.used_hands[context.scoring_name] then
                return {
                    dollars = card.ability.extra.add
                }
            else
                return {
                    dollars = -card.ability.extra.subtract
                }
            end
        end
        if context.after then
            card.ability.extra.used_hands[context.scoring_name] = true
        end
    end
}
SMODS.Joker({
	key = "rising_sun_casino",
	cost = 4,
	rarity = 1,
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
		if context.evaluate_poker_hand and next(context.poker_hands["Two Pair"]) and not context.blueprint then
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
			if card.asa_trigger then
				return {
					replace_scoring_name = "Full House",
					replace_display_name = "Full House",
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "attorney",
	cost = 5,
	rarity = 1,
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

local suitsold = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if #SMODS.find_card("j_asa_of_all_trades") >= 1 and self:get_id() == 11 then
		return true
	end
	return suitsold(self, suit, bypass_debuff, flush_calc)
end
SMODS.Joker({
	key = "of_all_trades",
	cost = 4,
	rarity = 1,
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