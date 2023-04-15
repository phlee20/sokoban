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
    self.tileMenuPosY = VIRTUAL_HEIGHT / 2 - TILE_SIZE * 7 / 2
    self.tileMenu = TileMenu(self.tileMenuPosX, self.tileMenuPosY)

    -- tile map
    self.map = Map(self.gridWidth, self.gridHeight)

    -- file menu
    self.fileMenuPosX = VIRTUAL_WIDTH - TILE_SIZE * 3
    self.fileMenuPosY = TILE_SIZE
    self.fileMenu = FileMenu(self.fileMenuPosX, self.fileMenuPosY)

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
   
    if love.mouse.wasPressed(1) and self.map:mouseOverGrid(x - self.gridPosX, y - self.gridPosY) then
        local tileX, tileY = self.map:pointToTile(x - self.gridPosX, y - self.gridPosY)

        if selection == 6 then
            self.map:eraseTile(tileX, tileY)
            gSounds['clear']:play()
        elseif selection ~= nil then
            self.map:addTile(tileX, tileY, self.tileMenu.buttons[selection].id)
            gSounds['select']:play()
        end
    end


end

function EditorState:render()
    self.grid:render(self.gridPosX, self.gridPosY)
    self.tileMenu:render()
    self.fileMenu:render()
    self.map:render(self.gridPosX, self.gridPosY)
end