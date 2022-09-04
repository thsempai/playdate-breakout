import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local pd <const> = playdate

local gameAreaWidth <const> = 224
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

function Game:init(line, col)

    Game.super.init(self)
    self:moveTo(gameAreaPositionX + gameAreaWidth / 2, gameAreaPositionY + gameAreaHeigh / 2)


    local image = gfx.image.new(gameAreaWidth, gameAreaHeigh)

    gfx.pushContext(image)
    gfx.drawRect(0, 0, gameAreaWidth, gameAreaHeigh)
    gfx.popContext()

    self:setImage(image)

    self.blocks = {}

end

function Game:addBlocks(line, col)
    -- add blocks
    x = getLeftBorder()
    y = getTopBorder()

    for l = 0, line - 1 do
        for c = 0, col - 1 do
            block = Block(x, y)
            block:add()
            table.insert(self.blocks, block)
            x += block.width
        end
        x = getLeftBorder()
        y += block.height
    end

end

class("Block").extends(gfx.sprite)

function Block:init(x, y)

    local image = gfx.image.new("sprites/block")
    self:setImage(image)
    self:moveTo(x + image.width / 2, y + image.height / 2)
    self:setCollideRect(0, 0, image:getSize())

end
