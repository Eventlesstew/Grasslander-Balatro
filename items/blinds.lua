SMODS.Atlas({
    key = "gloom",
    path = "gloom.png",
    px = 71,
    py = 95
})

SMODS.Enhancement {
    key = 'gloom',
    atlas = 'gloom',
    --replace_base_card = true,
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
    key = "spiker",
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = 'spiker',
    atlas = 'spiker',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 2},
    vars = {suit = 'Spades'},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("47395b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(blind.effect.suit) then
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
    end
}

SMODS.Atlas({
    key = 'clacklume',
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = 'clacklume',
    atlas = 'clacklume',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 3},
    vars = {suit = 'Hearts'},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("827144"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(blind.effect.suit) then
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
    end
}

SMODS.Atlas({
    key = 'wondertraps',
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = 'wondertraps',
    atlas = 'wondertraps',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 4},
    vars = {suit = 'Clubs'},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("395b51"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(blind.effect.suit) then
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
    end
}

SMODS.Atlas({
    key = 'cruncher',
    path = "clackerblinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = 'cruncher',
    atlas = 'cruncher',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 4},
    vars = {suit = 'Diamonds'},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("714482"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_suit(blind.effect.suit) then
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
    end
}