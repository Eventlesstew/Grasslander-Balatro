function shakeBlind(self)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            SMODS.juice_up_blind()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = false,
                func = function()
                    play_sound('tarot2', 0.76, 0.4)
                    return true
                end
            }))
            play_sound('tarot2', 1, 0.4)
            return true
        end)
    }))
end

SMODS.Atlas({
    key = "gloom",
    path = "gloomOld.png",
    px = 71,
    py = 95
})

SMODS.Enhancement {
    key = 'gloom',
    atlas = 'gloom',
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    --display_size = {w = 71, h = 102},
    --pixel_size = {w = 71, h = 102},
    in_pool = function(self, args)
        return false
    end,
}

--[[SMODS.Atlas({
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
}]]

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
    key = 'clacker',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 0},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("39405b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                local _card = SMODS.create_card {set = "Base", enhancement = "m_grasslanders_gloom", area = G.discard}
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.hand:sort()
                        SMODS.juice_up_blind()
                        return true
                    end
                }))
            end
        end
    end,
}

SMODS.Blind {
    key = 'biter',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 1},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("82444b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.prepped = nil
            end

            -- Ensures the Blind will debuff cards next hand
            if context.after then
                blind.prepped = true
            end

            if context.hand_drawn and blind.prepped then
                -- Debuffs cards
                for i = 1, 2 do
                    local valid_cards = {}
                    for _, v in ipairs(G.hand.cards) do
                        if not v.gl_biter_debuff then
                            valid_cards[#valid_cards + 1] = v
                        end
                    end
                    local target_card = pseudorandom_element(valid_cards, 'gl_biter')
                    target_card:juice_up()
                    target_card.gl_biter_debuff = true
                    SMODS.recalc_debuff(target_card)
                end
                blind.prepped = nil
                shakeBlind()
                delay(0.4)
            end

            if context.debuff_card and context.debuff_card.gl_biter_debuff then
                return {
                    debuff = true
                }
            end
        end
    end,
}

SMODS.Blind {
    key = 'spiker',
    atlas = 'clackerblindplaceholder',
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
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 4},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    effect = {suit = "Clubs"},
    boss_colour = HEX("395b51"),
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
    atlas = 'clackerblindplaceholder',
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
    boss_colour = HEX("486d5e"),
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
    boss = {min = 1},
    boss_colour = HEX("825444"),
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
    boss = {min = 1},
    boss_colour = HEX("3d354c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.var_penalty = 0
            end
            if context.before and #context.full_hand >= 5 then
                blind.triggered = true
                blind.var_penalty = blind.var_penalty + 1
                G.hand:change_size(-1)
                shakeBlind()
                delay(0.4)
            end
        end
    end,

    disable = function(self)
        if G.GAME.blind.var_penalty then
            G.hand:change_size(G.GAME.blind.var_penalty)
        end
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            if G.GAME.blind.var_penalty then
                G.hand:change_size(G.GAME.blind.var_penalty)
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
    boss = {min = 1},
    boss_colour = HEX("333545"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.end_of_round and context.game_over == false and context.main_eval then
                local cards = 0
                for _, v in ipairs(G.hand.cards) do
                    cards = cards + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:set_ability('m_grasslanders_gloom', nil, false)
                            v:juice_up()
                            return true
                        end
                    }))
                end
                if cards > 0 then
                    shakeBlind()
                    delay(0.8)
                end
            end
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
    boss_colour = HEX("73596d"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.to_area == G.hand and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
                context.other_card.ability.gl_crusher_debuff = true
                context.other_card.debuff = true
            end
            if context.debuff_card and context.debuff_card.ability.gl_crusher_debuff then
                return {
                    debuff = true
                }
            end
        end
    end,
    disable = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_crusher_debuff = nil
        end
    end,
    defeat = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_crusher_debuff = nil
        end
    end
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
    boss_colour = HEX("a05c68"),
    calculate = function(self, blind, context)
        if context.setting_blind or context.hand_drawn then
            blind.prepped = nil
        end
        if not blind.disabled then
            if context.press_play then
                blind.prepped = true
            end
            if context.to_area == G.hand and blind.prepped then
                context.other_card.ability.gl_ripted_debuff = true
                context.other_card.debuff = true
            end
            if context.debuff_card and context.debuff_card.ability.gl_ripted_debuff then
                return {
                    debuff = true
                }
            end
        end
    end,
    disable = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_ripted_debuff = nil
        end
    end,
    defeat = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_ripted_debuff = nil
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
    boss_colour = HEX("667359"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        for _,v in ipairs(G.hand.cards) do
                            if v.facing ~= 'back' then
                                v:flip()
                            end
                        end
                        return true
                    end,
                }))
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

SMODS.Blind {
    key = 'strider',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 15},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("597371"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.hands_sub = math.max(math.floor(G.GAME.round_resets.hands * 0.5), 1)
                ease_hands_played(-blind.hands_sub)

                blind.discards_sub = math.max(math.floor(G.GAME.current_round.discards_left * 0.5), 0)
                ease_discard(-blind.discards_sub)
            end
        end
    end,
    disable = function(self)
        ease_hands_played(G.GAME.blind.hands_sub)
        ease_discard(G.GAME.blind.discards_sub)
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
    boss_colour = HEX("39545b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                blind.prepped = true
            end
            if blind.prepped and context.hand_drawn and not context.first_hand_drawn then
                shakeBlind()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips + get_blind_amount(G.GAME.round_resets.ante)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        return true
                    end
                }))
                blind.prepped = nil
            end
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.blind.mult
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        blind.prepped = nil
    end,

    loc_vars = function(self)
        return { vars = {get_blind_amount(G.GAME.round_resets.ante)} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize('gl_deepwalker_x1')} }
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
        local valid = false
        if (G.GAME.round_resets.ante >= 3) then
            local count = 0
            for _,v in ipairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(v)) then
                    count = count + 1
                end
            end

            valid = (count >= 3)
        end
        return valid
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                next(SMODS.get_enhancements(context.other_card)) then
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
}

