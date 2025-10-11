SMODS.Joker {
    key = "shooketh",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.scaling_xmult,
            }
        }
    end,
    config = {
        extra = {
            scaling_xmult = 1,
            xmult_gain = 0.5,
        }
    },
    atlas = "jokers_atlas",
    pos = {x=10,y=HODGE.atlas_y.joke[1]},
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.after and context.main_eval and not context.blueprint then
            if (hand_chips * mult) < 0 then
                card.ability.extra.scaling_xmult = card.ability.extra.scaling_xmult + card.ability.extra.xmult_gain
                return {
                    message = "+X"..card.ability.extra.xmult_gain
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.scaling_xmult
            }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

