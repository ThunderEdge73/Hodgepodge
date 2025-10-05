local shader = SMODS.Shader {
    key = "prophecy",
    path = "prophecy.fs"
}

HODGE.prophecy_image = HODGE.load_custom_image("depths.png")

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

-- generate_shader_atlas("hodge_jokers_atlas","hodge_depths_jokers_atlas","prophecy",{mask_texture = HODGE.prophecy_image})

--HODGE.prophecy_canvas = love.graphics.newCanvas(w*G.CANV_SCALE, h*G.CANV_SCALE, {type = '2d', readable = true})

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
    atlas = "jokers_atlas",
    pos = {x=1,y=HODGE.atlas_y.utdr[1]},
    rarity = 2,
    cost = 6,
    calculate = function(self,card,context)
    end,
    blueprint_compat = true,
    in_pool = function(self,args)
    end,
    set_badges = function(self,card,badges)
        HODGE.badge('category','utdr')
    end
    -- draw = function(self, card, layer)
    --     love.graphics.push("all")

    --     love.graphics.setCanvas(HODGE.prophecy_canvas)
    --     love.graphics.setColor(1,1,1,1)

    --     G.SHADERS["hodge_prophecy"]:send("mask_texture",HODGE.prophecy_image)
    --     card.children.center:draw_shader("hodge_prophecy", nil,card.ARGS.send_to_shader)

    --     love.graphics.pop()
    -- end
}

SMODS.DrawStep {
    key = "prophecy_drawstep",
    order = 25,
    func = function(card,layer)
        local canvas = love.graphics.getCanvas()
        love.graphics.setCanvas(HODGE.prophecy_canvas)
        love.graphics.clear()
        card.children.center:draw()

        love.graphics.setCanvas(canvas)
        love.graphics.setShader( G.SHADERS['hodge_prophecy'])
        G.SHADERS["hodge_prophecy"]:send("mask_texture",HODGE.prophecy_image)
        love.graphics.draw(HODGE.prophecy_canvas,0,0)
        --card.children.center:draw_shader("hodge_prophecy", nil,card.ARGS.send_to_shader)
    end,
    conditions = {facing = "front"}
}

