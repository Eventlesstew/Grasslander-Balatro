
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
            extra = { focus = self, message = localize('k_upgrade_ex') }, -- another way to show messages, not sure what's the difference.
        }
    end
end

SMODS.Atlas({
    key = "scorpibeat",
    path = "j_sample_wee.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "scorpibeat",                                  --name used by the joker.    
    config = { extra = {mult = 15} },    --variables used for abilities and effects.
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
    path = "j_sample_wee.png",
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
            if context.before then
                card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
                G.hand:change_size(card.ability.extra.h_mod)

                return {
                    message = localize{type = 'variable',key = 'a_handsize',vars = {card.ability.extra.h_mod}},
                    colour = G.C.FILTER
                }
            end
            if context.discard and context.other_card == context.full_hand[#context.full_hand] then
                if card.ability.extra.h_size > 0 then
                    card.ability.extra.h_size = card.ability.extra.h_size - card.ability.extra.h_mod
                    G.hand:change_size(-card.ability.extra.h_mod)

                    return {
                        message = localize{type = 'variable',key = 'a_handsize_minus',vars = {card.ability.extra.h_mod}},
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
        return { vars = {card.ability.extra.h_mod, card.ability.extra.h_size}, key = self.key }
    end
}

SMODS.Atlas({
    key = "molty",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "molty",                                  --name used by the joker.    
    config = { extra = {mult = 0, mult_mod = 5} },    --variables used for abilities and effects.
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
    atlas = 'molty',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.after and SMODS.calculate_round_score() > G.GAME.blind.chips then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                mult = card.ability.extra.mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.mult_mod, card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "volcarock",
    path = "j_sample_baroness.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "volcarock",                                  --name used by the joker.    
    config = { extra = {x_mult = 3, heat = 0, heat_mod = 1, heat_max = 3} },    --variables used for abilities and effects.
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
    atlas = 'volcarock',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.discard and context.other_card == context.full_hand[#context.full_hand] then
                card.ability.extra.heat = card.ability.extra.heat + card.ability.extra.heat_mod

                return {
                    message = localize('k_heat_ex'),
                    colour = G.C.RED
                }
            end
            if context.before then
                if card.ability.extra.heat > 0 and card.ability.extra.heat <= card.ability.extra.heat_max then
                    card.ability.extra.heat = card.ability.extra.heat - card.ability.extra.heat_mod

                    return {
                        message = localize('k_cool_ex'),
                        colour = G.C.CHIPS
                    }
                end
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.heat > card.ability.extra.heat_max then
                card.ability.extra.heat = 0
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.heat_mod, card.ability.extra.heat, card.ability.extra.heat_max, card.ability.extra.x_mult}, key = self.key }
    end
}