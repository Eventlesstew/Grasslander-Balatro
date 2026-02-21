grasslanders = SMODS.current_mod

-- This Atlas is used by all of the Grasslander Jokers
SMODS.Atlas({
    key = "grasslanderJoker",
    path = "jokers.png",
    px = 71,
    py = 95
})

-- I'll use Blowy as an example for the values shared by all other Jokers
SMODS.Joker{
    -- They key acts as the card's internal ID. 
    -- Do note that SMODS appends j_(modprefix)_ to the key so Blowy's actual key for example is j_grasslanders_blowy
    key = "blowy",
    atlas = 'grasslanderJoker', -- The card refers to the Atlas listed.
    pos = { x = 0, y = 0 }, -- Since the texture used is a spritesheet, this specifies which texture is used.
    soul_pos=nil, -- This value is only relevant for things with an overlay such as Legendaries and the Soul. nil means it is invisible.

    config = {extra = {h_size = 0, h_mod = 1}}, -- Extra variables stored by the Joker for use in calculate functions
    rarity = 1, --Joker rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5, -- How much the Joker costs
    blueprint_compat=false, -- This only affects the "compatible" message in Blueprint or Brainstorm. You need to use context.blueprint to specify which stuff Blueprint can or can't do.
    eternal_compat=true, -- Specifies if the Joker can have Eternal
    perishable_compat=true, -- Specifies if the Joker can have Perishable

    calculate = function(self,card,context) --define calculate functions here
        -- Context contains various different booleans that you can see in this link:
        -- https://github.com/Steamodded/smods/wiki/Calculate-Functions#:~:text=Contexts,-A%20context

        if not context.blueprint then -- This prevents Blueprint from doing anything
            if context.after then -- Affects the hand size after hand
                card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
                G.hand:change_size(card.ability.extra.h_mod)

                return {
                    message = localize{type = 'variable',key = 'a_handsize',vars = {card.ability.extra.h_mod}},
                    colour = G.C.FILTER
                }
            end

            if context.end_of_round and context.game_over == false and context.main_eval then -- Resets Hand size at end of round
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.h_size = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff) -- If Blowy was debuffed, this allows her to change the hand size back
        G.hand:change_size(card.ability.extra.h_size)
    end,

    remove_from_deck = function(self, card, from_debuff) -- Resets hand size when removed
        G.hand:change_size(-card.ability.extra.h_size)
    end,

    loc_vars = function(self, info_queue, card) --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.h_mod, card.ability.extra.h_size}, key = self.key }
    end
}

