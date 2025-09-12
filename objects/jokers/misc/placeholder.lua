SMODS.Joker {
    key = "placeholder",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {}
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=0,y=HODGE.atlas_y.misc[1]},
    rarity = 1,
    cost = 0,
    blueprint_compat = false,
    calculate = function(self,card,context)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}