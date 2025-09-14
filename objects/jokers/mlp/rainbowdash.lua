SMODS.Joker {
    key = "rainbowdash",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=5,y=HODGE.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.after then
            local loyalties = 0
            for i,c in ipairs(context.scoring_hand) do -- For card in hand
                if c.seal == "hodge_loyalty" then
                    loyalties = loyalties + 1
                end
            end
            if loyalties < 2 then
                --print("rd | loyalties < 2")
                for i,c in ipairs(context.scoring_hand) do -- For card in hand
                    if HODGE.table_contains(HODGE.elements_of_harmony,c.seal) and (loyalties == 0 or c.seal == "hodge_loyalty") then -- If is element of harmony
                        --If there's a loyalty card in the hand, it deals with the logic instead. its easier this way ^
                        --print("rd | "..c.seal)
                        --print("rd | back to deck")
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
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card.seal == "hodge_loyalty" then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','mlp')
        badges[#badges+1] = HODGE.badge('credit','jorse')
    end
}