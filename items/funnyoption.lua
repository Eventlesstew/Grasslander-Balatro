if grasslanders.config.clackerblinds > 1 then
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
end

--[[
SMODS.Joker:take_ownership('droll', {
        loc_txt = {
            ["name"] = "Drool Joker",
        },
    }
)]]

SMODS.Joker{
    key = "ddquad",
    config = { extra = {}},
    pos = { x = 0, y = 4 },
    rarity = 4,
    cost = 20,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'grasslanderJoker',

    in_pool = function(self, args)
        return false
    end,
}
