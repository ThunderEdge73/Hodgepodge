SMODS.Joker {
    key = "shooketh",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult,
            }
        }
    end,
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 0.5,
        }
    },
    atlas = "jokers_atlas",
    pos = {x=10,y=HODGE.atlas_y.joke[1]},
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.after and context.main_eval and not context.blueprint then
            if (hand_chips * mult) < 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "+X"..card.ability.extra.xmult_gain
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

