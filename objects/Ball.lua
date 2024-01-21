function Ball()
    return {
        speed = 300,
        radius = ball_consts.RADIUS,
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        direction = ball_consts.DIRECTION.DOWN,
        move = function(self, dt, player)
            -- Up
            if self.direction == ball_consts.DIRECTION.UP then
                if self:checkHasCollidedWithCeiling() then
                    self.direction = ball_consts.DIRECTION.DOWN
                else
                    self.y = self.y - self.speed * dt
                end
            end

            -- Upright
            if self.direction == ball_consts.DIRECTION.UPRIGHT then
                if self:checkHasCollidedWithWall() then
                    self.direction = ball_consts.DIRECTION.UPLEFT
                elseif self:checkHasCollidedWithCeiling() then
                    self.direction = ball_consts.DIRECTION.DOWNRIGHT
                else
                    self.y = self.y - self.speed * dt
                    self.x = self.x + self.speed * dt
                end
            end

            -- Upleft
            if self.direction == ball_consts.DIRECTION.UPLEFT then
                if self:checkHasCollidedWithWall() then
                    self.direction = ball_consts.DIRECTION.UPRIGHT
                elseif self:checkHasCollidedWithCeiling() then
                    self.direction = ball_consts.DIRECTION.DOWNLEFT
                else
                    self.y = self.y - self.speed * dt
                    self.x = self.x - self.speed * dt
                end
            end

            -- Down
            if self.direction == ball_consts.DIRECTION.DOWN then
                if self:checkHasCollidedWithPlayer(player) then
                    if player.direction == player_consts.DIRECTION.LEFT then
                        self.direction = ball_consts.DIRECTION.UPRIGHT
                    elseif player.direction == player_consts.DIRECTION.RIGHT then
                        self.direction = ball_consts.DIRECTION.UPLEFT
                    else
                        self.direction = ball_consts.DIRECTION.UP
                    end
                else
                    self.y = self.y + self.speed * dt
                end
            end

            -- Downright
            if self.direction == ball_consts.DIRECTION.DOWNRIGHT then
                if self:checkHasCollidedWithWall() then
                    self.direction = ball_consts.DIRECTION.DOWNLEFT
                elseif self:checkHasCollidedWithPlayer(player) then
                    if player.direction == player_consts.DIRECTION.IDLE then
                        self.direction = ball_consts.DIRECTION.UP
                    else
                        self.direction = ball_consts.DIRECTION.UPRIGHT
                    end
                else
                    self.y = self.y + self.speed * dt
                    self.x = self.x + self.speed * dt
                end
            end

            -- Downleft
            if self.direction == ball_consts.DIRECTION.DOWNLEFT then
                if self:checkHasCollidedWithWall() then
                    self.direction = ball_consts.DIRECTION.DOWNRIGHT
                elseif self:checkHasCollidedWithPlayer(player) then
                    if player.direction == player_consts.DIRECTION.IDLE then
                        self.direction = ball_consts.DIRECTION.UP
                    else
                        self.direction = ball_consts.DIRECTION.UPLEFT
                    end
                else
                    self.y = self.y + self.speed * dt
                    self.x = self.x - self.speed * dt
                end
            end
        end,
        draw = function(self)
            love.graphics.setColor(255 / 255, 87 / 255, 51 / 255)
            love.graphics.circle('fill', self.x, self.y, self.radius)
        end,
        checkHasCollidedWithCeiling = function(self)
            if self.direction == ball_consts.DIRECTION.UP
                or self.direction == ball_consts.DIRECTION.UPLEFT
                or self.direction == ball_consts.DIRECTION.UPRIGHT then
                if self.y <= self.radius then
                    return true
                end
            end
            return false
        end,
        checkHasCollidedWithWall = function(self, player)
            -- check left wall
            if (self.direction == ball_consts.DIRECTION.UPLEFT
                    or self.direction == ball_consts.DIRECTION.DOWNLEFT)
                and self.x - self.radius <= 0 then
                return true
            end

            -- check right wall
            if (self.direction == ball_consts.DIRECTION.UPRIGHT
                    or self.direction == ball_consts.DIRECTION.DOWNRIGHT)
                and self.x + self.radius >= love.graphics.getWidth() then
                return true
            end
            return false
        end,
        checkHasCollidedWithPlayer = function(self, player)
            -- check player
            if self.direction == ball_consts.DIRECTION.DOWN
                or self.direction == ball_consts.DIRECTION.DOWNLEFT
                or self.direction == ball_consts.DIRECTION.DOWNRIGHT then
                if self.x > player.x
                    and self.x + self.radius < player.x + player.width
                    and self.y + self.radius >= player.y then
                    return true
                end
                return false
            end
        end
    }
end

return Ball
