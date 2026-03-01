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
    path = "gloom.png",
    px = 71,
    py = 95,
    --py = 115,
})

SMODS.Enhancement {
    key = 'gloom',
    atlas = 'gloom',
    replace_base_card = true,
    overrides_base_rank = true,
    no_rank = true,
    no_suit = true,
    --display_size = {w = 71, h = 115},
    in_pool = function(self, args)
        return false
    end,
}

--[[
SMODS.DrawStep {
    key = 'gloom_card',
    order = 1,
    func = function(card, layer)
        if SMODS.has_enhancement(card, 'm_grasslanders_gloom') then
            local scale_mod = 1
            card.children.center:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}]]

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
    key = 'biter',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 1},
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX("82444b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.gl_biter_debuff then
                return {
                    debuff = true
                }
            end

            if context.debuff_hand and not context.check then
                -- Debuffs cards
                local count = 0
                for i = 1, 2 do
                    local valid_cards = {}
                    for _, v in ipairs(G.hand.cards) do
                        if not v.gl_biter_debuff then
                            valid_cards[#valid_cards + 1] = v
                        end
                    end
                    local target_card = pseudorandom_element(valid_cards, 'gl_biter')
                    if target_card then
                        count = count + 1
                        target_card.gl_biter_debuff = true
                        SMODS.recalc_debuff(target_card)
                        target_card:juice_up()
                    end
                end

                if count > 0 then
                    blind.prepped = nil
                    shakeBlind()
                    delay(0.4)
                end
            end
        end
    end,
    disable = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_biter_debuff = nil
        end
    end,
    defeat = function(self)
        for _, card in ipairs(G.playing_cards) do
            card.ability.gl_biter_debuff = nil
        end
    end
}

SMODS.Blind {
    key = 'spiker',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'crawler',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'fangatusk',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'tesloid',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'crusher',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    atlas = 'clackerblind',
    unlocked = true,
          
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
    atlas = 'clackerblind',
    unlocked = true,
          
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
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 15},
    dollars = 5,
    mult = 2,
    boss = {min = 2},
    boss_colour = HEX("597371"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                ease_hands_played(-1)
                ease_discard(-1)
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
    atlas = 'clackerblind',
    unlocked = true,
          
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
        return { vars = {localize('gl_deepwalker_collection')} }
    end,
}

SMODS.Blind {
    key = 'kyner',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 18},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("433e57"),
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
    key = 'rockagnaw',
    atlas = 'clackerblind',
    unlocked = true,
          
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
                        for i = 1, #G.hand.cards do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.hand.cards[i]:juice_up()
                                    return true
                                end,
                            }))
                            ease_dollars(-1)
                            delay(0.23)
                        end
                        return true
                    end
                }))
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
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
                delay(0.4)
            end
        end
    end,
}

SMODS.Blind {
    key = 'wallkerip',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 20},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("543770"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                local valid_suits = {}
                for k, scored_card in pairs(context.full_hand) do

                    -- This has to be pairs specifically as it is an unindexed table.
                    for _, scored_suit in pairs(SMODS.Suits) do
                        if scored_card:is_suit(scored_suit.key) then
                            valid_suits[scored_suit] = true
                        end
                    end
                end
                
                -- Check if the hand is debuffed.
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
    key = 'screecher',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 22},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("35414c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand and not context.check then
                blind.triggered = false
                if G.GAME.hands[context.scoring_name].level > to_big(1) and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    local penalty
                    if G.GAME.hands[context.scoring_name].level > to_big(3) then
                        penalty = 3
                    else
                        penalty = to_number(G.GAME.hands[context.scoring_name].level) - 1
                    end
                    return {
                        level_up = -penalty
                    }
                end
            end
        end
    end,
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
}

SMODS.Blind {
    key = 'glumplesk',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 24},
    dollars = 5,
    mult = 2,
    boss = {min = 4},
    boss_colour = HEX("a96c8e"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                for k, v in pairs(G.jokers.cards) do
                    v.states.drag.can = false
                end
            end
            if context.hand_drawn then
                for k, v in pairs(G.hand.cards) do
                    v.states.drag.can = false
                end
            end
        end
    end,

    disable = function(self)
        for _, v in ipairs(G.jokers.cards) do
            v.states.drag.can = true
        end
        for k, v in pairs(G.hand.cards) do
            v.states.drag.can = true
        end
    end,
    defeat = function(self)
        for _, v in ipairs(G.jokers.cards) do
            v.states.drag.can = true
        end
        for k, v in pairs(G.hand.cards) do
            v.states.drag.can = true
        end
    end
}

