import "CoreLibs/sprites"
import "CoreLibs/crank"
import "game"

local gfx <const> = playdate.graphics
local pd <const> = playdate

class("Player").extends(gfx.sprite)

function Player:init(x, y, speed)
    Player.super.init(self)

    local image = gfx.image.new("sprites/player")
    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, image:getSize())
    self.speed = speed
    self.crankMultiple = 10
end

function Player:update()
    Player.super:update(self)
    if pd.isCrankDocked() then
        if pd.buttonIsPressed(playdate.kButtonRight) then
            self:moveBy(self.speed, 0)

        elseif pd.buttonIsPressed(playdate.kButtonLeft) then
            self:moveBy(-self.speed, 0)

        end
    else
        local dx = playdate.getCrankChange() / 359.9999
        self:moveBy(self.speed * dx * self.crankMultiple, 0)
    end

    if self.x <= getLeftBorder() + self.width / 2 then
        self:moveTo(getLeftBorder() + self.width / 2, self.y)
    elseif self.x >= getRightBorder() - self.width / 2 then
        self:moveTo(getRightBorder() - self.width / 2, self.y)
    end


end
