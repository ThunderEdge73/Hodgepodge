SMODS.Joker {
    key = "lumi",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {}
        }
    end,
    config = {
        extra = 2
    },
    atlas = "jokers_atlas",
    pos = {x=0,y=HODGE.atlas_y.legendary[1]},
    soul_pos = {x=0,y=HODGE.atlas_y.soul[4]},
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    calculate = function(self,card,context)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}

