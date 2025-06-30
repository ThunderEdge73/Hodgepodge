SMODS.Joker {
    key = "disappearingguy",
    -- loc_txt = {
    --     name = "Merge Down",
    --     text = {
    --         "All cards count as {C:attention}first scored{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.xmult}
        }
    end,
    config = {
        xmult = 10
    },
    atlas = "jokers_atlas",
    pos = {x=3,y=REND.atlas_y.joke[1]},
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            local cards_to_destroy = {}
            local to_right = false
            for k,joker in ipairs(G.jokers.cards) do
                if joker == card then
                    to_right = true
                end
                if to_right then
                    table.insert(cards_to_destroy,joker)
                end
            end
            G.GAME.joker_buffer = G.GAME.joker_buffer - #cards_to_destroy
            for k,joker in ipairs(cards_to_destroy) do
                joker.debuff = true
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    joker:start_dissolve(nil, nil, 1.6)
                return true end }))
            end
            return {
                xmult = card.ability.xmult
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

