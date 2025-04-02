SMODS.Suit {
    key = "moons",
    card_key = "MOONS",
    pos = {y=2},
    ui_pos = {x=2,y=0},
    loc_txt = {
        singular = "Moon",
        plural = "Moons"
    },
    lc_atlas = 'suits_atlas',
    hc_atlas = 'suits_atlas',
    lc_ui_atlas = 'icons_atlas',
    hc_ui_atlas = 'icons_atlas',
    lc_colour = HEX("5217F2"),
    hc_colour = HEX("5217F2"),
    in_pool = function(self,args)
        if G.GAME.selected_back then
            local moon_decks = {"Friendship Deck"}
            return REND.table_contains(moon_decks,G.GAME.selected_back.name)
        else
            return true
        end
    end
}