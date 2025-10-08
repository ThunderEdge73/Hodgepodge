--- Music ---

-- SMODS.Sound {
--     key = "music_powerpack",
--     path = "mus_powerpack.ogg",
--     volume = 0.5,
--     sync = {
--         ['music1'] = true,
--         ['music2'] = true,
--         ['music3'] = true,
--         ['music4'] = true,
--         ['music5'] = true,
--     },
--     select_music_track = function(self)
--         -- stole this logic from aikos lol
--         return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'power' and 100 or nil
--     end
-- }

--- DEFINE CONSUMABLE TYPE ---

SMODS.ConsumableType {
    key = "perk",
    primary_colour = HEX("FFC700"),
    secondary_colour = HEX("000000"),
    cards = {
        ["crumb"] = true,
    }
}

SMODS.UndiscoveredSprite {
    key = "perk",
    atlas = "perk_undiscovered_atlas",
    pos = {x=0,y=0},
    no_overlay = true
}

SMODS.Consumable { -- Crumb (+3 Hand size)
    key = "crumb",
    set = "perk",
    atlas = "perk_atlas",
    pos = {x=1,y=0},
    display_size = {w=67,h=68},
    cost = 3,
    config = {
        max_highlighted = 999,
        extra = 3
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra}}
    end,
    can_use = function(self,card)
        return true --G.hand and G.GAME.blind.in_blind
    end,
    use = function(self,card,area,copier)
        G.hand:change_size(card.ability.extra)
    end
}

--- BOOSTERS ---

-- SMODS.Booster {
--     key = "power_booster_1",
--     atlas = "booster_atlas",
--     pos = {x=0,y=0},
--     kind = "power",
--     config = {extra = 2, choose = 1},
--     weight = 0.5,
--     draw_hand = true,
--     group_key = "k_hodge_power_booster",
--     create_card = function(self,card,i)
--         return {
--             set = "power",
--             key_append = "power_booster",
--             skip_materialize = true,
--             area = G.pack_cards
--         }
--     end
-- }

-- SMODS.Booster {
--     key = "power_booster_2",
--     atlas = "booster_atlas",
--     pos = {x=1,y=0},
--     kind = "power",
--     config = {extra = 2, choose = 1},
--     weight = 0.5,
--     draw_hand = true,
--     group_key = "k_hodge_power_booster",
--     create_card = function(self,card,i)
--         return {
--             set = "power",
--             key_append = "power_booster",
--             skip_materialize = true,
--             area = G.pack_cards
--         }
--     end
-- }

-- SMODS.Booster {
--     key = "power_booster_jumbo",
--     atlas = "booster_atlas",
--     pos = {x=2,y=0},
--     kind = "power",
--     config = {extra = 4, choose = 1},
--     weight = 0.5,
--     draw_hand = true,
--     group_key = "k_hodge_power_booster",
--     create_card = function(self,card,i)
--         return {
--             set = "power",
--             key_append = "power_booster",
--             skip_materialize = true,
--             area = G.pack_cards
--         }
--     end
-- }

-- SMODS.Booster {
--     key = "power_booster_mega",
--     atlas = "booster_atlas",
--     pos = {x=3,y=0},
--     kind = "power",
--     config = {extra = 4, choose = 2},
--     weight = 0.2,
--     draw_hand = true,
--     group_key = "k_hodge_power_booster",
--     create_card = function(self,card,i)
--         return {
--             set = "power",
--             key_append = "power_booster",
--             skip_materialize = true,
--             area = G.pack_cards
--         }
--     end
-- }