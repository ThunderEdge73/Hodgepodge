SMODS.Joker {
    key = "handcrank",
    -- loc_txt = {
    --     name = "Merge Down",
    --     text = {
    --         "All cards count as {C:attention}first scored{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        local current_val = (card.ability.chips >= 0 and "+" or "") .. card.ability.chips
        return {
            vars = {current_val,card.ability.extra.increase}
        }
    end,
    config = {
        chips = -20,
        extra = {
            start = -20,
            increase = 5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=1,y=REND.atlas_y.joke[1]},
    rarity = 1,
    cost = 3,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            local save_chips = card.ability.chips
            card.ability.chips = card.ability.extra.start
            return {
                chips = save_chips,
                message = "Reset!"
            }
        end
        if context.rend_clicked and context.card_clicked == card then
            card.ability.chips = card.ability.chips + card.ability.extra.increase
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..card.ability.extra.increase, colour = G.C.CHIPS, instant = true})
            -- return {
            --     message = "+"..card.ability.extra.increase
            -- }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

-- SMODS.Joker:take_ownership('hanging_chad',
--     {
--         calculate = function(self,card,context)
--             if context.repetition then
--                 print(REND.first_card_merge_down(context.scoring_hand))
--                 if context.repetition and context.scoring_hand and REND.table_contains(REND.first_card_merge_down(context.scoring_hand),context.other_card) then
--                     print("hanging chad")
--                     return {
--                         message = localize('k_again_ex'),
--                         repetitions = self.ability.extra,
--                         card = self
--                     }
--                 end
--             end
--         end
--     },
--     true -- Suppress mod badge
-- )

