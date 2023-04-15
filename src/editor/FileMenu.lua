FileMenu = Class {}

function FileMenu:init(x, y)
    self.x = x
    self.y = y

    self.buttons = self:generateButtons()

end

function FileMenu:render()
    for _, button in ipairs(self.buttons) do
        button:render(self.x, self.y)
    end
end

function FileMenu:generateButtons()
    local buttons = {}

    local types = { 'Reset', 'Save', 'Load' }
    
    for i = 1, #types do
        table.insert(buttons, MenuButton(0, (i - 1) * TILE_SIZE * 2, types[i]))
    end
    

    return buttons
end