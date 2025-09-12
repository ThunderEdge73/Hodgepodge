SMODS.Joker {
    key = "synccrystal",
    -- loc_txt = {
    --     name = "Blown Away",
    --     text = {
    --         "If played hand contains a",
    --         "{C:attention}Straight{}, destroy highest",
    --         "scoring card and reduce",
    --         "blind by {C:attention}#1#%{}"
    --     }
    -- },
    loc_vars = function (self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    config = {
        extra = {
        }
    },
    atlas = "jokers_atlas",
    pos = {x=10,y=HODGE.atlas_y.misc[1]},
    soul_pos = {x=10,y=HODGE.atlas_y.soul[1]},
    rarity = 3,
    cost = 5,
    calculate = function(self,card,context)
        if context.before then
            local total_rank = 0
            local count = 0
            for _,playing_card in pairs(context.scoring_hand) do
                total_rank = total_rank + playing_card.base.id
                --print(total_rank)
                count = count+1
            end
            local average = math.floor(total_rank / count)
            for i=1, #context.scoring_hand do
                if (average > 10 and average < 14) then
                    context.scoring_hand[i].base.nominal = 10
                    local face_ranks = {"Jack","Queen","King"}
                    context.scoring_hand[i].base.value = face_ranks[(average-10)]
                elseif average == 14 then
                    context.scoring_hand[i].base.nominal = 11
                    context.scoring_hand[i].base.value = "Ace"
                else
                    context.scoring_hand[i].base.nominal = average
                    context.scoring_hand[i].base.value = tostring(average)
                end
                context.scoring_hand[i].base.id = average
                local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('card1', percent);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
            end
            for i=1, #context.scoring_hand do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = context.scoring_hand[i]
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix = average
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 or rank_suffix == 1 then rank_suffix = 'A'
                    end
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end  
            for i=1, #context.scoring_hand do
                local percent = 0.85 + (i-0.999)/(#context.scoring_hand-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('tarot2', percent, 0.6);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
            end
        end
    end,
    blueprint_compat = false,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_misc'), G.C.CHIPS, G.C.WHITE, 1.2)
    end
}