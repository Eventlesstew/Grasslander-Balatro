SMODS.Atlas({
    key = "clacker",
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = "clacker",
    atlas = 'clacker',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 0},
    vars = {active=true},
    dollars = 3,
    mult = 1,
    boss = {min = 1},
    boss_colour = HEX("39405b"),
    get_loc_debuff_text = function(self)
        return G.GAME.blind.loc_debuff_text ..
            (G.GAME.blind.only_hand and ' [' .. localize(G.GAME.blind.only_hand, 'poker_hands') .. ']' or '')
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then

        end
    end
}

SMODS.Atlas({
    key = "biter",
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = "biter",
    atlas = 'biter',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 1},
    vars = {active=true},
    dollars = 4,
    mult = 1.5,
    boss = {min = 1},
    boss_colour = HEX("44395b"),
    get_loc_debuff_text = function(self)
        return G.GAME.blind.loc_debuff_text ..
            (G.GAME.blind.only_hand and ' [' .. localize(G.GAME.blind.only_hand, 'poker_hands') .. ']' or '')
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then

        end
    end
}