SMODS.Back {
    key = "energy",
    atlas = "grasslanderJoker",
    pos = { x = 4, y = 0 },
    unlocked = true,
    apply = function(self, back)
        G.GAME.modifiers.gl_boss_rush = true
    end,
}