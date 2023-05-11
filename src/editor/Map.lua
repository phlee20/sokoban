Map = Class { __includes = Grid }

function Map:init(x, y, lvl)
    self.level = lvl
    self.mapLoaded = false
    Grid.init(self, x, y)

    self:resetMap()

    Event.on('reset', function()
        self:resetMap()
    end)

    Event.on('save', function()
        self:saveMap()
        loadLevels()
    end)

    Event.on('delete', function()
        self:deleteMap()
        loadLevels()
    end)

    self.message = false
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

    if self.message then
        self:confirmMessage()
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

    -- load existing map first time only
    if self.level <= #gLevels and not self.mapLoaded then
        self:loadMap()

    -- draw empty map
    else
        for y = 1, self.gridY do
            table.insert(self.tiles, {})
            table.insert(self.mapDef, {})
            for x = 1, self.gridX do
                table.insert(self.tiles[y], Tile(x, y, tileID))
                table.insert(self.mapDef[y], 2)
            end
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
    
    table.insert(gLevels, self.level, {})
    for i = 1, #self.mapDef do
        table.insert(gLevels[self.level], self.mapDef[i])
    end
    if self.level <= #gLevels then
        table.remove(gLevels, self.level + 1)
    end

    self:writeFile()

    self:confirmMessage()
    self.message = true
    Timer.after(1.5, function()
        self.message = false
    end)
end

function Map:deleteMap()
    table.remove(gLevels, self.level)
    self:writeFile()
    self:confirmMessage()
    self.message = true
    Timer.after(1.5, function()
        self.message = false
    end)
end

function Map:writeFile()
    -- convert to string
    file = io.open('src/levels_def.txt', 'w')
    if not file then return nil end

    for i = 1, #gLevels do
        -- write level number
        file:write(tostring(i))
        
        -- write level lines
        for y = 1, #gLevels[i] do
            file:write('\n')
            local row = ""
            for x = 1, #gLevels[i][y] do
                row = row .. tostring(gLevels[i][y][x])
            end
            file:write(row)
        end
        if i < #gLevels then
            file:write('\n')
        end
    end

    file:close()
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

function Map:loadMap()
    local convertID = {
        [BLANK[1]] = 2,
        [GROUND[1]] = 0,
        [WALLS[1]] = 1
    }
    
    for y = 1, self.gridY do
        table.insert(self.tiles, {})
        table.insert(self.mapDef, {})
        for x = 1, self.gridX do
            local square = gLevels[self.level][y][x]
            if square == 1 then
                tileID = WALLS[1]
            elseif square == 2 then
                tileID = BLANK[1]
            else
                tileID = GROUND[1]
            end
            table.insert(self.tiles[y], Tile(x, y, tileID))

            -- add boxes and dots
            if square == 3 or square == 6 then
                tileID = BOXES[1]
                table.insert(self.boxes, Box(x, y, tileID))
            end

            if square == 4 or square == 6 then
                tileID = DOTS[1]
                table.insert(self.dots, Dot(x, y, tileID))
            end

            -- locate the player starting position
            if square == 5 then
                self.player:move(x, y)
                self.playerExists = true
            end
            table.insert(self.mapDef[y], tileID)
        end
    end
    self.mapLoaded = true
end

function Map:confirmMessage()
    love.graphics.setColor(1, 1, 1, 150 / 255)
    love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 160)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Done', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
end
