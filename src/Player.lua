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
    self:attemptMove()
end

function Player:render(x, y)
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.frame], self.x + x, self.y + y)
end

function Player:attemptMove()
    local toX = self.gridX
    local toY = self.gridY
    local behindX = toX
    local behindY = toY

    if love.keyboard.wasPressed('left') then
        toX = toX - 1
        self.direction = 'left'
        behindX = toX - 1
    elseif love.keyboard.wasPressed('right') then
        toX = toX + 1
        self.direction = 'right'
        behindX = toX + 1
    elseif love.keyboard.wasPressed('up') then
        toY = toY - 1
        self.direction = 'up'
        behindY = toY - 1
    elseif love.keyboard.wasPressed('down') then
        toY = toY + 1
        self.direction = 'down'
        behindY = toY + 1
    end

    -- check if the new tile is a wall
    if self.level:isWall(toX, toY) then
        return
    end

    -- check if a box exists on the next tile
    for _, boxA in ipairs(self.level.boxes) do
        if boxA:exists(toX, toY) then

            -- check if a wall exists behind the box
            if self.level:isWall(behindX, behindY) then
                return
            end

            -- loop through boxes to check if another box exists behind the box
            for _, boxB in ipairs(self.level.boxes) do
                if boxB:exists(behindX, behindY) then
                    return
                end
            end
            
            -- move the box to second location
            boxA:move(behindX, behindY)
        end
    end

    self.x = (toX - 1) * TILE_SIZE
    self.y = (toY - 1) * TILE_SIZE

    -- set new grid coordinates
    self.gridX = toX
    self.gridY = toY
end