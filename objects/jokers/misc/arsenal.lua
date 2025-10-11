SMODS.Joker {
    key = "arsenal",
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
                card.ability.extra.xmult_loss,
                card.ability.extra.scaling_xmult
            }
        }
    end,
    config = {
        extra = {
            scaling_xmult = 1,
            xmult_gain = 1,
            xmult_loss = 0.2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=8,y=HODGE.atlas_y.misc[1]},
    rarity = 3,
    cost = 5,
    calculate = function(self,card,context)
        if context.before and context.main_eval and not context.blueprint then
            local _suitcount = 0
            for suitname, suitdetails in pairs(SMODS.Suits) do
                for _, _pcard in ipairs(context.scoring_hand) do
                    if _pcard:is_suit(suitname) then
                        _suitcount = _suitcount + 1
                        break
                    end
                end
            end
            --print(_suitcount)
            if _suitcount >= 4 then
                card.ability.extra.scaling_xmult = card.ability.extra.scaling_xmult + card.ability.extra.xmult_gain
                return {
                    message = "+X"..card.ability.extra.xmult_gain
                }
            else
                if card.ability.extra.scaling_xmult > 1 then
                    card.ability.extra.scaling_xmult = card.ability.extra.scaling_xmult - card.ability.extra.xmult_loss
                    return {
                        message = "-X"..card.ability.extra.xmult_loss
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.scaling_xmult
            }
        end
    end,
    blueprint_compat = true, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','misc')
    end
}