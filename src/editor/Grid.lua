Grid = Class {}

function Grid:init(x, y)
    self.x = x
    self.y = y
end

function Grid:update(dt)

end

function Grid:render(xOffset, yOffset)
    for x = 1, self.x do
        for y = 1, self.y do
            love.graphics.rectangle('line', (x - 1) * TILE_SIZE + xOffset, (y - 1) * TILE_SIZE + yOffset, TILE_SIZE, TILE_SIZE)
        end
    end
end