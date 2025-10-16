SMODS.Atlas {
    key = "celestia_atlas",
    path = "celestia_atlas.png",
    px = 135,
    py = 95
}

SMODS.Joker {
    key = "celestia",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
                card.ability.extra.chip_gain,
                card.ability.extra.scaling_chips
            }
        }
    end,
    config = {
        extra = {
            scaling_chips = 0,
            chip_gain = 6
        }
    },
    atlas = "celestia_atlas",
    pos = {x=0,y=0},
    soul_pos = {x=1,y=0},
    display_size = {w = 135, h = 95},
    rarity = 4,
    cost = 20,
    calculate = function(self,card,context)
        if context.after and not context.blueprint then
            for i=1, #context.full_hand do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    if context.full_hand[i] then
                        context.full_hand[i]:flip();play_sound('card1', percent);
                        context.full_hand[i]:juice_up(0.3, 0.3);
                    end
                return true end }))
            end
            for i=1, #context.full_hand do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    if context.full_hand[i] then
                        local card = context.full_hand[i]                    
                        assert(SMODS.change_base(card,"hodge_suns"))
                    end
                return true end }))
            end  
            for i=1, #context.full_hand do
                local percent = 0.85 + (i-0.999)/(#context.full_hand-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    if context.full_hand[i] then
                        context.full_hand[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        context.full_hand[i]:juice_up(0.3, 0.3)
                    end
                return true end }))
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("hodge_suns") and not context.blueprint then
            card.ability.extra.scaling_chips = card.ability.extra.scaling_chips + card.ability.extra.chip_gain
                return {
                    message = "+"..card.ability.extra.chip_gain,
                    message_card = card
                }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.scaling_chips
            }
        end
    end,
    blueprint_compat = true,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','mlp')
    end
}
