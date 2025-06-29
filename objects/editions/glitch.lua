SMODS.Shader {
    key = "glitch",
    path = "glitch.fs"
}

SMODS.Edition {
    key = "glitch",
    shader = "glitch", -- Big shader currently doesn't do anything, as scale is handled in on_apply, on_load, etc.
    -- loc_txt = {
    --     label = "Big",
    --     name = "Big",
    --     text = {
    --         "Takes {C:dark_edition}2{} #1#",
    --         "{C:attention}Doubles{} all* values",
    --         "{s:0.8,C:inactive}*Where possible"
    --     }
    -- },
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    apply_to_float = true,
    disable_base_shader = true,
    on_apply = function(card) -- WHEN A CARD BECOMES BIG

        REND.mod_card_values(card.ability,{set = 255, reference = card.rendom_orig_ability, unkeywords = {
            ["cry_prob"] = true, ["akyrs_cycler"] = true, -- cryptid probability, aiko's cycling card (hibana i think)
        }})
        card.cost = 255
        card.sell_cost = 255
        --card.role.draw_major.T.w = card.role.draw_major.T.w * 1.25
        --card.role.draw_major.T.h = card.role.draw_major.T.h * 1.25
    end
}