import "AnimatedSprite"

local gfx <const> = playdate.graphics
local pd <const> = playdate

class("Eye").extends(AnimatedSprite)

function Eye:init(minX, maxX, minY, maxY)

    self.minX = minX
    self.minY = minY
    self.maxX = maxX
    self.maxY = maxY

    imagetable = gfx.imagetable.new("sprites/eye")
    Eye.super.init(self, imagetable)
    self:addState("opening", 1, 5, { tickStep = 1, nextAnimation = "open" })
    self:addState("open", 6, 6, { tickStep = 1 })
    self:addState("closing", 7, 11, { tickStep = 1, nextAnimation = "close" })
    self:addState("close", 12, 12, { tickStep = 1, nextAnimation = "close" }).asDefault()
    self:addState("blink", 13, 22, { tickStep = 1, nextAnimation = "open" })

    self.states.closing.onAnimationEndEvent = function(self) self:randomMove() end

    self:randomMove()
    self:playAnimation()

    self:chooseNext()
end

function Eye:chooseNext()
    nextState = nil
    state = self.currentState

    if state == "closing" or state == "close" then
        nextState = ({ "opening", "blink" })[math.random(1, 2)]
    elseif state == "opening" or state == "open" or state == "blink" then
        nextState = ({ "closing", "blink" })[math.random(1, 2)]
    end
    callback = function()
        print(state)
        self:changeState(nextState)
        self:chooseNext()
    end
    time = math.random(3, 10) * 1000
    print(time)
    pd.timer.performAfterDelay(time, callback)

end

function Eye:randomMove()
    x = math.random(self.minX, self.maxX)
    y = math.random(self.minY, self.maxY)
    print(x .. " " .. y)
    self:moveTo(x, y)
end

function Eye:update()
    Eye.super.update(self)

end
