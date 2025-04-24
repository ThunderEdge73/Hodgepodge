SMODS.Joker {
    key = "combo",
    -- loc_txt = {
    --     name = "Combo",
    --     text = {
    --         "Gains {X:mult,C:white}x#1#{} Mult per",
    --         "blinds won in 1 hand",
    --         "consecutively",
    --         "{C:inactive}(Currently {X:mult,C:white}x#2#{C:inactive} Mult){}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.increase,
                card.ability.x_mult
            }
        }
    end,
    config = {
        x_mult = 1,
        extra = {
            base = 1,
            increase = 0.2,
            last_hands_played = 0
        }
    },
    atlas = "jokers_atlas",
    pos = {x=9,y=0},
    rarity = 3,
    cost = 8,
    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            local ret_message = ""
            if G.GAME.hands_played - card.ability.extra.last_hands_played <= 1 then
                card.ability.x_mult = card.ability.x_mult + card.ability.extra.increase
                ret_message = "Upgrade!"
            else
                card.ability.x_mult = card.ability.extra.base
                ret_message = "Reset!"
            end
            card.ability.extra.last_hands_played = G.GAME.hands_played
            return {message = ret_message}
        end
    end,
    blueprint_compat = true,
    add_to_deck = function(self,card,from_debuff)
        card.ability.extra.last_hands_played = G.GAME.hands_played
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}