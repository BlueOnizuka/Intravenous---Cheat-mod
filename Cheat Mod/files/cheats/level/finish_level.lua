local a = {}
a._categoryID = "LEVEL";
a._type = "click";
a.translationID = "CHEAT_MOD_FINISH_LEVEL";

function a:onClick()
    game.finishLevel();
end

return a;