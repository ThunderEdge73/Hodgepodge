SMODS.Joker {
    key = "vestup",
    -- loc_txt = {
    --     name = "Merge Down",
    --     text = {
    --         "All cards count as {C:attention}first scored{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.chips,card.ability.extra.chip_gain_bonus,card.ability.extra.increase}
        }
    end,
    config = {
        chips = 4,
        extra = {
            chip_gain_bonus = 1,
            increase = 1
        }
    },
    atlas = "jokers_atlas",
    pos = {x=5,y=REND.atlas_y.joke[1]},
    soul_pos = {x=5,y=REND.atlas_y.soul[2]},
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = card.ability.chips
            }
        end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.chip_gain_bonus = card.ability.extra.chip_gain_bonus + card.ability.extra.increase
            return {
                message = "Vest Up!"
            }
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

