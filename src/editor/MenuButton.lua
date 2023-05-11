MenuButton = Class {}

function MenuButton:init(x, y, text, onClick)
    self.x = x
    self.y = y
    self.width = TILE_SIZE * 2
    self.height = TILE_SIZE

    self.text = text
    self.onCick = onClick or function() end
    
    self.highlighted = false
end

function MenuButton:render(x, y)
    -- love.graphics.rectangle("line", self.x + x, self.y + y, self.width, self.height)
    love.graphics.setFont(gFonts['small'])

    if self.highlighted then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    end

    love.graphics.printf(self.text, x, self.y + 16 + y, self.width, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end

function MenuButton:mouseOver(mouseX, mouseY)
    if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height then
        return true
    end

    return false
end

function MenuButton:toggle()
    self.highlighted = not self.highlighted
end