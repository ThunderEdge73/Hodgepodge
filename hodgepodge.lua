REND = SMODS.current_mod

REND.optional_features = function()
    return {
        retrigger_joker = true,
        cardareas = {
            discard = true
        }
    }
end

----------------------------
----- GLOBAL VARIABLES -----
----------------------------

REND.elements_of_harmony = {"hodge_kindness","hodge_honesty","hodge_loyalty","hodge_laughter","hodge_generosity","hodge_magic"}

REND.atlas_y = {
    misc      = { 0 },
    joke      = { 2 },
    mlp       = { 4 },
    legendary = { 6 },
    utdr      = { 8 },

    soul      = { 1, 3, 5, 7 }
}

-----------------------------
----- UTILITY FUNCTIONS -----
-----------------------------

-- stole this little number from yahimod
REND.load_custom_image = function(filename)
    local full_path = (REND.path .. "customimages/" .. filename)
    local file_data = assert(NFS.newFileData(full_path),("Failed to create file_data"))
    local tempimagedata = assert(love.image.newImageData(file_data),("Failed to create tempimagedata"))
    return (assert(love.graphics.newImage(tempimagedata),("Failed to create return image")))
end
    

REND.starts_with = function(str,start)
    return str:sub(1, #start) == start
end

REND.table_contains = function(table,value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end

REND.load_script = function(path)
    local helper, load_error = SMODS.load_file(path)
    if load_error then
        print("Loading "..path.." failed! Error: "..load_error)
    else
        if helper then
            helper()
        end
    end
end

REND.table_true_size = function(table)
    local n = 0
    for k,v in pairs(table) do
        n = n+1
    end
    return n
end

-- Thanks to aikoyori for this one! This is copied directly from the Aikoyori's Shenanigans mod lol
REND.mod_card_values = function (table_in, config)
    if not config then config = {} end
    local set = config.set or nil
    local add = config.add or 0
    local multiply = config.multiply or 1
    local keywords = config.keywords or {}
    local unkeyword = config.unkeywords or {}
    local x_protect = config.x_protect or true -- This is my addition! If true and a key starts with x_ and the value is 1, it won't multiply
    local reference = config.reference or table_in
    local function modify_values(table_in, ref)
        for k,v in pairs(table_in) do -- For key, value in the table
            if type(v) == "number" then -- If it's a number
                if (keywords[k] or (REND.table_true_size(keywords) < 1)) and not unkeyword[k] then -- If it's in the keywords, OR there's no keywords and it isn't in the unkeywords
                    if ref and ref[k] then -- If it exists in the reference
                        if not (x_protect and (REND.starts_with(k,"x_") or REND.starts_with(k,"h_x_")) and ref[k] == 1) then
                            table_in[k] = ((set or ref[k]) + add) * multiply -- Set it to (reference's value + add) * multiply
                        end
                    end
                end
            elseif type(v) == "table" then -- If it's a table
                modify_values(v, ref[k]) -- Recurse for values in the table
            end
        end
    end
    if table_in == nil then
        return
    end
    modify_values(table_in, reference)
end

-- Thanks also for this function, aiko
REND.deep_copy = function(orig,cutoff_value)
    cutoff_value = cutoff_value or orig
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if orig_type ~= cutoff_value then
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                copy[REND.deep_copy(orig_key)] = REND.deep_copy(orig_value)
            end
        end
    else
        copy = orig
    end
    return copy
end

REND.reverse_table = function(table)
    local tab = REND.deep_copy(table)
    for i = 1, math.floor(#tab/2), 1 do
        tab[i], tab[#tab-i+1] = tab[#tab-i+i], tab[i]
    end
    return tab
end

REND.first_card_merge_down = function(cards,merge) -- Get first card, with compatibility for Merge Down joker
    if merge == nil then
        merge = false
        for _,j in ipairs(G.jokers.cards) do
            if j.ability and j.ability.name == "j_hodge_mergedown" then
                merge = true
            end 
        end
    end
    if merge then
        -- print("all cards")
        return cards
    else
        if cards[1] then
            -- print("first card")
            return {cards[1]}
        else
            -- print("no cards")
            return {}
        end
    end
end

--  REND.bias_shuffle(G.deck.cards,
--      [{
--          match = function(item) return REND.table_contains(REND.elements_of_harmony,item.seal) end,
--          upper_lim = #G.deck.cards/2
--      }]
--  )
-- REND.bias_shuffle_broken = function(list, biases, seed) -- THIS DOESNT WORK!
--     if seed then math.randomseed(seed) end

--     if list[1] and list[1].sort_id then
--         table.sort(list, function (a, b) return (a.sort_id or 1) < (b.sort_id or 2) end)
--     end

--     local function is_allowed(item,index,maxindex)
--         for i,bias in ipairs(biases) do
--             if bias.match(item) then
--                 if bias.upper_lim and bias.upper_lim < index then
--                     return false
--                 end
--                 if bias.lower_lim and (bias.lower_lim > index) and not (maxindex < bias.lower_lim) then
--                     return false
--                 end
--                 -- print("bias passed")
--             end
--         end
--         -- print("all biases passed")
--         return true
--     end

--     for i = #list, 2, -1 do
--         local j = nil
--         local pass = false
--         local emergency_quit = 50
--         while emergency_quit > 0 and not pass do
--             j = math.random(i)
--             pass = is_allowed(list[i],j,i) and is_allowed(list[j],i,i)
--             emergency_quit = emergency_quit - 1
--         end
--         if emergency_quit == 0 then print("emergency quit") end
--         list[i], list[j] = list[j], list[i]
--     end
-- end

REND.force_front_shuffle = function(list, condition, lower_bound, seed)
    if seed then math.randomseed(seed) end

    if list[1] and list[1].sort_id then
        table.sort(list, function (a, b) return (a.sort_id or 1) < (b.sort_id or 2) end)
    end

    for i = #list, 2, -1 do
        local j = nil
        j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end

    for i = #list, 2, -1 do
        if condition(list[i]) and i <= lower_bound then
            --print("card where it shouldnt be")
            --print("i =",i,list[i].seal)
            local j = math.random(#list)
            while condition(list[j]) or j <= lower_bound do
                j = math.random(#list)
            end

            --print("j =",j,list[j].seal)
            list[i], list[j] = list[j], list[i]
        end
    end
end

------------------
----- Sounds -----
------------------

SMODS.Sound {
    key = "poisonogg",
    path = "Poison.ogg"
}

---------------------------
----- Texture Atlases -----
---------------------------

SMODS.Atlas {
    key = "seal_atlas",
    path = "modded_seals.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "power_atlas",
    path = "powers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tarot_atlas",
    path = "tarots.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    atlas_table = 'ANIMATION_ATLAS',
    key = "anim_power_atlas",
    path = "animated_powers.png",
    px = 71,
    py = 95,
    frames = 15
}

SMODS.Atlas {
    key = "booster_atlas",
    path = "boosters.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "enhancements_atlas",
    path = "enhancements.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "suits_atlas",
    path = "suits.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "modded_mlp_suits_atlas",
    path = "modded_mlp_suits.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "modded_mlp_suits_2_atlas",
    path = "modded_mlp_suits_2.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "icons_atlas",
    path = "icons.png",
    px = 18,
    py = 18
}

SMODS.Atlas {
    key = "decks_atlas",
    path = "decks.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "jokers_atlas",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    atlas_table = 'ANIMATION_ATLAS',
    key = "blinds_atlas",
    path = "blinds.png",
    px = 34,
    py = 34,
    frames = 21
}

SMODS.Atlas {
    key = "modicon",
    px = 32,
    py = 32,
    path = "modicon.png"
}

SMODS.Atlas {
    key = "tags",
    px = 34,
    py = 34,
    path = "tags.png"
}

-----------------------------
----- LOADING SCRIPTS!! -----
-----------------------------

------ Hooks ------
REND.load_script("hooks/general.lua")

------ Consumables ------
-- Custom Types
REND.load_script("objects/consumables/power.lua")
-- Planets
REND.load_script("objects/consumables/avalon.lua")

------ Editions ------
REND.load_script("objects/editions/big.lua")
REND.load_script("objects/editions/terry.lua")
REND.load_script("objects/editions/parasite.lua")
REND.load_script("objects/editions/glitch.lua")

------ Enhancements ------
REND.load_script("objects/enhancements/asbestos.lua")
REND.load_script("objects/enhancements/blackhole.lua")
REND.load_script("objects/enhancements/waterdamage.lua")

------ Seals ------
-- Misc
REND.load_script("objects/seals/revive.lua")
-- MLP
REND.load_script("objects/seals/mlp/loyalty.lua")
REND.load_script("objects/seals/mlp/honesty.lua")
REND.load_script("objects/seals/mlp/kindness.lua")
REND.load_script("objects/seals/mlp/generosity.lua")
REND.load_script("objects/seals/mlp/laughter.lua")
REND.load_script("objects/seals/mlp/magic.lua")

------ Decks ------
REND.load_script("objects/decks/jumbo.lua")
REND.load_script("objects/decks/condemned.lua")
REND.load_script("objects/decks/boardgame.lua")
REND.load_script("objects/decks/friendship.lua")

----- Suits ------
-- Snakes n Ladders
REND.load_script("objects/suits/snake.lua")
REND.load_script("objects/suits/ladders.lua")
-- MLP
REND.load_script("objects/suits/suns.lua")
REND.load_script("objects/suits/moons.lua")

------ Jokers ------
-- Page 1 - Misc
REND.load_script("objects/jokers/misc/placeholder.lua")
REND.load_script("objects/jokers/misc/brokenrecord.lua")
REND.load_script("objects/jokers/misc/spaghettification.lua")
REND.load_script("objects/jokers/misc/catapult.lua")
REND.load_script("objects/jokers/misc/cocksley.lua")

REND.load_script("objects/jokers/misc/ricoshot.lua")
REND.load_script("objects/jokers/misc/projectileboost.lua")
REND.load_script("objects/jokers/misc/exploded.lua")
REND.load_script("objects/jokers/misc/arsenal.lua")
REND.load_script("objects/jokers/misc/overkill.lua")

REND.load_script("objects/jokers/misc/synccrystal.lua")
REND.load_script("objects/jokers/misc/combo.lua")
REND.load_script("objects/jokers/misc/mergedown.lua")
REND.load_script("objects/jokers/misc/blownaway.lua")
REND.load_script("objects/jokers/misc/metamorphosis.lua")
-- Page 2 - Joke
REND.load_script("objects/jokers/joke/hydra.lua")
REND.load_script("objects/jokers/joke/handcrank.lua")
REND.load_script("objects/jokers/joke/cyan.lua")
REND.load_script("objects/jokers/joke/disappearingguy.lua")
REND.load_script("objects/jokers/joke/lowpercent.lua")

REND.load_script("objects/jokers/joke/vestup.lua")
REND.load_script("objects/jokers/joke/nft.lua")
REND.load_script("objects/jokers/joke/stopsign.lua")
REND.load_script("objects/jokers/joke/lostcount.lua")
REND.load_script("objects/jokers/joke/big gamba.lua")

REND.load_script("objects/jokers/joke/shooketh.lua")
REND.load_script("objects/jokers/joke/ppe.lua")
REND.load_script("objects/jokers/joke/sou.lua")
REND.load_script("objects/jokers/joke/nonejoker.lua")
REND.load_script("objects/jokers/joke/parappa.lua")

-- Page 3 - MLP
REND.load_script("objects/jokers/mlp/summersun.lua")
REND.load_script("objects/jokers/mlp/nightmarenight.lua")
REND.load_script("objects/jokers/mlp/twilightsparkle.lua")
REND.load_script("objects/jokers/mlp/amber.lua")
REND.load_script("objects/jokers/mlp/moonrock.lua")

REND.load_script("objects/jokers/mlp/rainbowdash.lua")
REND.load_script("objects/jokers/mlp/pinkiepie.lua")
REND.load_script("objects/jokers/mlp/fluttershy.lua")
REND.load_script("objects/jokers/mlp/rarity.lua")
REND.load_script("objects/jokers/mlp/applejack.lua")

REND.load_script("objects/jokers/mlp/rainbowfactory.lua")
REND.load_script("objects/jokers/mlp/cupcakes.lua")
REND.load_script("objects/jokers/mlp/butterflies.lua")
REND.load_script("objects/jokers/mlp/littlemissrarity.lua")
REND.load_script("objects/jokers/mlp/applesleepexperiment.lua")

-- Page 4 - Legendaries
REND.load_script("objects/jokers/misc/lumi.lua")
REND.load_script("objects/jokers/joke/david.lua")
REND.load_script("objects/jokers/pokemon/missingno.lua")
REND.load_script("objects/jokers/pokemon/badegg.lua") -- does... does this count?
REND.load_script("objects/jokers/mlp/timeloop.lua") --this fucker is soooooo broken
-- Page 5 - UTDR
-- REND.load_script("objects/jokers/utdr/prophecy.lua")


------ Blinds ------
REND.load_script("objects/blinds/name.lua") -- I CURSE THE NAME THE ONE BEHIND IT ALLLLLLLLLLLLLLLLLLLLLLL
REND.load_script("objects/blinds/pip.lua") -- who up tipping they pip

------ Challenges ------
REND.load_script("objects/challenges/battleroyale.lua")

REND.load_script("collabs/mlp.lua")

--test commit