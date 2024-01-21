_G.love = require('love')
require('consts')
local Player = require('objects.Player')
local Ball = require('objects.Ball')
local Game = require('Game')
local Button = require('components.Button')
math.randomseed(os.time())

function StartGame()
    _G.game:startGame('running')
end



function love.load()
    _G.game = Game()
    _G.game:startGame('menu')
    _G.player = Player()
    _G.heart_icon = love.graphics.newImage("assets/heart.png")
    _G.bg_image = love.graphics.newImage("assets/image.jpg")
    _G.game.buttons.menu_buttons.startGame = Button("Start game", 10, 90, nil, nil, StartGame)
    _G.game.buttons.menu_buttons.exitGame = Button("Exit game", 10, 150, nil, nil, love.event.quit)

    _G.game.buttons.ended_buttons.startGame = Button("Restart", love.graphics.getWidth() / 2 - 300 / 2,
        love.graphics.getHeight() / 2 - 300 / 2, 300, 130, StartGame)
        
    _G.game.buttons.ended_buttons.exitGame = Button("Exit game", love.graphics.getWidth() / 2 - 300 / 2,
        love.graphics.getHeight() / 2 - 300 / 2 + 140, 300, 130, love.event.quit)
end

function love.update(dt)
    if _G.game.state.running then
        love.mouse.setVisible(false)
        if #_G.game.balls <= 0 or #_G.game.blocks <= 0 or _G.game.lives <= 0 then
            _G.game:changeState('ended')
        end
        _G.game:destroyBlock()
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
    elseif _G.game.state.menu then
        love.mouse.setVisible(true)
        _G.game.mouse.x, _G.game.mouse.y = love.mouse.getPosition()
    elseif _G.game.state.ended then
        love.mouse.setVisible(true)
        _G.game.mouse.x, _G.game.mouse.y = love.mouse.getPosition()
    elseif _G.game.state.paused then
        love.mouse.setVisible(false)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        if _G.game.state.running then
            _G.game:changeState('paused')
        elseif _G.game.state.paused then
            _G.game:changeState('running')
        end
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

function love.mousepressed(x, y, button)
    if button == 1 then
        if game.state["menu"] then
            for _, but in pairs(_G.game.buttons.menu_buttons) do
                but:checkIsCursorInButton(_G.game.mouse.x, _G.game.mouse.y)
            end
        elseif game.state["ended"] then
            for _, but in pairs(_G.game.buttons.ended_buttons) do
                but:checkIsCursorInButton(_G.game.mouse.x, _G.game.mouse.y)
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setNewFont(16)
    love.graphics.print(tostring(_G.game.state.running))

    if _G.game.state.paused then
        love.graphics.printf('Paused', love.graphics.newFont(48), 0, love.graphics.getHeight() / 2,
            love.graphics.getWidth(),
            'center')
    end

    if _G.game.state.menu then
        love.graphics.draw(_G.bg_image, love.graphics.getWidth()/7, love.graphics.getHeight()/4, 0, 0.7)
        for _, but in pairs(_G.game.buttons.menu_buttons) do
            but:draw(20, 15)
        end
    end
    if _G.game.state.ended then
        love.graphics.printf('Your score: '.. _G.game.points, love.graphics.newFont(48), 0, love.graphics.getHeight() / 5,
            love.graphics.getWidth(),
            'center')
        for _, but in pairs(_G.game.buttons.ended_buttons) do
            love.graphics.setNewFont(32)
            but:draw(20, 15)
        end
    end
    if _G.game.state.running or _G.game.state.paused then
        for i = 0, _G.game.lives - 1 do
            love.graphics.draw(_G.heart_icon, 00, i * 50, 0.05, 0.05)
        end
        _G.game:drawPoints()
        _G.game:drawBlocks()
        _G.player:draw()

        for _, ball in ipairs(_G.game.balls) do
            ball:draw()
        end
    end
end
