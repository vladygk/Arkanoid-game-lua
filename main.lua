_G.love = require('love')
require('consts')
local Player = require('objects.Player')
local Ball = require('objects.Ball')


function love.load()
    love.mouse.setVisible(false)
    _G.player = Player()
    _G.ball = Ball()
end

function love.update(dt)
    _G.ball:move(dt,_G.player)
    if love.keyboard.isDown('a') or  love.keyboard.isDown('left') then
        _G.player:move(player_consts.DIRECTION.LEFT,dt)
    end
    if love.keyboard.isDown('d') or  love.keyboard.isDown('right') then
        _G.player:move(player_consts.DIRECTION.RIGHT,dt)
    end
end

function love.keyreleased(key)
    if key == 'a' or key == 'left' or key == 'd' or key == 'right' then
        _G.player.direction = player_consts.DIRECTION.IDLE
    end
end

function love.draw()
    love.graphics.setColor(1,1,1)
  
    love.graphics.print(_G.ball.direction)
    
    _G.player:draw()
    _G.ball:draw()
end