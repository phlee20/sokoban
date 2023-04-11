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
    if love.keyboard.wasPressed('up') then
        self.gridY = self.gridY - 1
        self.y = (self.gridY - 1) * TILE_SIZE
    end
end

function Player:render(x, y)
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.frame], self.x + x, self.y + y)
end