SMODS.Joker{
    key = "scorpibeat",
    atlas = 'grasslanderJoker',
    config = { extra = {mult = 18} },
    pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
      

    calculate = function(self,card,context)
        if context.joker_main then -- Triggers when scored
            if G.GAME.blind.boss then -- Checks if you're on a Boss Blind
                return {
                    mult = card.ability.extra.mult, 
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Joker{
    key = "sprinkle",
    atlas = 'grasslanderJoker',
    config = { extra = {chips = 0, chip_mod = 3} },
    pos = { x = 2, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and not context.blueprint then -- Triggers when the card is played
            local valid = true
            for _,v in ipairs(G.hand.cards) do -- This checks if held hand has any face cards
                if v:is_face() then
                    valid = false
                    break
                end
            end

            if valid then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return { -- Gives Chips
                    message = localize('k_upgrade_ex'),
                    message_card = card,
                    colour = G.C.CHIPS
                }
            end
        end

        if context.joker_main then
            return { -- Gives Chips
                chips = card.ability.extra.chips,
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod}, key = self.key }
    end
}

SMODS.Joker{
    key = "molty",
    atlas = 'grasslanderJoker',
    config = { extra = {mult = 1, mult_mod = 0.25} },
    pos = { x = 3, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     

    calculate = function(self,card,context)
        if not context.blueprint then -- Prevents Blueprint from scaling
            if context.after and SMODS.calculate_round_score() >= G.GAME.blind.chips then -- Checks if hand is on fire
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod -- Increases Xmult Output
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        -- Giving Mult
        if context.joker_main then
            return {
                x_mult = card.ability.extra.mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = "g_onfire" } -- Adds the popup to 
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod}, key = self.key }
    end
}

SMODS.Joker{
    key = "trizap",
    atlas = 'grasslanderJoker',
    config = { extra = {odds = 2}},
    pos = { x = 4, y = 0 },
    soul_pos={ x = 5, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        if 
            context.card and 
            (context.joker_type_destroyed or context.selling_card) 
            and context.card.ability.set == 'Joker' and -- Triggers if Jokers are sold or destroyed
            (context.card ~= card) and -- So Trizap doesn't copy itself even though it can do that.
            not (context.card.edition and context.card.edition.negative) and -- Prevents Negatives from being copied
            SMODS.pseudorandom_probability(card, "gl_trizap", 1, card.ability.extra.odds) -- Probability
        then
            local copied_joker = copy_card(context.card)
            copied_joker:set_edition({ negative = true })

            local valid_stickers = {}

            for _, v in pairs(SMODS.Stickers) do
                v:apply(copied_joker,v.key)
                local result = copied_joker.ability[v.key]
                v:apply(copied_joker, false)

                if result then
                    valid_stickers[#valid_stickers+1] = v
                end
            end

            local chosen_sticker = pseudorandom_element(valid_stickers, 'gl_trizap_stickers')
            if chosen_sticker then
                copied_joker['set_'..chosen_sticker.key](copied_joker, true)
            end
            
            copied_joker:add_to_deck()
            G.jokers:emplace(copied_joker)
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative

        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gl_trizap") -- Gives the chances for Trizap. Modified by Oops All Sixes
        return { vars = {numerator,denominator}, key = self.key }
    end
}

SMODS.Joker{
    key = "logobreak",
    atlas = 'grasslanderJoker',
    config = { extra = {active = false, odds = 2, tag = 'tag_coupon'}},
    pos = { x = 0, y = 1 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,

    calculate = function(self,card,context)
        if card.ability.extra.active then
            if not context.blueprint then
                if context.after and SMODS.calculate_round_score() >= G.GAME.blind.chips then -- Disables Loggy if hand is on fire
                    card.ability.extra.active = false
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval then -- Gives the Coupon Tag if active
                if SMODS.pseudorandom_probability(card, "gl_logobreak", 1, card.ability.extra.odds) then -- Random chance
                    G.E_MANAGER:add_event(Event({ -- Code to give the Coupon Tag
                        func = (function()
                            add_tag(Tag(card.ability.extra.tag))
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end
        elseif context.setting_blind and not context.blueprint then -- Sets up Logobreak
            card.ability.extra.active = true
        end
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "logobreak") -- Gives the chances for Logobreak. Modified by Oops All Sixes
        info_queue[#info_queue + 1] = {set = "Other", key = "g_onfire" }
        return { vars = {numerator,denominator}, key = self.key }
    end
}

SMODS.Joker{
    key = "pricklea",
    atlas = 'grasslanderJoker',
    config = { extra = {repetitions = 1}},
    pos = { x = 0, y = 2 },
    rarity = 2,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then -- This is used for repeating cards
            local valid = true

            for _, scored_card in ipairs(context.scoring_hand) do -- Checks if card is the only one in hand with it's enhancement.
                if scored_card ~= context.other_card then
                    if next(SMODS.get_enhancements(context.other_card)) then
                        --print(SMODS.get_enhancements(context.other_card))
                        print(SMODS.get_enhancements(context.other_card))
                        for enhancement, _ in ipairs(SMODS.get_enhancements(context.other_card)) do
                            print(enhancement)
                            if SMODS.has_enhancement(scored_card, enhancement) then
                                valid = false
                                break
                            end
                        end

                    elseif not next(SMODS.get_enhancements(scored_card)) then
                        valid = false
                    end
                end

                if not valid then
                    break
                end
            end

            if valid then -- Repeats the card if valid
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
}

SMODS.Joker{
    key = "reeflute",
    atlas = 'grasslanderJoker',
    config = { extra = {}},
    pos = { x = 2, y = 1 },
    rarity = 1,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then -- Triggers for cards held in hand
            if context.other_card.debuff then -- Prevents triggering if card is debuffed
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                -- Grants chips
                return {
                    chips = context.other_card:get_chip_bonus() * 2
                }
            end
        end
    end,
}

-- This is the sound used by Volcarox for eruption
SMODS.Sound ({
    key = 'erupt',
    path = 'volc_explosion.ogg',
})

SMODS.Joker{
    key = "volcarox",
    atlas = 'grasslanderJoker',  
    config = { extra = {draw = 10, active = false, d_remaining = 0} },
    pos = { x = 3, y = 1 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        if not context.blueprint and context.discard then -- Activates Volcarox, ensures that Blueprint is not affected
            card.ability.extra.active = true
        end

        if context.hand_drawn and card.ability.extra.active then -- This is the code for drawing extra cards
            if not context.blueprint then -- Ensures that Blueprint doesn't mess things up
                card.ability.extra.active = false
            end
            if G.GAME.current_round.discards_left <= card.ability.extra.d_remaining then
                return {
                    message = localize('k_erupt_ex'),
                    colour = G.C.RED,
                    sound = 'grasslanders_erupt',
                    func = function() -- This is for timing purposes, everything here runs after the message
                        SMODS.draw_cards(card.ability.extra.draw)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                save_run()
                                return true
                            end
                        }))
                    end,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.draw, card.ability.extra.d_remaining}, key = self.key }
    end
}

SMODS.Joker{
    key = "frogobonk",
    atlas = 'grasslanderJoker',
    config = { extra = {mult = 5}},
    pos = {x = 4, y = 2},
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=false,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if next(SMODS.get_enhancements(context.other_card))then
                if not context.blueprint and context.other_card:get_edition() then -- Check if card is Polychrome
                    SMODS.destroy_cards(card, nil, nil, true) -- Add an event to destroy Frogobonk
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{key = "j_grasslanders_lumobonk"}
                            return true
                        end
                    }))
                else
                    return {
                        mult = card.ability.extra.mult,
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult}, key = self.key }
    end
}

--[[
    SMODS.Joker{
        key = "altjunklake",
        atlas = 'grasslanderJoker',
        config = { extra = {dollars = 10}},
        pos = { x = 1, y = 1 },
        rarity = 2,
        cost = 5,
        blueprint_compat=false,
        eternal_compat=true,
        perishable_compat=true,
        unlocked = true,
         
        effect=nil,
        soul_pos=nil,

        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if 
                    context.other_card:get_id() == G.GAME.current_round.grasslanders_junklake_card.id and
                    context.other_card:is_suit(G.GAME.current_round.grasslanders_junklake_card.suit) 
                then   
                    SMODS.destroy_cards(context.other_card)
                    return {
                        dollars = card.ability.extra.dollars
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            local idol_card = G.GAME.current_round.grasslanders_junklake_card or { rank = 'Ace', suit = 'Spades' }
            return { vars = { card.ability.extra.dollars, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
        end,
    }
    ]]
SMODS.Joker{
    key = "junklake",
    atlas = 'grasslanderJoker',
    config = { extra = {dollars = 20, count = 0, threshold = 3, active = true}},
    pos = { x = 1, y = 1 },
    rarity = 1,
    cost = 5,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.end_of_round and context.main_eval then
                card.ability.extra.active = false
                card.ability.extra.count = 0
            end
            if context.setting_blind then
                card.ability.extra.active = true
                card.ability.extra.count = 0
            end

            if context.discard then
                local effects = {}
                if context.other_card:get_id() == G.GAME.current_round.grasslanders_junklake_card.id then
                    card.ability.extra.count = card.ability.extra.count + 1

                    if card.ability.extra.active and card.ability.extra.count < card.ability.extra.threshold then
                        return {
                            message = (card.ability.extra.count .. '/' .. card.ability.extra.threshold),
                            colour = G.C.MONEY,
                        }
                    end
                end
                if 
                    context.other_card == context.full_hand[#context.full_hand] and
                    card.ability.extra.count >= card.ability.extra.threshold and 
                    card.ability.extra.active 
                then
                    local target_cards = {}
                    for _, v in ipairs(G.playing_cards) do
                        if v:get_id() == G.GAME.current_round.grasslanders_junklake_card.id then
                            target_cards[#target_cards + 1] = v
                        end
                    end
                    for _, v in ipairs(target_cards) do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                draw_card(v, G.hand)
                                return true
                            end
                        }))
                    end
                    card.ability.extra.active = false
                    return {
                        dollars = card.ability.extra.dollars,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.destroy_cards(target_cards)
                                    return true
                                end
                            }))
                        end
                    }
                end

                return SMODS.merge_effects(effects)
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.grasslanders_junklake_card or { id = 1, rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.dollars, localize(idol_card.rank, 'ranks'), card.ability.extra.count, card.ability.extra.threshold} }
    end,
}

