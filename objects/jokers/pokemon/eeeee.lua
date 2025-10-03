SMODS.Joker {
    key = "eeeee",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.x_mult
            }
        }
    end,
    config = {
        x_mult = 1,
        extra = {
            x_mult = 0.5
        }
    },
    atlas = "jokers_atlas",
    pos = {x=8,y=HODGE.atlas_y.legendary[1]},
    soul_pos = {x=8,y=HODGE.atlas_y.soul[4]},
    rarity = 4,
    cost = 20,
    calculate = function(self,card,context)
        if context.hodge_rank_change then
            local num_orig_rank = SMODS.Ranks[tostring(context.orig_rank)].id
            local num_new_rank = SMODS.Ranks[tostring(context.new_rank)].id
            print(context.orig_rank,  context.new_rank)
            if context.orig_rank < context.new_rank then
                card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult
                return {
                    message = "+"..card.ability.extra.x_mult.."X"
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','pokemon')
    end
}
