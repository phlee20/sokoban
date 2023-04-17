Class = require 'lib/class'
push = require 'lib/push'
lume = require 'lib/lume'

Timer = require 'lib/knife.timer'
Event = require 'lib/knife.event'


require 'src/Util'
require 'src/constants'

require 'src/Tile'
require 'src/Level'
require 'src/Box'
require 'src/Dot'
require 'src/Player'
require 'src/level_def'
require 'src/player_def'

require 'src/editor/Grid'
require 'src/editor/Button'
require 'src/editor/TileMenu'
require 'src/editor/Map'
require 'src/editor/MenuButton'
require 'src/editor/FileMenu'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/TitleState'
require 'src/states/PlayState'
require 'src/states/LevelSelectState'
require 'src/states/EditorState'
require 'src/states/GridSelectState'


gTextures = {
    ['tilesheet'] = love.graphics.newImage('graphics/sokoban_tilesheet.png'),
    ['retina'] = love.graphics.newImage('graphics/sokoban_tilesheet_retina.png')
}

gFrames = {
    ['tilesheet'] = GenerateQuads(gTextures['tilesheet'], TILE_SIZE, TILE_SIZE),
    ['retina'] = GenerateQuads(gTextures['retina'], TILE_SIZE * 2, TILE_SIZE * 2)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 128)
}

gSounds = {
    ['select'] = love.audio.newSource('sounds/Button-Down.mp3', 'static'),
    ['clear'] = love.audio.newSource('sounds/Button-Up.mp3', 'static')
}