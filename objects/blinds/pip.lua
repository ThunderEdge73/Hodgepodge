SMODS.Blind {
    key = "pip",
    atlas = "blinds_atlas",
    pos = {y=1},
    mult = 2,
    boss = {min = 1, max = 69}, -- Max isn't used
    boss_colour = HEX("4bc292"),
    in_pool = function(self)
        return true
    end,
    loc_vars = function(self)
        return { vars = {1, 6}}
    end,
    collection_loc_vars = function(self) 
        return {vars = { '1','6' }}
    end,
    calculate = function(self,card,context)
        if context.fix_probability then
            return {
                numerator = 1,
                denominator = 6
            }
        end
    end
}

