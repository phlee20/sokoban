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
