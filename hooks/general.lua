-- Give cards the attribute "rendom_upgrade_big" for storing whether or not they are big
local cardInitHook = Card.init
function Card:init(X,Y,W,H,card,center,params)
    local ret = cardInitHook(self,X,Y,W,H,card,center,params)
    self.rendom_upgrade_big = false
    return ret
end-- Store a card's original ability, so that if it's changed (e.g. by the Big edition) it can be reverted
-- P.S: This is also lifted from Aikoyori's Shenanigans
local setCardAbilityHook = Card.set_ability
function Card:set_ability(c,i,d)
    local r = setCardAbilityHook(self,c,i,d)
    if (i) then
        self.rendom_orig_ability = REND.deep_copy(self.ability)
    end
    return r
end

-- Save/Load the custom attributes given to a card
local cardSave = Card.save
function Card:save()
    local c = cardSave(self)
    c.rendom_orig_ability = self.rendom_orig_ability
    c.rendom_upgrade_big = self.rendom_upgrade_big
    return c
end

local cardLoad = Card.load
function Card:load(cardTable,other_card)
    local c = cardLoad(self,cardTable,other_card)
    self.rendom_orig_ability = cardTable.rendom_orig_ability
    self.rendom_upgrade_big = cardTable.rendom_upgrade_big
    return c
end


-- -- THIS IS NO LONGER ITS EFFECT - Element of Honesty cannot be flipped
-- local blindStayFlipped = Blind.stay_flipped
-- function Blind:stay_flipped(area,card,from_area)
--     local r = blindStayFlipped(self,area,card,from_area)
--     if card and card.seal == "rendom_honesty" then
--         return false
--     else
--         return r
--     end
-- end

-- Element of Laughter Retriggers other elements
local calculateSeal = Card.calculate_seal
function Card:calculate_seal(context)
    local ret = calculateSeal(self,context)
    if context.repetition then
        if context.scoring_hand and REND and REND.table_contains and REND.table_contains(REND.elements_of_harmony,self.seal) then
            for k,v in ipairs(context.scoring_hand) do
                if v.seal == "rendom_laughter" and v ~= self then
                    return {
                        message = "Haha!",
                        repetitions = 1,
                        card = self
                    }
                end
            end
        end
    end
    return ret
end

-- Menu card
local menuHook = Game.main_menu
function Game:main_menu(ctx)
    local r = menuHook(self,ctx)
    local cards = {"rendom_SUNS_A","rendom_MOONS_A","rendom_SNAKE_A"}
    local card = cards[math.random(#cards)]
    local card = Card(0,0,G.CARD_W,G.CARD_H,G.P_CARDS[card],G.P_CENTERS.m_rendom_asbestos)
    card.T.w = card.T.w * 1.4
    card.T.h = card.T.h * 1.4
    G.title_top.T.w = G.title_top.T.w * 1.7675
    G.title_top.T.x = G.title_top.T.x - 0.8
    card:set_sprites(card.config.center)
    card.no_ui = true
    card.states.visible = false
    self.title_top:emplace(card)
    G.E_MANAGER:add_event(
        Event{
            delay = 0.5,
            func = function()
                if ctx == "splash" then
                    card.states.visible = true
                    card:start_materialize({G.C.WHITE, G.C.WHITE}, true, 2.5)
                else
                    card.states.visible = true
                    card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 1.2)
                end
                return true
            end
        }
    )
    return r
end