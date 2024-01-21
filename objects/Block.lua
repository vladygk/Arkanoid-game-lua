function Block(x,y)
    local getColor = function ()
        return {math.random(255)/255,math.random(255)/255,math.random(255)/255}
    end

    return {
        width = _G.block_consts.WIDTH,
        height = _G.block_consts.HEIGHT,
        x = x,
        y = y,
        color = getColor(),
        draw = function (self,mode)
            love.graphics.setColor(self.color)
            love.graphics.rectangle(mode,self.x,self.y,self.width, self.height)
        end
    }
end

return Block