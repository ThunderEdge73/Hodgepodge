SMODS.Joker {
    key = "projectileboost",
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
            xmult_gain = 0.4,
            xmult_loss = 0.2,
            poker_hand = "Pair",
            banned_hands = {"High Card"}
        }
    },
    atlas = "jokers_atlas",
    pos = {x=6,y=HODGE.atlas_y.misc[1]},
    rarity = 3,
    cost = 5,
    calculate = function(self,card,context)
        if context.pre_discard and not context.blueprint then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if text == card.ability.extra.poker_hand then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                _poker_hands = {}
                for k,v in pairs(G.GAME.hands) do
                    if v.visible and k ~= card.ability.extra.poker_hand and not HODGE.table_contains(card.ability.extra.banned_hands,k) then
                        _poker_hands[#_poker_hands + 1] = k
                    end
                end
                card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,pseudoseed("projectileboost"))
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