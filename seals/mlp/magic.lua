SMODS.Seal {
    key = "magic",
    badge_colour = HEX("F64A94"),
    config = {
        extra = {
        }
    },
    -- loc_txt = {
    --     label = "Element of Harmony",
    --     name = "Element of Magic",
    --     text = {
    --         "Apply a random","{C:attention}Element of Harmony{}","to one held card"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {vars = {}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local eligible_sealless_cards = {}
            for k, v in pairs(G.hand.cards) do
                if v.ability.set == 'Default' and (not v.seal) then
                    table.insert(eligible_sealless_cards, v)
                end
            end
            if REND.table_true_size(eligible_sealless_cards) > 0 then 
                local over = false
                local temp_pool = eligible_sealless_cards or {}
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed("magic"))
                local selected_element = pseudorandom_element(REND.elements_of_harmony, pseudoseed("magic"))
                eligible_card:set_seal(selected_element, nil, true)
                check_for_unlock({type = 'have_edition'})
            end
        end
    end,
    atlas = "seal_atlas",
    pos = {x=3,y=0}
}

-- The effect is carried out in hooks/general.lua