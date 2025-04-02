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

REND.elements_of_harmony = {"rendom_kindness","rendom_honesty","rendom_loyalty","rendom_laughter","rendom_generosity","rendom_magic"}

-----------------------------
----- UTILITY FUNCTIONS -----
-----------------------------

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
        helper()
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
                            table_in[k] = (ref[k] + add) * multiply -- Set it to (reference's value + add) * multiply
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

-----------------------------
----- LOADING SCRIPTS!! -----
-----------------------------

--- Hooks ---
REND.load_script("hooks/general.lua")
--- Consumeables ---
REND.load_script("consumables/power.lua")
--- Editions ---
REND.load_script("editions/big.lua")
REND.load_script("editions/terry.lua")
REND.load_script("editions/parasite.lua")
--- Enhancements ---
REND.load_script("enhancements/asbestos.lua")
REND.load_script("enhancements/blackhole.lua")
REND.load_script("enhancements/waterdamage.lua")
--- Seals ---
REND.load_script("seals/revive.lua")
REND.load_script("seals/mlp/loyalty.lua")
REND.load_script("seals/mlp/honesty.lua")
REND.load_script("seals/mlp/kindness.lua")
REND.load_script("seals/mlp/generosity.lua")
REND.load_script("seals/mlp/laughter.lua")
REND.load_script("seals/mlp/magic.lua")
--- Decks ---
REND.load_script("decks/jumbo.lua")
REND.load_script("decks/condemned.lua")
REND.load_script("decks/snake.lua")
REND.load_script("decks/friendship.lua")
--- Suits ---
REND.load_script("suits/snake.lua")
REND.load_script("suits/suns.lua")
REND.load_script("suits/moons.lua")
--- Jokers ---
REND.load_script("jokers/cupcakes.lua")
REND.load_script("jokers/blownaway.lua")