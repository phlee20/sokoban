LevelSelectState = Class { __includes = BaseState }

function LevelSelectState:init()
    self.level = 1
end

function LevelSelectState:update(dt)
    if love.keyboard.wasPressed('right') then
        self.level = math.min(self.level + 1, MAX_LEVEL)
    elseif love.keyboard.wasPressed('left') then
        self.level = math.max(self.level - 1, 1)
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(PlayState(self.level))
    end
end

function LevelSelectState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select Level', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.printf("< " .. self.level .. " >", 0, VIRTUAL_HEIGHT / 3 * 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
end
