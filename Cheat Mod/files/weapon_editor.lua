local font = "pixellari22"
local itemHeight = 24;

local function isValidType(type)
    return type == 'number' or type == 'string' or type == 'boolean' or type ==
               'table';
end

local function isWeapon(data)
    return data.bulletSpeed ~= nil or data.rateOfFire ~= nil
end

function c:showWeaponEditor(weapon)
    local properties = {}
    local base = weapon.baseClass
    if (base) then
        for k, d in pairs(base) do
            local _type = type(d)
            if (isValidType(_type)) then
                properties[k] = d
            end
        end
    end

    for k, d in pairs(weapon) do
        local _type = type(d)
        if (isValidType(_type)) then
            properties[k] = d
        end
    end

    self:displayArray(properties, weapon:getName() or weapon:getID(), weapon);
end

local function createButton(self, frame, name, weapon, key, _type)
    local button = gui.create("Button")
    button:setSize(mainMenu.optionWidth - 40, mainMenu.controlHeight)
    button:setFont(font)
    button:setText(name)
    button.onClick = function(obj, localX, localY, _key)
        local weapon = weapon
        local key = key
        local type = _type

        frameController:pop(frame)
        self:edit(weapon, key, type)
    end

    return button;
end

local function createComboBox(self, frame, name, weapon, key, _type)
    local button = gui.create("Button")
    button:setSize(mainMenu.optionWidth - 40, mainMenu.controlHeight)
    button:setFont(font)
    button:setText(name)
    button.fillInteractionComboBox = function(self, cbox)
        cbox:addOption(0, 0, self.rawW, 18, "true", fonts.get("pixellari20"),
                       function()
            weapon[key] = true
            self:setText("true")
        end)
        cbox:addOption(0, 0, self.rawW, 18, "false", fonts.get("pixellari20"),
                       function()
            weapon[key] = false
            self:setText("false")
        end)
    end
    button.onClick = function(self, localX, localY, key)
        if interactionController:attemptHide(self) then
            return
        end

        local x, y = self:getPos(true)

        interactionController:startInteraction(self, x, y + self.h)
    end

    return button;
end

local function createButtonArray(self, frame, name, data, key, _type)
    local button = gui.create("Button")
    button:setSize(mainMenu.optionWidth - 40, mainMenu.controlHeight)
    button:setFont(font)
    button:setText(name)
    button.onClick = function(obj, localX, localY, _key)
        local key = key
        local type = _type

        frameController:pop(frame)
        self:displayArray(data, key, data)
    end

    return button;
end

function c:displayArray(properties, name, weapon)
    -- objectSelector:addBlocker(self);
    self:pauseGame();

    local sorted_properties = {}
    for name, value in pairs(properties) do
        if (name == "baseClass" and type(value) == "table") then
            -- nothing
        else
            table.insert(sorted_properties, {
                name = tostring(name),
                value = value
            })
        end
    end
    table.sort(sorted_properties, function(a, b)
        return a.name < b.name
    end)

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
    propertySheet:addItem(scroll, name, nil, nil, nil);

    local elementWidth = f.rawW - 40;

    for _, data in pairs(sorted_properties) do
        local key = data.name;
        local data = data.value;
        local _type = type(data)

        local button = nil;
        if (_type == 'number' or _type == 'string') then
            button = createButton(self, f, tostring(data), weapon, key, _type);
        elseif (_type == 'boolean') then
            button = createComboBox(self, f, tostring(data), weapon, key, _type);
        elseif (_type == 'table') then
            button =
                createButtonArray(self, f, tostring(data), data, key, _type);
        end

        mainMenu:addOptionCombo(key, button, scroll)
    end

    self.frame = f;
    frameController:push(f);
end

function c:edit(data, key, type)
    -- objectSelector:addBlocker(self);
    self:pauseGame();

    local baseSize = 520;
    local panelSize = baseSize - 10;

    local itemHeight = mainMenu.controlHeight;

    local onKill = function()
        if (isWeapon(data)) then
            self:showWeaponEditor(data)
            return;
        end

        self:hide()
    end

    local f = gui.create("Frame");
    f:setAnimated(false);
    f:setAlphaTarget(1);
    f:setFont(font);
    f:setText(_T("CHEAT_MOD_MENU"));
    f:addDepth(1000);
    f:setSize(baseSize, f:getTopPartBottom() + (itemHeight * 5));
    f:center();
    f.onKill = onKill;

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
    propertySheet:addItem(scroll, string.format("%s (%s)", key, type), nil, nil,
                          nil);

    local elementWidth = f.rawW;

    local textbox = gui.create("TextBox")
    textbox:setSize(elementWidth, itemHeight)
    textbox:setFont(font)
    textbox:setText(tostring(data[key]))
    if (type == "number") then
        textbox:setNumbersOnly(true)
        textbox:setDecimalsAllowed(true)
        textbox:setAllowNegativeNumbers(true)
    end
    scroll:addItem(textbox);

    local button = gui.create("Button")
    button:setSize(elementWidth, itemHeight)
    button:setFont(font)
    button:setText("Set")
    button.onClick = function(obj, localX, localY, _key)
        data[key] = textbox:getText() -- if numbersOnly, returns number
        frameController:pop(f);
    end
    scroll:addItem(button);

    self.frame = f;
    frameController:push(f);
end
