import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local pd <const> = playdate

gameAreaWidth = 224
gameAreaHeigh = 240
local gameAreaPositionX <const> = (pd.display.getWidth() - gameAreaWidth) / 2
local gameAreaPositionY <const> = 0

score = 0

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
    self:moveTo(pd.display.getWidth() / 2, pd.display.getHeight() / 2)


    local image = gfx.image.new(pd.display.getWidth(), pd.display.getHeight())

    gfx.pushContext(image)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(getLeftBorder(), getTopBorder(), gameAreaWidth, gameAreaHeigh, 3)

    gfx.fillRoundRect(getRightBorder() + 10, getTopBorder(), pd.display.getWidth() - getRightBorder() - 20, 100, 3)
    gfx.popContext()

    self:setImage(image)
    self:setZIndex(-32768)

    self.blocks = {}

end

function Game:update()
    Game.super.update(self)
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
    Block.super.init(self)
    local image = gfx.image.new("sprites/block")
    self:setImage(image)
    self:moveTo(x + image.width / 2, y + image.height / 2)
    self:setCollideRect(0, 0, image:getSize())
    self.value = 100

end
