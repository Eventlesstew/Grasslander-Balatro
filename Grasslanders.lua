local lovely = require("lovely")

assert(SMODS.load_file("globals.lua"))()

grasslanders = SMODS.current_mod
if NFS.read(SMODS.current_mod.path.."config.lua") then
    local file = STR_UNPACK(NFS.read(SMODS.current_mod.path.."config.lua"))
    grasslanders.config_path = SMODS.current_mod.path.."config.lua"
    grasslanders.config_file = file
end

G.FUNCS.restart_game_smods = function(e)
	SMODS.restart_game()
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
            create_toggle({
                align = "tl",
                label = "Grasslander Jokers",
                ref_table = grasslanders.config_file,
                ref_value = "grasslanderJokers",
                callback = function(_set_toggle)
                    grasslanders.config_file.grasslanderJokers = _set_toggle
                    grasslanders.config.grasslanderJokers = _set_toggle
                    NFS.write(grasslanders.config_path, STR_PACK(grasslanders.config_file))
                end
            }),
            create_toggle({
                align = "tl",
                label = "Censor Hornetrix",
                ref_table = grasslanders.config_file,
                ref_value = "althornetrix",
                callback = function(_set_toggle)
                    grasslanders.config_file.althornetrix = _set_toggle
                    grasslanders.config.althornetrix = _set_toggle
                    NFS.write(grasslanders.config_path, STR_PACK(grasslanders.config_file))
                end
            }),
            create_toggle({
                align = "tl",
                label = "Clacker Blinds",
                ref_table = grasslanders.config_file,
                ref_value = "clackerblinds",
                callback = function(_set_toggle)
                    grasslanders.config_file.clackerblinds = _set_toggle
                    grasslanders.config.clackerblinds = _set_toggle
                    NFS.write(grasslanders.config_path, STR_PACK(grasslanders.config_file))
                end
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
if grasslanders.config_file.grasslanderJokers then
    assert(SMODS.load_file("items/jokers.lua"))()
end
if grasslanders.config_file.clackerblinds then
    assert(SMODS.load_file("items/blinds.lua"))()
end