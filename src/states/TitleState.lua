TitleState = Class { __includes = BaseState }

function TitleState:init()

end

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(PlayState(1))
    end
end

function TitleState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('S O K O B A N', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 3 * 2, VIRTUAL_WIDTH, 'center')
end

