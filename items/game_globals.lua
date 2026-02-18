SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
}

-- Changes the hand used by all Anjellyze and Concrab Jokers
local function gl_reroll_hands(plingit_hand)
    G.GAME.current_round.plingit_hand = plingit_hand

    local _poker_hands = {}

    -- This filters out all Poker hands that are invisible (Foak, Flush House and Flush Five) and the hand Anjellyze already has.
    -- This prevents Anjellyze from rerolling to them
    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and handname ~= G.GAME.current_round.anjellyze_hand then
            _poker_hands[#_poker_hands + 1] = handname
        end
    end

    G.GAME.current_round.anjellyze_hand = pseudorandom_element(_poker_hands, 'gl_anjellyze')
end

local function reset_grasslanders_junklake_card()
    G.GAME.current_round.grasslanders_junklake_card = { rank = 'Ace', suit = 'Spades' }
    local valid_idol_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_idol_cards[#valid_idol_cards + 1] = playing_card
        end
    end

    local idol_card = pseudorandom_element(valid_idol_cards, 'gl_junklake' .. G.GAME.round_resets.ante)
    if idol_card then
        G.GAME.current_round.grasslanders_junklake_card.rank = idol_card.base.value
        G.GAME.current_round.grasslanders_junklake_card.suit = idol_card.base.suit
        G.GAME.current_round.grasslanders_junklake_card.id = idol_card.base.id
    end
end

function grasslanders.reset_game_globals(run_start)
    if run_start then
        if G.GAME.modifiers.gl_plingitkaizo then
            G.GAME.starting_params.ante_scaling = 5
        end

        gl_reroll_hands('High Card') -- Plingit defaults to High Card at the start of the run
    end

    reset_grasslanders_junklake_card()
end

function grasslanders.calculate(self, context)
    if context.after then
        gl_reroll_hands(context.scoring_name)
    end
end

function grasslanders.alert_debuff(blind, add, text)
    if add and not blind.boss_warning_text then
        blind.get_loc_debuff_text = function ()
            return text
        end
        blind.boss_warning_text = UIBox{
        definition = 
            {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
            {n=G.UIT.R, config = {align = 'cm', maxw = 1}, nodes={
                {n=G.UIT.O, config={object = DynaText({scale = 0.7, string = text, maxw = 9, colours = {G.C.WHITE},float = true, shadow = true, silent = true, pop_in = 0, pop_in_rate = 6})}},
            }},
            --[[{n=G.UIT.R, config = {align = 'cm', maxw = 1}, nodes={
                {n=G.UIT.O, config={func = "update_blind_debuff_text", object = DynaText({scale = 0.6, string = text, maxw = 9, colours = {G.C.WHITE},float = true, shadow = true, silent = true, pop_in = 0, pop_in_rate = 6})}},
            }}]]
        }},
        config = {
            align = 'cm',
            offset ={x=0,y=-3.1}, 
            major = G.play,
            }
        }
        blind.boss_warning_text.attention_text = true
        blind.boss_warning_text.states.collide.can = false
        if SMODS.hand_debuff_source then
            SMODS.hand_debuff_source:juice_up(0.05, 0.1)
        else
            G.GAME.blind.children.animatedSprite:juice_up(0.05, 0.02)
        end
        play_sound('chips1', math.random()*0.1 + 0.55, 0.12)
    elseif not add then
        if blind.boss_warning_text then 
            blind.boss_warning_text:remove()
            blind.boss_warning_text = nil
        end
    end
end