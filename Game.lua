local Block = require('objects.Block')

function Game()
    return {
        state = {
            menu = true,
            running = false,
            paused = false,
            ended = false
        },
        buttons = {
            menu_buttons = {},
            ended_buttons = {}
        },
        mouse = { x = 0, y = 0 },
        points = 0,
        lives = 5,
        balls = {},
        blocks = {},
        startGame = function(self, state)
            self.lives = 5
            self.balls = {}
            self.blocks = {}
            self:changeState(state)
            self:createBlocks()
            self:createBall(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
            self.points = 0
        end,
        createBall = function(self, x, y)
            table.insert(self.balls, Ball(x, y))
        end,
        destroyBall = function(self, index)
            table.remove(self.balls, index)
            self.lives = self.lives - 1
        end,
        createBlocks = function(self)
            for i = 1, 5 do
                local line = {}
                for j = 1, 5 do
                    table.insert(line, Block(100 * i + 60, 55 * j))
                end
                table.insert(self.blocks, line)
            end
        end,
        drawBlocks = function(self)
            for _, line in ipairs(self.blocks) do
                for _, block in ipairs(line) do
                    block:draw('fill')
                end
            end
        end,
        destroyBlock = function(self)
            for i = 1, 5 do
                local line = self.blocks[i]
                for j = #line, 1, -1 do
                    local current_block = line[j]
                    if current_block.is_hit then
                        self:createBall(current_block.x, current_block.y)
                        table.remove(line, j)
                    end
                end
            end
        end,
        drawPoints = function(self)
            love.graphics.printf('Score:' .. self.points, love.graphics.newFont(32), 0, 10, love.graphics.getWidth(),
                'center')
        end,
        changeState = function(self, state)
            self.state.menu = 'menu' == state
            self.state.running = 'running' == state
            self.state.paused = 'paused' == state
            self.state.ended = 'ended' == state
        end
    }
end

return Game
