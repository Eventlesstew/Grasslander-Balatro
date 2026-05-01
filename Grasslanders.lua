local lovely = require("lovely")

grasslanders = SMODS.current_mod
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end
local config = grasslanders.config

function grasslanders.save_config(self)
    SMODS.save_mod_config(self)
end

G.FUNCS.restart_game_smods = function(e)
	SMODS.restart_game()
end

G.FUNCS.joker_config = function(option_node)
    grasslanders.config.grasslanderJokers = option_node.cycle_config.current_option
    grasslanders:save_config()
end


G.FUNCS.deck_config = function(option_node)
    grasslanders.config.elementDecks = option_node.cycle_config.current_option
    grasslanders:save_config()
end

G.FUNCS.clacker_blind_config = function(option_node)
    grasslanders.config.clackerblinds = option_node.cycle_config.current_option
    grasslanders:save_config()
end

-- Config Tab
grasslanders.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			r = 0.1,
			align = "tl",
			padding = 0.2,
			colour = G.C.BLACK
		},
		nodes =  {
            {n = G.UIT.C, config = { align = "cl", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
                create_toggle({label = localize('gl_options_hornetrix'), ref_table = grasslanders.config, ref_value = "althornetrix", callback = function() grasslanders:save_config() end}),
                create_toggle({label = localize('gl_options_vanillaChallenges'), ref_table = grasslanders.config, ref_value = "vanillaChallenges", callback = function() grasslanders:save_config() end}),
                UIBox_button({label = {localize('gl_options_apply')}, minw = 3.5, button = 'restart_game_smods'}),
            }},
		}
	}
end

grasslanders.extra_tabs = function()
	return {

    -- Content Tab
    {label = localize('gl_options_contentTitle'), tab_definition_function = function()
    return {
        n=G.UIT.ROOT, 
        config = {
            emboss = 0.05,
            r = 0.1,
            align = "tl",
            padding = 0.2,
            colour = G.C.BLACK
        }, 
        nodes = {
            {n = G.UIT.C, config = {align = "cl", minw = G.ROOM.T.w*0, padding = 0.04 }, nodes = {
                create_option_cycle({ref_table = grasslanders.config, ref_value = "grasslanderJokers", opt_callback = 'joker_config', w = 4,
                    current_option = grasslanders.config.clackerblinds,
                    label = localize('gl_options_grasslanders'),
                    options = {
                        localize('gl_options_off'),
                        localize('gl_options_on'),
                    },
                }),
                create_option_cycle({ref_table = grasslanders.config, ref_value = "elementDecks", opt_callback = 'deck_config', w = 4,
                    current_option = grasslanders.config.clackerblinds,
                    label = localize('gl_options_elements'),
                    options = {
                        localize('gl_options_off'),
                        localize('gl_options_on'),
                    },
                }),
                create_option_cycle({ref_table = grasslanders.config, ref_value = "clackerblinds", opt_callback = 'clacker_blind_config', w = 4,
                    current_option = grasslanders.config.clackerblinds,
                    label = localize('gl_options_clackerblindtitle'),
                    options = {
                        localize('gl_options_off'),
                        localize('gl_options_on'),
                        localize('gl_options_clackerReplace'),
                    },
                }),
                create_option_cycle({ref_table = grasslanders.config, ref_value = "clackerblinds", opt_callback = 'clacker_blind_config', w = 4,
                    current_option = grasslanders.config.clackerblinds,
                    label = localize('gl_options_challenges'),
                    options = {
                        localize('gl_options_off'),
                        localize('gl_options_on'),
                        localize('gl_options_kaizochallenges'),
                    },
                }),
                UIBox_button({label = {localize('gl_options_apply')}, minw = 3.5, button = 'restart_game_smods'}),
            }},
        }
    }end},
}
end

for _,v in pairs({
    'grasslanderJokers',
    'clackerblinds',
    'elementDecks',
    'kaizochallenges'
}) do
    grasslanders.config[v] = (type(grasslanders.config[v]) == 'number' and grasslanders.config[v]) or 2 
end

assert(SMODS.load_file("items/game_globals.lua"))()
assert(SMODS.load_file("items/multirank.lua"))()
if grasslanders.config.vanillaChallenges then
    assert(SMODS.load_file("items/challenges_vanilla.lua"))()
end

-- Loads Clacker Blinds
if grasslanders.config.clackerblinds > 1 then
    assert(SMODS.load_file("items/blinds.lua"))()

    if grasslanders.config.kaizochallenges > 1 then
        assert(SMODS.load_file("items/challenges_gloom.lua"))()
    end
end

-- Loads Jokers
if grasslanders.config.grasslanderJokers > 1 then
    assert(SMODS.load_file("items/jokers.lua"))()

    if grasslanders.config.kaizochallenges > 1 then
        assert(SMODS.load_file("items/challenges.lua"))()
    end
end

-- Loads Decks
if grasslanders.config.elementDecks > 1 then
    assert(SMODS.load_file("items/decks.lua"))()

end

-- Loads Kaizo Challenges
if grasslanders.config.kaizochallenges > 2 then
    assert(SMODS.load_file("items/challenges_kaizo.lua"))()
end

assert(SMODS.load_file("items/funnystuff.lua"))()
--[[
if grasslanders.config.funny == true then
    assert(SMODS.load_file("items/funnystuff.lua"))()
end
]]