SMODS.Enhancement {
    key = "blackhole",
    -- loc_txt = {
    --     label = "Black Hole",
    --     name = "Black Hole",
    --     text = {
    --         "When scored, destroy",
    --         "other played cards and",
    --         "gain their values.",
    --         "{C:inactive,s:0.8}Currently:",
    --         "{C:chips,s:0.8}+#1#{s:0.8} Chips",
    --         "{C:mult,s:0.8}+#2#{s:0.8} Mult",
    --         "{X:mult,C:white,s:0.8}X#3#{s:0.8} Mult"
    --         --"{C:money,s:0.8}$#4#{s:0.8}"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                card.ability.chips,
                card.ability.mult,
                card.ability.x_mult
                --card.ability.money
            }
        }
    end,
    atlas = "enhancements_atlas",
    pos = {x=0,y=0},
    config = {
        chips = 0,
        mult = 0,
        x_mult = 1,
        money = 0
    },
    calculate = function(self,card,context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.chips
                --dollars = card.ability.money
            }
        end

        if context.after and context.cardarea == G.play then -- ALL CARDS HAVE 1 XMULT SO IT GOES UP FOR EVERY CARD SWALLOWED
            for i=1,#context.scoring_hand do
                if not (context.scoring_hand[i] == card) then
                    local target = context.scoring_hand[i]
                    local edition = {
                        chips = ((target.edition or {chips=0}).chips) or 0,
                        mult = ((target.edition or {mult=0}).mult) or 0,
                        x_mult = ((target.edition or {x_mult=1}).x_mult) or 1
                    }
                    local seal = {
                        chips = ((target.ability.seal or {chips=0}).chips) or 0,
                        mult = ((target.ability.seal or {mult=0}).mult) or 0,
                        x_mult = ((target.ability.seal or {x_mult=1}).x_mult) or 1
                    }
                    local total_chip_gain = target.base.nominal + target.ability.bonus + target.ability.perma_bonus + seal.chips + edition.chips
                    local total_mult_gain = target.ability.mult + seal.mult + edition.mult
                    local total_xmult_gain = target.ability.x_mult * seal.x_mult * edition.x_mult

                    -- print("Card "..i..": "..total_chip_gain.." chips | "..total_mult_gain.." mult | "..total_xmult_gain.." xmult")
                    card.ability.chips = card.ability.chips + total_chip_gain
                    card.ability.mult = card.ability.mult + total_mult_gain
                    card.ability.x_mult = card.ability.x_mult + total_xmult_gain
                end
            end
            return {
                message="Yum!",
            }
        end
    end
}