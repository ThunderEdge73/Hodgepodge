SMODS.Back {
    name = "Jumbo Deck",
    key = "jumbo",
    atlas = "decks_atlas",
    pos = {x=0,y=0},
    config = {hodge_big = true, hand_size = 4, joker_slot = 2},
    -- loc_txt = {
    --     name = "Jumbo Deck",
    --     text = {
    --         "Start run with",
    --         "only {C:attention}Big{} cards",
    --         "{C:attention}+4{} hand size",
    --         "{C:inactive}(Hand can hold {C:attention}6{C:inactive} Big cards){}"
    --     }
    -- },
    loc_vars = function(self,info_queue,back)
        return { vars = {self.config.hand_size, self.config.joker_slot} }
    end,
    apply = function()
        --G.GAME.starting_params.hand_size = 12
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

local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.GAME.selected_back.name == "Jumbo Deck" then
        card:set_edition({hodge_big = true})
    end
    return card
end