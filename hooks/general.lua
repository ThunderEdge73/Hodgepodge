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