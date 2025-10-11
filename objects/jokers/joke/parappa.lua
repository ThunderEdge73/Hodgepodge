SMODS.Joker {
    key = "parappa",
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
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'parappa')
        return {
            vars = {
                numerator,
                denominator,
            }
        }
    end,
    config = {
        extra = {
            retriggers_static = 1,
            numerator = 3,
            odds = 4
        }
    },
    atlas = "jokers_atlas",
    pos = {x=14,y=HODGE.atlas_y.joke[1]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'parappa', card.ability.extra.odds, card.ability.extra.odds, 'parappa') then
            return {
                repetitions = card.ability.extra.retriggers_static
            }
        end
    end,
    blueprint_compat = true,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}