SMODS.Blind {
    key = 'chomper',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 25},
    dollars = 5,
    mult = 2,
    boss = {min = 4},
    boss_colour = HEX("a3444c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.gl_chomped then
                    return {
                        debuff = true
                    }
                end
            end

            if context.setting_blind then
                blind.state = nil
            end
            if context.before then
                blind.state = 'hand'
            end
            if context.pre_discard then
                blind.state = 'discard'
            end

            if context.hand_drawn then
                blind.triggered = true

                if blind.state == 'hand' then
                    local valid_jokers = {}
                    for _,v in ipairs(G.jokers.cards) do
                        if not v.ability.gl_chomped then
                            valid_jokers[#valid_jokers + 1] = v
                        end
                    end

                    local target_joker = pseudorandom_element(valid_jokers, 'gl_chomper_debuff')
                    if target_joker then
                        target_joker.ability.gl_chomped = true
                        SMODS.recalc_debuff(target_joker)
                        target_joker:juice_up()
                        blind:wiggle()
                    end
                    blind.state = nil
                
                elseif blind.state == 'discard' then
                    local debuffed_jokers = {}
                    for _,v in ipairs(G.jokers.cards) do
                        if v.ability.gl_chomped then
                            debuffed_jokers[#debuffed_jokers + 1] = v
                        end
                    end

                    local target_joker = pseudorandom_element(debuffed_jokers, 'gl_chomper_rebuff')
                    if target_joker then
                        target_joker.ability.gl_chomped = nil
                        SMODS.recalc_debuff(target_joker)
                        target_joker:juice_up()
                        blind:wiggle()
                    end
                    blind.state = nil
                end
            end
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_chomped = nil
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_chomped = nil
        end
    end
}

SMODS.Blind {
    key = 'jawtrap',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 26},
    dollars = 5,
    mult = 2,
    boss = {min = 4},
    boss_colour = HEX("70242e"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if (context.debuff_hand and not context.check) or (context.scoring_name and G.STATE == G.STATES.SELECTING_HAND) then
                local check = context.scoring_name and G.STATE == G.STATES.SELECTING_HAND

                local will_destroy = false

                if blind.hand_list then
                    local doesNotHaveHand = true
                    for _,v in ipairs(blind.hand_list) do
                        if context.scoring_name == v then
                            doesNotHaveHand = false
                            break
                        end
                    end
                    if doesNotHaveHand then
                        will_destroy = true
                        if not check then
                            blind.hand_list[#blind.hand_list + 1] = context.scoring_name
                        end
                    end
                elseif not check then
                    blind.hand_list = {context.scoring_name}
                end
                
                local destructable_jokers = {}
                if will_destroy then
                    for i = 1, #G.jokers.cards do
                        if not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                            destructable_jokers[#destructable_jokers + 1] =
                            G.jokers.cards[i]
                        end
                    end
                end

                if check then
                    if will_destroy and #destructable_jokers > 0 then
                        grasslanders.alert_debuff(self, true, localize('gl_jawtrap'))
                    else
                        grasslanders.alert_debuff(self, false)
                    end
                else
                    grasslanders.alert_debuff(self, false)
                    local joker_to_destroy = pseudorandom_element(destructable_jokers, 'gl_jawtrap')

                    if joker_to_destroy then
                        blind.triggered = true
                        joker_to_destroy.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                                return true
                            end
                        }))
                        shakeBlind()
                    end
                end
            end
        end
    end,
}

SMODS.Blind {
    key = 'leaper',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 23},
    dollars = 5,
    mult = 2,
    boss = {min = 4},
    boss_colour = HEX("6d7f5c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.effect.state = 'inactive'
            end
            if context.pre_discard then
                if G.GAME.current_round.discards_left <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            blind:disable()
                            return true
                        end
                    }))
                else
                    blind.effect.state = 'discard'
                end
            end
            if context.press_play then
                blind.effect.state = 'play'
            end
        end
    end,
}

