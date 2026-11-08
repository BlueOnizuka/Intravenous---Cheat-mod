local a = {}
a._categoryID = "LEVEL";
a._type = "click";
a.translationID = "CHEAT_MOD_ENABLE_LIGHTS";

function a:getLigthSwitchClassID()
    return objects.getClassID("light_switch");
end

function a:getLightSwitches()
    return game.worldObject:getObjectsByClass( self:getLigthSwitchClassID() );
end

function a:onClick()
    local objects = self:getLightSwitches();
    if (not objects) then return; end

    local lampSwitch;
    for i=1, #objects do
        lampSwitch = objects[i];

        if #lampSwitch.lamps > 0 then
            for j = 1, #lampSwitch.lamps do
                lampSwitch.lamps[j]:enable();
            end
        end
    end
end

return a;