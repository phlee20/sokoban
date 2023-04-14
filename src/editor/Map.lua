Map = Class { __includes = Grid }

function Map:init(x, y)
    Grid.init(self, x, y)

    self.tiles = {}
    self:resetMap()

    self.boxes = {}
    self.dots = {}
    self.player = nil
end

function Map:update(dt)

end

function Map:render(xOffset, yOffset)
    for x = 1, self.gridY do
        for y = 1, self.gridX do
            self.tiles[x][y]:render(xOffset, yOffset)
        end
    end

    for k, v in ipairs(self.boxes) do
        v:render(xOffset, yOffset)
    end
end

function Map:resetMap()
    local tileID = BLANK[1]

    for y = 1, self.gridY do
        table.insert(self.tiles, {})
        for x = 1, self.gridX do
            table.insert(self.tiles[y], Tile(x, y, tileID))
        end
    end
end

function Map:mouseOverGrid(mouseX, mouseY)
    return mouseX > self.x and mouseX < self.width and mouseY > self.y and mouseY < self.height
end

function Map:pointToTile(mouseX, mouseY)
    local tileX = math.floor(mouseX / TILE_SIZE) + 1
    local tileY = math.floor(mouseY / TILE_SIZE) + 1

    return tileX, tileY
end

function Map:editTile(x, y, highlightedButton)
    if self.tiles[y][x].id == BLANK[1] then
        if highlightedButton == WALLS[1] or highlightedButton == GROUND[1] then
            self.tiles[y][x].id = highlightedButton
        end
    elseif self.tiles[y][x].id == GROUND[1] then
        if highlightedButton == BOXES[1] then
            if self:tileExists(x, y, highlightedButton) then
                table.insert(self.boxes, Box(x, y, BOXES[1]))
            end
        end
    end
end

function Map:tileExists(x, y, type)
    -- nothing can be on top of a box
    for k, v in ipairs(self.boxes) do
        if v.gridX == x and v.gridY == y then
            return false
        end
    end

    
    return true
end