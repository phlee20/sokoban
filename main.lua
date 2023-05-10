io.stdout:setvbuf("no")

require 'src/Dependencies'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    love.window.setTitle('Store')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

    gLevels = loadLevels()

    gStateStack = StateStack()
    gStateStack:push(TitleState())

    love.mouse.buttonsPressed = {}
    love.mouse.buttonsReleased = {}
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.mousereleased(x, y, button)
    love.mouse.buttonsReleased[button] = true
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.mouse.wasReleased(button)
    return love.mouse.buttonsReleased[button]
end

function love.update(dt)
    Timer.update(dt)

    gStateStack:update(dt)

    love.mouse.buttonsPressed = {}
    love.mouse.buttonsReleased = {}
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    gStateStack:render()

    push:finish()
end

function loadLevels()
    local levels = {}
    local levelCounter = 0

    file = io.open('src/levels_def.txt', 'r')
    if not file then return nil end

    repeat
        local line = file:read('l')

        if line ~= nil then
            local length = string.len(line)
            if length == 1 then
                table.insert(levels, {})
                row = 0
                levelCounter = levelCounter + 1
            else
                table.insert(levels[levelCounter], {})
                row = row + 1
                for i = 1, length do
                    table.insert(levels[levelCounter][row], tonumber(string.sub(line, i, i)))
                end
            end
        end
    until line == nil

    file:close()

    -- for i = 1, #levels do
    --     for j = 1, #levels[i] do
    --         for k = 1, #levels[i][j] do
    --             print(levels[i][j][k])
    --         end
    --     end
    -- end

    return levels
end
