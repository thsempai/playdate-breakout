import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local pd <const> = playdate

local gameAreaWidth <const> = 200
local gameAreaHeigh <const> = 240
local gameAreaPositionX <const> = (pd.display.getWidth() - gameAreaWidth) / 2
local gameAreaPositionY <const> = 0

function getRightBorder()
    return gameAreaPositionX + gameAreaWidth
end

function getLeftBorder()
    return gameAreaPositionX
end

function getBottomBorder()
    return gameAreaPositionY + gameAreaHeigh
end

function getTopBorder()
    return gameAreaPositionY;
end

class("Game").extends(gfx.sprite)

function Game:init()

    Game.super.init(self)
    self:moveTo(gameAreaPositionX + gameAreaWidth / 2, gameAreaPositionY + gameAreaHeigh / 2)


    local image = gfx.image.new(gameAreaWidth, gameAreaHeigh)

    gfx.pushContext(image)
    gfx.drawRect(0, 0, gameAreaWidth, gameAreaHeigh)
    gfx.popContext()

    self:setImage(image)
end
