import "CoreLibs/sprites"
import "game"

local gfx <const> = playdate.graphics
local pd <const> = playdate

class("Ball").extends(gfx.sprite)

function Ball:init(x, y, r, speed)

    Ball.super.init(self)
    self:moveTo(x, y)
    self.speed = speed

    local image = gfx.image.new(r * 2, r * 2)

    gfx.pushContext(image)
    gfx.drawCircleAtPoint(r, r, r)
    gfx.popContext()

    self:setImage(image)
    self:setCollideRect(0, 0, r * 2, r * 2)
end

function Ball:update()

    Ball.super.update(self)
    self:moveBy(self.speed[1], self.speed[2])
    if self.x <= getLeftBorder() + self.width / 2 or self.x >= getRightBorder() - self.width / 2 then
        self.speed[1] *= -1
    end

    if self.y <= getTopBorder() + self.height / 2 or self.y >= getBottomBorder() - self.height / 2 then
        self.speed[2] *= -1
    end

    -- collisions
    collisions = self:overlappingSprites()

    if #collisions >= 1 then
        self.speed[2] *= -1
        for i = 1, #collisions do
            if collisions[i]:isa(Block) then
                collisions[i]:remove()
            end
        end
    end

end