local can_play_ref = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
    can_play_ref(e)

    if (not G.GAME.blind.disabled) and G.GAME.blind.config.blind.key == 'bl_grasslanders_leaper' and G.GAME.blind.effect.state == 'play' then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

local can_discard_ref = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    can_discard_ref(e)

    if (not G.GAME.blind.disabled) and G.GAME.blind.config.blind.key == 'bl_grasslanders_leaper' and G.GAME.blind.effect.state == 'discard' then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

SMODS.Blind {
    key = 'silentflash',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 27},
    dollars = 5,
    mult = 2,
    boss = {min = 5},
    boss_colour = HEX("b4a270"),
    modifies_draw = true,
    calculate = function(self, blind, context)
        if context.setting_blind then
            blind.prepped = nil
        end

        if not blind.disabled then
            if context.before then
                blind.prepped = true
            end
            if context.drawing_cards and blind.prepped then
                blind.prepped = nil
                return {
                    cards_to_draw = 1
                }
            end
        end
    end,
}

SMODS.Blind {
    key = 'snaggler',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 28},
    dollars = 5,
    mult = 2,
    boss = {min = 5},
    boss_colour = HEX("70673d"),
    modifies_draw = true, -- This is necessary for boss blinds like the Serpent for hand modification
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
                if (context.amount >= 4) then
                    return {
                        cards_to_draw = 4
                    }
                end
            end
        end
    end,
}

SMODS.Blind {
    key = 'bumpohorn',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 29},
    dollars = 5,
    mult = 2,
    boss = {min = 6},
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

SMODS.Sound {
    key = 'gloom_music',
    path = 'gloom_theme.ogg',
    pitch = 1,
    select_music_track = function() 
        local valid = nil
        if G.GAME.blind then
            if G.GAME.blind.config.blind.key == 'bl_grasslanders_twinckler' then
                valid = true
            elseif G.GAME.blind.config.blind.key == 'bl_grasslanders_maw' then
                valid = true
            elseif G.GAME.blind.config.blind.key == 'bl_grasslanders_persecutor' then
                valid = true
            elseif G.GAME.blind.config.blind.key == 'bl_grasslanders_radiochomper' then
                valid = true
            elseif G.GAME.blind.config.blind.key == 'bl_grasslanders_matriarch' then
                valid = true
            end
        end
        return valid
    end,
}

SMODS.Blind {
    key = 'twinckler',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 31},
    dollars = 8,
    mult = 2,
    boss = {showdown = true},
    boss_colour = HEX("a2ab8e"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.gl_twinckled then
                    return {
                        debuff = true
                    }
                end
            end

            if context.before and G.jokers.cards then
                local valid_jokers = {G.jokers.cards[1], G.jokers.cards[#G.jokers.cards]}
                local target_joker = pseudorandom_element(valid_jokers, 'gl_twinckler')

                target_joker.ability.gl_twinckled = true
                shakeBlind()
                target_joker:juice_up()
                SMODS.recalc_debuff(target_joker)
            end

            if context.hand_drawn then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability.gl_twinckled then
                        v.ability.gl_twinckled = nil
                        SMODS.recalc_debuff(v)
                    end
                end
            end
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_twinckled = nil
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_twinckled = nil
        end
    end
}

SMODS.Blind {
    key = 'maw',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 32},
    dollars = 8,
    mult = 2,
    boss = {showdown = true},
    boss_colour = HEX("a33829"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after and SMODS.calculate_round_score() < (get_blind_amount(G.GAME.round_resets.ante) * 0.5) then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.chips = 0
                        return true
                    end
                }))
                ease_chips(0)
                shakeBlind()
            end
        end
    end,
    loc_vars = function(self)
        return { vars = {get_blind_amount(G.GAME.round_resets.ante) * 0.5} }
    end,
    collection_loc_vars = function(self)
        return { vars = {localize('gl_maw_collection')} }
    end,
}

