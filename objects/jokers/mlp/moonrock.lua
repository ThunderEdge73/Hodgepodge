SMODS.Joker {
    key = "moonrock",
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 5, 'moonrock')
        local example_count = 3
        return {
            vars = {
                numerator,
                denominator,
                example_count,
                numerator * example_count
            }
        }
    end,
    config = {
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
            if SMODS.pseudorandom_probability(card, 'moonrock', moons, 5, 'moonrock') then
                ease_discards(1)
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
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}