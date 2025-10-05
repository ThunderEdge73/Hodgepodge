SMODS.Joker {
    key = "jovialmerriment",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.x_mult,
                G.GAME.round_scores.hand.amt
            }
        }
    end,
    config = {
        x_mult = 1,
        extra = {
            x_mult = 0.5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=3,y=HODGE.atlas_y.legendary[1]},
    soul_pos = {x=3,y=HODGE.atlas_y.soul[4]},
    rarity = 4,
    cost = 20,
    calculate = function(self,card,context)
        if context.after and context.cardarea == G.jokers then
            print(hand_chips * mult, G.GAME.round_scores.hand.amt)
            if hand_chips * mult >= G.GAME.round_scores.hand.amt then
                card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult
                return {
                    message = "+"..card.ability.extra.x_mult.."X"
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}
