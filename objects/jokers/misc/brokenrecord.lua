SMODS.Joker {
    key = "brokenrecord",
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
                card.ability.extra.retriggers
            }
        }
    end,
    config = {
        extra = {
            retriggers = 3,
            retrigger_target = nil
        }
    },
    atlas = "jokers_atlas",
    pos = {x=1,y=REND.atlas_y.misc[1]},
    rarity = 1,
    cost = 5,
    calculate = function(self,card,context)
        if context.modify_scoring_hand and not context.blueprint then
            if context.other_card == context.full_hand[#context.full_hand] then
                if not REND.table_contains(context.scoring_hand,context.other_card) then
                    card.ability.extra.retrigger_target = context.other_card
                    return {
                        add_to_hand = true
                    }
                else
                    card.ability.extra.retrigger_target = nil
                end
            end
        end
        if context.repetition and context.cardarea == G.play and context.other_card == card.ability.extra.retrigger_target then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
    end,
    blueprint_compat = true, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}