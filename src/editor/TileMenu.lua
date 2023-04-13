TileMenu = Class {}

function TileMenu:init()
    -- Base tiles: wall, ground
    -- Stack tiles: player, dot, box
    -- Rules - no tiles on walls
    -- player and box can stack on dot but not on each other
    
    -- left click to select a tile and place a tile
    -- right click to deselect or remove a tile
    -- drag?
    
    self.x = TILE_SIZE
    self.y = VIRTUAL_HEIGHT / 2 - TILE_SIZE * 9 / 2
    self.width = TILE_SIZE
    self.height = TILE_SIZE * 9

    self.buttons = self:generateButtons()
end

function TileMenu:render()
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    
    for _, button in ipairs(self.buttons) do
        button:render(self.x, self.y)
    end
end

function TileMenu:generateButtons()
    local buttons = {}

    local types = { WALLS[1], GROUND[1], BOXES[1], DOTS[1], PLAYER_DEF['idle-down'].frame }

    for i = 1, #types do
        table.insert(buttons, Button(1, 1 + (i - 1) * 2, types[i]))
    end

    return buttons
end