local a = {}
a._categoryID = "AI";
a._type = "click";
a.translationID = "CHEAT_MOD_ENABLE_NPCS";

function a:getWorld()
    return game.getWorld();
end

function a:getNPCs()
    local world = self:getWorld();
    if (not world) then return; end

    return world:getNPCs();
end

function a:onClick()
    local objects = self:getNPCs();
    if (not objects) then return; end

    self:getWorld():setNPCLogicState(true);
end

return a;