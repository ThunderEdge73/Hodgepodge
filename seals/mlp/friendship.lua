SMODS.Seal {
    key = "friendship",
    badge_colour = HEX("F083B0"),
    config = {
        extra = 2
    },
    loc_txt = {
        label = "Element of Friendship",
        name = "Element of Friendship",
        text = {
            "{C:chips}+10{} Chips for every",
            "{C:attention}Element of Harmony{}",
            "in your full deck"
        }
    },
    loc_vars = function(self,info_queue,card)
        return {}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local total_chips = 0
            local elements_of_harmony = {"rendom_friendship","rendom_honesty","rendom_loyalty","rendom_laughter","rendom_generosity","rendom_magic"}
            for k,currentCard in pairs(G.playing_cards) do
                if REND.table_contains(elements_of_harmony,currentCard.seal) then
                    total_chips = total_chips + 10
                end
            end
            return {chips = total_chips}
        end
    end,
    atlas = "seal_atlas",
    pos = {x=2,y=1}
}

-- The effect is carried out in hooks/general.lua