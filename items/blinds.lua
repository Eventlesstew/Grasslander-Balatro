SMODS.Atlas({
    key = "gloom",
    path = "gloom.png",
    px = 71,
    py = 95
})

SMODS.Enhancement {
    key = 'gloom',
    atlas = 'gloom',
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
}

SMODS.Atlas({
    key = "gloom_deck",
    path = "gloom.png",
    px = 71,
    py = 95
})

SMODS.Back {
    key = "gloom_deck",
    atlas = "gloom_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = {extra = {ability = 'm_grasslanders_gloom'}},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _,v in pairs(G.playing_cards) do
                    v:set_ability(self.config.extra.ability, nil, true)
                end
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = {self.config.extra.ability} }
    end,
}

SMODS.Atlas({
    key = "bl_small",
    raw_key = true,
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Atlas({
    key = "bl_big",
    raw_key = true,
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

--[[
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
    dollars = 3,
    mult = 1,
    boss = {min=1, max=1},
    boss_colour = HEX("39405b"),
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
    dollars = 4,
    mult = 1.5,
    boss = {min=1, max=1},
    boss_colour = HEX("44395b"),
}
]]

SMODS.Atlas({
    key = "clackerblind",
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Atlas({
    key = "clackerblindplaceholder",
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 1,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = 'spiker',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 2},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    effect = {suit = "Spades"},
    boss_colour = HEX("47395b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(self.effect.suit) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
    loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
}

SMODS.Blind {
    key = 'clacklume',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 3},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    effect = {suit = "Hearts"},
    boss_colour = HEX("827144"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(self.effect.suit) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
    loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
}

SMODS.Blind {
    key = 'wondertraps',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 4},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    effect = {suit = "Clubs"},
    boss_colour = HEX("395651"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(self.effect.suit) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
    loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
}

SMODS.Blind {
    key = 'cruncher',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 5},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    effect = {suit = "Diamonds"},
    boss_colour = HEX("714482"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(self.effect.suit) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
    loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize(self.effect.suit, 'suits_singular')} }
    end,
}

SMODS.Blind {
    key = 'observer',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 6},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("448269"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card.ability.played_this_ante then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
    loc_vars = function(self, info_queue, blind)
        return { vars = {} }
    end,
    collection_loc_vars = function(self)
        return { vars = {} }
    end,
}

SMODS.Blind {
    key = 'tesloid',
    atlas = 'clackerblind',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 7},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                mult = 1
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end,
}

SMODS.Blind {
    key = 'fangatusk',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 8},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                blind.triggered = true
                hand_chips = 0
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end,
}

SMODS.Blind {
    key = 'crawler',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 9},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.var_penalty = 0
            end
            if context.before and #context.scoring_hand >= 5 then
                blind.triggered = true
                blind.var_penalty = blind.var_penalty + 1
                G.hand:change_size(-1)
            end
        end
    end,

    disable = function(self)
        if blind.var_penalty then
            G.hand:change_size(blind.var_penalty)
        end
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            if blind.var_penalty then
                G.hand:change_size(blind.var_penalty)
            end
        end
    end
}

SMODS.Blind {
    key = 'woeslop',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 10},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'veguar',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 11},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'crusher',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 12},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'ripted',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 13},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'shifter',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 14},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'strider',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 15},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'deepwalker',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 16},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'stigz',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 17},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'kyner',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 18},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'rockagnaw',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 19},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'wallkerip',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 20},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'clacteriophage',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 21},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'screecher',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 22},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'leaper',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 23},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'glumplesk',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 24},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'chomper',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 25},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'jawtrap',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 26},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'silentflash',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 27},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'snaggler',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 28},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'bumpohorn',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 29},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'wartumorr',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 30},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'twinckler',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 31},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'maw',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 32},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'persecutor',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 33},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'radiochomper',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 34},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

SMODS.Blind {
    key = 'matriarch',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 35},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("615852"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}