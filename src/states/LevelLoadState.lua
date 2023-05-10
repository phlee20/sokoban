LevelLoadState = Class { __includes = BaseState }

function LevelLoadState:init()
    self.level = 1
end

function LevelLoadState:update(dt)
    if love.keyboard.wasPressed('right') then
        self.level = self.level + 1
        if self.level > #gLevels then
            self.level = 1
        end
    elseif love.keyboard.wasPressed('left') then
        self.level = self.level - 1
        if self.level < 1 then
            self.level = #gLevels
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(EditorState(#gLevels[self.level][1], #gLevels[self.level], self.level))
    end

    if love.keyboard.wasPressed('escape') then
        gStateStack:pop()
        gStateStack:push(TitleState())
    end
end

function LevelLoadState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select Level', 0, VIRTUAL_HEIGHT / 5, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("< " .. self.level .. " >", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
end