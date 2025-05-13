SMODS.Shader {
    key = "big",
    path = "big.fs"
}

SMODS.Edition {
    key = "big",
    shader = "big", -- Big shader currently doesn't do anything, as scale is handled in on_apply, on_load, etc.
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
        if card and card.ability then
            if card.ability.set == "Joker" or card.ability.set == "Edition" then --"Edition" for the collection menu
                return {vars = {"Joker slots"}}
            elseif card.ability.set == "Default" then
                return {vars = {"hand size"}}
            else -- Each consumable has a different card.ability.set so im just taking a gamble here
                return {vars = {"consumable slots"}}
            end
        else
            return {vars = {"card slots"}}
        end
    end,
    config = {
        card_limit = -1
    },
    in_shop = true,
    weight = 10,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    extra_cost = 5,
    apply_to_float = true,
    disable_base_shader = true,
    on_apply = function(card) -- WHEN A CARD BECOMES BIG
        ----print("Checking to apply Big! orig mult = "..card.rendom_orig_ability.mult)
        if not card.rendom_upgrade_big then
            ----print("Applying Big! orig mult = "..card.rendom_orig_ability.mult)
            local extra_probability_jokers = {"8 Ball","Business Card","Space Joker"} -- List of jokers who have ability.extra set to just 1 number, the probability of smth happening
            local extra_is_probability = REND.table_contains(extra_probability_jokers,card.ability.name) -- If current joker is one of these jokers ^^^
            ----print(card.ability.mult)
            REND.mod_card_values(card.ability,{multiply = 2, reference = card.rendom_orig_ability, unkeywords = {
                ["cry_prob"] = true, ["akyrs_cycler"] = true, -- cryptid probability, aiko's cycling card (hibana i think)
                ["odds"] = true, -- Multiplying odds by 2 makes them half as likely! I want them to be twice as likely,
                ["extra"] = extra_is_probability -- ^
            }})
            ----print(card.ability.mult)
            REND.mod_card_values(card.ability,{multiply = 0.5, keywords = {["odds"]=true,["extra"]=extra_is_probability,["cry_prob"]=true}}) -- Multiply just the odds
            ----print(card.ability.mult)
            card.rendom_upgrade_big = true
            card.T.scale = card.T.scale * 1.25
            ----print("Applied Big! orig mult = "..card.rendom_orig_ability.mult)
        end
        
        --card.role.draw_major.T.w = card.role.draw_major.T.w * 1.25
        --card.role.draw_major.T.h = card.role.draw_major.T.h * 1.25
    end,
    on_remove = function(card) -- REMOVING BIG FROM A CARD
        ----print("Removing Big! orig mult = "..tostring(card.rendom_orig_ability.mult))
        card.ability = REND.deep_copy(card.rendom_orig_ability)
        card.rendom_upgrade_big = false
        card.T.scale = card.T.scale / 1.25
        ----print("Removed Big! orig mult = "..card.rendom_orig_ability.mult)
        --card.role.draw_major.T.w = card.role.draw_major.T.w / 1.25
        --card.role.draw_major.T.h = card.role.draw_major.T.h / 1.25
    end,
    on_load = function(card) -- LOADING A SAVE WITH A BIG CARD
        card.T.scale = card.T.scale * 1.25
        --card.role.draw_major.T.w = card.role.draw_major.T.w * 1.25
        --card.role.draw_major.T.h = card.role.draw_major.T.h * 1.25
    end
}