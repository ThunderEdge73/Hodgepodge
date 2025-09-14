SMODS.Joker {
    key = "exploded",
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
                card.ability.extra.poker_hand,
                card.ability.extra.xmult_loss,
                card.ability.extra.xmult
            }
        }
    end,
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 0.2,
            xmult_loss = 0.2,
            poker_hand = "High Card"
        }
    },
    atlas = "jokers_atlas",
    pos = {x=7,y=HODGE.atlas_y.misc[1]},
    rarity = 3,
    cost = 5,
    calculate = function(self,card,context)
        if context.after and context.main_eval and not context.blueprint then
            if context.scoring_name == card.ability.extra.poker_hand then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "+X"..card.ability.extra.xmult_gain
                }
            else
                if card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
                    return {
                        message = "-X"..card.ability.extra.xmult_loss
                    }
                end
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