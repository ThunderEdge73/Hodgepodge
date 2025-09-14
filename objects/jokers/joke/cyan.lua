SMODS.Joker {
    key = "cyan",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.chips,card.ability.extra.increase}
        }
    end,
    config = {
        chips = 0,
        extra = {
            increase = 2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=HODGE.atlas_y.joke[1]},
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.before and context.cardarea == G.jokers then
            for k, playing_card in ipairs(G.play.cards) do
                if not HODGE.table_contains(context.scoring_hand, playing_card) then
                    card.ability.chips = card.ability.chips + card.ability.extra.increase
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        playing_card:juice_up()
                    return true end}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!", colour = G.C.CHIPS})
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.chips
            }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

