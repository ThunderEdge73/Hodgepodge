SMODS.Blind {
    key = "name",
    loc_txt = {
        name = "The Name",
        text = {
            "Debuffs all","Elements of Harmony"
        }
    },
    atlas = "blinds_atlas",
    pos = {x=0},
    recalc_debuff = function(self, card, from_blind)
        if REND.table_contains(REND.elements_of_harmony,card.seal) then
            return true
        end
        return false
    end,
    mult = 2,
    boss = {min = 1, max = 69}, -- Max isn't used
    boss_colour = HEX("5f312d"),
    in_pool = function(self)
        if G.playing_cards then
            print("playing cards")
            local elements = 0
            for k,card in ipairs(G.playing_cards) do
                if REND.table_contains(REND.elements_of_harmony,card.seal) then
                    elements = elements + 1
                end
            end
            if elements >= #G.playing_cards / 10 then
                return true
            end
        end
        return false
    end
}