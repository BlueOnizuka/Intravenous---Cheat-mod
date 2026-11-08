c = {}
c.__VERSION = "v1.3 - 06.08.2021"
c.cheatCategories = {
    "PLAYER",
    "LOADOUT",
    "WEAPON",
    "LEVEL",
    "AI",
    "PLAYTHROUGH",
    "RENDER",
    "OTHER"
}
c.defaultCategory = "OTHER";

c.inputHandler = require("input_handler");
c.inputHandler:setCheatObject(c);

c.cheatClass = require("cheat");

c.registered = {};
c.registeredByID = {};
c.registeredByCategory = {};

c.wasGUIOpened = false;
c.usedCheats = {};
c.enabledByID = {};

require("gui");
require("weapon_editor");
require("event_handler");

local setmetatable = setmetatable;
local _insert = table.insert;
local tostring = tostring;
local print = print;
local next = next;

function c:getByID(id)
    return self.registeredByID[id];
end

function c:isEnabled(id)
    return self:getByID(id):isEnabled()
end

function c:checkIfCategoryExists(id)
    local tbl = self.cheatCategories;
    for i = 1, #tbl do
        if (tbl[i] == id) then
            return true;
        end
    end

    return false;
end

function c:addCategory(id)
    local tbl = self.cheatCategories;
    _insert(tbl, #tbl, id); -- "OTHER" should always be at the end :)
end

function c:getByCategory(id)
    return self.registeredByCategory[id];
end

function c:createCheat(id, data)
    if (not id) then
        print("[cheat_mod] expected id, got nil!");
        return;
    end
    if (not data) then
        print("[cheat_mod] expected data, got nil! - id: " .. tostring(id));
        return;
    end
    if (not (type(data) == "table")) then
        print("[cheat_mod] invalid data type! - id: " .. tostring(id) ..
                  " | type: " .. type(data));
        return;
    end
    if (next(data) == nil) then
        print("[cheat_mod] empty data! - id: " .. tostring(id));
        return;
    end
    local cheat = self:getByID(id);
    if (cheat) then
        print("[cheat_mod] cheat with this id already exists! - id: " ..
                  tostring(id));
        return;
    end

    setmetatable(data, self.cheatClass.mtindex);
    data.id = id;

    _insert(self.registered, data);
    self.registeredByID[id] = data;

    local categoryID = data:getCategory();
    if (not self:checkIfCategoryExists(categoryID)) then
        self:addCategory(categoryID);
    end
    self.registeredByCategory[categoryID] =
        self.registeredByCategory[categoryID] or {};
    _insert(self.registeredByCategory[categoryID], id);

    print("[cheat_mod][createCheat] created '" .. id .. "' (" .. categoryID ..
              ")" .. "!");
end

function c:getUsedCheatsString()
    local str = ""
    for i = 1, #self.usedCheats do
        str = str .. self.usedCheats[i];
        if (next(self.usedCheats, i)) then
            str = str .. ", "
        end
    end

    if (str == "") then
        str = "NONE";
    end

    return str;
end

function c:getEnabledCheatsString()
    local str = ""
    for k, d in pairs(self.enabledByID) do
        if (d) then
            str = str .. k .. ", "
        end
    end

    if (str == "") then
        str = "NONE"
    end
    return str;
end

function c:addUsedCheat(id)
    local found = false;
    for i = 1, #self.usedCheats do
        if (self.usedCheats[i] == id) then
            found = true;
            break
        end
    end
    if (not found) then
        table.insert(self.usedCheats, id)
    end
end

function c:enable(id)
    if (not id) then
        print("[cheat_mod][enable] expected id, got nil!");
        return;
    end
    local cheat = self:getByID(id);
    if (not cheat) then
        print("[cheat_mod][enable] expected cheat, got nil! - id: " ..
                  tostring(id));
        return;
    end

    self:addUsedCheat(id);
    self.enabledByID[id] = true;

    cheat:enable();
end

function c:disable(id)
    if (not id) then
        print("[cheat_mod][disable] expected id, got nil!");
        return;
    end
    local cheat = self:getByID(id);
    if (not cheat) then
        print("[cheat_mod][disable] expected cheat, got nil! - id: " ..
                  tostring(id));
        return;
    end

    self.enabledByID[id] = false;
    cheat:disable();
end

function c:disableAll()
    local cheat;
    for i = 1, #self.registered do
        cheat = self.registered[i];

        if (cheat:getID() == "radiosity") then
            radiosity:setRadiosityState(true) -- dirty fix
        else
            self:disable(cheat:getID())
        end
    end
end

require("gui/init");
require("language/init");
require("cheats/init");

require("keybinding");
