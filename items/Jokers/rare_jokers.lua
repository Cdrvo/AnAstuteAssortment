SMODS.Joker{
    key = "scrambled_eggs",
    cost = 7,
    atlas  = "asa_jokers",
    pos = {x=0,y=0},
    eternal_compat = false,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.selling_self and not context.blueprint then
            for k, v in pairs(G.playing_cards) do
			local _suit, _rank =
				pseudorandom_element(SMODS.Suits, pseudoseed("asa_scrambled_eggs")).key,
				pseudorandom_element(SMODS.Ranks, pseudoseed("asa_scrambled_eggs")).card_key
                SMODS.change_base(v,_suit, _rank)
            end
        end
    end
}