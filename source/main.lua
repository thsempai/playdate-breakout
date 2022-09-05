import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "ball"
import "game"
import "player"

local gfx <const> = playdate.graphics
local pd <const> = playdate

pd.graphics.setBackgroundColor(gfx.kColorBlack)
local function initialize()

	local game = Game()
	game:add()
	game:addBlocks(4, 7)

	local player = Player(getLeftBorder() + gameAreaWidth / 2, getBottomBorder() - 25, 5)
	player:add()
end

initialize()

function playdate.update()
	gfx.sprite.update()
	gfx.drawText(score, getRightBorder() + 20, getTopBorder() + 10)
	gfx.drawText("lifes: " .. lifes, getRightBorder() + 20, getTopBorder() + 30)
end
