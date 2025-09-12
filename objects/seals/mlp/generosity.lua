SMODS.Seal {
    key = "generosity",
    badge_colour = HEX("BC8CF3"),
    config = {
        extra = {
            max_value = 25,
            percent = 0.25
        }
    },
    -- loc_txt = {
    --     label = "Element of Harmony",
    --     name = "Element of Generosity",
    --     text = {
    --         -- "Convert up to {C:attention}#1#%{}","of your {C:money}money{} to {C:mult}Mult{}","{C:inactive,s:0.9}Caps at {C:money,s:0.9}$#2#{}"
    --         "Other scored","{C:attention}Elements of Harmony{}","gain {C:chips}10{} Chips"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {vars = {(card.ability.seal.extra or self.config.extra).percent * 100, (card.ability.seal.extra or self.config.extra).max_value}}
    end,
    calculate = function(self,card,context)
        ---- THE BELOW IS ITS OLD EFFECT. I LIKED IT SO IM KEEPING IT HERE FOR REUSE
        -- if context.cardarea == G.play and context.main_scoring then
        --     local amount = math.min(card.ability.seal.extra.max_value,math.floor(((G.GAME.dollars + (G.GAME.dollar_buffer or 0))*card.ability.seal.extra.percent)))
        --     if amount > 0 then
        --         G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - amount
        --         G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
        --         return {dollars = -amount, mult = amount}
        --     end
        -- end
        if context.before and context.cardarea == G.play then
            for k,v in ipairs(context.scoring_hand) do
                if HODGE.table_contains(HODGE.elements_of_harmony,v.seal) and v ~= card then
                    v.ability.perma_bonus = (v.ability.perma_bonus or 0) + 10
                end
            end
        end
    end,
    atlas = "seal_atlas",
    pos = {x=3,y=1}
}