SMODS.Joker {
    key = "ppe",
    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_hodge_asbestos
        return {
            vars = {card.ability.extra.rate}
        }
    end,
    config = {
        extra = {
            rate = 2
        }
    },
    atlas = "jokers_atlas",
    pos = {x=11,y=HODGE.atlas_y.joke[1]},
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    calculate = function(self,card,context)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

