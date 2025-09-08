SMODS.Joker {
    key = "twilightsparkle",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=2,y=REND.atlas_y.mlp[1]},
    rarity = 2,
    cost = 7,
    calculate = function(self,card,context)
        if context.joker_main then
            local chosen_card = pseudorandom_element(context.scoring_hand,pseudoseed("twilightsparkle"))
            G.E_MANAGER:add_event(Event({func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true end}))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                chosen_card:set_seal("hodge_magic", nil, true)
                return true end}))
        end
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}