SMODS.Joker{
    key = "hornetrix",
    atlas = 'grasslanderJoker',
    config = { extra = {dollars = 5}},
    pos = { x = 1, y = 2 },
    rarity = 1,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=false,
    perishable_compat=true,
    unlocked = true,
     

    set_sprites = function(self, card, front)
        local alt = 1
        if grasslanders.config.althornetrix then
            card.children.center:set_sprite_pos({x=5,y=2})
        else
            card.children.center:set_sprite_pos({x=1,y=2})
        end
    end,

    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            local eaten_card = pseudorandom_element(G.consumeables.cards, 'grasslanders_hornetrix')
            if eaten_card then -- Checks if you do have a consumable card
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.dollars -- Increases Sell Value
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
        return { vars = {card.ability.extra.dollars}, key = self.key }
    end
}

SMODS.Joker{
    key = "anjellyze",
    atlas = 'grasslanderJoker',
    config = { extra = {}},
    pos = { x = 2, y = 2 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     

    calculate = function(self,card,context)
        -- Levels up the poker hand if it is correct
        if context.before then
            if context.scoring_name == G.GAME.current_round.anjellyze_hand then
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        local hand = G.GAME.current_round.anjellyze_hand or 'High Card'
        return {vars = {localize(hand, 'poker_hands')}, key = self.key }
    end
}

SMODS.Joker{
    key = "concrab", -- Old name used here, it was only changed in the localisation file.
    atlas = 'grasslanderJoker',
    config = { extra = {}},
    pos = { x = 4, y = 1 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        -- Gives Chips and Mult
        if context.joker_main then
            local effects = {
                {
                    chips = G.GAME.hands[G.GAME.current_round.plingit_hand].chips, 
                },
                {
                    mult = G.GAME.hands[G.GAME.current_round.plingit_hand].mult, 
                },
            }
            return SMODS.merge_effects(effects)
        end
    end,

    loc_vars = function(self, info_queue, card)
        local hand = G.GAME.current_round.plingit_hand or 'High Card' -- Allows Plingit to be viewable in collection
        return { vars = {
            localize(hand, 'poker_hands'),
            G.GAME.hands[hand].chips,
            G.GAME.hands[hand].mult
        }, key = self.key }
    end
}

SMODS.Joker{
    key = "chonkreep",
    atlas = 'grasslanderJoker',
    config = { extra = {reduction = 0.05, score_mod = 0, score_display = 0}},
    pos = { x = 3, y = 2 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     

    calculate = function(self,card,context)
        if context.pre_discard then
            card.ability.extra.score_mod = G.GAME.blind.chips * card.ability.extra.reduction
            card.ability.extra.score_display = G.GAME.blind.chips
        end
        if context.discard then
            G.GAME.blind.chips = G.GAME.blind.chips - card.ability.extra.score_mod
            G.E_MANAGER:add_event(Event({
                func = (function()
                    if context.other_card == context.full_hand[#context.full_hand] then
                        card.ability.extra.score_display = G.GAME.blind.chips
                    else
                        card.ability.extra.score_display = card.ability.extra.score_display - card.ability.extra.score_mod
                    end
                    G.GAME.blind.chip_text = number_format(card.ability.extra.score_display)
                    return true
                end)
            }))
            return {
                message = localize{type = 'variable', key='gl_chonkreep', vars={card.ability.extra.score}},
                delay = 0.2,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.reduction}, key = self.key }
    end
}

SMODS.Joker{
    key = "mossibug",
    atlas = 'grasslanderJoker',
    config = { extra = {chips = 0, chip_penalty = 10, chip_mod = 100}},
    pos = { x = 1, y = 3 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end

            if 
                context.final_scoring_step and 
                G.GAME.chips + SMODS.calculate_round_score() < G.GAME.blind.chips and 
                card.ability.extra.chips > 0 
            then
                if card.ability.extra.chips - card.ability.extra.chip_penalty > 0 then
                    card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_penalty
                else
                    card.ability.extra.chips = 0
                end

                return {
                    message = localize('gl_mossibug'),
                    colour = G.C.CHIPS
                }
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

SMODS.Joker{
    key = "tickini",
    config = { extra = {requirement = 0}},
    pos = { x = 1, y = 4},
    rarity = 3,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.after then
            if SMODS.calculate_round_score() >= card.ability.extra.requirement then
                card.ability.extra.requirement = SMODS.calculate_round_score()
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key_append = 'gl_tickini' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.PURPLE,
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.requirement}, key = self.key }
    end
}

SMODS.Sound ({
    key = 'breakstone',
    path = 'dw_shelly.ogg',
})

SMODS.Joker{
    key = "santile",
    config = { extra = {odds = 4, chips = 150}},
    pos = { x = 2, y = 3 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
        if context.after and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_stone') and SMODS.pseudorandom_probability(card, 'grasslanders_santile', 1, card.ability.extra.odds) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('grasslanders_breakstone', 1.0, 0.55)
                            return true
                        end
                    }))
                    SMODS.destroy_cards(scored_card)
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'grasslanders_santile')
        return { vars = {numerator, denominator, card.ability.extra.chips}, key = self.key }
    end
}

