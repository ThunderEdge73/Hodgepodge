SMODS.Joker {
    key = "butterflies",
    -- loc_txt = {
    --     name = "Nightmare Night",
    --     text = {
    --         "Played cards with",
    --         "{C:hodge_moons}Moon{} suit give",
    --         "{C:mult}+3{} Mult when scored"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS["e_"..card.ability.extra.edition]
        return {
            vars = {
            }
        }
    end,
    config = {
        extra = {
            edition = "hodge_parasite"
        }
    },
    atlas = "jokers_atlas",
    pos = {x=12,y=HODGE.atlas_y.mlp[1]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        -- if context.individual and context.cardarea == G.play then
        --     if context.other_card.seal == "hodge_honesty" and not context.blueprint then
        --         local other_card = context.other_card --NOT FOR CONVENIENCE!! DOESNT WORK WITHOUT THIS
        --         G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
        --             other_card:set_edition({[card.ability.extra.edition] = true}, true)
        --             other_card:juice_up(0.3, 0.3)
        --             card:juice_up(0.3,0.3)
        --             return true end
        --         }))
        --     end
        -- end
        if context.after and not context.blueprint then
            for i,playing_card in pairs(context.scoring_hand) do
                if playing_card.seal == "hodge_honesty" and not playing_card.destroyed then
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        playing_card:set_edition({[card.ability.extra.edition] = true}, true)
                        playing_card:juice_up(0.3, 0.3);
                        card:juice_up(0.3,0.3);
                        return true end
                    }))
                end
            end
        end
    end,
    blueprint_compat = false,
    in_pool = function(self,args)
        for k,card in ipairs(G.playing_cards) do
            if card.seal == "hodge_honesty" then
                return true
            end
        end
        return false
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','mlp')
    end
}