--- DEFINE CONSUMABLE TYPE ---

SMODS.ConsumableType {
    key = "slamdown",
    primary_colour = HEX("FF0000"),
    secondary_colour = HEX("555555"),
    cards = {
        ["gordon"] = true,
        ["poverty"] = true
    },
    loc_txt = {
        name = "Slam Down",
        collection = "Slam Down"
    },
    shop_rate = 1
}

--- DEFINE GORDON RAMSEY CARD ---

SMODS.Consumable {
    key = "gordon",
    set = "slamdown",
    atlas = "slamdown_atlas",
    pos = {x=1,y=0},
    cost = 3,
    config = {
        max_highlighted = 1,
        extra = "rendom_revive"
    },
    loc_txt = {
        name = "Gordon Ramsey",
        text = {
            "Select {C:attention}#1#{} card to",
            "apply {C:attention}Revive{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    can_use = function(self,card)
        return #G.hand.highlighted == card.ability.max_highlighted
    end,
    use = function(self,card,area,copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true end}))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                return true end}))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); return true end}))
    end
}

--- DEFINE POVERTY CARD ---

SMODS.Consumable {
    key = "poverty",
    set = "slamdown",
    atlas = "slamdown_atlas",
    pos = {x=2,y=0},
    cost = 3,
    config = {
        max_highlighted = 1,
        extra = "m_rendom_blackhole"
    },
    loc_txt = {
        name = "Poverty",
        text = {
            "Select {C:attention}#1#{} card to apply",
            "{C:attention}Black Hole{} enhancement"
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[(card.ability or self.config).extra]
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    can_use = function(self,card)
        return #G.hand.highlighted == card.ability.max_highlighted
    end,
    use = function(self,card,area,copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true end}))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_rendom_blackhole"])
                return true end}))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); return true end}))
    end
}