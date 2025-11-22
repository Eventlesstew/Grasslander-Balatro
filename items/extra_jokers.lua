SMODS.Atlas({
    key = "ogAnjellyze",
    path = "anjellyze.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "ogAnjellyze",
    config = { extra = {mult = 0, mult_mod = 4, hands = {}}},
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
        if context.before then
            local repeated_hand = false
            for _,h in ipairs(card.ability.extra.hands) do
                if context.scoring_name == h then
                    card.ability.extra.hands = {}
                    repeated_hand = true
                    break
                end
            end

            card.ability.extra.hands[#card.ability.extra.hands + 1] = context.scoring_name

            if repeated_hand then
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return{
                mult = card.ability.extra.mult * #card.ability.extra.hands
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        local hand_list = {}
        local total_mult = 0
        if #card.ability.extra.hands > 0 then
            total_mult = card.ability.extra.mult * #card.ability.extra.hands
            for _,h in ipairs(card.ability.extra.hands) do
                hand_list[#hand_list + 1] = localize(h, 'poker_hands')
            end
        else
            hand_list = {'bro'}
        end
        
        -- TODO: Figure out how to change the text part of Annie.
        info_queue[#info_queue + 1] = {set = "Other", key = "anjellyze_hands", text = hand_list}
        return { vars = {total_mult, card.ability.extra.mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "logoleaf",
    path = "logoleaf.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "logoleaf",                                  --name used by the joker.    
    config = { extra = {chips=0, chip_mod=20, chip_penalty=40} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0},                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'logoleaf',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.chip_penalty}, key = self.key }
    end
}

SMODS.Atlas({
    key = "buffslimester",
    path = "SLIMESTER.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "buffslimester",
    config = { extra = {x_mult=35, x_mult_mod=1}},
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
    atlas = 'buffslimester',

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult,card.ability.extra.x_mult_mod}, key = self.key }
    end
}