SMODS.Joker{
    key = "kracosteal",
    config = { extra = {dollars = 3, active = false}},
    pos = { x = 3, y = 3 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    atlas = 'grasslanderJoker',

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars}, key = self.key }
    end,

    calculate = function(self,card,context)
        if context.reroll_shop then
            if card.ability.extra.active then
                local refund
                if context.cost < card.ability.extra.dollars then
                    refund = context.card
                else
                    refund = card.ability.extra.dollars
                end

                return {
                    dollars = refund
                }
            elseif not context.blueprint then
                card.ability.extra.active = true
            end
        end
        if not context.blueprint then
            if context.buying_card then
                card.ability.extra.active = false
            end
            if context.starting_shop then
                card.ability.extra.active = true
            end
        end
    end,
    --[[
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
    ]]
}

SMODS.Joker{
    key = "wisplasm",
    config = { extra = {odds = 4}},
    pos = { x = 4, y = 3 },
    rarity = 2,
    cost = 7,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.reroll_shop and SMODS.pseudorandom_probability(card, 'gl_wisplasm', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        for i = #G.shop_booster.cards,1, -1 do
                            local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
                            c:remove()
                            c = nil
                        end
                        
                        for i = 1, G.GAME.starting_params.boosters_in_shop + (G.GAME.modifiers.extra_boosters or 0) - #G.shop_booster.cards do
                            local new_shop_card = SMODS.add_booster_to_shop()
                            new_shop_card:juice_up()
                        end

                        return true
                    end
                }))
                return {
                    message = localize{'gl_wisplasm'},
                    colour = G.C.GREEN
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gl_wisplasm") -- Gives the chances for Trizap. Modified by Oops All Sixes
        return { vars = {numerator,denominator}, key = self.key }
    end
    --[[
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
    ]]
}

