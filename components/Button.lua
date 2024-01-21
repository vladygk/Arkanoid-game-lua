function Button(text, x, y, width, height, func, funcParam)
    return {
        text = text or "No text",
        x = x or 100,
        y = y or 100,
        width = width or 120,
        height = height or 50,
        func = func or (function() print("No callback provided.") end),

        draw = function(self, textX, textY)
            love.graphics.setColor(0, 1, 65 / 255)
            love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
            love.graphics.print(self.text, self.x + textX, self.y + textY)
            love.graphics.setColor(1, 1, 1)
        end,

        checkIsCursorInButton = function(self, mouse_x, mouse_y)
            if mouse_x  >= self.x
                and mouse_x <= self.x + self.width
                and mouse_y  >= self.y
                and mouse_y <= self.y + self.height then
                    if funcParam then
                        self.func(funcParam)
                    else
                        self.func()
                    end
                    return true
            end
            return false
        end
    }
end

return Button
