SMODS.Atlas({
    key = "grasslanderDecks",
    path = "decks.png",
    px = 71,
    py = 95
})

SMODS.Back {
    key = "organic",
    atlas = "grasslanderDecks",
    pos = { x = 0, y = 0 },
    unlocked = false,
    config = { vouchers = { 'v_magic_trick', 'v_illusion'} },
    locked_loc_vars = function(self, info_queue, card)
        return { vars = {80} }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 30, suit = 'Hearts' } }`
        if args.type == 'modify_deck' then
            return (#G.playing_cards or 0) >= 80
        end
        return false
    end
}

SMODS.Back {
    key = "fanciful",
    atlas = "grasslanderDecks",
    pos = { x = 1, y = 0 },
    unlocked = false,
    apply = function(self, back)
        G.GAME.modifiers.gl_legendary_shop = 0.01
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 30, suit = 'Hearts' } }`
        return args.type == 'spawn_legendary'
    end
}

--[[
SMODS.Rarity:take_ownership (
    "Legendary",    
    {
        weight = 1,
        get_weight = function(self, weight, object_type)
            if G.GAME.modifiers.gl_legendary_shop then
                return weight
            else
                return 0
            end
        end,
    },
    true
)]]

SMODS.Back {
    key = "gloom",
    atlas = "grasslanderDecks",
    pos = { x = 2, y = 0 },
    unlocked = false,
    config = { ante_scaling = 0.5 },
    apply = function(self, back)
        G.GAME.modifiers.gl_boss_rush = true
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'blind_discoveries' then
            local discovered_blinds = 0
            local threshold = 0
            for k, v in pairs(G.P_BLINDS) do
                threshold = threshold + 1
                if v.discovered then
                    discovered_blinds = discovered_blinds + 1
                end
            end
            return discovered_blinds >= threshold
        end
        return false
    end
}