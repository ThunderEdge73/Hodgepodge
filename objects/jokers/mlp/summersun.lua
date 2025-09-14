SMODS.Joker {
    key = "summersun",
    -- loc_txt = {
    --     name = "Summer Sun Celebration",
    --     text = {
    --         "Played cards with",
    --         "{C:hodge_suns}Sun{} suit give",
    --         "{C:mult}+3{} Mult when scored"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=0,y=HODGE.atlas_y.mlp[1]},
    rarity = 1,
    cost = 5,
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
        badges[#badges+1] = HODGE.badge('category','mlp')
    end
}