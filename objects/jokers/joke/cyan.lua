SMODS.Joker {
    key = "cyan",
    -- loc_txt = {
    --     name = "Merge Down",
    --     text = {
    --         "All cards count as {C:attention}first scored{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.chips,card.ability.extra.increase}
        }
    end,
    config = {
        chips = 0,
        extra = {
            increase = 2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=REND.atlas_y.joke[1]},
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.before and context.cardarea == G.jokers then
            for k, playing_card in ipairs(G.play.cards) do
                if not REND.table_contains(context.scoring_hand, playing_card) then
                    card.ability.chips = card.ability.chips + card.ability.extra.increase
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        playing_card:juice_up()
                    return true end}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!", colour = G.C.CHIPS})
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.chips
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

