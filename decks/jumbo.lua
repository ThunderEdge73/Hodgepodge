SMODS.Back {
    name = "Jumbo Deck",
    key = "jumbo",
    pos = {x=0,y=0},
    config = {rendom_big = true},
    loc_txt = {
        name = "Jumbo Deck",
        text = {
            "Start run with",
            "only {C:attention}Big{} cards",
            "{C:attention}+4{} hand size"
        }
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.starting_params.hand_size = 12
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_edition({
                        rendom_big = true
                    },true,true)
                end
                return true
            end
        }))
    end
}