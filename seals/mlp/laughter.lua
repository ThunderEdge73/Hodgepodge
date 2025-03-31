SMODS.Seal {
    key = "laughter",
    badge_colour = HEX("64C5FF"),
    config = {
        extra = {
        }
    },
    -- loc_txt = {
    --     label = "Element of Harmony",
    --     name = "Element of Laughter",
    --     text = {
    --         "Retrigger other scoring","{C:attention}Elements of Harmony"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {vars = {}}
    end,
    calculate = function(self,card,context)
        -- if context.repetition and context.cardarea == G.play then
        --     print(context.other_card.seal)
        --     print(REND.elements_of_harmony)
        --     if REND.table_contains(REND.elements_of_harmony,context.other_card.seal) then
        --         return {
        --             message = "Haha!", 
        --             repetitions = 1,
        --             card = context.other_card
        --         }
        --     end
        -- end
    end,
    atlas = "seal_atlas",
    pos = {x=0,y=1}
}

-- The effect is carried out in hooks/general.lua