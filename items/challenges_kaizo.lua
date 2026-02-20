if grasslanders.config.clackerblinds > 1 then
    SMODS.Challenge {
        key = 'gloom_kaizo',
        button_colour = G.C.GOLD,
        deck = {
            enhancement = 'm_grasslanders_gloom',
        }
    }
end
if grasslanders.config.grasslanderJokers then
    SMODS.Challenge {
        key = 'plingitkaizo',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
        },
        rules = {
            modifiers = {
                { id = 'hands',       value = 1 },
                { id = 'discards',    value = 0 },
                { id = 'joker_slots', value = 15},
            },
            custom = {
                {id = 'gl_plingitkaizo', value = true},
            }
        },
        restrictions = {
            banned_other = {
                {id = 'bl_grasslanders_matriarch', type = 'blind'},
            },
        },
    }
end