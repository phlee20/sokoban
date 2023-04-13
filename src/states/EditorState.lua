EditorState = Class { __includes = BaseState }

function EditorState:init()
    self.width = 4
    self.height = 5
    self.grid = Grid(self.width, self.height)
    self.xOffset = VIRTUAL_WIDTH / 2 - self.width / 2 * TILE_SIZE
    self.yOffset = VIRTUAL_HEIGHT / 2 - self.height / 2 * TILE_SIZE

    self.tileMenu = TileMenu()
end

function EditorState:update(dt)

end

function EditorState:render()
    self.grid:render(self.xOffset, self.yOffset)
    self.tileMenu:render()
end