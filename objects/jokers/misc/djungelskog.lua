SMODS.Joker {
    key = "djungelskog",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {}
        }
    end,
    config = {
        extra = {
            power_boost = 2,
            last_left_joker = nil,
            last_right_joker = nil,
        }
    },
    atlas = "jokers_atlas",
    pos = {x=4,y=HODGE.atlas_y.legendary[1]},
    soul_pos = {x=4,y=HODGE.atlas_y.soul[4]},
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    calculate = function(self,card,context)
    end,
    update = function(self,card,dt)
        if G.jokers and next(SMODS.find_card("j_hodge_djungelskog")) then
            for i,joker in ipairs(G.jokers.cards) do
                if joker == card then
                    if i-1 >= 1 then
                        if G.jokers.cards[i-1] ~= card.ability.extra.last_left_joker then
                            --print("left "..i-1)
                            if card.ability.extra.last_left_joker then
                                --print("left reset "..card.ability.extra.last_left_joker.ability.name)
                                Blockbuster.manipulate_value(card.ability.extra.last_left_joker,"hodge_djungelskog",1)
                            end
                            --print("left double "..G.jokers.cards[i-1].ability.name)
                            Blockbuster.manipulate_value(G.jokers.cards[i-1],"hodge_djungelskog",2)
                            card.ability.extra.last_left_joker = G.jokers.cards[i-1]
                        end
                    elseif card.ability.extra.last_left_joker then
                        --print("left nil")
                        --print("left nil reset "..card.ability.extra.last_left_joker.ability.name)
                        Blockbuster.manipulate_value(card.ability.extra.last_left_joker,"hodge_djungelskog",1)
                        card.ability.extra.last_left_joker = nil
                    end

                    if i+1 <= #G.jokers.cards then
                        if G.jokers.cards[i+1] ~= card.ability.extra.last_right_joker then
                            --print("right "..i+1)
                            if card.ability.extra.last_right_joker and card.ability.extra.last_right_joker ~= card.ability.extra.last_left_joker then
                                --print("right reset "..card.ability.extra.last_right_joker.ability.name)
                                Blockbuster.manipulate_value(card.ability.extra.last_right_joker,"hodge_djungelskog",1)
                            end
                            --print("right double "..G.jokers.cards[i+1].ability.name)
                            Blockbuster.manipulate_value(G.jokers.cards[i+1],"hodge_djungelskog",2)
                            card.ability.extra.last_right_joker = G.jokers.cards[i+1]
                        end
                    elseif card.ability.extra.last_right_joker ~= nil then
                        --print("right nil")
                        --print("right nil reset "..card.ability.extra.last_right_joker.ability.name)
                        if card.ability.extra.last_right_joker ~= card.ability.extra.last_left_joker then
                            Blockbuster.manipulate_value(card.ability.extra.last_right_joker,"hodge_djungelskog",1)
                        end
                        card.ability.extra.last_right_joker = nil
                    end

                    break
                end
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','misc')
    end
}

