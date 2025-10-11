SMODS.Joker {
    key = "cocksley",
    -- loc_txt = {
    --     name = "Cocksley",
    --     text = {
    --         "{C:mult}+#1#{} discards",
    --         "{C:chips}#2#{} hand"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.d_size,-card.ability.extra.hand_loss}
        }
    end,
    config = {
        d_size = 3,
        extra = {hand_loss = 1},
    },
    atlas = "jokers_atlas",
    pos = {x=4,y=HODGE.atlas_y.misc[1]},
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','misc')
    end,
    add_to_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hand_loss
    end,
    remove_from_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand_loss
    end,
}