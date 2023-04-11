Box = Class {__includes = Tile}

function Box:init(x, y, tileID)
    Tile.init(self, x, y, tileID)

end

function Box:update(dt)

end

function Box:render(x, y)
    Tile.render(self, x, y)
end

function Box:exists(x, y)
    return self.gridX == x and self.gridY == y
end

function Box:move(x, y)
    self.gridX = x
    self.gridY = y

    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE
end
