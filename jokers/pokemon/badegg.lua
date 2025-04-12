SMODS.Joker {
    key = "badegg",
    loc_txt = {
        name = "Bad EGG",
        text = {
            "{C:dark_edition,E:1,s:1.5}...{}"
        }
    },
    loc_vars = function (self,info_queue,card)
        return {vars = {}}
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=4,y=1},
    soul_pos = {x=5,y=1},
    rarity = 3,
    cost = -10,
    in_pool = function(self,args)
        return false
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            if pseudorandom("bad_egg") < 1/256 then
                local legendary = pseudorandom_element(G.P_JOKER_RARITY_POOLS[4],pseudoseed("bad_egg"))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3,0.3)
                    return true end }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3,func = function()
                    card:set_ability(legendary)
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3,0.3)
                    return true end }))
            else
                return {
                    message = "Oh?"
                }
            end
        end
    end,
    -- add_to_deck = function(self,card,from_debuff)
    --     card.sell_cost = -256
    -- end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_pokemon_maybe'), G.C.MULT, G.C.WHITE, 1.2)
    end
}
