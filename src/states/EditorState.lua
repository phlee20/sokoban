EditorState = Class { __includes = BaseState }

function EditorState:init()
    -- grid
    self.gridWidth = 4
    self.gridHeight = 5
    self.gridPosX = VIRTUAL_WIDTH / 2 - self.gridWidth / 2 * TILE_SIZE
    self.gridPosY = VIRTUAL_HEIGHT / 2 - self.gridHeight / 2 * TILE_SIZE
    self.grid = Grid(self.gridWidth, self.gridHeight)

    -- tile menu
    self.tileMenuPosX = TILE_SIZE
    self.tileMenuPosY = VIRTUAL_HEIGHT / 2 - TILE_SIZE * 9 / 2
    self.tileMenu = TileMenu(self.tileMenuPosX, self.tileMenuPosY)

    -- tile map
    self.map = Map(self.gridWidth, self.gridHeight)

    -- mouse states to keep track
    self.tileSelected = false
end

function EditorState:update(dt)
    local x, y = push:toGame(love.mouse.getPosition())

    if love.mouse.wasPressed(1) then
        for k, button in ipairs(self.tileMenu.buttons) do
            if button:mouseOver(x - self.tileMenuPosX, y - self.tileMenuPosY) then
                gSounds['select']:play()
                self.tileMenu:clicked(k)
            end
        end
    end

    local selection = self.tileMenu.highlightedButton

    if selection ~= nil then
        if love.mouse.wasPressed(1) and self.map:mouseOverGrid(x - self.gridPosX, y - self.gridPosY) then
            local tileX, tileY = self.map:pointToTile(x - self.gridPosX, y - self.gridPosY)
            self.map:editTile(tileX, tileY, self.tileMenu.buttons[selection].id)
        end
    end


end

function EditorState:render()
    self.grid:render(self.gridPosX, self.gridPosY)
    self.tileMenu:render()
    self.map:render(self.gridPosX, self.gridPosY)
end