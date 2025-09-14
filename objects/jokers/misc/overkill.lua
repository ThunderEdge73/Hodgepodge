SMODS.Joker {
    key = "overkill",
    -- loc_txt = {
    --     name = "Blown Away",
    --     text = {
    --         "If played hand contains a",
    --         "{C:attention}Straight{}, destroy highest",
    --         "scoring card and reduce",
    --         "blind by {C:attention}#1#%{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.score_req,
                card.ability.extra.xmult_loss,
                card.ability.extra.xmult
            }
        }
    end,
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 2,
            xmult_loss = 0.2,
            score_req = 2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=9,y=HODGE.atlas_y.misc[1]},
    rarity = 3,
    cost = 5,
    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            --print(G.GAME.chips/G.GAME.blind.chips)
            if G.GAME.chips/G.GAME.blind.chips >= card.ability.extra.score_req then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "+X"..card.ability.extra.xmult_gain
                }
            end
        end
        if context.after and context.main_eval and not context.blueprint then
            if card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
                return {
                    message = "-X"..card.ability.extra.xmult_loss
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    blueprint_compat = true, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','misc')
    end
}