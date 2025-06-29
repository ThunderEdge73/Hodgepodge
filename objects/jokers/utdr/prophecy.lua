local shader = SMODS.Shader {
    key = "prophecy",
    path = "prophecy.fs"
}

REND.prophecy_image = REND.load_custom_image("depths.png")

-- I DIDNT NEED AN OF THIS STUFF DOWN HERE AT ALl!! IT WAS ALL WRONG!!!!!! I LOVE GRAPHICS CODE

-- -- function modified from the blueprint mod
-- local function preapply_shader_to_atlas(image, shader_key, shader_args)
--     local width, height = image:getDimensions()
--     local canvas = love.graphics.newCanvas(width, height, {type = '2d', readable = true, dpiscale = image:getDPIScale()})

--     love.graphics.push("all")

--     love.graphics.setCanvas(canvas)
--     love.graphics.clear({0,0,0,0})

--     love.graphics.setColor(1,1,1,1)

--     for k,v in pairs(shader_args) do
--         G.SHADERS[shader_key]:send(k, v)
--     end
--     love.graphics.setShader(G.SHADERS[shader_key])

--     love.graphics.draw(image)

--     love.graphics.pop()

--     return love.graphics.newImage(canvas:newImageData(), {mipmaps = true, dpiscale = image:getDPIScale()})
-- end

-- local function generate_shader_atlas(atlas_key,new_key,shader_key,shader_args)
--     if not G.ASSET_ATLAS[new_key] then
--         G.ASSET_ATLAS[new_key] = {}
--         G.ASSET_ATLAS[new_key].name = G.ASSET_ATLAS[atlas_key].name
--         G.ASSET_ATLAS[new_key].type = G.ASSET_ATLAS[atlas_key].type
--         G.ASSET_ATLAS[new_key].px = G.ASSET_ATLAS[atlas_key].px
--         G.ASSET_ATLAS[new_key].py = G.ASSET_ATLAS[atlas_key].py
--         G.ASSET_ATLAS[new_key].image = preapply_shader_to_atlas(G.ASSET_ATLAS[atlas_key].image, shader_key, shader_args)
--     end
-- end

-- generate_shader_atlas("rendom_jokers_atlas","rendom_depths_jokers_atlas","prophecy",{mask_texture = REND.prophecy_image})

REND.prophecy_canvas = love.graphics.newCanvas(71, 95, {type = '2d', readable = true})

SMODS.Joker {
    key = "prophecy",
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
    atlas = "depths_jokers_atlas",
    pos = {x=1,y=REND.atlas_y.utdr[1]},
    rarity = 2,
    cost = 6,
    calculate = function(self,card,context)
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
    end,
    set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_badge_utdr'), G.C.MULT, G.C.BLACK, 1.2)
    end,
    draw = function(self, card, layer)
        -- love.graphics.push("all")

        -- love.graphics.setCanvas(REND.prophecy_canvas)
        -- love.graphics.setColor(1,1,1,1)

        -- G.SHADERS["rendom_prophecy"]:send("mask_texture",REND.prophecy_image)
        -- card.children.center:draw_shader("rendom_prophecy", nil,card.ARGS.send_to_shader)

        -- love.graphics.pop()
    end
}

-- SMODS.DrawStep {
--     key = "prophecy_drawstep",
--     order = 25,
--     func = function(card,layer)
--         G.SHADERS["rendom_prophecy"]:send("mask_texture",REND.prophecy_image)
--         card.children.center:draw_shader("rendom_prophecy", nil,card.ARGS.send_to_shader)
--     end,
--     conditions = {facing = "front"}
-- }