SMODS.Blind {
    key = 'persecutor',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 33},
    dollars = 8,
    mult = 2,
    boss = {showdown = true},
    boss_colour = HEX("a3293a"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind or context.pre_discard then
                blind.prepped = nil
            end
            if context.before then
                blind.prepped = true
            end

            if context.hand_drawn and blind.prepped then
                local forced_count = 2
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_card.ability.forced_selection then
                        forced_count = forced_count - 1
                    end
                end
                if forced_count > 0 then
                    G.hand:unhighlight_all()
                    for i=1,forced_count do
                        local valid_cards = {}
                        for _, playing_card in ipairs(G.hand.cards) do
                            if not playing_card.ability.forced_selection then
                                valid_cards[#valid_cards + 1] = playing_card
                            end
                        end
                        local forced_card = pseudorandom_element(valid_cards, 'gl_persecutor')
                        if forced_card then
                            forced_card.ability.forced_selection = true
                            G.hand:add_to_highlighted(forced_card)
                        end
                    end
                end
            end
        end
    end,

    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.forced_selection = nil
        end
    end
}

SMODS.Blind {
    key = 'radiochomper',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 34},
    dollars = 8,
    mult = 2,
    boss = {showdown = true},
    boss_colour = HEX("b48f43"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.gl_chonked then
                    return {
                        debuff = true
                    }
                end
            end

            if context.first_hand_drawn then
                for _,v in ipairs(G.jokers.cards) do
                    v.ability.gl_chonked = true
                    SMODS.recalc_debuff(v)
                    v:juice_up()
                end
                shakeBlind()
            end

            if context.hand_drawn and not context.first_hand_drawn then
                blind.triggered = true
                local debuffed_jokers = {}
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability.gl_chonked then
                        debuffed_jokers[#debuffed_jokers + 1] = v
                    end
                end

                local target_joker = pseudorandom_element(debuffed_jokers, 'gl_radiochomper')
                if target_joker then
                    target_joker.ability.gl_chonked = nil
                    SMODS.recalc_debuff(target_joker)
                    target_joker:juice_up()
                    blind:wiggle()
                end
            end
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_chonked = nil
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.gl_chonked = nil
        end
    end
}

SMODS.Blind {
    key = 'matriarch',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 35},
    dollars = 8,
    mult = 2,
    boss = {showdown = true},
    boss_colour = HEX("97467b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after and (G.GAME.chips + SMODS.calculate_round_score() >= G.GAME.blind.chips) then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.chips = 0
                        return true
                    end
                }))
                ease_chips(0)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        blind:disable()
                        return true
                    end
                }))
            end
        end
    end,
}

SMODS.Blind {
    key = 'clacker',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'woeslop',
    atlas = 'clackerblind',
    unlocked = true,
          
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
    key = 'veguar',
    atlas = 'clackerblind',
    unlocked = true,
          
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
            if context.debuff_hand and not context.check then
                local faces = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card:is_face() then
                        faces = faces + 1
                        scored_card:set_ability('m_grasslanders_gloom', nil, false)
                        G.E_MANAGER:add_event(Event({
                            func = function()
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
    key = 'stigz',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 17},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("697359"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand and not context.check and context.scoring_name ~= G.GAME.current_round.most_played_poker_hand then
                local count = 0
                for _,v in ipairs(context.full_hand) do
                    v:set_ability('m_grasslanders_gloom', nil, false)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                    count = count + 1
                end
                if count > 0 then
                    shakeBlind()
                end
            end
        end
    end,
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
}

SMODS.Blind {
    key = 'fungalic',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 36},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("66999a"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                for _, v in ipairs(G.playing_cards) do
                    if v.ability.played_this_ante then
                        v.gl_fungalic_effect = true
                    end
                end
            end
            if (context.debuff_hand and not context.check) or (context.scoring_name and G.STATE == G.STATES.SELECTING_HAND) then
                local check = context.scoring_name and G.STATE == G.STATES.SELECTING_HAND

                local faces = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card.gl_fungalic_effect then
                        faces = faces + 1
                        if not check then
                            scored_card:set_ability('m_grasslanders_gloom', nil, false)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    scored_card:juice_up()
                                    return true
                                end
                            }))
                        end
                    end
                end
                if check then
                    if faces > 0 then
                        grasslanders.alert_debuff(self, true, localize('gl_fungalic'))
                    else
                        grasslanders.alert_debuff(self, false)
                    end
                else
                    grasslanders.alert_debuff(self, false)
                    if faces > 0 then
                        shakeBlind()
                        delay(0.4)
                    end
                end
            end
        end
    end,

    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.gl_fungalic_effect = nil
        end
    end,

    defeat = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.gl_fungalic_effect = nil
        end
    end,
}

