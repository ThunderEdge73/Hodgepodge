SMODS.Joker {
    key = "twilightsparkle",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=REND.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.joker_main then
            local chosen_card = pseudorandom_element(context.scoring_hand,pseudoseed("twilightsparkle"))
            
            local eligible_sealless_cards = {}
            for k, v in pairs(context.scoring_hand) do
                if v.ability.set == 'Default' and (not v.seal) then
                    table.insert(eligible_sealless_cards, v)
                end
            end
            if REND.table_true_size(eligible_sealless_cards) > 0 then 
                local over = false
                local temp_pool = eligible_sealless_cards or {}
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed("magic"))
                local selected_element = pseudorandom_element(REND.elements_of_harmony, pseudoseed("magic"))
                eligible_card:set_seal(selected_element, nil, true) -- if you queue it the other jokers can still choose it as if it has no seal
                G.E_MANAGER:add_event(Event({func = function()
                    play_sound("tarot1")
                    card:juice_up(0.3, 0.5)
                    return true end}))
            end
        end
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}