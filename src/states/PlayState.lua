PlayState = Class { __includes = BaseState }

function PlayState:init(currentLevel)
    self.currentLevel = currentLevel
    self.level = Level(self.currentLevel)
    self.player = Player(self.level)

    self.moves = 0
    self.solved = false

    -- initial check for boxes on dots
    self.level:isSolved()

    Event.on('checkSolve', function()
        self.moves = self.moves + 1
        if self.level:isSolved() then
            self.solved = true
        end
    end)
end

function PlayState:update(dt)
    if not self.solved then
        self.level:update(dt)
        self.player:update(dt)

        -- restart the level
        if love.keyboard.wasPressed('r') then
            gStateStack:pop()
            gStateStack:push(PlayState(self.currentLevel))
        end
    else
        -- go to next level
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            gStateStack:pop()
            if self.currentLevel == #gLevels then
                gStateStack:push(TitleState())
            else
                gStateStack:push(PlayState(self.currentLevel + 1))
            end
        end
    end
    
    if love.keyboard.wasPressed('escape') then
        gStateStack:pop()
        gStateStack:push(LevelSelectState())
    end
end

function PlayState:render()
    self.level:render()
    self.player:render(self.level.xRenderOffset, self.level.yRenderOffset)

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Level ' .. self.currentLevel, 20, 20)

    love.graphics.print('Moves: ' .. tostring(self.moves), VIRTUAL_WIDTH - 160, 20)

    love.graphics.print('(r)eset', 20, VIRTUAL_HEIGHT - 40)
    love.graphics.print("Quit - 'esc'", VIRTUAL_WIDTH - 200, VIRTUAL_HEIGHT - 40)


    if self.solved then
        love.graphics.setColor(1, 1, 1, 150 / 255)
        love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 160)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(gFonts['medium'])
        love.graphics.printf('VICTORY', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
        
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf('Press enter to continue', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
    end
end