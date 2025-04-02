SMODS.Back {
    name = "Friendship Deck",
    key = "friendship",
    atlas = "decks_atlas",
    pos = {x=2,y=0},
    config = {},
    loc_txt = {
        name = "Friendship Deck",
        text = {
            "Includes {C:suns}Sun{} and {C:moons}Moon{} suits",
            "Includes 1 of each {C:attention}Element of Harmony{}"
        }
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                local card_indices = {}
                for k,v in ipairs(G.playing_cards) do
                    table.insert(card_indices,k)
                end
                while #card_indices > 6 do
                    table.remove(card_indices,pseudorandom("friendship_deck",1,#card_indices))
                end
                print(G.playing_cards[card_indices[1]].base.name)
                print(G.playing_cards[card_indices[2]].base.name)
                print(G.playing_cards[card_indices[3]].base.name)
                print(G.playing_cards[card_indices[4]].base.name)
                print(G.playing_cards[card_indices[5]].base.name)
                print(G.playing_cards[card_indices[6]].base.name)
                G.playing_cards[card_indices[1]]:set_seal("rendom_loyalty")
                G.playing_cards[card_indices[2]]:set_seal("rendom_magic")
                G.playing_cards[card_indices[3]]:set_seal("rendom_kindness")
                G.playing_cards[card_indices[4]]:set_seal("rendom_honesty")
                G.playing_cards[card_indices[5]]:set_seal("rendom_generosity")
                G.playing_cards[card_indices[6]]:set_seal("rendom_laughter")
                return true
            end
        }))
    end
}