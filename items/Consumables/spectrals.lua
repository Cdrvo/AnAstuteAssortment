SMODS.Enhancement:take_ownership("m_glass", {
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "m_glass")
        return {vars = {card.ability.Xmult, num, denom}}
    end,
    config = {Xmult = 2, extra = {odds = 4}},
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and
            SMODS.pseudorandom_probability(card, 'm_glass', 1, card.ability.extra.odds) then
            card.glass_trigger = true
            local card_data = {
                edition = (card.edition and "e_" .. card.edition.type),
                seal = card:get_seal(true),
                rank = card.config.card.value,
                suit = card.config.card.suit
            }
            G.GAME.glass_broken[#G.GAME.glass_broken+1] = card_data
            return {remove = true}
        end
    end
}, true)
local start_run_hook = Game.start_run
Game.start_run = function(self, args)
    start_run_hook(self, args)
    G.GAME.glass_broken = G.GAME.glass_broken or {}
end


SMODS.Consumable {
    key = "crystals",
    atlas = "asa_spectrals",
    pos = {x = 0, y = 0},
    set = "Spectral",
    cost = 4,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_glass)
    end,
    in_pool = function(self, args)
        return next(G.GAME.glass_broken) ~= nil
    end,
    can_use = function(self, card)
        return next(G.GAME.glass_broken) ~= nil
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(#G.GAME.glass_broken)
        local all_restored = {}
        for i, glass in pairs(G.GAME.glass_broken) do
            -- G.playing_card = (G.playing_card and (G.playing_card + 1)) or 1
            -- local copy = copy_card(glass, nil, nil, G.playing_card)
            -- copy:add_to_deck()
            -- G.deck.config.card_limit = G.deck.config.card_limit + 1
            -- table.insert(G.playing_cards, copy)
            -- G.deck:emplace(copy)
            -- copy.states.visible = nil
            local restored = SMODS.add_card({
                set = "Base",
                area = G.deck,
                skip_materialize = true,
                key_append = "asa_crystals",
                edition = glass.edition,
                enhancement = "m_glass",
                seal = glass.seal,
                rank = glass.rank,
                suit = glass.suit
            })
            table.insert(all_restored, restored)
        end
        SMODS.calculate_context({playing_card_added = true, cards = all_restored})
        G.GAME.glass_broken = {}
    end
}