import "CoreLibs/sprites"
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
end

function Player:update()
    Player.super:update(self)
    if pd.buttonIsPressed(playdate.kButtonRight) then
        self:moveBy(self.speed, 0)
        if self.x >= getRightBorder() - self.width / 2 then
            self:moveTo(getRightBorder() - self.width / 2, self.y)
        end

    elseif pd.buttonIsPressed(playdate.kButtonLeft) then
        self:moveBy(-self.speed, 0)
        if self.x <= getLeftBorder() + self.width / 2 then
            self:moveTo(getLeftBorder() + self.width / 2, self.y)
        end
    end


end
