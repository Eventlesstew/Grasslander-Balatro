local lovely = require("lovely")

grasslanders = SMODS.current_mod
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
            create_toggle({label = localize('gl_options_hornetrix'), ref_table = grasslanders.config, ref_value = "althornetrix", callback = function() grasslanders:save_config() end}),
            create_toggle({label = localize('gl_options_grasslanders'), ref_table = grasslanders.config, ref_value = "grasslanderJokers", callback = function() grasslanders:save_config() end}),
            create_option_cycle({ref_table = grasslanders.config, ref_value = "clackerblinds", opt_callback = 'clacker_blind_config', w = 4,
                current_option = grasslanders.config.clackerblinds,
                label = localize('gl_options_clackerblindtitle'),
                options = {
                    localize('gl_options_clackerblind0'),
                    localize('gl_options_clackerblind1'),
                    localize('gl_options_clackerblind2'),
                },
            }),
            UIBox_button({
                align = "tl",
                label = { "Apply Changes" }, 
                minw = 3.5,
                button = 'restart_game_smods'
			}),
		}
	}
end

assert(SMODS.load_file("items/icon.lua"))()

if grasslanders.config.grasslanderJokers == true then
    assert(SMODS.load_file("items/jokers.lua"))()
end
if grasslanders.config.clackerblinds > 0 then
    assert(SMODS.load_file("items/blinds.lua"))()
end