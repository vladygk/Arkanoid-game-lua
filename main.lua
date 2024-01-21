_G.love = require('love')
require('consts')
local Player = require('objects.Player')
local Ball = require('objects.Ball')
local Game = require('Game')
math.randomseed(os.time())

function love.load()
    love.mouse.setVisible(false)
    _G.game = Game()
    _G.player = Player()
    _G.game:createBall(50, 50)
    _G.game:createBlocks()
end

function love.update(dt)
    for _, ball in ipairs(_G.game.balls) do
        ball:move(dt, _G.player)
    end
    for i, ball in ipairs(_G.game.balls) do
        if ball.y >= love.graphics.getHeight() then
            _G.game:destroyBall(i)
        end
    end
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        _G.player:move(player_consts.DIRECTION.LEFT, dt)
    end
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        _G.player:move(player_consts.DIRECTION.RIGHT, dt)
    end
end

function love.keyreleased(key)
    if key == 'a' or key == 'left' or key == 'd' or key == 'right' then
        _G.player.direction = player_consts.DIRECTION.IDLE
    end
    if key == 'space' then
        _G.game:createBall(50, 50)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    _G.game:drawBlocks()
    love.graphics.print(#_G.game.balls)
    _G.player:draw()
    for _, ball in ipairs(_G.game.balls) do
        ball:draw()
    end
end
