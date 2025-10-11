SMODS.Joker {
    key = "moonrock",
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'moonrock')
        local example_count = 3
        return {
            vars = {
                card.ability.extra.discards_gain,
                numerator,
                denominator,
                example_count,
                numerator * example_count
            }
        }
    end,
    config = {
        extra = {
            odds = 5,
            numerator = 1,
            discards_gain = 1
        }
    },
    atlas = "jokers_atlas",
    pos = {x=4,y=HODGE.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.joker_main then
            local moons = 0
            for k, playing_card in ipairs(context.scoring_hand) do
                if playing_card.base.suit == "hodge_moons" then
                    moons = moons + 1
                end
            end
            if SMODS.pseudorandom_probability(card, 'moonrock', moons*card.ability.extra.numerator, card.ability.extra.odds, 'moonrock') then
                ease_discard(card.ability.extra.discards_gain)
            end
        end
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card:is_suit("hodge_moons") then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','mlp')
        badges[#badges+1] = HODGE.badge('credit','pumpkin')
    end
}