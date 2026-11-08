local a = {}
a._categoryID = "AI";
a._type = "click";
a.translationID = "CHEAT_MOD_KILL_ALL_NPCS";

function a:getWorld()
    return game.getWorld();
end

function a:getNPCs()
    local world = self:getWorld();
    if (not world) then return; end

    return world:getNPCs();
end

function a:onClick()
    local npcs = self:getNPCs();
    if (not npcs) then return; end

    local playerActor = game.playerActor;
    if (not playerActor) then return; end

    for _,npcActor in pairs(npcs) do
        if (npcActor:getClass() == "goon") then
            npcActor:die(playerActor);
        end
    end
end

return a;