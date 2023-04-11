function GenerateBackground(atlas)
    local quad = love.graphics.newQuad(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
        atlas:getWidth(), atlas:getHeight()
    )
    return quad
end

--[[
    Generates all the quads for the game given an 'atlas'.
]]

function GenerateQuads(atlas, tilewidth, tileheight, xOffset, yOffset)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    -- trims the sprite if extra padding exists
    local xOffset = xOffset or 0
    local yOffset = yOffset or 0

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth + xOffset, y * tileheight + yOffset,
                tilewidth - xOffset * 2, tileheight - yOffset * 2, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end