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
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'parappa')
        return {
            vars = {
                numerator,
                denominator,
            }
        }
    end,
    config = {
        extra = {
            retriggers = 1,
            numerator = 3,
            denominator = 4
        }
    },
    atlas = "jokers_atlas",
    pos = {x=14,y=REND.atlas_y.joke[1]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'parappa', card.ability.extra.denominator, card.ability.extra.denominator, 'parappa') then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
    end,
    blueprint_compat = true,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}