SMODS.Back {
    name = "Board Game Deck",
    key = "boardgame",
    atlas = "decks_atlas",
    pos = {x=3,y=0},
    config = {},
    -- loc_txt = {
    --     name = "Snake Deck",
    --     text = {
    --         "Includes cards with","the Snake suit"
    --     }
    -- },
    apply = function()
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
        G.E_MANAGER:add_event(Event({
            func = function() 
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, "j_oops", "boardgame")
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
                return true
            end}))   
    end
}