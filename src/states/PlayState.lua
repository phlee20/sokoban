PlayState = Class { __includes = BaseState }

function PlayState:init(currentLevel)
    self.currentLevel = currentLevel
    self.level = Level(self.currentLevel)
    self.player = Player(self.level)

    self.timer = 0
    self.solved = false

    -- initial check for boxes on dots
    self.level:isSolved()

    Event.on('checkSolve', function()
        if self.level:isSolved() then
            self.solved = true
        end
    end)
end

function PlayState:update(dt)
    if not self.solved then
        self.level:update(dt)
        self.player:update(dt)

        self.timer = self.timer + dt
        
        -- restart the level
        if love.keyboard.wasPressed('r') then
            gStateStack:pop()
            gStateStack:push(PlayState(self.currentLevel))
        end
    else
        -- go to next level
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            gStateStack:pop()
            gStateStack:push(PlayState(self.currentLevel + 1))
        end
    end
end

function PlayState:render()
    self.level:render()
    self.player:render(self.level.xRenderOffset, self.level.yRenderOffset)

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Level ' .. self.currentLevel, 20, 20)

    -- add timer display
    love.graphics.print('Time: ' .. math.floor(self.timer), VIRTUAL_WIDTH - 160, 20)

    -- add GUI

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