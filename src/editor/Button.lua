Button = Class { __includes = Tile }

function Button:init(x, y, tileID)
    Tile.init(self, x, y, tileID)

    self.selected = false
end

function Button:mouseOver(mouseX, mouseY)
    if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height then
        return true
    end

    return false
end

function Button:toggle()
    self.selected = not self.selected
end

function Button:render(x, y)
    Tile.render(self, x, y)

    if self.selected then
        love.graphics.setLineWidth(5)
        love.graphics.setColor(1, 0, 1, 1)
        love.graphics.rectangle('line', self.x + x, self.y + y, TILE_SIZE, TILE_SIZE, 5)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
    end
end