Map = Class { __includes = Grid }

function Map:init(x, y)
    Grid.init(self, x, y)

    self:resetMap()

    Event.on('reset', function()
        self:resetMap()
    end)

    Event.on('save', function()
        self:saveMap()
    end)
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
    self.tiles = {}
    self.boxes = {}
    self.dots = {}
    self.playerExists = false
    self.player = Tile(2, 2, PLAYER_DEF['idle-down'].frame)

    -- serialized map
    self.mapDef = {}

    local tileID = BLANK[1]

    for y = 1, self.gridY do
        table.insert(self.tiles, {})
        table.insert(self.mapDef, {})
        for x = 1, self.gridX do
            table.insert(self.tiles[y], Tile(x, y, tileID))
            table.insert(self.mapDef[y], 2)
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
    if type == DOTS[1] or type == PLAYER_DEF['idle-down'].frame then
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

function Map:saveMap()
    local convertID = {
        [BLANK[1]] = 2,
        [GROUND[1]] = 0,
        [WALLS[1]] = 1
    }

    -- add wall, ground and blank tiles
    for y = 1, self.gridY do
        for x = 1, self.gridX do
            self.mapDef[y][x] = convertID[self.tiles[y][x].id]
        end
    end

    -- overwrite dot (4), dot-box (6), player (5) and box (3) tiles
    for k, v in ipairs(self.dots) do
        self.mapDef[v.gridY][v.gridX] = 4
    end

    for k, v in ipairs(self.boxes) do
        if v.onDot then
            self.mapDef[v.gridY][v.gridX] = 6
        else
            self.mapDef[v.gridY][v.gridX] = 3
        end
    end

    if self.playerExists then
        self.mapDef[self.player.gridY][self.player.gridX] = 5
    end

    local serialized = lume.serialize(self.mapDef)
    love.filesystem.write("sokoban_map.csv", serialized)
    print(serialized)
end

function Map:boxOnDot()
    for _, box in ipairs(self.boxes) do
        for _, dot in ipairs(self.dots) do
            -- checks if boxes are on dots
            if dot.gridX == box.gridX and dot.gridY == box.gridY then
                box.onDot = true
                break
            else
                box.onDot = false
            end
        end
    end
end