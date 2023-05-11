Level = Class {}

function Level:init(lvl)
    -- Get level layout and max height and width
    self.levelLayout = gLevels[lvl]
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

end

function Level:update(dt)

end

function Level:render()
    for x = 1, self.levelHeight do
        for y = 1, self.levelWidth do
            self.tiles[x][y]:render(self.xRenderOffset, self.yRenderOffset)
        end
    end

    for k, v in ipairs(self.dots) do
        v:render(self.xRenderOffset, self.yRenderOffset)
    end

    for k, v in ipairs(self.boxes) do
        v:render(self.xRenderOffset, self.yRenderOffset)
    end
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
            if self.levelLayout[y][x] == 3 or self.levelLayout[y][x] == 6 then
                tileID = BOXES[1]
                table.insert(self.boxes, Box(x, y, tileID))
            end

            if self.levelLayout[y][x] == 4 or self.levelLayout[y][x] == 6 then
                tileID = DOTS[1]
                table.insert(self.dots, Dot(x, y, tileID))
            end

            -- locate the player starting position
            if self.levelLayout[y][x] == 5 then
                self.xPlayerStart = x
                self.yPlayerStart = y
            end
        end
    end
end

function Level:isWall(x, y)
    return self.tiles[y][x].id == WALLS[1]
end

function Level:isSolved()
    local numDots = 0

    for _, box in ipairs(self.boxes) do
        for _, dot in ipairs(self.dots) do
            -- checks if boxes are on dots
            if dot.gridX == box.gridX and dot.gridY == box.gridY then
                numDots = numDots + 1
                box.onDot = true
                break
            else
                box.onDot = false
            end
        end
    end
    
    return numDots == #self.dots
end