SMODS.Blind {
    key = 'wallkerip',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 20},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("543770"),
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                local valid_suits = {}
                for k, scored_card in pairs(context.full_hand) do

                    -- WHY DOES THIS NOT WORK?!
                    for _, scored_suit in ipairs(SMODS.Suits) do
                        print(scored_suit)
                        if scored_card:is_suit(scored_suit) then
                            valid_suits[scored_suit] = true
                        end
                    end
                end
                
                local suit_count = 0
                for _, v in pairs(valid_suits) do
                    suit_count = suit_count + 1
                end
                return {debuff = (suit_count >= 3)}
            end
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
    boss = {min = 5},
    boss_colour = HEX("70673d"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) and (context.amount >= 4) then
                return {
                    cards_to_draw = 4
                }
            end
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
    boss_colour = HEX("7c2d35"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.hands = {}
                for _, poker_hand in ipairs(G.handlist) do
                    blind.hands[poker_hand] = false
                end
            end
            if context.debuff_hand then
                if not context.check then
                    if blind.hands[context.scoring_name] then
                        blind.triggered = true
                        ease_dollars(-G.GAME.dollars, true)
                    end

                    blind.hands[context.scoring_name] = true
                end
            end
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
            if context.after then
                
            end
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
    boss = {showdown = true},
    boss_colour = HEX("615852"),
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
    boss = {min = 1, max = 4},
    boss_colour = HEX("607f5c"),
    in_pool = function()
        local result = (1 <= G.GAME.round_resets.ante) and (G.GAME.round_resets.ante <= 4)
        return result
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before and not context.blueprint then
                local faces = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card:is_face() then
                        faces = faces + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:set_ability('m_grasslanders_gloom', nil, false)
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if faces > 0 then
                    shakeBlind()
                    delay(0.4)
                end
            end
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
    key = 'chomper',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 25},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("a3444c"),
    in_pool = function()
        return false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
        end
    end,
}

if grasslanders.config.post_trigger then
    -- Rockagnaw requires this setting to function
    SMODS.current_mod.optional_features = function()
        return {
            post_trigger = true,
        }
    end

    SMODS.Blind {  
        key = 'rockagnaw',
        atlas = 'clackerblindplaceholder',
        unlocked = true,
        discovered = true,     
        pos = {x = 0, y = 19},
        dollars = 5,
        mult = 2,
        boss = {min = 3},
        boss_colour = HEX("916d53"),
        calculate = function(self, blind, context)
            if not blind.disabled then
                -- Resets all Jokers on play or discard
                if context.press_play or context.pre_discard then
                    for _,v in ipairs(G.jokers.cards) do
                        if v.gl_rockagnaw_trigger then
                            v.gl_rockagnaw_trigger = nil
                        end
                    end
                end

                -- Adds triggered Jokers
                if context.post_trigger then
                    context.other_card.gl_rockagnaw_trigger = true
                end

                -- Blind effect
                if context.after or (context.discard and context.other_card == context.full_hand[#context.full_hand]) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            for _,v in ipairs(G.jokers.cards) do
                                if v.gl_rockagnaw_trigger then
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            v:juice_up()
                                            v.gl_rockagnaw_trigger = nil
                                            return true
                                        end,
                                    }))
                                end
                                ease_dollars(-1)
                                delay(0.23)
                            end
                            return true
                        end
                    }))
                    blind.triggered = true
                    shakeBlind()
                    delay(0.4)
                end
            end
        end,

        -- Resets all Jokers when disabled
        disable = function(self)
            for _,v in ipairs(G.jokers.cards) do
                if v.gl_rockagnaw_trigger then
                    v.gl_rockagnaw_trigger = nil
                end
            end
        end,

        -- Resets all Jokers when defeated
        defeat = function(self)
            for _,v in ipairs(G.jokers.cards) do
                if v.gl_rockagnaw_trigger then
                    v.gl_rockagnaw_trigger = nil
                end
            end
        end
    }
else
    -- If Post Trigger is disabled, 
    SMODS.Blind {
        key = 'altrockagnaw',
        atlas = 'clackerblindplaceholder',
        unlocked = true,
        discovered = true,     
        pos = {x = 0, y = 19},
        dollars = 5,
        mult = 2,
        boss = {min = 3},
        boss_colour = HEX("916d53"),
        calculate = function(self, blind, context)
            if not blind.disabled then
                if context.press_play then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            for _,v in ipairs(G.jokers.cards) do
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        return true
                                    end,
                                }))
                                ease_dollars(-1)
                                delay(0.23)
                            end
                            return true
                        end
                    }))
                    blind.triggered = true
                    shakeBlind()
                    delay(0.4)
                end
            end
        end,
    }
end

SMODS.Blind {
    key = 'screecher',
    atlas = 'clackerblindplaceholder',
    unlocked = true,
    discovered = true,     
    pos = {x = 0, y = 22},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("35414c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if #G.GAME.hands[context.scoring_name].level > 1 and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    if not context.check then
                        local penalty = 3

                        if G.GAME.hands[context.scoring_name].level < 3 then
                            penalty = #G.GAME.hands[context.scoring_name].level
                        end

                        return {
                            level_up = -penalty
                        }
                    end
                end
            end
        end
    end,
}