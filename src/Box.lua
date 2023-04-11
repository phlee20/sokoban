Box = Class {__includes = Tile}

function Box:init(x, y, tileID)
    Tile.init(self, x, y, tileID)

end

function Box:update(dt)

end

function Box:render(x, y)
    Tile.render(self, x, y)
end