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
    unlocked = true,
    config = { vouchers = { 'v_magic_trick', 'v_illusion'} },
}

SMODS.Back {
    key = "fanciful",
    atlas = "grasslanderDecks",
    pos = { x = 1, y = 0 },
    unlocked = true,
    apply = function(self, back)
        G.GAME.modifiers.gl_legendary_shop = 0.01
    end,
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
    unlocked = true,
    config = { ante_scaling = 0.5 },
    apply = function(self, back)
        G.GAME.modifiers.gl_boss_rush = true
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end,
}