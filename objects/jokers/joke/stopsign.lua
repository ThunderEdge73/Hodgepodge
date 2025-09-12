SMODS.Joker {
    key = "stopsign",
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'stopsign')
        return {
            vars = {card.ability.extra.rank,numerator,denominator,card.ability.extra.permamult}
        }
    end,
    config = {
        extra = {
            permamult = 8,
            odds = 8,
            rank = "8"
        }
    },
    atlas = "jokers_atlas",
    pos = {x=7,y=HODGE.atlas_y.joke[1]},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    calculate = function(self,card,context) --G.GAME.blind.config.blind.key
        if context.setting_blind and G.GAME.blind.config.blind.key == "bl_hodge_pip" then
            card.config.center.pos.y = 3
            card.ability.extra.permamult = 6
            card.ability.extra.rank = "6"
        end
        if context.end_of_round and G.GAME.blind.config.blind.key == "bl_hodge_pip" then
            card.config.center.pos.y = 2
            card.ability.extra.permamult = 8
            card.ability.extra.rank = "8"
        end
        if context.individual and context.cardarea == G.play then
            --if context.other_card.base.value == "8" and pseudorandom("stopsign") < (G.GAME.probabilities.normal or 1)/(card.ability.extra.odds) then
            if context.other_card.base.value == card.ability.extra.rank and SMODS.pseudorandom_probability(card, 'stopsign', 1, card.ability.extra.odds, 'stopsign') then
                --print("stopsign hit")
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.permamult
                return {
                    card = context.other_card,
                    message = "Upgrade!"
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

