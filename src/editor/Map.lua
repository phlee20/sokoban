Map = Class { __includes = Grid }

function Map:init(x, y)
    Grid.init(self, x, y)

    self.tiles = {}
    self:resetMap()

    self.boxes = {}
    self.dots = {}

    self.playerExists = false
    self.player = Tile(2, 2, PLAYER_DEF['idle-down'].frame)
end

function Map:update(dt)

end

function Map:render(xOffset, yOffset)
    for x = 1, self.gridY do
        for y = 1, self.gridX do
            self.tiles[x][y]:render(xOffset, yOffset)
        end
    end

    for k, v in ipairs(self.dots) do
        v:render(xOffset, yOffset)
    end

    for k, v in ipairs(self.boxes) do
        v:render(xOffset, yOffset)
    end

    if self.playerExists then
        self.player:render(xOffset, yOffset)
    end
end

function Map:resetMap()
    local tileID = BLANK[1]

    for y = 1, self.gridY do
        table.insert(self.tiles, {})
        for x = 1, self.gridX do
            table.insert(self.tiles[y], Tile(x, y, tileID))
        end
    end
end

function Map:mouseOverGrid(mouseX, mouseY)
    return mouseX > self.x and mouseX < self.width and mouseY > self.y and mouseY < self.height
end

function Map:pointToTile(mouseX, mouseY)
    local tileX = math.floor(mouseX / TILE_SIZE) + 1
    local tileY = math.floor(mouseY / TILE_SIZE) + 1

    return tileX, tileY
end

function Map:addTile(x, y, highlightedButton)
    if self.tiles[y][x].id == BLANK[1] then
        if highlightedButton == WALLS[1] or highlightedButton == GROUND[1] then
            self.tiles[y][x].id = highlightedButton
        end
    elseif self.tiles[y][x].id == GROUND[1] then
        if self:tileExists(x, y, highlightedButton) then
            if highlightedButton == BOXES[1] then
                table.insert(self.boxes, Box(x, y, BOXES[1]))
            elseif highlightedButton == DOTS[1] then
                table.insert(self.dots, Dot(x, y, DOTS[1]))
            elseif highlightedButton == PLAYER_DEF['idle-down'].frame then
                self.playerExists = true
                self.player:move(x, y)
            end
        end
    end
end

function Map:eraseTile(x, y)
    if self.playerExists then
        if self.player.gridX == x and self.player.gridY == y then
            self.playerExists = false
            return
        end
    end

    for k, v in ipairs(self.boxes) do
        if v.gridX == x and v.gridY == y then
            table.remove(self.boxes, k)
            return
        end
    end

    for k, v in ipairs(self.dots) do
        if v.gridX == x and v.gridY == y then
            table.remove(self.dots, k)
            return
        end
    end

    self.tiles[y][x].id = BLANK[1]
end

function Map:tileExists(x, y, type)

    if type == DOTS[1] then
        for k, v in ipairs(self.dots) do
            if v.gridX == x and v.gridY == y then
                return false
            end
        end
    end

    for k, v in ipairs(self.boxes) do
        if v.gridX == x and v.gridY == y then
            return false
        end
    end

    if self.playerExists then
        if self.player.gridX == x and self.player.gridY == y then
            return false
        end
    end
    
    return true
end