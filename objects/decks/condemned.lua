SMODS.Back {
    name = "Condemned Deck",
    key = "condemned",
    atlas = "decks_atlas",
    pos = {x=2,y=0},
    config = {hodge_big = true},
    -- loc_txt = {
    --     name = "Condemned Deck",
    --     text = {
    --         "Random cards are missing",
    --         "Random cards are {C:attention,T:m_hodge_asbestos}Asbestos{}",
    --         "Random cards are {C:attention,T:m_hodge_waterdamage}Water Damaged{}"
    --     }
    -- },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local rand = math.random()
                    if rand < 0.2 then
                        G.playing_cards[i]:remove()
                    elseif rand < 0.35 then
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_hodge_asbestos)
                    elseif rand < 0.6 then
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_hodge_waterdamage)
                    end
                end
                return true
            end
        }))
    end
}