SMODS.Blind {
    key = 'clacteriophage',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 21},
    dollars = 5,
    mult = 2,
    boss = {min = 3},
    boss_colour = HEX("ab4f58"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand and not context.check and #context.scoring_hand <= 1 then
                local count = 0
                for _,v in ipairs(context.full_hand) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:set_ability('m_grasslanders_gloom', nil, false)
                            v:juice_up()
                            return true
                        end
                    }))
                    count = count + 1
                end
                if count > 0 then
                    shakeBlind()
                end
            end
        end
    end,
}

SMODS.Blind {
    key = 'wartumorr',
    atlas = 'clackerblind',
    unlocked = true,
          
    pos = {x = 0, y = 30},
    dollars = 5,
    mult = 2,
    boss = {min = 6},
    boss_colour = HEX("a96c75"),
    in_pool = function()
        local valid = false
        if (G.GAME.round_resets.ante >= 6) then
            local count = 0
            for _,v in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(v, 'm_grasslanders_gloom') then
                    count = count + 1
                end
            end

            valid = (count >= 1)
        end
        return valid
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.hand_drawn then
                local forced_count = 1
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_card.ability.forced_selection then
                        forced_count = forced_count - 1
                    end
                end
                if forced_count > 0 then
                    G.hand:unhighlight_all()
                    for i=1,forced_count do
                        local valid_cards = {}
                        for _, playing_card in ipairs(G.hand.cards) do
                            if SMODS.has_enhancement(playing_card, "m_grasslanders_gloom") and not playing_card.ability.forced_selection then
                                valid_cards[#valid_cards + 1] = playing_card
                            end
                        end
                        local forced_card = pseudorandom_element(valid_cards, 'gl_wartumorr')
                        if forced_card then
                            forced_card.ability.forced_selection = true
                            G.hand:add_to_highlighted(forced_card)
                        end
                    end
                end
            end
            --[[
            if context.hand_drawn then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        local gloom_cards = {}
                        local discard_count = #G.discard.cards
                        for i=1, discard_count do --draw cards from deck
                            if SMODS.has_enhancement(G.discard.cards[i], 'm_grasslanders_gloom') then
                                gloom_cards[#gloom_cards + 1] = G.discard.cards[i]
                            end
                        end
                        
                        local gloom_count = #gloom_cards
                        for i=1, #gloom_cards do
                            draw_card(G.discard, G.deck, i*100/gloom_count,'up', nil ,gloom_cards[i], 0.005, i%2==0, nil, math.max((21-i)/20,0.7))
                            --pseudorandom('gl_wartumorr', 1, #G.deck.cards)
                        end
                            --draw_card(G.discard, G.deck, i*100/discard_count,'up', nil ,nil, 0.005, i%2==0, nil, math.max((21-i)/20,0.7))
                        return true
                    end
                }))
            end
            
            if context.discard then
                local scored_card = context.other_card

                if SMODS.has_enhancement(scored_card, 'm_grasslanders_gloom') then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local copied_card = copy_card(scored_card, nil, nil, G.playing_card)
                    copied_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copied_card)
                    G.deck:emplace(copied_card)
                    copied_card.states.visible = nil

                    SMODS.destroy_cards(scored_card)
                end
            end

            if context.after then
                for _,scored_card in ipairs(context.full_hand) do
                    if SMODS.has_enhancement(scored_card, 'm_grasslanders_gloom') then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local copied_card = copy_card(scored_card, nil, nil, G.playing_card)
                        copied_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copied_card)
                        G.deck:emplace(copied_card)
                        copied_card.states.visible = nil

                        SMODS.destroy_cards(scored_card)
                    end
                end
            end]]
        end
    end,

    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.forced_selection = nil
        end
    end
}