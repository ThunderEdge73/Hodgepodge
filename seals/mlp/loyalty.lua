SMODS.Seal {
    key = "loyalty",
    badge_colour = HEX("F94448"),
    config = {
        extra = 2
    },
    -- loc_txt = {
    --     label = "Element of Loyalty",
    --     name = "Element of Loyalty",
    --     text = {
    --         "{C:green}#1# in #2#{} chance to","return to hand when played"
    --     }
    -- },
    loc_vars = function(self,info_queue,card)
        return {vars = {G.GAME.probabilities.normal or 1, card.ability.seal.extra}}
    end,
    atlas = "seal_atlas",
    calculate = function(self,card,context)
        if context.after and context.cardarea == G.play then
            if pseudorandom("loyalty") < (G.GAME.probabilities.normal or 1) / card.ability.seal.extra then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        draw_card(G.discard, G.hand, nil, nil, nil ,card, nil, nil, false, nil, nil) --from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only
                        return true
                    end
                }))
            end
        end
    end,
    pos = {x=2,y=0}
}
