SMODS.Joker {
    key = "nft",
    loc_vars = function (self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator_neg, card.ability.extra.odds, 'nft')
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
            numerator_neg = 1,
            unrounded_sell_value = nil
        }
    },
    atlas = "jokers_atlas",
    pos = {x=6,y=HODGE.atlas_y.joke[1]},
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.unrounded_sell_value then
                if math.floor(card.ability.extra.unrounded_sell_value + 0.5) ~= card.sell_cost then 
                    --was modified externally
                    card.ability.extra.unrounded_sell_value = card.sell_cost
                end
                card.ability.extra.unrounded_sell_value = card.ability.extra.unrounded_sell_value * card.ability.extra.sell_mult
            else
                card.ability.extra.unrounded_sell_value = card.sell_cost * card.ability.extra.sell_mult 
            end
            card.sell_cost = math.floor(card.ability.extra.unrounded_sell_value + 0.5)
            return {
                message = "X"..card.ability.extra.sell_mult.."$"
            }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            --if pseudorandom("nft") < (G.GAME.probabilities.normal or 1)/(card.ability.extra.odds) then
            if SMODS.pseudorandom_probability(card, 'nft', card.ability.extra.numerator_neg, card.ability.extra.odds, 'nft') then
                card.sell_cost = 0
                card.ability.extra.unrounded_sell_value = 0
                return {
                    message = "Right Clicked!",
                    message_card = card
                }
            end
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

