TitleState = Class { __includes = BaseState }

function TitleState:init()
    self.height = math.floor(SCREEN_TILE_HEIGHT / 2 + 1)
    self.width = math.floor(SCREEN_TILE_WIDTH / 2)
    self.background = self:drawBackground()

end

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(EditorState())
        -- gStateStack:push(PlayState(1))
    end
end

function TitleState:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.background[x][y]:render(0, 0)
        end
    end

    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][PLAYER_DEF['idle-down'].frame],
        VIRTUAL_WIDTH / 2 - TILE_SIZE, TILE_SIZE * 6 + 16, 0, 2, 2)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('S O K O B A N', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 4 * 3, VIRTUAL_WIDTH, 'center')
end

function TitleState:drawBackground()
    local tiles = {}

    local tileID = nil

    for x = 1, self.width do
        table.insert(tiles, {})

        local boxHeight = math.random(3)

        for y = self.height, 1, -1 do

            -- chance to draw box

            -- draw background green and ground
            if y < 5 then
                if boxHeight > 0 then
                    tileID = BOXES[1]
                    boxHeight = boxHeight - 1
                else
                    tileID = GROUND[2]
                end
            else
                tileID = GROUND[1]
            end

            local tile = Tile(x, y, tileID, 2)

            table.insert(tiles[x], tile)

            --[[
            if math.random(3) == 1 then
                tileID = BOXES[1]
                love.graphics.draw(gTextures['retina'], gFrames['retina'][tileID], (x - 1) * TILE_SIZE * 2,
                    (y - 1) * TILE_SIZE * 2)
            end
            ]]
        end
    end

    return tiles
end