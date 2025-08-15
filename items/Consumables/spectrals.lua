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
            G.GAME.asa_glass_broken = G.GAME.asa_glass_broken + 1
            return {remove = true}
        end
    end
}, true)
local start_run_hook = Game.start_run
function Game:start_run(args)
    start_run_hook(self, args)
    G.GAME.asa_glass_broken = G.GAME.asa_glass_broken or 0
end


SMODS.Consumable {
    key = "crystals",
    atlas = "asa_spectrals",
    pos = {x = 0, y = 0},
    set = "Spectral",
    cost = 4,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_glass)
        return {vars = {(G.GAME and G.GAME.asa_glass_broken) or 0}}
    end,
    in_pool = function(self, args)
        return G.GAME.asa_glass_broken > 0
    end,
    can_use = function(self, card)
        return G.GAME.asa_glass_broken > 0
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(G.GAME.asa_glass_broken)
        local all_restored = {}
        for i = 1, G.GAME.asa_glass_broken do
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
                enhancement = "m_glass",
                edition = poll_edition("asa_crystals", nil, true, false, {"e_foil", "e_holo", "e_polychrome"}),
                seal = SMODS.poll_seal({type_key = "asa_crystals"})
            })
            table.insert(all_restored, restored)
        end
        SMODS.calculate_context({playing_card_added = true, cards = all_restored})
        G.GAME.asa_glass_broken = 0
    end
}
SMODS.Consumable {
    key = "altar",
    atlas = "asa_spectrals",
    pos = {x = 1, y = 0},
    set = "Spectral",
    cost = 4,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_stone)
        local n = 0
        if G.GAME and G.GAME.starting_deck_size and G.playing_cards then
            n = G.GAME.starting_deck_size - #G.playing_cards
        end
        return {vars = {G.GAME.starting_deck_size, math.max(0, n)}}
    end,
    can_use = function(self, card)
        return #G.playing_cards < G.GAME.starting_deck_size
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(G.GAME.starting_deck_size - #G.playing_cards)
        local added = {}
        for i = 1, G.GAME.starting_deck_size - #G.playing_cards do
            local created = SMODS.add_card({
                set = "Base",
                area = G.deck,
                skip_materialize = true,
                seal = SMODS.poll_seal({guaranteed = true, type_key = "asa_altar"}),
                enhancement = "m_stone"
            })
            table.insert(added, created)
        end
        SMODS.calculate_context({playing_card_added = true, cards = added})
    end
}
SMODS.Consumable {
    key = "sage",
    atlas = "asa_spectrals",
    pos = {x = 2, y = 0},
    set = "Spectral",
    cost = 4,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.e_foil)
        table.insert(info_queue, G.P_CENTERS.e_holo)
        table.insert(info_queue, G.P_CENTERS.e_polychrome)
        local n = 0
        if G.GAME and G.GAME.starting_deck_size and G.playing_cards then
            n = G.GAME.starting_deck_size - #G.playing_cards
        end
        return {vars = {G.GAME.starting_deck_size, math.max(0, n)}}
    end,
    can_use = function(self, card)
        return #G.playing_cards < G.GAME.starting_deck_size
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(G.GAME.starting_deck_size - #G.playing_cards)
        local added = {}
        for i = 1, G.GAME.starting_deck_size - #G.playing_cards do
            local created = SMODS.add_card({
                set = "Base",
                area = G.deck,
                skip_materialize = true,
                edition = poll_edition("asa_sage", nil, true, true, {
                    "e_foil",
                    "e_holo",
                    "e_polychrome"
                })
            })
            table.insert(added, created)
        end
        SMODS.calculate_context({playing_card_added = true, cards = added})
    end
}
SMODS.Consumable {
    key = "pentagram",
    atlas = "asa_spectrals",
    pos = {x = 3, y = 0},
    set = "Spectral",
    cost = 4,
    config = {extra = {destroy = 1, cards = 3}},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_gold)
        return {vars = {card.ability.extra.destroy, card.ability.extra.cards}}
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards >= 1
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(card.ability.extra.cards - card.ability.extra.destroy)
        local card_to_destroy = pseudorandom_element(G.hand.cards, "asa_pentagram_destroy")
        SMODS.destroy_cards(card_to_destroy)
        local added = {}
        for i = 1, card.ability.extra.cards do
            local created = SMODS.add_card({
                set = "Base",
                area = G.hand,
                skip_materialize = true,
                rank = "6",
                enhancement = "m_gold"
            })
            table.insert(added, created)
        end
        SMODS.calculate_context({playing_card_added = true, cards = added})
    end
}
SMODS.Consumable {
    key = "charm",
    atlas = "asa_spectrals",
    pos = {x = 4, y = 0},
    set = "Spectral",
    cost = 4,
    config = {extra = {destroy = 1, cards = 3}},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_lucky)
        return {vars = {card.ability.extra.destroy, card.ability.extra.cards}}
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards >= 1
    end,
    use = function(self, card, area, copier)
        G.deck:change_size(card.ability.extra.cards - card.ability.extra.destroy)
        local card_to_destroy = pseudorandom_element(G.hand.cards, "asa_pentagram_destroy")
        SMODS.destroy_cards(card_to_destroy)
        local added = {}
        for i = 1, card.ability.extra.cards do
            local created = SMODS.add_card({
                set = "Base",
                area = G.hand,
                skip_materialize = true,
                rank = "7",
                enhancement = "m_lucky"
            })
            table.insert(added, created)
        end
        SMODS.calculate_context({playing_card_added = true, cards = added})
    end
}
SMODS.Consumable {
    key = "music",
    atlas = "asa_spectrals",
    pos = {x = 5, y = 0},
    set = "Spectral",
    cost = 4,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.e_foil)
        table.insert(info_queue, G.P_CENTERS.e_holo)
    end,
    can_use = function(self, card)
        local jokers_available = false
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if not j.edition then
                    jokers_available = true
                end
            end
        end
        return G.hand and #G.hand.cards >= 1 and jokers_available
    end,
    use = function (self, card, area, copier)
        SMODS.destroy_cards(G.hand.cards)
        for _, j in ipairs(G.jokers.cards) do
            if not j.edition then
                j:set_edition(poll_edition("asa_music", nil, true, true, {"e_foil", "e_holo"}), true)
            end
        end
    end
}
SMODS.Booster:take_ownership_by_kind("Standard", {
    create_card = function(self, card, i)
        if pseudorandom("asa_voodoo_spawn", 0, 999) < 3 then
            local h = false
            if G.pack_cards then
                for index, value in ipairs(G.pack_cards.cards) do
                    if value.config.center.key == "c_asa_voodoo_doll" then
                        h = true
                    end
                end
            end
            print(h)
            return {
                set = "Spectral",
                area = G.pack_cards,
                skip_materialize = true,
                key_append = "Standard",
                key = "c_asa_voodoo_doll"
            }
        else
            local _edition = poll_edition("Standard" .. G.GAME.round_resets.ante, 2, true)
            local _seal = SMODS.poll_seal({mod = 10})
            return {
                set = "Playing Card",
                edition = _edition,
                seal = _seal,
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "Standard"
            }
        end
    end
}, true)
SMODS.Consumable {
    key = "voodoo_doll",
    atlas = "asa_spectrals",
    pos = {x = 6, y = 0},
    set = "Spectral",
    cost = 4,
    can_use = function(self, card)
        return true
    end,
    hidden = true,
    soul_set = "Playing Card",
    soul_rate = 0.003,
    use = function(self, card, area, copier)
        G.deck:change_size(1)
        local ranks = {"K","Q","J"}
        local c = SMODS.add_card({
            set = "Base",
            key_append = "asa_voodoo_doll",
            area = G.deck,
            rank = pseudorandom_element(ranks, "asa_voodoo_doll"),
            skip_materialize = true,
            edition = poll_edition("asa_voodoo_doll", nil, true, true, {"e_foil","e_holo","e_polychrome"}),
            seal = SMODS.poll_seal({guaranteed = true, type_key = "asa_altar"}),
            enhancement = SMODS.poll_enhancement({guaranteed = true, type_key = "asa_altar"})
        })
        SMODS.calculate_context({playing_card_added = true, cards = {c}})
    end
}
