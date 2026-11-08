local a = {}
a._categoryID = "PLAYTHROUGH";
a._type = "click";
a.translationID = "CHEAT_MOD_UNLOCK_NEW_GAME_PLUS";

local createNewGamePlusButton = mainMenu.createNewGamePlusButton

local function createNewGamePlusButtonFIX(self, data)
--	if not DEBUG_MODE and #game.gameData.completedCampaigns == 0 then
--		return
--	end

	local opt = gui.create("OpenCampaignsButton")

	opt:setSize(self.buttonWidth, self.buttonHeight)
	opt:setNewGamePlus(true)
	opt:setFont("pixellari22")
	opt:setText(_T("MENU_START_NEW_GAME_PLUS", "New game+"))
	opt:addDepth(50)
	table.insert(self.menuElements, {
		opt,
		data[2]
	})
end

function a:onClick()
    for i=1, #mainMenu.menuCreators do
        if (mainMenu.menuCreators[i][1] == createNewGamePlusButton) then
            mainMenu.menuCreators[i][1] = createNewGamePlusButtonFIX;
            return;
        end
    end

end

return a;