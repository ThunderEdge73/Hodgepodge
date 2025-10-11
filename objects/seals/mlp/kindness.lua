SMODS.Seal {
    key = "kindness",
    badge_colour = HEX("F083B0"),
    config = {
        extra = {
            chips = 5
        }
    },
    -- loc_txt = {
    --     label = "Element of Harmony",
    --     name = "Element of Kindness",
    --     text = {
    --         "{C:chips}+10{} Chips for every",
    --         "{C:attention}Element of Harmony{}",
    --         "in your full deck",
    --         "{C:inactive,s:0.9}Currently {C:chips,s:0.9}+#1#{}"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        local total_chips = 0
        if G.playing_cards then
            for k,currentCard in pairs(G.playing_cards) do
                if HODGE.table_contains(HODGE.elements_of_harmony,currentCard.seal) then
                    total_chips = total_chips + (card.ability.seal.extra.chips)
                end
            end
        end
        return {vars={card.ability.seal.extra.chips,total_chips}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local total_chips = 0
            for k,currentCard in pairs(G.playing_cards) do
                if HODGE.table_contains(HODGE.elements_of_harmony,currentCard.seal) then
                    total_chips = total_chips + card.ability.seal.extra.chips
                end
            end
            return {chips = total_chips}
        end
    end,
    atlas = "seal_atlas",
    pos = {x=1,y=1}
}

-- The effect is carried out in hooks/general.lua