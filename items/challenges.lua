SMODS.Challenge {
    key = 'gloom',
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = 'K' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'T' },
            { s = 'S', r = '9' },
            { s = 'S', r = '8' },
            { s = 'S', r = '7' },
            { s = 'S', r = '6' },
            { s = 'S', r = '5' },
            { s = 'S', r = '4' },
            { s = 'S', r = '3' },
            { s = 'S', r = '2' },
            { s = 'S', r = 'A' },

            { s = 'H', r = 'K', e = 'm_grasslanders_gloom' },
            { s = 'H', r = 'Q', e = 'm_grasslanders_gloom' },
            { s = 'H', r = 'J', e = 'm_grasslanders_gloom' },
            { s = 'H', r = 'T', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '9', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '8', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '7', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '6', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '5', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '4', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '3', e = 'm_grasslanders_gloom' },
            { s = 'H', r = '2', e = 'm_grasslanders_gloom' },
            { s = 'H', r = 'A', e = 'm_grasslanders_gloom' },

            { s = 'C', r = 'K' },
            { s = 'C', r = 'Q' },
            { s = 'C', r = 'J' },
            { s = 'C', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'C', r = '8' },
            { s = 'C', r = '7' },
            { s = 'C', r = '6' },
            { s = 'C', r = '5' },
            { s = 'C', r = '4' },
            { s = 'C', r = '3' },
            { s = 'C', r = '2' },
            { s = 'C', r = 'A' },

            { s = 'D', r = 'K' },
            { s = 'D', r = 'Q' },
            { s = 'D', r = 'J' },
            { s = 'D', r = 'T' },
            { s = 'D', r = '9' },
            { s = 'D', r = '8' },
            { s = 'D', r = '7' },
            { s = 'D', r = '6' },
            { s = 'D', r = '5' },
            { s = 'D', r = '4' },
            { s = 'D', r = '3' },
            { s = 'D', r = '2' },
            { s = 'D', r = 'A' },
        }
    }
}

SMODS.Challenge {
    key = 'vegebonion',
    jokers = {
        { id = 'j_grasslanders_vegebonion', eternal = true },
    }
}

SMODS.Challenge {
    key = 'deespirr',
    jokers = {
        { id = 'j_grasslanders_deespirr', eternal = true },
    }
}

SMODS.Challenge {
    key = 'hyphilliacs',
    jokers = {
        { id = 'j_grasslanders_hyphilliacs', eternal = true },
    },
    rules = {
        custom = {
            {id = 'gl_hyphilliacs', value = true},
        }
    },
    restrictions = {
        banned_cards = {
            {id = 'j_ride_the_bus'},
            {id = 'j_grasslanders_sprinkle'},
            {id = 'j_pareidolia'},
        },
        banned_other = {
            {id = 'bl_plant', type = 'blind'},
            {id = 'bl_mark', type = 'blind'},
            {id = 'bl_grasslanders_veguar', type = 'blind'},
        },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },

            { s = 'C', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'S', r = 'Q' },

            { s = 'C', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'S', r = 'Q' },

            { s = 'C', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'S', r = 'Q' },
        }
    }
}

function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        if G.GAME.modifiers.gl_hyphilliacs then
            G.GAME.starting_params.ante_scaling = 2
        end
    end
end

SMODS.Challenge {
    key = 'sugamimi',
    jokers = {
        { id = 'j_grasslanders_sugamimi', eternal = true },
    }
}

SMODS.Challenge {
    key = 'vacomar',
    jokers = {
        { id = 'j_grasslanders_vacomar', eternal = true },
    }
}

SMODS.Challenge {
    key = 'gloom_kaizo',
    deck = {
        enhancement = 'm_grasslanders_gloom',
    }
}