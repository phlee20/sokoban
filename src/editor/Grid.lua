Grid = Class {}

function Grid:init(x, y)
    self.gridX = x
    self.gridY = y
end

function Grid:update(dt)

end

function Grid:render(xOffset, yOffset)
    for x = 1, self.gridX do
        for y = 1, self.gridY do
            love.graphics.rectangle('line', (x - 1) * TILE_SIZE + xOffset, (y - 1) * TILE_SIZE + yOffset, TILE_SIZE, TILE_SIZE)
        end
    end
end