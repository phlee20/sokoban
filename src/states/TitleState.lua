TitleState = Class { __includes = BaseState }

function TitleState:init()
    self.height = math.floor(SCREEN_TILE_HEIGHT / 2 + 1)
    self.width = math.floor(SCREEN_TILE_WIDTH / 2)
    self.background = self:drawBackground()
    
    -- Menu buttons
    self.currentMenuItem = 1
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('down') then
        self.currentMenuItem = self.currentMenuItem + 1
        if self.currentMenuItem > 3 then
            self.currentMenuItem = 1
        end
    elseif love.keyboard.wasPressed('up') then
        self.currentMenuItem = self.currentMenuItem - 1
        if self.currentMenuItem < 1 then
            self.currentMenuItem = 3
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        if self.currentMenuItem == 1 then
            gStateStack:push(LevelSelectState())
        elseif self.currentMenuItem == 2 then
            gStateStack:push(GridSelectState())
        else
            gStateStack:push(LevelLoadState())
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
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
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('S O K O B A N', 2, VIRTUAL_HEIGHT / 3 + 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('S O K O B A N', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])

    self:drawOptions()
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

function TitleState:drawOptions()
    love.graphics.setFont(gFonts['small'])

    -- draw play game option
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 1)
    love.graphics.printf('Play Game', 3, VIRTUAL_HEIGHT / 4 * 3 + 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if self.currentMenuItem == 1 then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    end

    love.graphics.printf('Play Game', 0, VIRTUAL_HEIGHT / 4 * 3, VIRTUAL_WIDTH, 'center')

    -- draw make new level option
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 1)
    love.graphics.printf('Create New Level', 3, VIRTUAL_HEIGHT / 4 * 3 + 50 + 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if self.currentMenuItem == 2 then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    end

    love.graphics.printf('Create New Level', 0, VIRTUAL_HEIGHT / 4 * 3 + 50, VIRTUAL_WIDTH, 'center')

    -- draw edit level option
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 1)
    love.graphics.printf('Edit Level', 3, VIRTUAL_HEIGHT / 4 * 3 + 100 + 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if self.currentMenuItem == 3 then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    end

    love.graphics.printf('Edit Level', 0, VIRTUAL_HEIGHT / 4 * 3 + 100, VIRTUAL_WIDTH, 'center')
end
