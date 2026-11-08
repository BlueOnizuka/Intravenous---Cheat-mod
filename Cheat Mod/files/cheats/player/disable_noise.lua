local a = {}
a._categoryID = "PLAYER";
a._type = "check";
a.translationID = "CHEAT_MOD_DISABLE_NOISE";

local emit = noise.emit;
local newEmit =function(self, x, y, radius, emitter, noiseType)
    if (emitter == game.playerActor) then return; end

    emit(self, x, y, radius, emitter, noiseType);
end
function a:onEnable()
    noise.emit = newEmit;
end

function a:onDisable()
    noise.emit = emit;
end

return a;