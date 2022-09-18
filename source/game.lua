import "CoreLibs/sprites"
import "CoreLibs/string"

import "bonus"

local gfx <const> = playdate.graphics
local pd <const> = playdate

gameAreaWidth = 224
gameAreaHeigh = 240
blockSize = 16

local gameAreaPositionX <const> = (pd.display.getWidth() - gameAreaWidth) / 2
local gameAreaPositionY <const> = 0

local bonusRatio = 0.125

score = 0
lifes = 3
bonusGravity = 2

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

function Game:init(file)


    Game.super.init(self)

    self.blocks = {}

    self:moveTo(pd.display.getWidth() / 2, pd.display.getHeight() / 2)

    if file ~= nil then
        file = pd.file.open(file)

        dimension = file:readline()
        index = dimension:find("x")
        w = tonumber(dimension:sub(1, index - 1))
        h = tonumber(dimension:sub(index + 1, dimension:len()))
        gameAreaWidth = w * blockSize
        gameAreaHeigh = h * blockSize

        lineNumber = 1
        line = file:readline()
        while line do
            line = pd.string.trimWhitespace(line)
            colNumber = 1

            while line:sub(colNumber, colNumber) ~= "" do
                if line:sub(colNumber, colNumber) == "." then
                    colNumber += 1
                elseif line:sub(colNumber, colNumber + 1) == "bb" then
                    -- block classic
                    self:addBlock(lineNumber, colNumber)
                    colNumber += 2
                else
                    error("Level generation: unsupported character found '" .. line:sub(colNumber, colNumber) .. "'.")
                end
            end

            line = file:readline()
            lineNumber += 1
        end
    end


    local image = gfx.image.new(pd.display.getWidth(), pd.display.getHeight())

    gfx.pushContext(image)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(getLeftBorder(), getTopBorder(), gameAreaWidth, gameAreaHeigh, 3)

    gfx.fillRoundRect(pd.display.getWidth() - 32 - 10, getTopBorder(), 32, 32, 3)
    gfx.popContext()

    self.currentBonus = nil

    self:setImage(image)
    self:setZIndex(-32768)

    --pd.sound.micinput.startListening()

end

function Game:update()
    Game.super.update(self)
    if pd.buttonIsPressed(pd.kButtonB) then
        if self.currentBonus ~= nil then
            self.currentBonus:use()
            self.currentBonus:remove()
            self.currentBonus = nil
        end
    end

end

function Game:addBlock(line, col)
    x = getLeftBorder() + (col - 1) * blockSize
    y = getTopBorder() + (line - 1) * blockSize

    block = Block(x, y)
    block:add()
    table.insert(self.blocks, block)

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

function Game:getNewBonus(bonus)
    if self.currentBonus ~= nil then
        self.currentBonus:remove()
    end
    self.currentBonus = bonus
    self.currentBonus:moveTo(pd.display.getWidth() - 16 - 10, getTopBorder() + 16)
    self.currentBonus.isStatic = true
end

class("Block").extends(gfx.sprite)

function Block:init(x, y)
    Block.super.init(self)
    local image = gfx.image.new("sprites/block")
    self:setImage(image)
    self:setCenter(0, 0) -- top left
    self:moveTo(x, y)
    self:setCollideRect(0, 0, image:getSize())

end

function Block:destroy()
    rnd = math.random(1, 1 / bonusRatio)
    if rnd == 1 then
        local bonus = BonusLife(self.x, self.y)
        bonus:add()
    end
    self:remove()
end
