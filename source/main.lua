import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "ball"
import "game"
import "player"

local gfx <const> = playdate.graphics
local pd <const> = playdate


math.randomseed(playdate.getSecondsSinceEpoch())

pd.graphics.setBackgroundColor(gfx.kColorBlack)

local function initialize()

	local game = Game()
	game:add()
	game:addBlocks(4, 7)

	local player = Player(getLeftBorder() + gameAreaWidth / 2, getBottomBorder() - 25, 5, game)
	player:add()
end

initialize()

function playdate.update()
	gfx.sprite.update()

end
