if grasslanders.config.grasslanderJokers then
    SMODS.Challenge {
        key = 'single',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_blowy', eternal = true },
            { id = 'j_grasslanders_scorpibeat', eternal = true },
            { id = 'j_grasslanders_sprinkle', eternal = true },
            { id = 'j_grasslanders_molty', eternal = true },
            { id = 'j_grasslanders_trizap', eternal = true },
        },
        rules = {
            modifiers = {
                { id = 'joker_slots', value = 6 },
            }
        }
    }

    SMODS.Challenge {
        key = 'double',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_logobreak', eternal = true },
            { id = 'j_grasslanders_pricklea', eternal = true },
            { id = 'j_grasslanders_reeflute', eternal = true },
            { id = 'j_grasslanders_volcarox', eternal = true },
            { id = 'j_grasslanders_frogobonk', eternal = true },
            { id = 'j_grasslanders_junklake', eternal = true },
            { id = 'j_grasslanders_hornetrix'},
            { id = 'j_grasslanders_anjellyze', eternal = true },
            { id = 'j_grasslanders_concrab', eternal = true },
            { id = 'j_grasslanders_chonkreep', eternal = true },
        },
        rules = {
            modifiers = {
                { id = 'joker_slots', value = 10 },
            }
        }
    }

    SMODS.Challenge {
        key = 'triple',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_mossibug', eternal = true },
            { id = 'j_grasslanders_tickini', eternal = true },
            { id = 'j_grasslanders_santile', eternal = true },
            { id = 'j_grasslanders_kracosteal', eternal = true },
            { id = 'j_grasslanders_wisplasm', eternal = true },
            { id = 'j_grasslanders_cocotom', eternal = true },
            { id = 'j_grasslanders_fortromtoise', eternal = true },
            { id = 'j_grasslanders_axonitta', eternal = true },
        },
        rules = {
            modifiers = {
                { id = 'joker_slots', value = 8 },
            }
        }
    }

    SMODS.Challenge {
        key = 'quad',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_litabelle', eternal = true },
            { id = 'j_grasslanders_erny', eternal = true },
            { id = 'j_grasslanders_emmie', eternal = true },
            { id = 'j_grasslanders_edward', eternal = true },
            { id = 'j_droll'},
        }
    }

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
                {id = 'bl_grasslanders_leaper', type = 'blind'},
            },
        },
    }

    SMODS.Challenge {
        key = 'volcaroxkaizo',
        button_colour = G.C.GOLD,
        jokers = {
            { id = 'j_grasslanders_volcarox', eternal = true },
            { id = 'j_grasslanders_volcarox', eternal = true },
            { id = 'j_grasslanders_volcarox', eternal = true },
            { id = 'j_grasslanders_volcarox', eternal = true },
            { id = 'j_grasslanders_volcarox', eternal = true },
        },
        rules = {
            modifiers = {
                { id = 'discards',    value = 1 },
            },
            custom = {
                {id = 'gl_plingitkaizo', value = true},
                { id = 'no_shop_jokers' },
            }
        },
    }
end

if grasslanders.config.clackerblinds > 1 then
    SMODS.Challenge {
        key = 'gloom_kaizo',
        button_colour = G.C.GOLD,
        deck = {
            enhancement = 'm_grasslanders_gloom',
        }
    }
end