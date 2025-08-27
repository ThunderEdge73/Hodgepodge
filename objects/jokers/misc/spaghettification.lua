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
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 4, 'spaghettification')
        return {
            vars = {
                numerator,
                denominator
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
    end,
    blueprint_compat = false, -- Work on this some more in the future to make it destroy more cards in sequence
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}