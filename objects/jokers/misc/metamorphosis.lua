SMODS.Joker {
    key = "metamorphosis",
    -- loc_txt = {
    --     name = "Metamorphosis",
    --     text = {
    --         "{C:green}#1# in #2#{} chance for",
    --         "{C:attention}scored cards{} to become",
    --         "a random {C:attention}enhancement{}",
    --         "{C:inactive,s:0.85}Can replace existing enhancements{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'metamorphosis')
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    config = {
        extra = {
            odds = 4
        }
    },
    atlas = "jokers_atlas",
    pos = {x=14,y=REND.atlas_y.misc[1]},
    rarity = 3,
    cost = 7,
    calculate = function(self,card,context)
        if context.before then
            local triggered = false
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(card, 'metamorphosis', 1, card.ability.extra.odds, 'metamorphosis') then
                    local enhancement = SMODS.poll_enhancement {
                        key = "metamorphosis",
                        guaranteed = true
                    }
                    v:set_ability(G.P_CENTERS[enhancement], nil, true)
                    triggered = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if triggered then
                local messages = {
                    "Transformed!","Transformed!","Transformed!","Transformed!","Transformed!","Transformed!","Transformed!","Transformed!", --lazy weighting
                    "Monch!","Monch!",
                    "Chomp!","Chomp!",
                    "Nom!","Nom!",
                    "Gooped!","Gooped!",
                    "Owch!","Owch!",
                    "Changed!", --plays Poison.ogg
                    "Chaos, chaos!",
                }
                local message = pseudorandom_element(messages,pseudoseed("metamorphosis"))
                if message == "Changed!" then
                    play_sound("hodge_poisonogg")
                end
                return {
                    message = message,
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end,
    blueprint_compat = true,
    add_to_deck = function(self,card,from_debuff)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}