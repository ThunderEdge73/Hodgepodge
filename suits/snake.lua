SMODS.Suit {
    key = "snake",
    card_key = "SNAKE",
    pos = {y=0},
    ui_pos = {x=0,y=0},
    -- loc_txt = {
    --     singular = "Snake",
    --     plural = "Snakes"
    -- },
    lc_atlas = 'suits_atlas',
    hc_atlas = 'suits_atlas',
    lc_ui_atlas = 'icons_atlas',
    hc_ui_atlas = 'icons_atlas',
    lc_colour = HEX("21A888"),
    hc_colour = HEX("21A888"),
    in_pool = function(self,args)
        if G.GAME.selected_back then
            local snake_decks = {"Snake Deck"}
            return REND.table_contains(snake_decks,G.GAME.selected_back.name)
        else
            return true
        end
    end
}