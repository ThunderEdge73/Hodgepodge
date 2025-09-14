SMODS.Joker {
    key = "amber",
    -- loc_txt = {
    --     name = "Summer Sun Celebration",
    --     text = {
    --         "Played cards with",
    --         "{C:hodge_suns}Sun{} suit give",
    --         "{C:mult}+3{} Mult when scored"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 5, 'amber')
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
    pos = {x=3,y=HODGE.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.joker_main then
            local suns = 0
            for k, playing_card in ipairs(context.scoring_hand) do
                if playing_card.base.suit == "hodge_suns" then
                    suns = suns + 1
                end
            end
            if SMODS.pseudorandom_probability(card, 'amber', suns, 5, 'amber') then
                ease_hands_played(1)
            end
        end
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card:is_suit("hodge_suns") then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','mlp')
    end
}