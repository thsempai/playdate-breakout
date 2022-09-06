import "CoreLibs/sprites"
import "CoreLibs/crank"
import "game"
import "ball"

local gfx <const> = playdate.graphics
local pd <const> = playdate

class("Player").extends(gfx.sprite)

function Player:init(x, y, speed, game)
    Player.super.init(self)

    local image = gfx.image.new("sprites/player")
    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, image:getSize())
    self.speed = speed
    self.crankMultiple = 20
    self.ball = Ball(x, y - self.height / 2 - 10, 8, { 0, 0 })
    self.game = game
end

function Player:add()
    Player.super.add(self)
    self.ball:add()
end

function Player:dockedBall()
    self.ball.isDocked = true;
    self.ball.speed = { 0, 0 }
end

function Player:LaunchBall(speed)
    self.ball.isDocked = false
    self.ball.speed = speed
end

function Player:update()
    Player.super:update(self)
    if pd.isCrankDocked() then
        if pd.buttonIsPressed(pd.kButtonRight) then
            self:moveBy(self.speed, 0)

        elseif pd.buttonIsPressed(pd.kButtonLeft) then
            self:moveBy(-self.speed, 0)
        end
    else
        local dx = pd.getCrankChange() / 359.9999
        self:moveBy(self.speed * dx * self.crankMultiple, 0)
    end

    if self.x <= getLeftBorder() + self.width / 2 then
        self:moveTo(getLeftBorder() + self.width / 2, self.y)
    elseif self.x >= getRightBorder() - self.width / 2 then
        self:moveTo(getRightBorder() - self.width / 2, self.y)
    end

    if self.ball.isDocked then
        if pd.buttonIsPressed(pd.kButtonA) then
            self:LaunchBall({ 4, -4 })
        end
        self.ball:moveTo(self.x, self.y - self.height / 2 - 10)
    end

    -- collisions

    collisions = self:overlappingSprites()
    for i = 1, #collisions do
        if collisions[i]:isa(Bonus) then
            self.game:getNewBonus(collisions[i])
        end
    end
end
