SMODS.Joker {
    key = "spaghettification",
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
                G.GAME.probabilities.normal or 1
            }
        }
    end,
    config = {
        extra = {
        }
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=REND.atlas_y.misc[1]},
    rarity = 2,
    cost = 5,
    calculate = function(self,card,context)
        if context.modify_scoring_hand and not context.blueprint then
            if context.other_card == context.full_hand[#context.full_hand] then
                if not REND.table_contains(context.scoring_hand,context.other_card) then
                    card.ability.retrigger_target = context.other_card
                    return {
                        add_to_hand = true
                    }
                else
                    card.ability.retrigger_target = nil
                end
            end
        end
    end,
    blueprint_compat = false, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}