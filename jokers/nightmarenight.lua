SMODS.Joker {
    key = "nightmarenight",
    loc_txt = {
        name = "Nightmare Night",
        text = {
            "Played cards with",
            "{C:rendom_moons}Moon{} suit give",
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
    pos = {x=4,y=0},
    rarity = 1,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit == "rendom_moons" then
                return { mult = 3 }
            end
        end
    end,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card:is_suit("rendom_moons") then
                return true
            end
        end
        return false
    end
}