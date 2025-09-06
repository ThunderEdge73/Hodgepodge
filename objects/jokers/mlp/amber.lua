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
    pos = {x=3,y=REND.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit == "hodge_suns" then
                return { mult = 3, message_card = context.other_card }
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
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}