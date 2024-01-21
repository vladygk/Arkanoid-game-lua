function Sound()
    return {
        songs = {
            love.audio.newSource("assets/sounds/all_star.mp3", "stream"),
            love.audio.newSource("assets/sounds/titanic.mp3", "stream"),
            love.audio.newSource("assets/sounds/smells.mp3", "stream"),
            love.audio.newSource("assets/sounds/your_house.mp3", "stream")
        },
        effects = {
            bounce = love.audio.newSource("assets/sounds/bounce.mp3", "static"),
            breakk = love.audio.newSource("assets/sounds/break.mp3", "static")
        },
        playSong = function(self)
            local index = math.random(#self.songs)
            for _, song in ipairs(self.songs) do
                song:setVolume(0.1)
            end
            love.audio.play(self.songs[index])
        end,
        isSongPlaying = function(self)
            for _, song in ipairs(self.songs) do
                if song:isPlaying() then
                    return true
                end
            end
            return false
        end,
        stopSong = function(self)
            for _, song in ipairs(self.songs) do
                song:stop()
            end
        end,
        playEffect = function(self, name)
            if name == 'bounce' or name == 'breakk' then
                if self.effects[name]:isPlaying() then
                    self.effects[name]:stop()
                    self.effects[name]:play()
                else
                    self.effects[name]:play()
                end
            end
        end,
    }
end

return Sound
