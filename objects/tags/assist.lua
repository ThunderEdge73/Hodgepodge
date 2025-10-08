SMODS.Tag {
    key = "assist",
    atlas = "tags_atlas",
    pos = {x=0,y=0},
    apply = function(self,tag,context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep("+", G.C.PURPLE, function()
                SMODS.add_card {
                    set = "Joker",
                    legendary = true,
                    stickers = {"perishable"},
                    force_stickers = true,
                    key_append = "hodge_assist"
                }
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}