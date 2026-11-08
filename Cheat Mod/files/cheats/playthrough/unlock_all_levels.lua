local a = {}
a._categoryID = "PLAYTHROUGH";
a._type = "click";
a.translationID = "CHEAT_MOD_UNLOCK_ALL_LEVELS";

function a:onClick()
    for campaignID, campaignData in pairs(game.campaignsByID) do
        campaignData.limitCompletedLevels = false;
    end
end

return a;