SMODS.Enhancement {
    key = "waterdamage",
    loc_txt = {
        label = "Water Damaged",
        name = "Water Damaged",
        text = {
            "{C:chips}+#1#{} bonus chips",
            "{C:green}#2#%{} chance to",
            "destroy card",
            "Values increase when scored"
        }
    },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.chips,
                card.ability.extra
            }
        }
    end,
    atlas = "enhancements_atlas",
    pos = {x=2,y=0},
    config = {
        chips = 0,
        extra = 0
    },
    calculate = function(self,card,context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.chips = card.ability.chips + 10
            card.ability.extra = card.ability.extra + 5
            return {
                chips = card.ability.chips
            }
        end

        if context.destroy_card and context.cardarea == G.play then
            if pseudorandom("waterdamaged") < card.ability.extra/100 then
                return {
                    message = "Ripped!",
                    remove = true
                }
            end
        end
    end
}