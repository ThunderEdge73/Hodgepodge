SMODS.Suit {
    key = "suns",
    card_key = "SUNS",
    pos = {y=1},
    ui_pos = {x=1,y=0},
    loc_txt = {
        singular = "Sun",
        plural = "Suns"
    },
    lc_atlas = 'suits_atlas',
    hc_atlas = 'suits_atlas',
    lc_ui_atlas = 'icons_atlas',
    hc_ui_atlas = 'icons_atlas',
    lc_colour = HEX("F2AE17"),
    hc_colour = HEX("F2AE17"),
    in_pool = function(self,args)
        if G.GAME.selected_back then
            local sun_decks = {"Friendship Deck"}
            return REND.table_contains(sun_decks,G.GAME.selected_back.name)
        else
            return true
        end
    end
}