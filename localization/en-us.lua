return {
    descriptions = {
        Back = {
            b_grasslanders_gloom_deck = {
                name = "Gloom Deck",
                text = {
                    "All Cards are",
                    "{C:attention}Gloom{} cards"
                },
                unlock = {
                    "Win a run with",
                    "{C:attention}#1#{}",
                    "on any difficulty",
                }
            },
        },
        Enhanced = {
            m_grasslanders_gloom = {
                name = "Gloom Card",
                text = {
                    "This card does",
                    "nothing",
                },
            },
        },
        Blind = {
            bl_grasslanders_clacker = {
                name = "Small Blind",
                text = {
                },
            },
            bl_grasslanders_biter = {
                name = "Big Blind",
                text = {
                },
            },
            bl_grasslanders_spiker = {
                name = "The Spiker",
                text = {
                    "All Spade cards are",
                    "drawn face down",
                },
            },
            bl_grasslanders_clacklume = {
                name = "The Clacklume",
                text = {
                    "All Heart cards are",
                    "drawn face down",
                },
            },
            bl_grasslanders_wondertraps = {
                name = "The Wondertraps",
                text = {
                    "All Club cards are",
                    "drawn face down",
                },
            },
            bl_grasslanders_cruncher = {
                name = "The Cruncher",
                text = {
                    "All Diamond cards are",
                    "drawn face down",
                },
            },
            bl_grasslanders_observer = {
                name = "The Observer",
                text = {
                    "Cards played previously this",
                    "Ante are drawn face down",
                },
            },
            bl_grasslanders_tesloid = {
                name = "The Tesloid",
                text = {
                    "Sets base Mult",
                    "to 1",
                },
            },
        },
        Joker = {
            j_grasslanders_sprinkle = {
                name = "Sprinkle",
                text = {
                    "Played cards give",
                    "{C:chips}+#1# {}Chips if no",
                    "{C:attention}face {}cards are",
                    "held in hand",
                },
            },
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
                    "{C:attention}+#1# {}Hand size per discard",
                    "{C:attention}-#1# {}Hand size per hand played",
                    "this round",
                    "{C:inactive}(Currently {C:attention}#3##2# {C:inactive}Hand Size)"
                },
            },
            j_grasslanders_molty = {
                name = "Molty",
                text = {
                    "This Joker gains",
                    "{X:mult,C:white}X#2#{} Mult if played",
                    "hand is on {C:attention}fire",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },
            j_grasslanders_trizap = {
                name = "Trizap",
                text = {
                    "If a {C:attention}Joker {}is sold or",
                    "destroyed, creates an {C:attention}Eternal",
                    "copy with a random",
                    "{C:attention}enhancement",
                },
            },
            j_grasslanders_frogobonk = {
                name = "Frogobonk",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:attention}Enhanced {}card scored",
                    --[[
                    "Becomes {C:attention}Crazy {}if a",
                    "{C:dark_edition}Polychrome {}card is",
                    "scored",
                    ]]
                },
            },
            j_grasslanders_lumobonk = {
                name = "Lumobonk", -- Frbbngook
                text = {
                    "{X:mult,C:white}X#1#{} Mult for each",
                    "{C:attention}card {}scored",
                    "with an {C:attention}Edition",
                },
            },
            j_grasslanders_reeflute = {
                name = "Reeflute",
                text = {
                    "All {C:attention}cards {}held in",
                    "hand give their",
                    "base chip value"
                },
            },
            j_grasslanders_concrab = {
                name = "Concrab",
                text = {
                    "Grants Chips and Mult",
                    "of previous {C:attention}poker hand",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive})",
                    "{C:inactive}({C:chips}+#2# {C:inactive}Chips and {C:mult}+#3# {C:inactive}Mult)"
                },
            },
            j_grasslanders_anjellyze = {
                name = "Anjellyze",
                text = {
                    "This {C:attention}Joker{} gains",
                    "{C:mult}+#2#{} Mult if poker hand",
                    "is a {C:attention}#3#",
                    "poker hand changes",
                    "at end of round",
                    "{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult)"
                },
            },
            j_grasslanders_logobreak = {
                name = "Logobreak",
                text = {
                    "If played hand is",
                    "not on {C:attention}fire{},",
                    "{C:green}#1# in #2#{} chance to",
                    "create a {C:attention}Coupon Tag",
                    "at end of round",
                },
            },
            j_grasslanders_volcarox = {
                name = "Volcarox",
                text = {
                    "Draw {C:attention}#1#{} extra {C:attention}cards",
                    "when {C:attention}#2# {}discards",
                    "are remaining"
                },
            },
            j_grasslanders_junklake = {
                name = "Junklake",
                text = {
                    "Gives {C:money}$#1# {}if all {C:attention}#2#s",
                    "are {C:attention}played {}or {C:attention}discarded",
                    "Rank changes every round",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive}/{C:attention}#4#{C:inactive})"
                },
            },
            j_grasslanders_pricklea = {
                name = "Pricklea",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_hornetrix = {
                name = "Hornetrix",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroy a random {C:attention}Consumable",
                    "and add {C:money}quadruple {}its sell",
                    "value to it's own sell value",
                },
            },
            j_grasslanders_chonkreep = {
                name = "Chonkreep",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },

            j_grasslanders_mossibug = {
                name = "Mossibug",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}-#2#{} Chips after",
                    "played hand or discard",
                    "{C:chips}+#3#{} Chips when",
                    "{C:attention}Boss Blind{} is defeated"
                },
            },
            j_grasslanders_santile = {
                name = "Santile",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_penny = {
                name = "Penny",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },j_grasslanders_fortromtoise = {
                name = "Fortromtoise",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult for",
                    "each card {C:attention}discarded{}, resets",
                    "after this Joker scores",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },
            j_grasslanders_kracosteal = {
                name = "Kracosteal",
                text = {
                    "Each {C:attention}Steel {}card",
                    "held in hand gives {C:money}$#1#",
                    "at end of round"
                },
            },
            j_grasslanders_axonitta = {
                name = "Axonitta",
                text = {
                    "Gains {C:mult}+#2# {}Mult for",
                    "each consecutive {C:attention}#3#",
                    "played, resets and changes to a",
                    "different {C:attention}poker hand",
                    "if played",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
            },
            j_grasslanders_wisplasm = {
                name = "Wisplasm",
                text = {
                    "Each {C:attention}Gold {}card held",
                    "in hand gives {X:mult,C:white}X#1#{} Mult",
                },
            },
            j_grasslanders_tickini = {
                name = "Tickini",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_cocotom = {
                name = "Cocotom",
                text = {
                    "When inactive, gains {X:mult,C:white}X#2#{} Mult",
                    "when a {C:attention}playing card {}is destroyed",
                    "Activates after {C:attention}#3#{} rounds",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },

            j_grasslanders_triple9 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_triple10 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },

            j_grasslanders_litabelle = {
                name = "Litabelle",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            
            j_grasslanders_erny = {
                name = "Erny",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult if played",
                    "hand contains a {C:attention}#3#",
                    "and a {C:attention}#4#{}, resets if",
                    "hand contains neither",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },
            j_grasslanders_emmie = {
                name = "Emmie",
                text = {
                    "Allows first played {C:attention}Straight{}",
                    "to be made with gaps",
                    "of {C:attention}2 ranks",
                    "{C:inactive}(ex: {C:attention}10 7 6 4 2{C:inactive})",
                },
            },
            j_grasslanders_edward = {
                name = "Edward",
                text = {
                    "Disables {C:attention}Joker{} to the right",
                    "and gains {C:mult}+#2#{} Mult if it",
                    "attempts to trigger",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
            },

            j_grasslanders_quad3 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_quad4 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_quad5 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },

            j_grasslanders_vegebonion = {
                name = "Vegebonion",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_deespirr = {
                name = "Deespirr",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_hyphilliacs = {
                name = "Hyphilliacs",
                text = {
                    "Played {C:attention}Kings {}trigger all",
                    "{C:attention}Queens {}of the same suit,",
                    "but are debuffed if none",
                    "are played and {C:attention}vice versa",
                },
            },

            j_grasslanders_bad4 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_bad5 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },

            j_grasslanders_sugamimi = {
                name = "Sugamimi",
                text = {
                    "{X:mult,C:white}INCOMPLETE",
                },
            },
            j_grasslanders_vacomar = {
                name = "Vacomar",
                text = {
                    "{C:red}+#4# {}discard if all", 
                    "discarded cards match",
                    "the {C:attention}suit {}or {C:attention}rank {}of",
                    "first discarded card",
                    "of round",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}#2#{V:1}#3#{C:inactive})"
                },
            },
            j_grasslanders_synth3 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_synth4 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },
            j_grasslanders_synth5 = {
                name = "???",
                text = {
                    "{X:black,C:white}UNDISCLOSED"
                }
            },

            j_grasslanders_penny = {
                name = "Penny",
                text = {
                    "{X:red,C:white}INCOMPLETE"
                }
            },
            j_grasslanders_beezy = {
                name = "Beezies",
                text = {
                    "{X:red,C:white}INCOMPLETE"
                }
            },

            j_grasslanders_buffslimester = {
                name = "Slimester",
                text = {
                    "{X:red,C:white}X#2#{} Mult for each month",
                    "{C:attention}Dark Depths{} has been",
                    "in development for",
                    "{C:inactive}Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
        },
        Other = {
            g_onfire = {
                name = "Hand On Fire",
                text = {
                    "Occurs when {C:attention}played hand",
                    "scores greater than the",
                    "{C:attention}Blind{} score"
                },
            },
            --[[
            anjellyze_hands = {
                name = "Played Hands",
                text = {
                    ''
                }
            }
            ]]
        },
    },
    misc = {

            -- do note that when using messages such as: 
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file

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

            k_downgrade_ex='Downgrade!',

            a_discard_one="+1 Discard",
            a_active='Active!',

            k_trap='Trap',
            k_free='Free',
            k_free_ex='Free!',
            a_fled='Fled',
            a_left='#1# left',

            a_hand_chips = "+#1# Chips",
            a_hand_chips_minus = "-#1# Chips",

            k_heat_ex="Heat!",
            k_cool_ex="Cool!",
            k_erupt_ex="Erupt!",

            k_sleep_ex="Sleep!",
            k_awake_ex="Awake!",
            --anjellyze_none = "None",
        }
    }
}