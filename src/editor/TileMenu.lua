TileMenu = Class {}

function TileMenu:init(x, y)
    self.x = x
    self.y = y

    self.buttons = self:generateButtons()

    self.highlightedButton = nil
end

function TileMenu:update(dt)
    
end

function TileMenu:render()    
    for _, button in ipairs(self.buttons) do
        button:render(self.x, self.y)
    end
end

function TileMenu:generateButtons()
    local buttons = {}

    local types = { WALLS[1], GROUND[1], BOXES[1], DOTS[1], PLAYER_DEF['idle-down'].frame }

    for i = 1, #types do
        table.insert(buttons, Button(1, i, types[i]))
    end

    -- add eraser button
    table.insert(buttons, Button(1, 7, ERASER))

    return buttons
end

function TileMenu:clicked(button)
    self.buttons[button]:toggle()

    if self.highlightedButton == nil then
        self.highlightedButton = button
    elseif button == self.highlightedButton then
        self.highlightedButton = nil
    else
        self.buttons[self.highlightedButton]:toggle()
        self.highlightedButton = button
    end
end