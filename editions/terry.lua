SMODS.Shader {
    key = "slime",
    path = "slime.fs"
}

SMODS.Edition {
    key = "terry",
    shader = "slime",
    loc_txt = {
        label = "Terry",
        name = "Terry",
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "{s:0.8,C:inactive}Randomly chosen when scored{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        local vals = self.config
        if (card.edition and card.edition.extra) then
            vals = card.edition
        end
        local rand = math.random()
        local inc = vals.extra.increment
        local min = vals.extra.lower_bound
        local max = vals.extra.upper_bound
        local placeholder = inc*math.ceil(((rand*(max-min))+min)/inc)
        return {vars = {placeholder}}
    end,
    config = {
        extra = {
            lower_bound = 0.1,
            upper_bound = 3,
            increment = 0.1
        }
    },
    in_shop = true,
    weight = 10,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    extra_cost = 4,
    apply_to_float = false,
    disable_base_shader = true,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.pre_joker then
            local rand = math.random()
            local inc = card.edition.extra.increment
            local min = card.edition.extra.lower_bound
            local max = card.edition.extra.upper_bound
            local value = inc*math.ceil(((rand*(max-min))+min)/inc)
            return {x_mult = value}
        end
    end
}