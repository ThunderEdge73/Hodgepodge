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