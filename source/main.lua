import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "ball"
import "game"
import "player"
import "eye"

local gfx <const> = playdate.graphics
local pd <const> = playdate


math.randomseed(playdate.getSecondsSinceEpoch())

pd.graphics.setBackgroundColor(gfx.kColorBlack)

local function initialize()

	local game = Game("levels/1.lvl")
	game:add()

	local player = Player(getLeftBorder() + gameAreaWidth / 2, getBottomBorder() - 25, 5, game)
	player:add()

	local eye1 = Eye(16, getLeftBorder() - 16, 16, getBottomBorder() - 16)

	eye1:add()

end

initialize()

function playdate.update()
	gfx.sprite.update()
	pd.timer.updateTimers()

end
