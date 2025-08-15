SMODS.Joker({
	key = "scrambled_eggs",
	cost = 7,
	atlas = "asa_jokers",
	pos = { x = 0, y = 0 },
	rarity = 3,
	eternal_compat = false,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			for k, v in pairs(G.playing_cards) do
				local _suit, _rank =
					pseudorandom_element(SMODS.Suits, pseudoseed("asa_scrambled_eggs")).key,  --Get a random suit
					pseudorandom_element(SMODS.Ranks, pseudoseed("asa_scrambled_eggs")).card_key --Get a random rank
				v:juice_up()
				SMODS.change_base(v, _suit, _rank) --Change the card's rank and suit
			end
		end
	end,
})

SMODS.Joker({
	key = "bismuth",
	cost = 8,
	atlas = "asa_jokers",
	pos = { x = 6, y = 0 },
	rarity = 3,
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 1.4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		table.insert(info_queue, G.P_CENTERS.m_stone)
		return {
			vars = { asa.xmult },
		}
	end,
	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_stone") then
				return {
					xmult = asa.xmult,
				}
			end
		end
	end,
	in_pool = function(self,wawa,wawa2)
		if ASA.check_enhancement(G.playing_cards,"m_stone") > 0 then
			return true
		end
		return false
	end
})

SMODS.Joker({
	key = "check",
	cost = 9,
	atlas = "asa_jokers",
	pos = { x = 3, y = 3 },
	rarity = 3,
	eternal_compat = true,
	blueprint_compat = true,
    config = {
        extra = {
            xmult = 2
        }
    },
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		return {
			vars = { asa.xmult },
		}
	end,
	calculate = function(self, card, context)
        local asa = card.ability.extra
		if context.before then
            card.asa_trigger = nil

            local play_cards = {}
            local card_count = 0

            for k, v in pairs(G.play.cards) do
                if v:get_id() == 13 then
                    play_cards[#play_cards+1] = v
                    card_count = card_count + 1
                    -- print(#play_cards)
                end
            end

            for k, v in pairs(context.scoring_hand) do
                for l, m in pairs(play_cards) do
                    if v == m then
                        card_count = card_count - 1
                        -- print(card_count)
                    end
                end
            end

            if card_count > 0 then
                card.asa_trigger = true
                -- print(card.asa_trigger)
            end
        end
        if context.individual and context.cardarea == G.play and card.asa_trigger then
            if context.other_card:get_id() == 12 then
                return{
                    xmult = asa.xmult
                }
            end
        end
        if context.final_scoring_step then
            card.asa_trigger = nil
        end
	end,
})

SMODS.Joker({
	key = "wild_rose",
	cost = 7,
	atlas = "asa_jokers",
	pos = { x = 4, y = 3 },
	rarity = 3,
	eternal_compat = true,
	blueprint_compat = true,
	config = {
		extra = {
			xmult = 1.4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local asa = card.ability.extra
		table.insert(info_queue, G.P_CENTERS.m_wild)
		return {
			vars = { asa.xmult },
		}
	end,
	calculate = function(self, card, context)
		local asa = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_wild") then
				return {
					xmult = asa.xmult,
				}
			end
		end
	end,
    update = function(self, card, context)
    if G and G.playing_cards then
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_wild") and v.debuff then
                v:set_debuff(false)
            end
        end
    end
end,
	in_pool = function(self,wawa,wawa2)
		if ASA.check_enhancement(G.playing_cards,"m_wild") > 0 then
			return true
		end
		return false
	end
})