SMODS.Joker{
    key = "cocotom",
    config = { extra = {x_mult = 1, x_mult_mod = 0.5, rounds = 20,}},
    pos = { x = 0, y = 3 },
    rarity = 3,
    cost = 9,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.buying_self then
            local eval = function(card) return card.ability.extra.rounds > 0 end
            juice_card_until(card,eval,true)
        end
        if not context.blueprint and card.ability.extra.rounds > 0 then
            if context.remove_playing_cards then 
                if #context.removed > 0 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (#context.removed * card.ability.extra.x_mult_mod)
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    }
                end
            end
            if context.after then
                card.ability.extra.rounds = card.ability.extra.rounds - 1
                if card.ability.extra.rounds <= 0 then
                    return {
                        message = localize('gl_cocotom_free'),
                        colour = G.C.MULT
                    }
                else
                    return {
                        message = localize{type = 'variable', key='gl_cocotom_countdown', vars={card.ability.extra.rounds}},
                        colour = G.C.MULT
                    }
                end
            end
        end
        if context.joker_main then
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

SMODS.Joker{
    key = "fortromtoise",
    config = { extra = {x_mult = 1, x_mult_mod = 0.2}},
    pos = { x = 3, y = 4 },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.discard then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult_mod}},
                    colour = G.C.MULT,
                    delay = 0.2
                }
            end
        end
        if context.joker_main then
            local effects = {
                {
                    x_mult = card.ability.extra.x_mult
                },
            }
            if not context.blueprint then
                card.ability.extra.x_mult = 1
                effects[#effects+1] = {
                    message = localize('k_reset'),
                    colour = G.C.MULT,
                }
            end

            return SMODS.merge_effects(effects)
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Joker{
    key = "axonitta",
    config = { extra = {}},
    pos = { x = 2, y = 4 },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.joker_main and not context.blueprint then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copied_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copied_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copied_card)
            G.hand:emplace(copied_card)
            copied_card.states.visible = nil
            SMODS.destroy_cards(context.full_hand[1])

            G.E_MANAGER:add_event(Event({
                func = function()
                    copied_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('gl_axonitta'),
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copied_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end,
}

SMODS.Joker{
    key = "ziffy",
    config = { extra = {booster_cost = 0}},
    pos = { x = 5, y = 3},
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.open_booster and not context.blueprint then
            card.ability.extra.booster_cost = context.card.cost
        end
        if context.skipping_booster then
            return {
                dollars = card.ability.extra.booster_cost
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {}, key = self.key }
    end
}

SMODS.Joker{
    key = "lumobonk",
    config = { extra = {x_mult = 2}},
    pos = { x = 4, y = 5 },
    rarity = 1,
    cost = 10,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    in_pool = function(self, args)
        return false
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_edition() then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult}, key = self.key }
    end
}

