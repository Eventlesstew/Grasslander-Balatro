return {
    descriptions = {
        Joker = {
            j_grasslanders_scorpibeat = {
                name = "Scorpibeat",
                text = {
                    "{C:mult}+#1# {}Mult when",
                    "{C:attention}Boss Blind {}is",
                    "selected"
                },
            },
            j_grasslanders_blowy = {
                name = "Blowy",
                text = {
                    "{C:attention}+#1# {}Hand size per hand played",
                    "{C:attention}-#1# {}Hand size per discard",
                    "this round",
                    "{C:inactive}Currently {C:attention}+#2# {C:inactive}Hand Size"
                },
            },
        }
    },
    misc = {

            -- do note that when using messages such as: 
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.


        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
        }
    }
}