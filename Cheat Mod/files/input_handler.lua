local inputHandler = {}
inputHandler._cheatObj = nil;

function inputHandler:setCheatObject(obj)
    self._cheatObj = obj;
end

function inputHandler:handleEscapeMenu(key)
    local cheatObj = self._cheatObj;
    if (key ==
        keyBinding:getCommandKey(cheatObj.keyBinding["TOGGLE_CHEAT_MENU"]) or
        key == "escape") then
        cheatObj:hide();
        return true;
    end

    return false
end

function inputHandler:handleKeyPress(key)
    if gui.handleKeyPress(key) then
        return true
    end

    if self:handleEscapeMenu(key) then
        return true
    end

    if frameController:getFrameCount() > 0 then
        return
    end
end

function inputHandler:handleKeyRelease(key)
    if gui.handleKeyRelease(key) then
        return true
    end

    return true;
end

function inputHandler:handleTextInput(text)
    if gui.handleTextEntry(text) then
        return true
    end

    return true
end

return inputHandler