SMODS.Joker{
    key = "litabelle",
    config = { extra = {dollars = 0}},
    pos = { x = 0, y = 5 },
    rarity = 3,
    cost = 7,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    atlas = 'grasslanderJoker',
    calculate = function(self,card,context)
        if not context.blueprint then
            if context.selling_card and not context.selling_self then
                card.ability.extra.dollars = card.ability.extra.dollars + (context.card.sell_cost * 2)
                ease_dollars(-context.card.sell_cost, true)
                return {
                    message = localize("k_upgrade_ex"),
                    color = G.C.MONEY
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        if G.GAME.blind.boss then
            local dollars = card.ability.extra.dollars
            card.ability.extra.dollars = 0
            return dollars
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars}, key = self.key }
    end
}

SMODS.Joker{
    key = "erny",
    config = { extra = {x_mult = 1, x_mult_mod = 1, uphand = 'Straight Flush', hand1 = 'Straight', hand2 = 'Flush'}},
    pos = { x = 3, y = 5 },
    rarity = 2,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            if next(context.poker_hands[card.ability.extra.uphand]) then
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
            localize(card.ability.extra.hand2, 'poker_hands'),
            localize(card.ability.extra.uphand, 'poker_hands')
        }, key = self.key }
    end
}

SMODS.Joker{
    key = "emmie",
    config = { extra = {active = false}},
    pos = { x = 2, y = 5 },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    -- Emmie's function is done through a Hook, this specifies whether she is active or not
    calculate = function(self,card,context)
        if context.first_hand_drawn then
            card.ability.extra.active = true
            local eval = function() return card.ability.extra.active end
            juice_card_until(card, eval, true)
        end
        if (context.before and next(context.poker_hands['Straight'])) or (context.end_of_round and context.main_eval) then
            card.ability.extra.active = false
        end
    end,
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

SMODS.Joker{
    key = "edward",
    config = { extra = {chips = 0, chip_mod = 5, chosen_joker = 0, active = false}},
    pos = { x = 1, y = 5 },
    rarity = 3,
    cost = 9,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false, -- TODO: Test if Edward works when Perishable and with Perishable
    unlocked = true,
     
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if 
            context.debuff_card and 
            context.debuff_card.area == G.jokers and 
            context.debuff_card == G.jokers.cards[card.ability.extra.chosen_joker] and
            (type(context.debuff_card.config.center.grasslanders_edward_compat) == 'nil' or context.debuff_card.config.center.grasslanders_edward_compat)
        then
            return {debuff = true}
        end

        if not context.blueprint then
            if context.setting_blind then
                card.ability.extra.active = true
            end

            if context.end_of_round and context.game_over == false and context.main_eval then 
                card.ability.extra.active = false
            end

            if 
                (context.end_of_round and context.game_over == false and context.main_eval) or
                context.setting_blind or
                (context.card_added and context.cardarea == G.jokers) or
                (context.selling_card and context.cardarea == G.jokers) or
                (context.grasslanders_stop_drag and context.cardarea == G.jokers) or
                context.joker_type_destroyed
            then
                if card.ability.extra.active then
                    for k, v in pairs(G.jokers.cards) do
                        if v == card then
                            card.ability.extra.chosen_joker = k + 1
                            break
                        end
                    end
                else
                    card.ability.extra.chosen_joker = 0
                end

                for _,v in pairs(G.jokers.cards) do
                    local debuffed = v.debuff
                    SMODS.recalc_debuff(v)
                    if v.debuff ~= debuffed then
                        v:juice_up()
                    end
                end
            end

            
            if context.before then
                local cards = {}
                for _,v in ipairs(G.jokers.cards) do
                    table.insert(cards, v)
                end
                for _,v in ipairs(G.hand.cards) do
                    table.insert(cards, v)
                end
                for _,v in ipairs(context.scoring_hand) do
                    table.insert(cards, v)
                end

                local debuffed_cards = {}
                for _,v in ipairs(cards) do
                    if v.debuff then
                        debuffed_cards[#debuffed_cards + 1] = v
                    end
                end
                if #debuffed_cards > 0 then
                    card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * #debuffed_cards)

                    local effect = {}
                    for _,v in ipairs(debuffed_cards) do
                        effect[#effect + 1] = {
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        return true
                                    end
                                }))
                            end,
                        }
                        effect[#effect + 1] = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                            message_card = card,
                        }
                    end
                    return SMODS.merge_effects(effect)
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
        local compat_message = nil
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and (type(other_joker.config.center.grasslanders_edward_compat) == 'nil' or other_joker.config.center.grasslanders_edward_compat)
            compat_message = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
        end
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod}, main_end = compat_message }
    end
}

