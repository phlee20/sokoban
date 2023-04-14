Map = Class { __includes = Grid }

function Map:init(x, y)
    Grid.init(self, x, y)

    self.tiles = {}
    self:resetMap()
end

function Map:update(dt)

end

function Map:render(xOffset, yOffset)
    for x = 1, self.gridY do
        for y = 1, self.gridX do
            self.tiles[x][y]:render(xOffset, yOffset)
        end
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

function Map:editTile(x, y)
    self.tiles[y][x].id = WALLS[1]
end