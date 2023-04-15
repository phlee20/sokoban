Box = Class {__includes = Tile}

function Box:init(x, y, tileID)
    Tile.init(self, x, y, tileID)

    self.onDot = false

end

function Box:update(dt)

end

function Box:render(x, y)
    love.graphics.setColor(1, 1, 1, 1)

    -- shade the box if it's on a dot
    if self.onDot then
        love.graphics.setColor(100 / 255, 1, 0, 1)
    end

    Tile.render(self, x, y)

    love.graphics.setColor(1, 1, 1, 1)
end

function Box:exists(x, y)
    return self.gridX == x and self.gridY == y
end