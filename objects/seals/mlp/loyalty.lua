SMODS.Seal {
    key = "loyalty",
    badge_colour = HEX("F94448"),
    config = {
        extra = {odds = 2}
    },
    -- loc_txt = {
    --     label = "Element of Harmony",
    --     name = "Element of Loyalty",
    --     text = {
    --         "Other played",
    --         "{C:attention}Elements of Harmony{}",
    --         "have a {C:green}#1# in #2#{} chance to",
    --         "return to hand when played"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {vars = {G.GAME.probabilities.normal or 1, card.ability.seal.extra.odds}}
    end,
    atlas = "seal_atlas",
    calculate = function(self,card,context)
        if context.after and context.cardarea == G.play then -- Correct context
            local first_loyalty = false
            local loyalties = 0
            for i,c in ipairs(context.scoring_hand) do -- For card in hand
                if c.seal == "hodge_loyalty" then
                    loyalties = loyalties + 1
                    if not first_loyalty then
                        first_loyalty = c
                    end
                end
            end
            if first_loyalty == card then
                --print("loyalty | first loyalty == card")
                for i,c in ipairs(context.scoring_hand) do -- For card in hand
                    if HODGE.table_contains(HODGE.elements_of_harmony,c.seal) and ((card ~= c) or (loyalties > 1)) then -- If is element of harmony
                        --print("loyalty | "..c.seal)
                        if SMODS.pseudorandom_probability(card, 'loyalty', 1, card.ability.seal.extra.odds, 'loyalty') then -- Random chance
                            --print("loyalty | passed check, back to hand")
                            G.E_MANAGER:add_event(Event({ -- Add to queue
                                trigger = 'immediate',
                                func = function()
                                    if not c.destroyed then
                                        draw_card(G.discard, G.hand, nil, nil, nil, c, nil, nil, false, nil, nil) --from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only
                                    end
                                    return true
                                end
                            }))
                        else
                            --print("loyalty | failed check")
                            if next(SMODS.find_card("j_hodge_rainbowdash")) then --rainbow dash offloads her work onto loyalty cards if they're present to avoid bugs
                                --print("loyalty | back to deck")
                                G.E_MANAGER:add_event(Event({ -- Add to queue
                                trigger = 'immediate',
                                func = function()
                                    if not c.destroyed then
                                        draw_card(G.discard, G.deck, nil, nil, nil, c, nil, nil, false, nil, nil) --from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only
                                    end
                                    return true
                                end
                            }))
                            end
                        end
                    end
                end
            end
        end
    end,
    pos = {x=2,y=0}
}
