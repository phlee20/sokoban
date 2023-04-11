Player = Class {}

function Player:init(x, y)
    self.gridX = x
    self.gridY = y

    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE
    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.frame = PLAYER_DEF['idle-down'].frame
end

function Player:update(dt)
    local toX = self.gridX
    local toY = self.gridY

    if love.keyboard.wasPressed('up') then
        toY = toY - 1
        self.y = (toY - 1) * TILE_SIZE
    elseif love.keyboard.wasPressed('down') then
        toY = toY + 1
        self.y = (toY + 1) * TILE_SIZE
    elseif love.keyboard.wasPressed('left') then
        toX = toX - 1
        self.x = (toX - 1) * TILE_SIZE
    elseif love.keyboard.wasPressed('right') then
        toX = toX + 1
        self.x = (toX + 1) * TILE_SIZE
    end

    self.gridX = toX
    self.gridY = toY
end

function Player:render(x, y)
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.frame], self.x + x, self.y + y)
end