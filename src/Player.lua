Player = Class {}

function Player:init(level)
    self.level = level
    self.gridX = self.level.xPlayerStart
    self.gridY = self.level.yPlayerStart

    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE
    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.direction = 'down'
    self.frame = PLAYER_DEF['idle-down'].frame
end

function Player:update(dt)
    local move = false
    local toX = self.gridX
    local toY = self.gridY
    local behindX = toX
    local behindY = toY

    if love.keyboard.wasPressed('left') then
        toX = toX - 1
        self.direction = 'left'
        behindX = toX - 1
        move = true
    elseif love.keyboard.wasPressed('right') then
        toX = toX + 1
        self.direction = 'right'
        behindX = toX + 1
        move = true
    elseif love.keyboard.wasPressed('up') then
        toY = toY - 1
        self.direction = 'up'
        behindY = toY - 1
        move = true
    elseif love.keyboard.wasPressed('down') then
        toY = toY + 1
        self.direction = 'down'
        behindY = toY + 1
        move = true
    end

    self.frame = PLAYER_DEF['idle-' .. self.direction].frame

    if move and self:validMove(toX, toY, behindX, behindY) then
        self.x = (toX - 1) * TILE_SIZE
        self.y = (toY - 1) * TILE_SIZE

        -- set new grid coordinates
        self.gridX = toX
        self.gridY = toY

        -- call an event to check if puzzle is solved
        Event.dispatch('checkSolve')
    end
end

function Player:render(x, y)
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.frame], self.x + x, self.y + y)
end

function Player:validMove(toX, toY, behindX, behindY)

    -- check if the new tile is a wall
    if self.level:isWall(toX, toY) then
        return false
    end

    -- check if a box exists on the next tile
    for _, boxA in ipairs(self.level.boxes) do
        if boxA:exists(toX, toY) then
            -- check if a wall exists behind the box
            if self.level:isWall(behindX, behindY) then
                return false
            end

            -- loop through boxes to check if another box exists behind the box
            for _, boxB in ipairs(self.level.boxes) do
                if boxB:exists(behindX, behindY) then
                    return false
                end
            end

            -- move the box to second location
            boxA:move(behindX, behindY)
        end
    end
    
    return true
end