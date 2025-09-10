SMODS.Joker {
    key = "rainbowfactory",
    -- loc_txt = {
    --     name = "Cupcakes",
    --     text = {
    --         "{X:mult,C:white}X#1#{} Mult, loses {X:mult,C:white}X#2#{} Mult",
    --         "per hand played",
    --         "Gains {X:mult,C:white}X#3#{} per scoring card",
    --         "with {C:attention}Element of Loyalty{} and",
    --         "destroys the card"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.max_rank,
                card.ability.extra.card_count,
                card.ability.extra.edition:gsub("^%l", string.upper),
                (card.ability.extra.remaining <= 0 and "Active!") or (card.ability.extra.remaining .. " remaining")
            }
        }
    end,
    config = {
        extra = {
            max_rank = 5,
            card_count = 5,
            edition = "polychrome",
            remaining = 5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=10,y=HODGE.atlas_y.mlp[1]},
    --soul_pos = {x=10,y=HODGE.atlas_y.soul[3]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        if context.after then
            while card.ability.extra.remaining <= 0 do
                local eligible_cards = {}
                for i,card in pairs(context.scoring_hand) do
                    if not card.destroyed then
                        table.insert(eligible_cards,card)
                    end
                end
                if #eligible_cards > 0 then
                    card.ability.extra.remaining = card.ability.extra.remaining + card.ability.extra.card_count
                    local chosen_card = pseudorandom_element(eligible_cards, pseudoseed('rainbowfactory'))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        chosen_card:set_edition({[card.ability.extra.edition] = true}, true)
                        chosen_card:juice_up(0.3, 0.3);
                        card:juice_up(0.3,0.3);
                        return true end
                    }))
                    
                else
                    break
                end
            end
        end
        if context.destroy_card and context.cardarea == G.play and context.destroy_card.base.nominal <= card.ability.extra.max_rank and not context.blueprint then
            card.ability.extra.remaining = card.ability.extra.remaining - 1
            return {
                remove = true
            }
        end
    end,
    blueprint_compat = true,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}