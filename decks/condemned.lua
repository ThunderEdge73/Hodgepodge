SMODS.Back {
    name = "Condemned Deck",
    key = "condemned",
    pos = {x=3,y=3},
    config = {rendom_big = true},
    loc_txt = {
        name = "Condemned Deck",
        text = {
            "Random cards are missing",
            "Random cards are {C:attention,T:m_rendom_asbestos}Asbestos{}"
        }
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local rand = math.random()
                    if rand < 0.2 then
                        G.playing_cards[i]:remove()
                    elseif rand < 0.6 then
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_rendom_asbestos)
                    end
                end
                return true
            end
        }))
    end
}