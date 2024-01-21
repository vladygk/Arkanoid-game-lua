local Block = require('objects.Block')

function Game()
    return {
        balls = {},
        blocks = {},
        createBall = function(self, x, y)
            table.insert(self.balls, Ball())
        end,
        destroyBall = function(self, index)
            table.remove(self.balls, index)
        end,
        createBlocks = function(self)
            for i = 1, 5 do
                local line = {}
                for j = 1, 5 do
                    table.insert(line, Block(100 * i+60, 55 * j))
                end
                table.insert(self.blocks,line)
            end
        end,
        drawBlocks = function(self)
            for _, line in ipairs(self.blocks) do
                for _, block in ipairs(line) do
                    block:draw('fill')
                end
            end
        end
    }
end

return Game
