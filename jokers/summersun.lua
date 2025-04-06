SMODS.Joker {
    key = "summersun",
    loc_txt = {
        name = "Summer Sun Celebration",
        text = {
            "Played cards with",
            "{C:rendom_suns}Sun{} suit give",
            "{C:mult}+3{} Mult when scored"
        }
    },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=3,y=0},
    rarity = 1,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit == "rendom_suns" then
                return { mult = 3 }
            end
        end
    end,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card:is_suit("rendom_suns") then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}