FileMenu = Class {}

function FileMenu:init(x, y, mode)
    self.x = x
    self.y = y
    self.mode = mode

    self.buttons = self:generateButtons()

end

function FileMenu:render()
    for _, button in pairs(self.buttons) do
        button:render(self.x, self.y)
    end
end

function FileMenu:generateButtons()
    local buttons = {}

    local types = { 'Clear', 'Save', 'Delete', 'Quit' }
    if self.mode == 'new' then
        types = { 'Clear', 'Save', 'Quit' }
    end
    
    for i = 1, #types do
        buttons[types[i]] = MenuButton(0, (i - 1) * TILE_SIZE * 2, types[i])
        -- table.insert(buttons, MenuButton(0, (i - 1) * TILE_SIZE * 2, types[i]))
    end
    
    buttons['Clear'].onClick = function()
        Event.dispatch('reset')
    end

    buttons['Save'].onClick = function()
        Event.dispatch('save')
    end

    if self.mode == 'edit' then
        buttons['Delete'].onClick = function()
            Event.dispatch('delete')
        end
    end

    buttons['Quit'].onClick = function()
        gStateStack:pop()
        gStateStack:push(TitleState())
    end

    return buttons
end