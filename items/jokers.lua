grasslanders = SMODS.current_mod

-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function return_JokerValues() -- not used, just here to demonstrate how you could return values from a joker
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips,       -- these are the 3 possible scoring effects any joker can return.
            mult = card.ability.extra.mult,         -- adds mult (+)
            x_mult = card.ability.extra.x_mult,     -- multiplies existing mult (*)
            card = self,                            -- under which card to show the message
            colour = G.C.CHIPS,                     -- colour of the message, Balatro has some predefined colours, (Balatro/globals.lua)
            message = localize('k_upgrade_ex'),     -- this is the message that will be shown under the card when it triggers.
            extra = { focus = self, message = localize('k_upgrade_ex') },
        }
    end
end

SMODS.Atlas({
    key = "scorpibeat",
    path = "scorpibeat.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "scorpibeat",                                  --name used by the joker.    
    config = { extra = {mult = 18} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'scorpibeat',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            if G.GAME.blind.boss then
                return {
                    mult = card.ability.extra.mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = { card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "blowy",
    path = "blowy.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "blowy",                                  --name used by the joker.    
    config = {extra = {h_size = 0, h_mod = 1}},    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'blowy',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.after then
                card.ability.extra.h_size = card.ability.extra.h_size - card.ability.extra.h_mod
                G.hand:change_size(-card.ability.extra.h_mod)

                return {
                    message = localize{type = 'variable',key = 'a_handsize_minus',vars = {card.ability.extra.h_mod}},
                    colour = G.C.FILTER
                }
            end
            if context.discard and context.other_card == context.full_hand[#context.full_hand] then
                if G.hand.config.card_limit > 0 then
                    card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
                    G.hand:change_size(card.ability.extra.h_mod)

                    return {
                        message = localize{type = 'variable',key = 'a_handsize',vars = {card.ability.extra.h_mod}},
                        colour = G.C.FILTER
                    }
                end
            end

            if context.end_of_round and context.game_over == false and context.main_eval then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.h_size = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local operator = '+'
        if card.ability.extra.h_size < 0 then
            operator = ''
        end
        return { vars = {card.ability.extra.h_mod, card.ability.extra.h_size, operator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "sprinkle",
    path = 'sprinkle.png',
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sprinkle",                                  --name used by the joker.    
    config = { extra = {chips = 50, rank = 'Ace'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'sprinkle',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 1 then
                local valid = true
                for _,v in ipairs(G.hand.cards) do
                    if v:is_face() then
                        valid = false
                        break
                    end
                end
                if valid then
                    return {
                        chips = card.ability.extra.chips,
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chips, localize(card.ability.extra.rank, 'ranks')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "molty",
    path = "molty.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "molty",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 0.5} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'molty',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.after and SMODS.calculate_round_score() >= G.GAME.blind.chips then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = "g_onfire" }
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "trizap",
    path = "trizap.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "trizap",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos={ x = 1, y = 0 },
    atlas = 'trizap',

    calculate = function(self,card,context)
        if (context.card and (context.joker_type_destroyed or (context.selling_card and context.card.ability.set == 'Joker'))) then
            local copied_joker = copy_card(context.card)
            copied_joker:set_edition(poll_edition('grasslanders_trizap'), true)
            if card.config.center.eternal_compat then
                copied_joker:set_eternal(true)
            end
            copied_joker:add_to_deck()
            G.jokers:emplace(copied_joker)
        end
        --[[
        if not context.blueprint then
            if (context.card and (context.joker_type_destroyed or (context.selling_card and context.card.ability.set == 'Joker'))) then
                local odds = 1
                for _,joker in ipairs(G.jokers.cards) do
                    if joker.edition and joker.edition.negative and joker ~= card then
                        odds = odds + 1
                    end
                end
                if SMODS.pseudorandom_probability(card, 'trizap', 1, odds) then
                    local copied_joker = copy_card(context.card)
                    copied_joker:set_edition("e_negative", true)
                    if card.config.center.eternal_compat then
                        copied_joker:set_eternal(true)
                    end
                    copied_joker:add_to_deck()
                    G.jokers:emplace(copied_joker)
                end
            end
        end
        ]]
    end,

    loc_vars = function(self, info_queue, card)
        local odds = 1
        if G.jokers then
            for _,joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative and joker ~= card then
                    odds = odds + 1
                end
            end
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, odds, 'trizap')

        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = { key = "eternal", set = "Other" }
        return { vars = {numerator, denominator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "frogobonk",
    path = "frogobonk.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "frogobonk",
    config = { extra = {mult = 5}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'frogobonk',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if next(SMODS.get_enhancements(context.other_card)) then
                return {
                    mult = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.other_card:get_edition() then
                SMODS.destroy_cards(card, nil, nil, true)
                SMODS.add_card{key = "j_grasslanders_lumobonk"}
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue+1] = {set = "Joker", key = "lumobonk" }
        return { vars = {card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "reeflute",
    path = "reeflute.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "reeflute",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'reeflute',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    chips = context.other_card:get_chip_bonus()
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "concrab",
    path = "concrab.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "concrab",
    config = { extra = {poker_hand = 'High Card'}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'concrab',

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            local effects = {
                {
                    chips = G.GAME.hands[card.ability.extra.poker_hand].chips, 
                },
                {
                    mult = G.GAME.hands[card.ability.extra.poker_hand].mult, 
                },
            }
            card.ability.extra.poker_hand = context.scoring_name
            return SMODS.merge_effects(effects)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            localize(card.ability.extra.poker_hand, 'poker_hands'),
            G.GAME.hands[card.ability.extra.poker_hand].chips,
            G.GAME.hands[card.ability.extra.poker_hand].mult
        }, key = self.key }
    end
}

SMODS.Atlas({
    key = "anjellyze",
    path = "anjellyze.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "anjellyze",
    config = { extra = {mult = 0, mult_mod = 4, poker_hand = 'High Card'}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'anjellyze',

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.before and context.scoring_name == card.ability.extra.poker_hand then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval then
                local _poker_hands = {}
                for handname, _ in pairs(G.GAME.hands) do
                    if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                        _poker_hands[#_poker_hands + 1] = handname
                    end
                end
                card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
                return {
                    message = localize('k_reset')
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod, localize(card.ability.extra.poker_hand, 'poker_hands')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "logobreak",
    path = "logobreak.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "logobreak",
    config = { extra = {active = false, odds = 2, tag = 'tag_coupon'}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=false,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'logobreak',

    calculate = function(self,card,context)
        --[[
        if card.ability.extra.active then
            if context.buying_card then
                return {
                    dollars = context.card.cost
                }
            end
        end

        if not context.blueprint then
            if card.ability.extra.active then
                if context.buying_card or context.ending_shop then
                    card.ability.extra.active = false
                end
            else
                if (context.end_of_round and context.game_over == false and context.main_eval) or context.buying_self then
                    card.ability.extra.active = true
                    local eval = function(card) return not card.ability.extra.active end
                    juice_card_until(card, eval, true)
                end
            end

            if context.after and SMODS.calculate_round_score() > G.GAME.blind.chips then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('a_fled'),
                    colour = G.C.FILTER,
                }
            end
        end
        ]]
        if card.ability.extra.active then
            if not context.blueprint then
                if context.after and SMODS.calculate_round_score() >= G.GAME.blind.chips then
                    card.ability.extra.active = false
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval then
                if SMODS.pseudorandom_probability(card, "logobreak", 1, card.ability.extra.odds) then
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag(card.ability.extra.tag))
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end
        elseif context.setting_blind and not context.blueprint then
            card.ability.extra.active = true
        end
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "logobreak")
        info_queue[#info_queue + 1] = {set = "Other", key = "g_onfire" }
        return { vars = {numerator,denominator}, key = self.key }
    end
}

SMODS.Sound ({
    key = 'erupt',
    path = 'volc_explosion.ogg',
})
SMODS.Atlas({
    key = "volcarox",
    path = "volcarox.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "volcarox",                                  --name used by the joker.    
    config = { extra = {draw = 10, active = false, d_remaining = 0} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'volcarox',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.setting_blind then
            card.ability.extra.active = true
        end
        if context.hand_drawn and G.GAME.current_round.discards_left == card.ability.extra.d_remaining and card.ability.extra.active then
            card.ability.extra.active = false
            return {
                message = localize('k_erupt_ex'),
                colour = G.C.RED,
                sound = 'grasslanders_erupt',
                func = function() -- This is for timing purposes, everything here runs after the message
                    SMODS.draw_cards(card.ability.extra.draw)
                end,
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.draw, card.ability.extra.d_remaining}, key = self.key }
    end
}

SMODS.Atlas({
    key = "junklake",
    path = "junklake.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "junklake",
    config = { extra = {dollars = 20}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'junklake',

    calculate = function(self,card,context)
        if
            (context.discard and context.other_card == context.full_hand[#context.full_hand]) or
            context.after
        then
            local valid = false

            local amount = 0
            for _, counted_card in ipairs(G.playing_cards) do
                if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                    amount = amount + 1
                end
            end

            local count = amount
            for _, counted_card in ipairs(G.deck.cards) do
                if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                    count = count - 1
                end
            end
            for _, counted_card in ipairs(G.hand.cards) do
                if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                    count = count - 1
                end
            end
            for _, counted_card in ipairs(context.full_hand) do
                if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                    valid = true
                    count = count + 1
                end
            end

            if valid and count >= amount then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        local rank = "2"
        local amount = 0
        local count = 0
        if G.GAME.current_round.junklake_card then
            rank = G.GAME.current_round.junklake_card.rank
            if G.playing_cards then
                for _, counted_card in ipairs(G.playing_cards) do
                    if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                        amount = amount + 1
                    end
                end
            end
            count = amount
            if G.deck and G.hand.cards then
                for _, counted_card in ipairs(G.deck.cards) do
                    if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                        count = count - 1
                    end
                end
                for _, counted_card in ipairs(G.hand.cards) do
                    if counted_card:get_id() == G.GAME.current_round.junklake_card.id then
                        count = count - 1
                    end
                end
            end
        else
            count = 0
            amount = 4
        end

        return { vars = {card.ability.extra.dollars, localize(rank, 'ranks'),count,amount}, key = self.key }
    end
}

local function reset_junklake()
    G.GAME.current_round.junklake_card = {rank = 'Ace', id = 1}
    local valid_jake_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_jake_cards[#valid_jake_cards + 1] = playing_card
        end
    end
    local jake_card = pseudorandom_element(valid_jake_cards, 'grasslanders_junklake' .. G.GAME.round_resets.ante)
    if jake_card then
        G.GAME.current_round.junklake_card.rank = jake_card.base.value
        G.GAME.current_round.junklake_card.id = jake_card.base.id
    end
    --[[
    G.GAME.current_round.junklake_card = {rank='Ace', id=1, amount=4}

    local jake_ranks = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            if not jake_ranks[playing_card.base.id] then
                jake_ranks[playing_card.base.id] = {
                    rank = playing_card.base.value,
                    id = playing_card.base.id,
                    amount = 1,
                }
            else
                jake_ranks[playing_card.base.id].amount = jake_ranks[playing_card.base.id].amount + 1
            end
        end
    end

    local min = nil
    local max = nil
    for _,v in ipairs(jake_ranks) do
        if (not min) or v.amount < min then
            min = v.amount
        end
        if (not max) or v.amount > max then
            max = v.amount
        end
    end

    local jake_table = {}
    for _,v in ipairs(jake_ranks) do
        local weight = max - min - v.amount + 2
        local i = 1
        while i <= weight do
            jake_table[#jake_table + 1] = v.id
            i = i + 1
        end
    end

    
    local chosen_rank = pseudorandom_element(jake_table,'grasslanders_junklake' .. G.GAME.round_resets.ante)
    G.GAME.current_round.junklake_card.rank = jake_ranks[chosen_rank].rank
    G.GAME.current_round.junklake_card.id = jake_ranks[chosen_rank].id
    G.GAME.current_round.junklake_card.amount = jake_ranks[chosen_rank].amount
    
    print(jake_table)
    print(G.GAME.current_round.junklake_card.rank)
    print(G.GAME.current_round.junklake_card.amount)
    ]]
end



SMODS.Atlas({
    key = "pricklea",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "pricklea",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'pricklea',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "hornetrix",
    path = "hornetrix.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "hornetrix",
    config = { extra = {sell_multiplier = 4}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'hornetrix',

    set_sprites = function(self, card, front)
        local alt = 0
        if grasslanders.config.althornetrix then
            alt = 1
        end
        card.children.center:set_sprite_pos({x=alt,y=0})
    end,

    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            local eaten_card = pseudorandom_element(G.consumeables.cards, 'grasslanders_hornetrix')
            if eaten_card then
                card.ability.extra_value = card.ability.extra_value + (eaten_card.sell_cost * card.ability.extra.sell_multiplier)
                card:set_cost()
                SMODS.destroy_cards(eaten_card)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.MONEY
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.sell_multiplier}, key = self.key }
    end
}

SMODS.Atlas({
    key = "chonkreep",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "chonkreep",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'chonkreep',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "mossibug",
    path = "mossibug.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "mossibug",
    config = { extra = {chips = 100, chip_penalty = 10, chip_mod = 100}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'mossibug',

    calculate = function(self,card,context)
        if not context.blueprint then
            if
                (context.discard and context.other_card == context.full_hand[#context.full_hand]) or
                context.after
            then
                if G.GAME.blind.boss and (G.GAME.chips + SMODS.calculate_round_score()) >= G.GAME.blind.chips then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                    return {
                        message = localize('k_awake_ex'),
                        colour = G.C.CHIPS
                    }
                else
                    if card.ability.extra.chips > 0 then
                        if card.ability.extra.chips - card.ability.extra.chip_penalty > 0 then
                            card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_penalty
                        else
                            card.ability.extra.chips = 0
                        end
                        return {
                            message = localize('k_sleep_ex'),
                            colour = G.C.CHIPS
                        } 
                    end
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips,card.ability.extra.chip_penalty,card.ability.extra.chip_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "santile",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "santile",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'santile',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
        if context.before and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_stone') then
                    scored_card.center.shatters = true
                    --play_sound('grasslanders_stonebreak')
                    SMODS.destroy_cards(scored_card, nil, nil, true)
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "fortromtoise",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "fortromtoise",
    config = { extra = {x_mult = 1, x_mult_mod = 0.25}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'fortromtoise',

    calculate = function(self,card,context)
        if context.discard then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
            }
        end
        if context.joker_main then
            local effects = {
                {
                    x_mult = card.ability.extra.x_mult, 
                },
                {

                    message = localize('k_reset'),
                    colour = G.C.MULT,
                }
            }
            card.ability.extra.x_mult = 1
            return SMODS.merge_effects(effects)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "kracosteal",
    path = "j_sample_baroness.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "kracosteal",
    config = { extra = {dollars = 3}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'kracosteal',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        dollars = card.ability.extra.dollars,
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = {card.ability.extra.dollars}, key = self.key }
    end
}

SMODS.Atlas({
    key = "wisplasm",
    path = "j_sample_baroness.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "wisplasm",
    config = { extra = {x_mult = 1.5}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'wisplasm',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_gold') then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        x_mult = card.ability.extra.x_mult
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return {vars = {card.ability.extra.x_mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "lumobonk",
    path = "lumobonk.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "lumobonk",
    config = { extra = {x_mult = 2}},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 10,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'lumobonk',
    in_pool = false,

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_edition() then
                    return {
                        x_mult = card.ability.extra.x_mult, 
                        colour = G.C.MULT
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "axonitta",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "axonitta",
    config = { extra = {mult = 0, mult_mod = 5, poker_hand = 'High Card'}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'axonitta',

    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            if context.scoring_name == card.ability.extra.poker_hand then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            else
                card.ability.extra.mult = 0
                card.ability.extra.poker_hand = context.scoring_name
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod, localize(card.ability.extra.poker_hand, 'poker_hands')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "tickini",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "tickini",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'tickini',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "cocotom",
    path = "cocotom.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "cocotom",
    config = { extra = {x_mult = 1, x_mult_mod = 0.5, rounds = 12,}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'cocotom',

    calculate = function(self,card,context)
        if context.buying_self then
            local eval = function(card) return card.ability.extra.rounds <= 0 end
            juice_card_until(card,eval,true)
        end
        if not context.blueprint and card.ability.extra.rounds > 0 then
            if context.remove_playing_cards then 
                if #context.removed > 0 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (#context.removed * card.ability.extra.x_mult_mod)
                    return {
                        message = localize {type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                        colour = G.C.MULT
                    }
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval then
                card.ability.extra.rounds = card.ability.extra.rounds - 1
                if card.ability.extra.rounds <= 0 then
                    return {
                        message = localize('k_free_ex'),
                        colour = G.C.FILTER
                    }
                else
                    return {
                        message = localize{key='a_left', vars={card.ability.extra.rounds}},
                        colour = G.C.FILTER
                    }
                end
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.rounds <= 0 then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod, card.ability.extra.rounds}, key = self.key }
    end
}

--[[
SMODS.Atlas({
    key = "triple9",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "triple9",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'triple9',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "triple10",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "triple10",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'triple10',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
]]

SMODS.Atlas({
    key = "litabelle",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "litabelle",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'litabelle',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "erny",
    path = "erny.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "erny",
    config = { extra = {x_mult = 1, x_mult_mod = 1, hand1 = 'Straight', hand2 = 'Flush'}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'erny',

    calculate = function(self,card,context)
        if context.before then
            if next(context.poker_hands[card.ability.extra.hand1]) and next(context.poker_hands[card.ability.extra.hand2]) then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            elseif (not next(context.poker_hands[card.ability.extra.hand1])) and (not next(context.poker_hands[card.ability.extra.hand2])) then
                card.ability.extra.x_mult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.x_mult,
            card.ability.extra.x_mult_mod,
            localize(card.ability.extra.hand1, 'poker_hands'),
            localize(card.ability.extra.hand2, 'poker_hands')
        }, key = self.key }
    end
}

SMODS.Atlas({
    key = "emmie",
    path = "emmie.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "emmie",
    config = { extra = {active = false}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'emmie',

    calculate = function(self,card,context)
        if context.first_hand_drawn then
            card.ability.extra.active = true
            local eval = function() return not card.ability.extra.active end
            juice_card_until(card, eval, true)
        end
        if (context.before and next(context.poker_hands['Straight'])) or (context.end_of_round and context.main_eval) then
            card.ability.extra.active = false
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

local smods_shortcut_ref  = SMODS.shortcut
function SMODS.shortcut()
    local emmie = SMODS.find_card('j_grasslanders_emmie')
    for _,v in ipairs(emmie) do
        if v.ability.extra.active then
            return 'emmie'
        end
    end
    return smods_shortcut_ref()
end

local card_stop_drag_ref = Card.stop_drag
function Card:stop_drag()
    local ret = card_stop_drag_ref(self)
    SMODS.calculate_context({grasslanders_stop_drag = true, cardarea = self.area})
    return ret
end

SMODS.Atlas({
    key = "edward",
    path = "edward.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "edward",
    config = { extra = {mult = 0, mult_mod = 2, chosen_joker = 0}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'edward',

    calculate = function(self,card,context)
        if context.debuff_card and context.debuff_card.area == G.jokers and context.debuff_card == G.jokers.cards[card.ability.extra.chosen_joker] then
            return {debuff = true}
        end
        
        if 
            (context.card_added and context.cardarea == G.jokers) or
            (context.selling_card and context.cardarea == G.jokers) or
            (context.grasslanders_stop_drag and context.cardarea == G.jokers) or
            context.joker_type_destroyed
        then
            local old_pos = card.ability.extra.chosen_joker
            for k, v in pairs(G.jokers.cards) do
                if v == card then
                    card.ability.extra.chosen_joker = k + 1
                    break
                end
            end

            --[[
            local target_jokers = {G.jokers.cards[card.ability.extra.chosen_joker]}
            if old_pos ~= card.ability.extra.chosen_joker then
                target_jokers[#target_jokers + 1] = G.jokers.cards[old_pos]
            end
            ]]
            for _,v in pairs(G.jokers.cards) do
                local debuffed = v.debuff
                SMODS.recalc_debuff(v)
                if v.debuff ~= debuffed then
                    v:juice_up()
                end
            end
        end

        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then my_pos = i end
        end
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[my_pos + 1], context)
        if ret then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.x_mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        --[[
        if context.individual and context.cardarea == G.play then
            if next(context.poker_hands[card.ability.extra.poker_hand]) then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    card = self,
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        ]]
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod}, key = self.key }
    end
}

--[[
SMODS.Atlas({
    key = "quad3",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "quad3",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'quad3',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "quad4",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "quad4",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'quad4',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
SMODS.Atlas({
    key = "quad5",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "quad5",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'quad5',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
]]

SMODS.Atlas({
    key = "vegebonion",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "vegebonion",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'vegebonion',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "deespirr",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "deespirr",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'deespirr',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "hyphilliacs",
    path = "hyphilliacs.png",
    px = 71,
    py = 95
})

-- BUG: Hyphilliac debuffing doesn't work right
SMODS.Joker{
    key = "hyphilliacs",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'hyphilliacs',

    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                local second_id = (scored_card:get_id() == 13 and 12) or (scored_card:get_id() == 12 and 13) or 0

                if second_id ~= 0 then
                    local valid = false

                    for _, second_card in ipairs(context.scoring_hand) do
                        if second_card:get_id() == second_id and (scored_card:is_suit(second_card.base.suit) or second_card:is_suit(scored_card.base.suit)) then
                            valid = true
                            break
                        end
                    end
                    if not valid then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                scored_card:set_debuff(true)
                                SMODS.recalc_debuff(scored_card)
                                return true
                            end
                        }))
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED
                        }
                    end
                end
            end
        end
        if context.repetition and context.cardarea == G.play then
            local second_id = (context.other_card:get_id() == 13 and 12) or (context.other_card:get_id() == 12 and 13) or 0

            if second_id ~= 0 then
                local effects = {}
                for _, second_card in ipairs(context.scoring_hand) do
                    if second_card:get_id() == second_id and (context.other_card:is_suit(second_card.base.suit) or second_card:is_suit(context.other_card.base.suit)) then
                        effects[#effects + 1] = {
                            repetitions = 1,
                            card = second_card
                        }
                    end
                end
                if effects then
                    return SMODS.merge_effects(effects)
                end
            end
        end


    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

--[[
SMODS.Atlas({
    key = "bad4",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "bad4",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'bad4',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "bad5",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "bad5",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'bad5',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
]]

SMODS.Atlas({
    key = "sugamimi",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sugamimi",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'sugamimi',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "vacomar",
    path = "j_sample_roomba.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "vacomar",                                  --name used by the joker.    
    config = {extra = {card = {state = 'invalid', id = 0, rank = '', suit = ''}, discard_mod = 1, valid = false}},    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'vacomar',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            if context.end_of_round and context.game_over == false and context.main_eval and card.ability.extra.card then
                card.ability.extra.card.state = 'invalid'
                card.ability.extra.card.rank = 0
                card.ability.extra.card.suit = ''
                card.ability.extra.card.id = ''
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end

            if context.discard then
                if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                    if SMODS.has_enhancement(context.other_card, 'm_stone') then
                        card.ability.extra.card.state = 'stone'
                    else
                        card.ability.extra.card.state = 'valid'
                        card.ability.extra.card.rank = context.other_card.base.value
                        card.ability.extra.card.suit = context.other_card.base.suit
                        card.ability.extra.card.id = context.other_card.base.id
                    end

                    return {
                        message = localize('a_active'),
                        colour = G.C.FILTER
                    }
                end

                if card.ability.extra.card.state ~= 'invalid' and context.other_card == context.full_hand[#context.full_hand] then
                    local valid = true

                    for _,discarded_card in ipairs(context.full_hand) do
                        if card.ability.extra.card.state == 'stone' then
                            if not(SMODS.has_enhancement(discarded_card, 'm_stone')) then
                                valid = false
                            end
                        else
                            if context.other_card:get_id() ~= card.ability.extra.card.id and not(discarded_card:is_suit(card.ability.extra.card.suit)) then
                                valid = false
                            end
                        end
                    end

                    if valid then
                        if context.other_card == context.full_hand[#context.full_hand] then
                            ease_discard(card.ability.extra.discard_mod, nil, true)
                            return {
                                message = localize('a_discard_one'),
                                colour = G.C.RED
                            }
                        end
                    end
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local rank = ''
        local msg = ''
        local suit = ''
        local col = G.C.FILTER
        if card.ability.extra.card.state ~= 'invalid' then
            if card.ability.extra.card.state == 'stone' then
                rank = 'Stone'
                msg = ' cards'
            else
                rank = localize(card.ability.extra.card.rank, 'ranks')
                msg = ' of '
                suit = localize(card.ability.extra.card.suit, 'suits_plural')
                col = G.C.SUITS[card.ability.extra.card.suit]
            end
        else
            msg = 'inactive'
        end
        return { vars = {rank, msg, suit, card.ability.extra.discard_mod, colours={col}}, key = self.key }
    end
}

function SMODS.current_mod.reset_game_globals(run_start)
    reset_junklake()
end

--[[
SMODS.Atlas({
    key = "synth3",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "synth3",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'synth3',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "synth4",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "synth4",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'synth4',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "synth5",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "synth5",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'synth5',

    calculate = function(self,card,context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
]]

SMODS.Atlas({
    key = "penny",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "penny",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'penny',

    calculate = function(self,card,context)
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

--[[
SMODS.Atlas({
    key = "beezy",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "beezy",
    config = { extra = {}},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'beezy',

    calculate = function(self,card,context)
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}
]]