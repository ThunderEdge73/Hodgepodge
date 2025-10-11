SMODS.Joker {
    key = "hydra",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.extra.xmult}
        }
    end,
    config = {
        extra = {
            self_copies = 2,
            xmult = 1.2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=0,y=HODGE.atlas_y.joke[1]},
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.selling_self and not context.blueprint then
            local amt = math.min(card.ability.extra.self_copies,G.jokers.config.card_limit + 1 - G.jokers.config.card_count)
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
        badges[#badges+1] = HODGE.badge('category','joke')
        badges[#badges+1] = HODGE.badge('credit','edward')
    end
}

