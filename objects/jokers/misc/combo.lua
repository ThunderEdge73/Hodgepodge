SMODS.Joker {
    key = "combo",
    -- loc_txt = {
    --     name = "Combo",
    --     text = {
    --         "Gains {X:mult,C:white}X#1#{} Mult per",
    --         "blinds won in 1 hand",
    --         "consecutively",
    --         "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.increase,
                card.ability.extra.scaling_xmult
            }
        }
    end,
    config = {
        extra = {
            base_xmult = 1,
            scaling_xmult = 1,
            increase = 0.2,
            last_hands_played = 0
        }
    },
    atlas = "jokers_atlas",
    pos = {x=11,y=HODGE.atlas_y.misc[1]},
    soul_pos = {x=11,y=HODGE.atlas_y.soul[1]},
    rarity = 3,
    cost = 8,
    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            local ret_message = ""
            if G.GAME.hands_played - card.ability.extra.last_hands_played <= 1 then
                card.ability.extra.scaling_xmult = card.ability.extra.scaling_xmult + card.ability.extra.increase
                ret_message = "Upgrade!"
            else
                card.ability.extra.scaling_xmult = card.ability.extra.base_xmult
                ret_message = "Reset!"
            end
            card.ability.extra.last_hands_played = G.GAME.hands_played
            return {message = ret_message}
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.scaling_xmult
            }
        end
    end,
    blueprint_compat = true,
    add_to_deck = function(self,card,from_debuff)
        card.ability.extra.last_hands_played = G.GAME.hands_played
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','misc')
    end
}