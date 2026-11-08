local a = {}
a._categoryID = "LEVEL";
a._type = "click";
a.translationID = "CHEAT_MOD_UNLOCK_DOORS";

function a:getDoorClassID()
    return objects.getClassID("door");
end

function a:getDoors()
    return game.worldObject:getObjectsByClass( self:getDoorClassID() );
end

function a:onClick()
    local objects = self:getDoors();
    if (not objects) then return; end

    local obj;
    for i=1, #objects do
        obj = objects[i];

        obj:setLocked(false);
    end
end

return a;