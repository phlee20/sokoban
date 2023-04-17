GridSelectState = Class { __includes = BaseState }

function GridSelectState:init()
    self.gridWidth = 5
    self.gridHeight = 5

    self.highlighted = 1
end

function GridSelectState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.highlighted = self.highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('right') then
        if self.highlighted == 1 then
            self.gridWidth = math.min(self.gridWidth + 1, 14)
        else
            self.gridHeight = math.min(self.gridHeight + 1, 10)
        end
    elseif love.keyboard.wasPressed('left') then
        if self.highlighted == 1 then
            self.gridWidth = math.max(self.gridWidth - 1, 5)
        else
            self.gridHeight = math.max(self.gridHeight - 1, 5)
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(EditorState(self.gridWidth, self.gridHeight))
    end
end

function GridSelectState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select Grid Size', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])

    if self.highlighted == 2 then
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.printf('Width', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("< " .. self.gridWidth .. " >", 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')
    
    if self.highlighted == 1 then
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.printf('Height', 0, VIRTUAL_HEIGHT / 4 * 3, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("< " .. self.gridHeight .. " >", 0, VIRTUAL_HEIGHT / 4 * 3 + 50, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end
