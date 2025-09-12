SMODS.Joker {
    key = "nonejoker",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {card.ability.x_chips}
        }
    end,
    config = {
        x_chips = 4
    },
    atlas = "jokers_atlas",
    pos = {x=13,y=HODGE.atlas_y.joke[1]},
    soul_pos = {x=13,y=HODGE.atlas_y.soul[2]},
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                mult = 1-mult,
                xchips = card.ability.x_chips
            }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

