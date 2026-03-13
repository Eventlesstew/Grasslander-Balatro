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
            }
        },
    }, 
    true
)