Dot = Class {__includes = Tile}

function Dot:init(x, y, tileID)
    Tile.init(self, x, y, tileID)

end

function Dot:update(dt)

end

function Dot:render(x, y)
    Tile.render(self, x, y)
end