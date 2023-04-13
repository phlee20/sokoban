Button = Class { __includes = Tile }

function Button:init(x, y, tileID)
    Tile.init(self, x, y, tileID)
end

function Button:render(x, y)
    Tile.render(self, x, y)
end