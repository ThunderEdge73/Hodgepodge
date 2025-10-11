SMODS.Joker {
    key = "handcrank",
    loc_vars = function (self,info_queue,card)
        local current_val = (card.ability.extra.scaling_chips >= 0 and "+" or "") .. card.ability.extra.scaling_chips
        return {
            vars = {current_val,card.ability.extra.chip_gain}
        }
    end,
    config = {
        extra = {
            base_chips = -20,
            scaling_chips = -20,
            chip_gain = 5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=1,y=HODGE.atlas_y.joke[1]},
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.joker_main then
            local save_chips = card.ability.extra.scaling_chips
            if not context.blueprint then
                card.ability.extra.scaling_chips = card.ability.extra.base_chips
            end
            return {
                chips = save_chips,
                message = not context.blueprint and "Reset!" or nil
            }
        end
        if context.hodge_clicked and context.card_clicked == card and not context.blueprint then
            card.ability.extra.scaling_chips = card.ability.extra.scaling_chips + card.ability.extra.chip_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..card.ability.extra.chip_gain, colour = G.C.CHIPS, instant = true})
            -- return {
            --     message = "+"..card.ability.extra.chip_gain
            -- }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

