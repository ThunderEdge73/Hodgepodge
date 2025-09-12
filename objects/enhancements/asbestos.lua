SMODS.Enhancement {
    key = "asbestos",
    -- loc_txt = {
    --     label = "Asbestos",
    --     name = "Asbestos",
    --     text = {
    --         "{X:mult,C:white}X#1#{} mult while in hand",
    --         "Loses {X:mult,C:white}X#2#{} per hand played",
    --         "{E:2,C:mult}Can go negative{}",
    --         "{E:1,C:mult}Negative values DON'T cancel out{}",
    --         "{C:mult,s:0.8}Discards and destructions may fail{}", "{C:mult,s:0.8}and increase degradation rate{}",
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.extra.h_x_mult,
                card.ability.extra.decrease_rate
            }
        }
    end,
    atlas = "enhancements_atlas",
    pos = {x=1,y=0},
    config = {
        extra = {
            h_x_mult = 5,
            decrease_rate = 0.5,
            disturb_odds = 2/3, -- Put the full fraction in! For example 2/3 is a 2 in 3 chance
            disturb_decay = 0.5,
            ignore_mult_restrictions = true -- The patches check for this bool
        }
    },
    calculate = function(self,card,context)
        
        if context.after and context.cardarea == G.hand then 
            card.ability.extra.h_x_mult = card.ability.extra.h_x_mult - card.ability.extra.decrease_rate
            return {
                message = "-x"..card.ability.extra.decrease_rate,
                colour = G.C.RED
            }
        end

        local disturb_odds = card.ability.extra.disturb_odds
        for k,joker in pairs(G.jokers.cards) do
            if joker.ability.name == "j_hodge_ppe" then
                disturb_odds = disturb_odds / joker.ability.extra.rate
            end
        end

        if context.discard and context.other_card == card then
            -- print("Is other_card? "..tostring(context.other_card == card))
            -- print("Card Area is deck? "..tostring(context.cardarea == G.deck))
            -- print("Card Area is discard? "..tostring(context.cardarea == G.discard))
            -- print("Card Area is hand? "..tostring(context.cardarea == G.hand))
            local rand = pseudorandom("asbestos")
            local disturb = rand < disturb_odds
            local funny_message = ((rand < 0.1) and "Told you!") or "Disturbed!"
            if disturb then
                card.ability.extra.decrease_rate = card.ability.extra.decrease_rate + card.ability.extra.disturb_decay
                G.E_MANAGER:add_event(Event({
                    func = function()
                        draw_card(G.discard,G.hand,nil,nil,nil,card)
                        return true
                    end
                }))
                return {
                    message = funny_message,
                    colour = G.C.RED
                }
            end
        end
        
        if context.remove_playing_cards and HODGE.table_contains(context.removed,card) then

            local rand = pseudorandom("asbestos")
            local disturb = rand < disturb_odds
            local funny_message = ((rand < 0.1) and "Told you!") or "Disturbed!"
            if disturb then
                card.ability.extra.decrease_rate = card.ability.extra.decrease_rate + 0.2
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _first_dissolve = nil
                        local new_cards = {}
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card:start_materialize(nil, _first_dissolve)
                        _first_dissolve = true
                        new_cards[#new_cards+1] = _card
                        --playing_card_joker_effects(new_cards)
                        return true
                    end
                }))
                return {
                    message = funny_message,
                    colour = G.C.RED
                }
            end
        end

        if context.main_scoring and context.cardarea == G.hand then
            local return_xmult = card.ability.extra.h_x_mult
            if mult < 0 then
                return_xmult = math.abs(return_xmult)
            end
            return {
                xmult = return_xmult
            }
        end
    end
}