Tile = Class {}

function Tile:init(x, y, tileID, scale)
    self.gridX = x
    self.gridY = y
    self.scale = scale or 1

    self.x = (self.gridX - 1) * TILE_SIZE * self.scale
    self.y = (self.gridY - 1) * TILE_SIZE * self.scale
    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = tileID

end

function Tile:render(x, y)
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.id], self.x + x, self.y + y,
        0, self.scale, self.scale)
end

function Tile:move(x, y)
    self.gridX = x
    self.gridY = y

    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE
end
