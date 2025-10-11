SMODS.Joker {
    key = "sou",
    loc_vars = function (self,info_queue,card)
        return {
            vars = {}
        }
    end,
    config = {
    },
    atlas = "jokers_atlas",
    pos = {x=12,y=HODGE.atlas_y.joke[1]},
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.after and context.main_eval then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,chips = G.GAME.hands[context.scoring_name].chips, mult = G.GAME.hands[context.scoring_name].mult, level=G.GAME.hands[context.scoring_name].level})
            level_up_hand(card, context.scoring_name, false, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
        if context.destroy_card and context.cardarea == G.play and not context.blueprint then
            return {
                remove = true
            }
        end
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = HODGE.badge('category','joke')
    end
}

