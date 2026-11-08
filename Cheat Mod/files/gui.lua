local mouseVisibilityHandler = mouseVisibilityHandler;
local frameController = frameController;
local objectSelector = objectSelector;
local inputService = inputService;
local mainMenu = mainMenu;
local camera = camera;
local events = events;
local fonts = fonts;
local game = game;
local gui = gui;
local _S = _S;
local _T = _T;

local font = "pixellari22"
local itemHeight = 24;

function c:createCheckbox(id)
    local cheat = self:getByID(id);
    if (not cheat) then
        print("[cheat_mod][createCheckbox] invalid cheat! - id: " .. id);
        return;
    end

    local check = gui.create("CategoryCheckbox");
    check:setFont(font);
    check:setText(cheat:getTranslationString());
    check:setSize(itemHeight, itemHeight);
    check.checkCallback = function(obj)
        if (cheat:isEnabled()) then
            self:disable(id);
        else
            self:enable(id);
        end
    end
    check.isOnFunc = function(obj)
        return cheat:isEnabled();
    end
    cheat:onGUICreation(check);

    return check;
end

function c:createButton(id)
    local cheat = self:getByID(id);
    if (not cheat) then
        print("[cheat_mod][createButton] invalid cheat! - id: " .. id);
        return;
    end

    local button = gui.create("Button");
    button:setSize(240, itemHeight);
    button:setFont(font);
    button:setText(cheat:getTranslationString());
    button.postClick = function(obj, localX, localY, key)
        self:addUsedCheat(id);
        cheat:onClick();
    end
    cheat:onGUICreation(button);

    return button;
end

function c:createGUIElement(cheatID)
    local e = self:getByID(cheatID);

    if (e) then
        local t = e:getType();
        local obj;
        if (t == "check") then
            obj = self:createCheckbox(cheatID);
            return obj;
        elseif (t == "click") then
            obj = self:createButton(cheatID);
            return obj;
        else
            print("[cheat_mod][createGUIElement] unknown cheat type! type: " ..
                      tostring(t) .. " | id: " .. tostring(cheatID));
            return;
        end

    end

    return;
end

function c:pauseGame()
    mainMenu.ingameMenuCreated = true; -- pause the game

    self.preOpenMousePos[1] = camera.mouseX / resolutionHandler.realW;
    self.preOpenMousePos[2] = camera.mouseY / resolutionHandler.realH;
    game.stopInputHandler();

    inputService:addHandler(self.inputHandler, mainMenu.inputHandlerPriority);
    mouseVisibilityHandler:addForceShower(self);
    events:fire(mainMenu.EVENTS.OPENED_INGAME_MENU);
end

function c:unpauseGame()
    mainMenu.ingameMenuCreated = false; -- unpause the game

    camera:setMousePosition(self.preOpenMousePos[1] * resolutionHandler.realW,
                            self.preOpenMousePos[2] * resolutionHandler.realH)
    game.startInputHandler();

    inputService:removeHandler(self.inputHandler);
    mouseVisibilityHandler:removeForceShower(self);
    events:fire(mainMenu.EVENTS.CLOSED_INGAME_MENU);
end

c.preOpenMousePos = {};
function c:hide()
    if (not self.frame) then
        return;
    end

    objectSelector:removeBlocker(self);
    frameController:pop(self.frame);
    self.frame = nil;

    self:unpauseGame();

    return true;
end

function c:show()
    if (self:hide()) then
        return;
    end

    self.wasGUIOpened = true;

    objectSelector:addBlocker(self);
    self:pauseGame();

    local baseSize = 520;
    local panelSize = baseSize - 10;

    local f = gui.create("Frame");
    f:setAnimated(false);
    f:setAlphaTarget(1);
    f:setSize(baseSize, 460);
    f:setFont(font);
    f:setText(_T("CHEAT_MOD_MENU"));
    f:addDepth(1000);
    f:center();
    f.onKill = function()
        self:hide();
    end

    local propertySheet = gui.create("PropertySheet", f)
    propertySheet:setSize(panelSize, f.rawH - 30)
    propertySheet:setPos(_S(5), _S(30))
    propertySheet:setFont(fonts.get(font));
    propertySheet:setTabOffset(_S(9), _S(3))

    local panelHeight = propertySheet.rawH - 35;

    local scroll = gui.create("ScrollbarPanel", f)
    scroll:setPos(0, _S(5))
    scroll:setSize(panelSize, panelHeight)
    scroll:setAdjustElementPosition(true)
    scroll:setAdjustElementSize(false)
    scroll:setSpacing(3)
    scroll:setPadding(3, 3)
    propertySheet:addItem(scroll, _T("CHEAT_MOD_PANEL_CHEATS"), nil, nil, nil);

    local warn_text = gui.create("Label", f);
    warn_text:setFont(font);
    warn_text:wrapText(f:getWidth(), _T("CHEAT_MOD_WARN_TEXT"));
    scroll:addItem(warn_text);

    local info_text = gui.create("Label", f);
    info_text:setFont(font);
    info_text:wrapText(f:getWidth(), _T("CHEAT_MOD_INFO_TEXT"));
    scroll:addItem(info_text);

    local elementWidth = f.rawW - 40;

    for i = 1, #self.cheatCategories do
        local categoryID = self.cheatCategories[i];

        local categoryObj = gui.create("Category")
        categoryObj:setFont(font);
        categoryObj:setSize(elementWidth, 24)
        categoryObj:setText(_T("CHEAT_MOD_CATEGORY_" .. categoryID) or
                                categoryID);
        categoryObj:assumeScrollbar(scroll);
        categoryObj:fold();
        scroll:addItem(categoryObj);

        local cheats = self:getByCategory(categoryID);
        if (cheats) then
            for j = 1, #cheats do
                local element = self:createGUIElement(cheats[j]);
                if (element) then
                    element:setWidth(elementWidth)
                    categoryObj:addItem(element);
                end
            end
        end
    end

    local scroll = gui.create("ScrollbarPanel", f)
    scroll:setPos(0, _S(5))
    scroll:setSize(panelSize, panelHeight)
    scroll:setAdjustElementPosition(true)
    scroll:setAdjustElementSize(false)
    scroll:setSpacing(3)
    scroll:setPadding(3, 3)
    propertySheet:addItem(scroll, _T("CHEAT_MOD_PANEL_WEAPON_EDITOR"), nil, nil,
                          nil)

    local warn_text = gui.create("Label", f);
    warn_text:setFont(font);
    warn_text:wrapText(f:getWidth(), _T("CHEAT_MOD_WEAPON_WARN_TEXT"));
    scroll:addItem(warn_text);

    for i = 1, #weapons.registered do
        local weapon = weapons.registered[i]

        local button = gui.create("Button")
        button:setSize(elementWidth, 24)
        button:setFont(font)
        button:setText(string.format("%s (%s)", tostring(weapon:getName()),
                                     weapon:getID()))
        button.onClick = function(obj, localX, localY, _key)
            self:showWeaponEditor(weapon)
        end
        scroll:addItem(button);

    end

    self.frame = f;
    frameController:push(f);
end
