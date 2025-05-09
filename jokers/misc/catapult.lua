SMODS.Joker {
    key = "catapult",
    -- loc_txt = {
    --     name = "Catapult",
    --     text = {
    --         "{C:chips}+#2#{} hands",
    --         "{C:mult}#1#{} discard"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.d_size,card.ability.extra.h_plays}
        }
    end,
    config = {
        d_size = -1,
        extra = {
            h_plays = 2
        }
    },
    blueprint_compat = false,
    atlas = "jokers_atlas",
    pos = {x=3,y=REND.atlas_y.misc[1]},
    rarity = 2,
    cost = 5,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end,
    add_to_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
    end,
    remove_from_deck = function(self,card,from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
    end,
}