local remove_hook = Card.remove
Card.remove = function(self)
    if SMODS.has_enhancement(self, "m_glass") then
        G.GAME.glass_broken[#G.GAME.glass_broken+1] = self
        print(#G.GAME.glass_broken)
    end
    remove_hook(self)
end
local start_run_hook = G.start_run
G.start_run = function(self, args)
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
        for i, glass in pairs(G.GAME.glass_broken) do
            G.playing_card = (G.playing_card and (G.playing_card + 1)) or 1
            local copy = copy_card(glass, nil, nil, G.playing_card)
            copy:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy)
            G.deck:emplace(copy)
            copy.states.visible = nil
        end
    end
}