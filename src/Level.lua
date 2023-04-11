Level = Class {}

function Level:init(lvl)
    -- Get level layout and max height and width
    self.levelLayout = LEVEL_DEF[lvl]
    self.levelHeight = #self.levelLayout
    self.levelWidth = #self.levelLayout[1]

    self.tiles = {}
    self.boxes = {}
    self.dots = {}
    self.xPlayerStart = nil
    self.yPlayerStart = nil
    self:generateMap()

    -- Centering offsets for the map to the screen
    self.xRenderOffset = (SCREEN_TILE_WIDTH - self.levelWidth) / 2 * TILE_SIZE
    self.yRenderOffset = (SCREEN_TILE_HEIGHT - self.levelHeight) / 2 * TILE_SIZE

    self.player = Player(self)

end

function Level:update(dt)
    self.player:update(dt)
    
end

function Level:render()
    for x = 1, self.levelHeight do
        for y = 1, self.levelWidth do
            self.tiles[x][y]:render(self.xRenderOffset, self.yRenderOffset)
        end
    end

    for k, v in ipairs(self.boxes) do
        v:render(self.xRenderOffset, self.yRenderOffset)
    end

    for k, v in ipairs(self.dots) do
        v:render(self.xRenderOffset, self.yRenderOffset)
    end

    self.player:render(self.xRenderOffset, self.yRenderOffset)
end

function Level:generateMap()
    local tileID = nil

    for y = 1, self.levelHeight do
        table.insert(self.tiles, {})
        for x = 1, self.levelWidth do
            -- add walls and ground tiles
            if self.levelLayout[y][x] == 1 then
                tileID = WALLS[1]
            elseif self.levelLayout[y][x] == 2 then
                tileID = BLANK[1]
            else
                tileID = GROUND[1]
            end

            table.insert(self.tiles[y], Tile(x, y, tileID))

            -- add boxes and dots
            if self.levelLayout[y][x] == 3 then
                tileID = BOXES[1]
                table.insert(self.boxes, Box(x, y, tileID))
            elseif self.levelLayout[y][x] == 4 then
                tileID = DOTS[1]
                table.insert(self.dots, Dot(x, y, tileID))

                -- locate the player starting position
            elseif self.levelLayout[y][x] == 5 then
                self.xPlayerStart = x
                self.yPlayerStart = y
            end
        end
    end
end

function Level:isWall(x, y)
    return self.tiles[y][x].id == WALLS[1]
end