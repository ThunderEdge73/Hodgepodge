SMODS.Joker {
    key = "mergedown",
    loc_txt = {
        name = "Merge Down",
        text = {
            "All cards count as {C:attention}first scored{}"
        }
    },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {}
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=1},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
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

