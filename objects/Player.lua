function Player()
    local WIDTH = player_consts.WIDTH
    local HEIGHT = player_consts.HEIGHT
    return {
        width = WIDTH,
        direction = player_consts.DIRECTION.IDLE,
        height = HEIGHT,
        x = love.graphics.getWidth() / 2 - WIDTH / 2,
        y = love.graphics.getHeight() - HEIGHT,
        draw = function(self)
            love.graphics.setColor(57 / 255, 255 / 255, 20 / 255)
            love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        end,
        move = function(self, direction, dt)
            if self.x > 0 then
                if direction == player_consts.DIRECTION.LEFT then
                    self.direction = player_consts.DIRECTION.LEFT
                    self.x = self.x - player_consts.SPEED * dt
                end
            end
            if self.x < love.graphics.getWidth() - self.width then
                if direction == player_consts.DIRECTION.RIGHT then
                    self.direction = player_consts.DIRECTION.RIGHT
                    self.x = self.x + player_consts.SPEED * dt
                end
            end
        end
    }
end

return Player
