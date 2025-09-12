SMODS.Joker {
    key = "nft",
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'nft')
        return {
            vars = {
                card.ability.extra.sell_mult,
                numerator,
                denominator
            }
        }
    end,
    config = {
        extra = {
            sell_mult = 1.5,
            odds = 20,
            unrounded = nil
        }
    },
    atlas = "jokers_atlas",
    pos = {x=6,y=HODGE.atlas_y.joke[1]},
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.setting_blind then
            if card.ability.extra.unrounded then
                card.ability.extra.unrounded = card.ability.extra.unrounded * card.ability.extra.sell_mult
            else
                card.ability.extra.unrounded = card.sell_cost * card.ability.extra.sell_mult 
            end
            card.sell_cost = math.floor(card.ability.extra.unrounded + 0.5)
            return {
                message = "X"..card.ability.extra.sell_mult.."$"
            }
        end
        if context.individual and context.cardarea == G.play then
            --if pseudorandom("nft") < (G.GAME.probabilities.normal or 1)/(card.ability.extra.odds) then
            if SMODS.pseudorandom_probability(card, 'nft', 1, card.ability.extra.odds, 'nft') then
                card.sell_cost = 0
                card.ability.extra.unrounded = 0
                return {
                    message = "Right Clicked!"
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_joke'), G.C.GREEN, G.C.WHITE, 1.2)
    end
}

