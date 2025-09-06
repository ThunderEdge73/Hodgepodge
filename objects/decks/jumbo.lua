SMODS.Back {
    name = "Jumbo Deck",
    key = "jumbo",
    atlas = "decks_atlas",
    pos = {x=0,y=0},
    config = {hodge_big = true},
    -- loc_txt = {
    --     name = "Jumbo Deck",
    --     text = {
    --         "Start run with",
    --         "only {C:attention}Big{} cards",
    --         "{C:attention}+4{} hand size",
    --         "{C:inactive}(Hand can hold {C:attention}6{C:inactive} Big cards){}"
    --     }
    -- },
    apply = function()
        G.GAME.starting_params.hand_size = 12
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_edition({
                        hodge_big = true
                    },true,true)
                end
                return true
            end
        }))
    end
}