MenuButton = Class {}

function MenuButton:init(x, y, text, onClick)
    self.x = x
    self.y = y
    self.width = TILE_SIZE * 2
    self.height = TILE_SIZE

    self.text = text
    self.onCick = onClick or function() end
end

function MenuButton:render(x, y)
    love.graphics.rectangle("line", self.x + x, self.y + y, self.width, self.height)

    love.graphics.print(self.text, self.x + x, self.y + y)
end