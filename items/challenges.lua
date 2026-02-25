SMODS.Challenge {
    key = 'trizap',
    jokers = {
        { id = 'j_grasslanders_trizap', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
    },
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 1 },
        }
    }
}

SMODS.Challenge {
    key = 'logobreak',
    jokers = {
        { id = 'j_grasslanders_logobreak', eternal = true},
        { id = 'j_grasslanders_blowy'},
    },
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
        }
    },
}

SMODS.Challenge {
    key = 'plingit',
    jokers = {
        { id = 'j_grasslanders_concrab', eternal = true },
        { id = 'j_grasslanders_concrab', eternal = true },
        { id = 'j_grasslanders_concrab', eternal = true },
    },
    rules = {
        modifiers = {
            { id = 'hands', value = 1 },
        }
    },
    restrictions = {
        banned_other = {
            {id = 'bl_grasslanders_matriarch', type = 'blind'},
        },
    },
}

SMODS.Challenge {
    key = 'junklake',
    jokers = {
        { id = 'j_grasslanders_junklake', eternal = true },
    },
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

            { s = 'H', r = 'K' },
            { s = 'H', r = 'Q' },
            { s = 'H', r = 'J' },
            { s = 'H', r = 'T' },
            { s = 'H', r = '9' },
            { s = 'H', r = '8' },
            { s = 'H', r = '7' },
            { s = 'H', r = '6' },
            { s = 'H', r = '5' },
            { s = 'H', r = '4' },
            { s = 'H', r = '3' },
            { s = 'H', r = '2' },
            { s = 'H', r = 'A' },

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

            { s = 'H', r = 'K' },
            { s = 'H', r = 'Q' },
            { s = 'H', r = 'J' },
            { s = 'H', r = 'T' },
            { s = 'H', r = '9' },
            { s = 'H', r = '8' },
            { s = 'H', r = '7' },
            { s = 'H', r = '6' },
            { s = 'H', r = '5' },
            { s = 'H', r = '4' },
            { s = 'H', r = '3' },
            { s = 'H', r = '2' },
            { s = 'H', r = 'A' },

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
    key = 'hornetrix',
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
        }
    },
    jokers = {
        { id = 'j_grasslanders_hornetrix'},
        { id = 'j_grasslanders_hornetrix'},
        { id = 'j_grasslanders_hornetrix'},
    },
    vouchers = {
        { id = 'v_tarot_merchant' },
        { id = 'v_tarot_tycoon' },
        { id = 'v_planet_merchant' },
        { id = 'v_planet_tycoon' },
        { id = 'v_crystal_ball' },
    },
}

SMODS.Challenge {
    key = 'santile',
    jokers = {
        { id = 'j_grasslanders_santile', eternal = true },
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_marble' },
            { id = 'j_vampire' },
            { id = 'j_midas_mask' },
            { id = 'j_certificate' },
            { id = 'c_magician' },
            { id = 'c_empress' },
            { id = 'c_heirophant' },
            { id = 'c_chariot' },
            { id = 'c_devil' },
            { id = 'c_justice' },
            { id = 'c_lovers' },
            { id = 'c_incantation' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
            { id = 'v_magic_trick' },
            { id = 'v_illusion' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
        },
        banned_tags = {
            { id = 'tag_standard' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        enhancement = 'm_stone'
    }
}

SMODS.Challenge {
    key = 'squid',
    jokers = {
        { id = 'j_grasslanders_kracosteal', eternal = true },
        { id = 'j_grasslanders_wisplasm', eternal = true },
        { id = 'j_grasslanders_ziffy', eternal = true },
    }
}

SMODS.Challenge {
    key = 'harparachnids',
    jokers = {
        { id = 'j_grasslanders_erny', eternal = true },
        { id = 'j_grasslanders_emmie', eternal = true },
        { id = 'j_grasslanders_edward', eternal = true },
    }
}

SMODS.Challenge {
    key = 'vegebonion',
    jokers = {
        { id = 'j_grasslanders_vegebonion', eternal = true },
    },
    rules = {
        custom = {
            {id = 'gl_vegebonion', value = true},
        }
    },
}

SMODS.Challenge {
    key = 'deespirr',
    jokers = {
        { id = 'j_grasslanders_deespirr', eternal = true },
        { id = 'j_oops', eternal = true, edition = 'negative' },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = 'K', e = 'm_glass'  },
            { s = 'S', r = 'Q', e = 'm_glass'  },
            { s = 'S', r = 'J', e = 'm_glass'  },
            { s = 'S', r = 'T', e = 'm_glass'  },
            { s = 'S', r = '9', e = 'm_glass'  },
            { s = 'S', r = '8', e = 'm_glass'  },
            { s = 'S', r = '7', e = 'm_glass'  },
            { s = 'S', r = '6', e = 'm_glass'  },
            { s = 'S', r = '5', e = 'm_glass'  },
            { s = 'S', r = '4', e = 'm_glass'  },
            { s = 'S', r = '3', e = 'm_glass'  },
            { s = 'S', r = '2', e = 'm_glass'  },
            { s = 'S', r = 'A', e = 'm_glass'  },

            { s = 'H', r = 'K' },
            { s = 'H', r = 'Q' },
            { s = 'H', r = 'J' },
            { s = 'H', r = 'T' },
            { s = 'H', r = '9' },
            { s = 'H', r = '8' },
            { s = 'H', r = '7' },
            { s = 'H', r = '6' },
            { s = 'H', r = '5' },
            { s = 'H', r = '4' },
            { s = 'H', r = '3' },
            { s = 'H', r = '2' },
            { s = 'H', r = 'A' },

            { s = 'C', r = 'K', e = 'm_glass'  },
            { s = 'C', r = 'Q', e = 'm_glass'  },
            { s = 'C', r = 'J', e = 'm_glass'  },
            { s = 'C', r = 'T', e = 'm_glass'  },
            { s = 'C', r = '9', e = 'm_glass'  },
            { s = 'C', r = '8', e = 'm_glass'  },
            { s = 'C', r = '7', e = 'm_glass'  },
            { s = 'C', r = '6', e = 'm_glass'  },
            { s = 'C', r = '5', e = 'm_glass'  },
            { s = 'C', r = '4', e = 'm_glass'  },
            { s = 'C', r = '3', e = 'm_glass'  },
            { s = 'C', r = '2', e = 'm_glass'  },
            { s = 'C', r = 'A', e = 'm_glass'  },

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
    key = 'hyphilliacs',
    jokers = {
        { id = 'j_grasslanders_hyphilliacs', eternal = true },
    },
    rules = {
        custom = {
            {id = 'gl_hyphilliacs', value = true},
        }
    },
}

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