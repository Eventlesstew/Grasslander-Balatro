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
                create_toggle({label = localize('gl_options_grasslanders'), ref_table = grasslanders.config, ref_value = "grasslanderJokers", callback = function() grasslanders:save_config() end}),
                --create_toggle({label = localize('gl_options_funny'), ref_table = grasslanders.config, ref_value = "funny", callback = function() grasslanders:save_config() end}),
                create_option_cycle({ref_table = grasslanders.config, ref_value = "clackerblinds", opt_callback = 'clacker_blind_config', w = 4,
                    current_option = grasslanders.config.clackerblinds,
                    label = localize('gl_options_clackerblindtitle'),
                    options = {
                        localize('gl_options_clackerblind0'),
                        localize('gl_options_clackerblind1'),
                        localize('gl_options_clackerblind2'),
                    },
                }),
                create_toggle({label = localize('gl_options_kaizochallenges'), ref_table = grasslanders.config, ref_value = "kaizochallenges", callback = function() grasslanders:save_config() end}),
                UIBox_button({label = {localize('gl_options_apply')}, minw = 3.5, button = 'restart_game_smods'}),
            }},
		}
	}
end

--[[
grasslanders.extra_tabs = function()
	return {

    -- Advanced Tab
    {label = localize('gl_options_performanceTitle'), tab_definition_function = function()
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
                create_toggle({label = localize('gl_options_kaizochallenges'), info = localize('gl_options_kaizochallenges_info'), ref_table = grasslanders.config, ref_value = "kaizochallenges", callback = function() grasslanders:save_config() end}),
                UIBox_button({label = {localize('gl_options_apply')}, minw = 3.5, button = 'restart_game_smods'}),
            }},
        }
    }end},

    -- Experimental Tab
    --[[{label = localize('gl_options_experimentalTitle'), tab_definition_function = function()
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
                create_toggle({label = localize('gl_options_kaizochallenges'), info = localize('gl_options_kaizochallenges_info'), ref_table = grasslanders.config, ref_value = "kaizochallenges", callback = function() grasslanders:save_config() end}),
                UIBox_button({label = {localize('gl_options_apply')}, minw = 3.5, button = 'restart_game_smods'}),
            }},
        }
    }end},
}
end]]

if type(grasslanders.config.althornetrix) == 'nil' then
    grasslanders.config.althornetrix = false
end
if type(grasslanders.config.kaizochallenges) == 'nil' then
    grasslanders.config.kaizochallenges = false
end

assert(SMODS.load_file("items/game_globals.lua"))()
assert(SMODS.load_file("items/multirank.lua"))()

-- Loads Jokers
if type(grasslanders.config.grasslanderJokers) == 'nil' then
    grasslanders.config.grasslanderJokers = true
end

if grasslanders.config.grasslanderJokers == true then
    assert(SMODS.load_file("items/jokers.lua"))()
    assert(SMODS.load_file("items/challenges.lua"))()
end

-- Loads Clacker Blinds
if not grasslanders.config.clackerblinds or type(grasslanders.config.clackerblinds) == 'boolean' then
    grasslanders.config.clackerblinds = 1
end

if grasslanders.config.clackerblinds > 1 then
    assert(SMODS.load_file("items/blinds.lua"))()
end

-- Disables Base Blinds
if grasslanders.config.clackerblinds >= 3 then
    local add_to_pool_ref = SMODS.add_to_pool
    SMODS.add_to_pool = function(prototype_obj, args)
        if prototype_obj.key:sub(1, 2) == "bl" and not prototype_obj.original_mod then
            return false
        end
        return add_to_pool_ref(prototype_obj, args)
    end
end

--[[
if grasslanders.config.funny == true then
    assert(SMODS.load_file("items/funnyoption.lua"))()
end
]]