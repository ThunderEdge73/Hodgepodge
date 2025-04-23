SMODS.Joker {
    key = "timeloop",
    loc_txt = {
        name = "Day 734",
        text = {
            -- "{C:dark_edition}+1{} Joker Slot",
            "After {C:attention}Boss Blind{} is defeated,",
            "rewind to start of the Ante.",
            "{C:gold}Money{}, {C:attention}Jokers{}, {C:attention}Shops{}, etc. are",
            "included in the rewind.",
            "{C:inactive,s:0.9}#1#{}"
        }
    },
    loc_vars = function (self,info_queue,card)
        -- card.ability.extra.loop_started_ui = card.ability.extra.loop_started_ui or ""
        local loop_active_text = "ERROR: shits fucked idk"
        if card.ability.extra.loop_started then
            loop_active_text = "Loop active."
        else
            loop_active_text = "Waiting for new ante..."
        end
        return {
            vars = {
                loop_active_text
            },
            -- main_end = (card.area and card.area == G.jokers) and {
            --     {
            --         n = G.UIT.C,
            --         config = { aligh = "bm", minh = 0.4},
            --         nodes = {
            --             {
            --                 n = G.UIT.C,
            --                 config = {
            --                     ref_table = card,
            --                     align = "m",
            --                     colour = G.C.JOKER_GREY,
            --                     r = 0.05,
            --                     padding = 0.06,
            --                     func = "blueprint_compat"
            --                 },
            --                 nodes = {
            --                     {
            --                         n = G.UIT.T,
            --                         config = {
            --                             ref_table = card.ability.extra,
            --                             ref_value = "loop_started_ui",
            --                             colour = G.C.UI.TEXT_LIGHT,
            --                             scale = 0.32 * 0.8
            --                         }
            --                     }
            --                 }
            --             }
            --         }
            --     }
            -- } or nil
        }
    end,
    -- update = function(self, card, front)
    --     if G.STAGE == G.STAGES.RUN then
    --         if card.ability.extra.loop_started then
    --             card.ability.extra.loop_started_ui = "loop started"
    --         else
    --             card.ability.extra.loop_started_ui = "loop not started"
    --         end
    --     end
    -- end,
    config = {
        extra = {
            -- loop_started_ui = "loop not started",
            loop_started = false,
            days = 734 --just for display
        }
    },
    atlas = "jokers_atlas",
    pos = {x=5,y=2},
    soul_pos = {x=6,y=2},
    rarity = 4,
    cost = 20,
    calculate = function(self,card,context)
        if context.starting_shop and G.GAME.rend_last_blind_type == 'Boss' and not context.blueprint then
            if G.GAME.rend_loop_save and card.ability.extra.loop_started then
                G.GAME.rend_loop_incoming = true
                print("load")
                savetext = STR_UNPACK(G.GAME.rend_loop_save)
                -- G.E_MANAGER:add_event(
                --     Event({
                --         trigger = "after",
                --         delay = G.SETTINGS.GAMESPEED,
                --         func = function()
                --             G:delete_run()
                --             G:start_run({
                --                 savetext = STR_UNPACK(G.GAME.rend_loop_save)
                --             })
                --         end
                --     }),
                --     "other"
                -- )
            else
                card.ability.extra.loop_started = true
                print("save")
                G.GAME.rend_loop_save = STR_PACK(G.culled_table)
                -- G.E_MANAGER:add_event(
                --     Event({
                --         trigger = "after",
                --         delay = G.SETTINGS.GAMESPEED,
                --         func = function()
                --             G.GAME.rend_loop_save = STR_PACK(G.culled_table)
                --         end
                --     }),
                --     "other"
                -- )
            end
        end
    end, --TODO: make this joker survive the time loop. maybe hook save_run or maybye save to a profile (G.PROFILES[G.SETTINGS.profile].var_name)
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_mlp'), G.C.PURPLE, G.C.WHITE, 1.2)
    end
}
