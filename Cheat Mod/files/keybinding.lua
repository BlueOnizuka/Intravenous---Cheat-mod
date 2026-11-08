c.keyBinding = {["TOGGLE_CHEAT_MENU"] = "toggle_cheat_mod_gui"};

local kb = keyBinding;
local function addCommandName(commandName, name, index)
    if not kb.commandNames[commandName] then
        table.insert(kb.commandNameOrder, index, commandName)
    end

    kb.commandNames[commandName] = name
end

-- local menuID = c.keyBinding["TOGGLE_CHEAT_MENU"];
-- addCommandName( menuID, _T("CHEAT_MOD_MENU"), 1 );
-- kb:assignCallbackToCommand( menuID, function() c:show(); end);

keyBinding.COMMANDS["TOGGLE_CHEAT_MENU"] = "toggle_cheat_mod_gui"

local menuID = keyBinding.COMMANDS["TOGGLE_CHEAT_MENU"]

keyBinding.DEFAULT_KEYS[menuID] = "f1"
addCommandName(menuID, _T("CHEAT_MOD_MENU"), 1);
keyBinding:assignCallbackToCommand(menuID, function()
    c:show()
end)
