SMODS.Joker {
    key = "hydra",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.x_mult}
        }
    end,
    config = {
        x_mult = 1.2,
        extra = {max_amt = 2}
    },
    atlas = "jokers_atlas",
    pos = {x=0,y=REND.atlas_y.joke[1]},
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.x_mult
            }
        end
        if context.selling_self then
            local amt = math.min(card.ability.extra.max_amt,G.jokers.config.card_limit + 1 - G.jokers.config.card_count)
            G.GAME.joker_buffer = G.GAME.joker_buffer + amt
            G.E_MANAGER:add_event(Event({
                func = function() 
                    for i=1,math.min(2,amt),1 do
                        local card = create_card('Joker', G.jokers, nil, 0, nil, nil, "j_hodge_hydra","hydra")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                    end

                    G.GAME.joker_buffer = 0
                    return true
                end}))   
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

