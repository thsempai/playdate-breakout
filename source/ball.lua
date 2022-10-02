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
    self._speed = { math.abs(speed[1]), math.abs(speed[2]) }

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
    self:setCollidesWithGroups(1)
end

function Ball:update()

    Ball.super.update(self)

    -- collisions

    goalX = self.x + self.speed[1]
    goalY = self.y + self.speed[2]
    actualX, actualY, collisions = self:moveWithCollisions(goalX, goalY)

    speedIsChanged = false

    for i = 1, #collisions do

        if goalX ~= actualX or goalY ~= actualY then

            if not collisions[i].other:isa(Player) and actualX - goalX ~= 0 then
                self.speed[1] *= -1
            end
            if actualY - goalY ~= 0 then
                self.speed[2] *= -1
            end
        end

    end

    -- borders collisions

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

end

function Ball:launch(speed)
    self.isDocked = false
    self.speed = speed
    self._speed = { math.abs(speed[1]), math.abs(speed[2]) }

end

function Ball:collisionResponse(other)
    self.soundHitPlayer:play()
    if other:isa(Block) then
        other:destroy()
        return gfx.sprite.kCollisionTypeBounce

    elseif other.isa(Player) then
        return gfx.sprite.kCollisionTypeBounce

    end
end
