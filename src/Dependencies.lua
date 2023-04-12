Class = require 'lib/class'
push = require 'lib/push'

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

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/TitleState'
require 'src/states/PlayState'


gTextures = {
    ['tilesheet'] = love.graphics.newImage('graphics/sokoban_tilesheet.png'),
    ['retina'] = love.graphics.newImage('graphics/sokoban_tilesheet_retina.png')
}

gFrames = {
    ['tilesheet'] = GenerateQuads(gTextures['tilesheet'], TILE_SIZE, TILE_SIZE),
    ['retina'] = GenerateQuads(gTextures['retina'], TILE_SIZE, TILE_SIZE)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 128)
}

gSounds = {

}