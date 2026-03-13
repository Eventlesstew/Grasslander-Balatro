SMODS.Challenge:take_ownership(
    'typecast_1',
    {
        restrictions = {
            banned_other = {
                { id = 'bl_final_leaf', type = 'blind' },
                { id = 'bl_grasslanders_jawtrap', type = 'blind' },
            }
        }
    }, 
    true
)

SMODS.Challenge:take_ownership(
    'golden_needle_1',
    {
        restrictions = {
            banned_cards = {
                { id = 'j_burglar' },
                { id = 'v_grabber' },
                { id = 'v_nacho_tong' },
            },
            banned_other = {
                { id = 'bl_grasslanders_matriarch', type = 'blind' },
                { id = 'bl_grasslanders_leaper', type = 'blind' },
            }
        },
    }, 
    true
)

SMODS.Challenge:take_ownership(
    'jokerless_1',
    {
        restrictions = {
            banned_cards = {
                { id = 'c_judgement' },
                { id = 'c_wraith' },
                { id = 'c_soul' },
                { id = 'p_buffoon_normal_1', ids = {
                    'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1',
                }
                },
            },
            banned_tags = {
                { id = 'tag_uncommon' },
                { id = 'tag_rare' },
                { id = 'tag_negative' },
                { id = 'tag_foil' },
                { id = 'tag_holographic' },
                { id = 'tag_polychrome' },
                { id = 'tag_buffoon' },
                { id = 'tag_top_up' },
            },
            banned_other = {
                { id = 'bl_final_heart', type = 'blind' },
                { id = 'bl_final_leaf',  type = 'blind' },
                { id = 'bl_final_acorn', type = 'blind' },
                { id = 'bl_grasslanders_jawtrap', type = 'blind' },
                { id = 'bl_grasslanders_chomper', type = 'blind' },
                { id = 'bl_grasslanders_twinckler', type = 'blind' },
                { id = 'bl_grasslanders_radiochomper', type = 'blind' },
            }
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'mad_world_1',
    {
        restrictions = {
            banned_other = {
                { id = 'bl_plant', type = 'blind' },
                { id = 'bl_grasslanders_veguar', type = 'blind' },
            }
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'five_card_1',
    {
        restrictions = {
            banned_cards = {
                { id = 'j_juggler' },
                { id = 'j_troubadour' },
                { id = 'j_turtle_bean' },
                { id = 'j_grasslanders_blowy' },
                { id = 'j_grasslanders_volcarox' },
            }
        }
    },
    true
)