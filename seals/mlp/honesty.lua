SMODS.Seal {
    key = "honesty",
    badge_colour = HEX("FEB55E"),
    config = {
        extra = 2
    },
    loc_txt = {
        label = "Element of Honesty",
        name = "Element of Honesty",
        text = {
            "Unflippable by boss blinds"
        }
    },
    loc_vars = function(self,info_queue,card)
        return {}
    end,
    atlas = "seal_atlas",
    pos = {x=2,y=1}
}

-- The effect is carried out in hooks/general.lua