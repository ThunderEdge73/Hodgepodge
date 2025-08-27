SMODS.Joker {
    key = "handcrank",
    loc_vars = function (self,info_queue,card)
        local current_val = (card.ability.chips >= 0 and "+" or "") .. card.ability.chips
        return {
            vars = {current_val,card.ability.extra.increase}
        }
    end,
    config = {
        chips = -20,
        extra = {
            start = -20,
            increase = 5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=1,y=REND.atlas_y.joke[1]},
    rarity = 1,
    cost = 3,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            local save_chips = card.ability.chips
            card.ability.chips = card.ability.extra.start
            return {
                chips = save_chips,
                message = "Reset!"
            }
        end
        if context.rend_clicked and context.card_clicked == card then
            card.ability.chips = card.ability.chips + card.ability.extra.increase
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..card.ability.extra.increase, colour = G.C.CHIPS, instant = true})
            -- return {
            --     message = "+"..card.ability.extra.increase
            -- }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

