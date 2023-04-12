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
    self:drawBackground()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('S O K O B A N', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 3 * 2, VIRTUAL_WIDTH, 'center')
end

function TitleState:drawBackground()

    local tileID = nil

    for x = 1, SCREEN_TILE_WIDTH / 2 do
        for y = 1, 7 do

            -- draw background green and ground
            if y < 5 then
                tileID = GROUND[2]
            else
                tileID = GROUND[1]
            end

            love.graphics.draw(gTextures['retina'], gFrames['retina'][tileID], (x - 1) * TILE_SIZE * 2,
                (y - 1) * TILE_SIZE * 2)
            
            if math.random(3) == 1 then
                tileID = BOXES[1]
                love.graphics.draw(gTextures['retina'], gFrames['retina'][tileID], (x - 1) * TILE_SIZE * 2,
                    (y - 1) * TILE_SIZE * 2)
            end
        end
    end

end