SMODS.Joker:take_ownership(
    'drunkard',
    {
	    grasslanders_edward_compat = false
    },
    true
)

SMODS.Joker:take_ownership(
    'merry_andy',
    {
	    grasslanders_edward_compat = false
    },
    true
)

SMODS.Joker{
    key = "vegebonion",
    config = { extra = {sell_value = 1, mult = 0, mult_mod = 2}},
    pos = { x = 0, y = 7 },
    rarity = 3,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',
    calculate = function(self,card,context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local effects = {}
            for _, area in ipairs({ G.jokers, G.consumeables }) do for _, other_card in ipairs(area.cards) do
                    local affected = false
                    if other_card.sell_cost > 0 and other_card ~= card then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) -
                            card.ability.extra.sell_value
                        other_card:set_cost()

                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                        affected = true
                    end

                    local getting_destroyed = false
                    if G.GAME.modifiers.gl_vegebonion and other_card.sell_cost <= 0 then
                        getting_destroyed = true
                        effects[#effects + 1] = {
                            func = function()
                                SMODS.destroy_cards(other_card)
                            end
                        }
                    end

                    if affected then
                        if not getting_destroyed then
                            effects[#effects + 1] = {
                                func = function()
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            other_card:juice_up()
                                            return true
                                        end
                                    }))
                                end
                            }
                        end
                        effects[#effects + 1] = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.RED,
                        }
                    end
            end end

            return SMODS.merge_effects(effects)
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.sell_value, card.ability.extra.mult_mod, card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Joker{
    key = "deespirr",
    config = { extra = {odds = 4}},
    pos = { x = 1, y = 7 },
    rarity = 2,
    cost = 8,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    atlas = 'grasslanderJoker',

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(card, 'grasslanders_deespirr', 1, card.ability.extra.odds) then
                    SMODS.destroy_cards(scored_card)
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "grasslanders_deespirr") -- Gives the chances for Trizap. Modified by Oops All Sixes
        return { vars = {numerator,denominator}, key = self.key }
    end
}

