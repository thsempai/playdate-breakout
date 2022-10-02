import "CoreLibs/sprites"
import "game"

local gfx <const> = playdate.graphics
local pd <const> = playdate

class("Bonus").extends(gfx.sprite)

function Bonus:init(x, y, img)

    Bonus.super.init(self)
    local image = nil

    if img == nil then
        image = gfx.image.new(32, 32)
    else
        image = gfx.image.new(img)
    end

    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, image:getSize())
    self.isStatic = false
end

function Bonus:update()
    Bonus.super.update(self)
    if not self.isStatic then
        self:moveBy(0, bonusGravity)
        if self.y > getBottomBorder() + self.width / 2 then
            self:remove()
        end
    end
end

function Bonus:use()

end

class("BonusLife").extends(Bonus)

function BonusLife:init(x, y)
    BonusLife.super.init(self, x, y, "sprites/bonus-life")
    self:setGroups(2)
end

function BonusLife:use()
    BonusLife.super.use(self)
    lifes += 1
end
