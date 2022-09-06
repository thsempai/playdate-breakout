import "CoreLibs/sprites"
import "game"
import "bonus"
import "player"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound
local pd <const> = playdate

class("Ball").extends(gfx.sprite)

function Ball:init(x, y, r, speed)

    Ball.super.init(self)
    self:moveTo(x, y)
    self.speed = speed

    local image = gfx.image.new(r * 2, r * 2)

    gfx.pushContext(image)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(r, r, r)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(r, r, r)
    gfx.popContext()

    self.isDocked = true

    self:setImage(image)
    self:setCollideRect(0, 0, r * 2, r * 2)
    self.soundHitPlayer = snd.sampleplayer.new("sounds/hit-player")
    self.soundHitBlock = snd.sampleplayer.new("sounds/hit-block")
end

function Ball:update()

    Ball.super.update(self)
    self:moveBy(self.speed[1], self.speed[2])
    if self.x <= getLeftBorder() + self.width / 2 or self.x >= getRightBorder() - self.width / 2 then
        self.speed[1] *= -1
    end

    if self.y <= getTopBorder() + self.height / 2 then
        self.speed[2] *= -1
    end

    if self.y >= getBottomBorder() - self.height / 2 then
        self.isDocked = true
        self.speed = { 0, 0 }
        lifes -= 1
    end
    -- collisions
    collisions = self:overlappingSprites()


    speedIsChanged = false
    for i = 1, #collisions do
        if collisions[i]:isa(Block) then
            self.soundHitBlock:play()
            collisions[i]:destroy()
            speedIsChanged = true
        end
        if collisions[i]:isa(Player) then
            self.soundHitPlayer:play()
            speedIsChanged = true
        end
    end
    if speedIsChanged then
        self.speed[2] *= -1
    end


end