SMODS.Joker{
    key = "hyphilliacs",
    config = { extra = {repetitions = 2}},
    pos = { x = 2, y = 7 },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',
    
    calculate = function(self,card,context)
        if not context.blueprint then
            if context.debuff_card and context.debuff_card.gl_hyphilliacs_debuff then
                return {
                    debuff = true
                }
            end

            if context.debuff_hand and not context.check then
                local count = 0
                for _, other_card in ipairs(context.full_hand) do
                    local card_id = other_card:get_id()
                    if card_id == 13 or card_id == 12 then
                        local second_id = (card_id == 12 and 13) or 12
                        
                        local debuff = true
                        for _, second_card in ipairs(context.full_hand) do
                            local actual_second_id = second_card:get_id()
                            if actual_second_id == second_id then
                                debuff = false
                                break
                            end
                        end

                        if debuff then
                            count = count + 1

                            if G.GAME.modifiers.gl_hyphilliacs then
                                SMODS.destroy_cards(other_card)
                            else
                                other_card.gl_hyphilliacs_debuff = true
                                SMODS.recalc_debuff(other_card)
                            end
                            --[[
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.recalc_debuff(other_card)
                                    other_card:juice_up()
                                    return true
                                end
                            }))]]
                        end
                    end
                end
                if count > 0 then
                    return {
                        message = localize("k_debuffed"),
                        colour = G.C.RED
                    }
                end
            end
            if context.hand_drawn or (context.end_of_round and context.game_over == false and context.main_eval) then
                for _, other_card in ipairs(G.playing_cards) do
                    other_card.gl_hyphilliacs_debuff = nil
                    SMODS.recalc_debuff(other_card)
                end
            end
        end
    end,
}

SMODS.Joker{
    key = "sugamimi",
    config = { extra = {retriggers = 1, dollars = 3}},
    pos = { x = 0, y = 8 },
    rarity = 4,
    cost = 20,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
     
    effect=nil,
    soul_pos={ x = 0, y = 9 },
    atlas = 'grasslanderJoker',

    calculate = function(self,card,context)
        if context.other_card and context.other_card.seal then

            -- Gold Seal
            if context.other_card.seal ~= 'Gold' then
                if context.individual and context.cardarea == G.play then
                    return {
                        dollars = card.ability.extra.dollars,
                        message_card = context.other_card
                    }
                end
            end

            -- Blue Seal
            if context.other_card.seal ~= 'Blue' then
                if 
                    context.end_of_round and
                    context.individual and
                    context.cardarea == G.hand and
                    #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit 
                then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            if G.GAME.last_hand_played then
                                local _planet = nil
                                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                    if v.config.hand_type == G.GAME.last_hand_played then
                                        _planet = v.key
                                    end
                                end
                                if _planet then
                                    SMODS.add_card({ key = _planet })
                                end
                                G.GAME.consumeable_buffer = 0
                            end
                            return true
                        end
                    }))
                    return {
                        message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet,
                        message_card = context.other_card
                    }
                end
            end

            if context.other_card.seal ~= 'Purple' then
                if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            SMODS.add_card({ set = 'Tarot' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize('k_plus_tarot'), 
                        colour = G.C.PURPLE,
                        message_card = context.other_card
                    }
                end
            end

            -- Red Seal
            if context.other_card.seal ~= 'Red' then
                if context.repetition then
                    return {
                        repetitions = card.ability.extra.retriggers,
                        message_card = context.other_card
                    }
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS.Red
        info_queue[#info_queue + 1] = G.P_SEALS.Gold
        info_queue[#info_queue + 1] = G.P_SEALS.Blue
        info_queue[#info_queue + 1] = G.P_SEALS.Purple
    end
}

SMODS.Joker{
    key = "vacomar",  
    config = {extra = {card = {state = 'invalid', id = 0, rank = '', suit = ''}, discard_mod = 1, valid = false}},
    pos = { x = 1, y = 8},
    rarity = 4,
    cost = 20, -- This only affects the sell price, hence why it's listed here.
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
                                        --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos={ x = 1, y = 9},
    atlas = 'grasslanderJoker',                                --atlas name, single sprites are deprecated.

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
                            valid = SMODS.has_enhancement(discarded_card, 'm_stone')
                        else
                            valid = (discarded_card:get_id() == card.ability.extra.card.id) or discarded_card:is_suit(card.ability.extra.card.suit)
                        end
                    end

                    if valid then
                        ease_discard(card.ability.extra.discard_mod, nil, true)
                        return {
                            message = localize('a_discard_one'),
                            colour = G.C.RED
                        }
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