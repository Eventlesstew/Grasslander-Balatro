local perform_checks = function(table1, op, table2, mod)
    for i, v in ipairs(table1) do
        for ii, vv in ipairs(table2) do
            if op == "==" and v == vv then return true end
            if op == "~=" and v ~= vv then return true end
            if op == ">" and v > vv then return true end
            if op == ">=" and v >= vv then return true end
            if op == "<" and v < vv then return true end
            if op == "<=" and v <= vv then return true end
            if op == "mod" and v % vv == mod then return true end
            if type(op) == "function" and op(v, vv) then return true end
        end
    end
    return false
end

local function tc(t, e)
    if t and type(t) == "table" then
        for _, v in pairs(t) do
            if v == e then
                return true
            end
        end
    end
    return false
end

local get_ids = function(card, extra_only)
    if not G.deck then return {card:get_id()} end
    local ids = {}
    --[[for i, v in ipairs(card.ability.soe_quantum_ranks or {}) do
        ids[#ids+1] = SMODS.Ranks[v].id
    end]]
    if not extra_only then
        if not tc(ids, card:get_id()) then
            table.insert(ids, 1, card:get_id())
        end
    end

    -- This is where we do the card modifications
    if next(SMODS.find_card('j_grasslanders_hyphilliacs')) then
        local card_id = card:get_id()
        if card_id == 13 then
            table.insert(ids, 12)
        elseif card_id == 12 then
            table.insert(ids, 13)
        end
    end

    return ids
end

local ids_op_ref = ids_op
function ids_op(card, op, b, c)
    local id = card:get_id()
    if not id then return false end
    local other_results = false
    if ids_op_ref ~= nil then
        other_results = ids_op_ref(card, op, b, c)
    end

    local function alias(x)
        local ids = {[id] = true}
        for i, v in ipairs(get_ids(card)) do
            ids[v] = true
        end
        if ids[x] then return '11' end
        return x
    end

    if other_results == true then
        return true
    end

    if op == "mod" then
        return perform_checks(get_ids(card), "mod", {b}, c)
    end

    if op == "==" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs == rhs
    end
    if op == "~=" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs ~= rhs
    end

    if op == ">=" then return perform_checks(get_ids(card), ">=", {b}) end
    if op == "<=" then return perform_checks(get_ids(card), "<=", {b}) end
    if op == ">" then return perform_checks(get_ids(card), ">", {b}) end
    if op == "<" then return perform_checks(get_ids(card), "<", {b}) end

    error("ids_op: unsupported op " .. tostring(op))
end

-- Handles same cards
-- TODO: Make it so you can only get one or the other with the ranks.
--[[
local oldgetxsame = get_X_same
function get_X_same(num, hand, or_more)
    local passed = false
    for _, v in ipairs(hand) do
        if next(get_ids(v, true)) then
            passed = true
            break
        end
    end
    if not passed then return oldgetxsame(num, hand, or_more) end
    local vals = {}
    for i = 1, SMODS.Rank.max_id.value do
        vals[i] = {}
    end
    vals[#vals+1] = {}
    for i=#hand, 1, -1 do
        local curr_ranks = get_ids(hand[i])
        for _, rank in ipairs(curr_ranks) do
            local curr_group = vals[rank]
            if not curr_group then
                curr_group = {}
                vals[rank] = curr_group
            end
            curr_group[#curr_group+1] = hand[i]
        end
    end
    local ret = {}
    for i = #vals, 1, -1 do
        local group = vals[i]
        if #group >= num or (or_more and #group > num) then
            ret[#ret+1] = group
        end
    end
    return ret
end

-- Handles getting straights
local oldgetstraight = get_straight
function get_straight(hand, min_length, skip, wrap)
    local passed = false
    for i, v in ipairs(hand) do
        if get_ids(v, true)[1] then
            passed = true
            break
        end
    end
    if not passed then return oldgetstraight(hand, min_length, skip) end
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    for k, _ in pairs(SMODS.Ranks) do ranks[k] = {} end
    for _, card in ipairs(hand) do
        local card_ids = get_ids(card)
        local card_ranks = {}
        for i, v in ipairs(card_ids) do
            for k, vv in pairs(SMODS.Ranks) do
                if vv.id == v then
                    table.insert(card_ranks, vv.key)
                    break
                end
            end
        end
        for _, rank in ipairs(card_ranks) do
            table.insert(ranks[rank], card)
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
        if not start and not wrap and rank.straight_edge then return ret end
        for _, v in ipairs(rank.next) do
            ret[#ret + 1] = v
            if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
                for _, w in ipairs(SMODS.Ranks[v].next) do
                    ret[#ret + 1] = w
                end
            end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _, k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) then
            tuples[#tuples + 1] = { k }
        end
    end
    for i = 2, #hand + 1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i ~= #hand + 1 then
                for _, l in ipairs(next_ranks(tuple[i - 1], i == 2)) do
                    if next(ranks[l]) then
                        local new_tuple = {}
                        for _, v in ipairs(tuple) do new_tuple[#new_tuple + 1] = v end
                        new_tuple[#new_tuple + 1] = l
                        new_tuples[#new_tuples + 1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i > min_length and not any_tuple then
                local straight = {}
                for _, v in ipairs(tuple) do
                    for _, card in ipairs(ranks[v]) do
                        straight[#straight + 1] = card
                    end
                end
                ret[#ret + 1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a, b) return #a > #b end)
    return ret
end]]