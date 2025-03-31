SMODS.Seal {
    key = "loyalty",
    badge_colour = HEX("F94448"),
    config = {
        extra = 2
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
        return {vars = {G.GAME.probabilities.normal or 1, card.ability.seal.extra}}
    end,
    atlas = "seal_atlas",
    calculate = function(self,card,context)
        if context.after and context.cardarea == G.play then -- Correct context
            local first_loyalty = false
            for i,c in ipairs(context.scoring_hand) do -- For card in hand
                if c.seal == "rendom_loyalty" then
                    if c == card then
                        first_loyalty = true
                    end
                    break
                end
            end
            if first_loyalty then
                for i,c in ipairs(context.scoring_hand) do -- For card in hand
                    if REND.table_contains(REND.elements_of_harmony,c.seal) then -- If is element of harmony
                        if pseudorandom("loyalty") < (G.GAME.probabilities.normal or 1) / card.ability.seal.extra then -- Random chance
                            G.E_MANAGER:add_event(Event({ -- Add to queue
                                trigger = 'immediate',
                                func = function()
                                    draw_card(G.discard, G.hand, nil, nil, nil, c, nil, nil, false, nil, nil) --from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only
                                    return true
                                end
                            }))
                        end
                    end
                end
            end
        end
    end,
    pos = {x=2,y=0}
}
