--[[
     Filename:	GuildNote.lua 

       Author:	Karin
  Modified by:	Shaun Voysey

      Version:	6.2.1

  Modified On:	1st July, 2015

    Notes:
	6.2.1	Made sure that the Guild total is not exceeded when looking for ME.

	6.2.0	Toc Update.

	6.1.1	Corrected The Guild loop.  Had to add the 'Realm' to the Current player's name <player>-<Realm> 
            for the loop to complete.  Otherwise GAME LOCKUP..

	6.1.0	Toc Update.

	5.0.0	Toc Update.

	4.2.0	Toc Update.

	4.0.2	Blasted Indexing.  GetGuildRosterSelection() function can be dangerous if you have
		selected someone else. And have full edit privs.

		Replaced with a looped function to get the players current index in the Guild list.

	4.0.1	Force a refresh of the Local Guild Information.

		It seems that Blizz have stopped most of the Guild refreshes.
		So I have inserted a GuildRoster() request so that the Local Public Note is updated.

	4.0.0	Major modification for Cataclysm.

		New functions and such to replace several loops that we used to use.
		No loops.  Faster done.

		Have to now pass variables for the Loading code.  Using GetRealmName() instead of getting the CVAR.
		Also moved the Config Boxes and strings to the left in the Addon panel.

	3.4.2	Corrected the swapover of Jewelcrafting and Inscription.

	3.4.1	Corrected a Loop in the Output.
 		I was using a non-existent Realm variable and not the GUILDNOTE_DB.

		Thankyou Dichune for Spotting it.  How I missed in testing...  Probably a last minute change.  :(

	3.4.0	Major Modifications with an Addon panel.
		Should no be Completely Localised.  Though Herbalsism could cause some problems.

		Players can now enter What they like for the Trades.  Still with the Maximum of 10 Characters.

]]--

function GuildNote_OnLoad(frame)
    frame:RegisterEvent("PLAYER_LOGIN");
    frame:RegisterEvent("CHAT_MSG_SKILL");
    frame:RegisterEvent("TRADE_SKILL_CLOSE");

    DEFAULT_CHAT_FRAME:AddMessage(GUILDNOTE_INCOLOUR .. " " .. GetAddOnMetadata("GuildNote", "Version") .. " now loaded.  Your tradeskill information will be updated automatically in the guild screen.");
end


function GuildNote_OnEvent(frame, event, ...)

    if (event == "PLAYER_LOGIN") then
        GuildNote_Initialise();

        -- Set the Label Text for the Edit Boxes.
        --

        GuildNote_GUI_FSAlchemy:SetText(GuildNote_Config[Realm].Default[1]);
        GuildNote_GUI_FSBlacksmith:SetText(GuildNote_Config[Realm].Default[2]);
        GuildNote_GUI_FSLeatherwork:SetText(GuildNote_Config[Realm].Default[3]);
        GuildNote_GUI_FSMining:SetText(GuildNote_Config[Realm].Default[4]);
        GuildNote_GUI_FSTailoring:SetText(GuildNote_Config[Realm].Default[5]);
        GuildNote_GUI_FSEngineering:SetText(GuildNote_Config[Realm].Default[6]);
        GuildNote_GUI_FSEnchanting:SetText(GuildNote_Config[Realm].Default[7]);
        GuildNote_GUI_FSSkinning:SetText(GuildNote_Config[Realm].Default[8]);
        GuildNote_GUI_FSJewelcrafting:SetText(GuildNote_Config[Realm].Default[9]);
        GuildNote_GUI_FSInscription:SetText(GuildNote_Config[Realm].Default[10]);
        GuildNote_GUI_FSHerbalism:SetText(GuildNote_Config[Realm].Default[11]);

        GuildNote_GUI_EBAlch:SetCursorPosition(0);
        GuildNote_GUI_EBBlac:SetCursorPosition(0);
        GuildNote_GUI_EBLeat:SetCursorPosition(0);
        GuildNote_GUI_EBMini:SetCursorPosition(0);
        GuildNote_GUI_EBTail:SetCursorPosition(0);
        GuildNote_GUI_EBEngi:SetCursorPosition(0);
        GuildNote_GUI_EBEnch:SetCursorPosition(0);
        GuildNote_GUI_EBSkin:SetCursorPosition(0);
        GuildNote_GUI_EBInsc:SetCursorPosition(0);
        GuildNote_GUI_EBJewe:SetCursorPosition(0);
        GuildNote_GUI_EBHerb:SetCursorPosition(0);
    else
        TheNote = "";

        --  I'm not in a Guild or I cannot change the Public Note.  (No need to go through the rest then.)
        --
        if (not IsInGuild()) or (not CanEditPublicNote()) then return end;

        --  Get the Profession Indexes
        --
        Prof1, Prof2, _, _, _, _ = GetProfessions();

        -- Sets up the public note.
        -- Each Profession shortened to a Maximum of 10 Characters unless already shortened in the Localization file.
        --
        -- Get the first Profession (This Profession should be here at this point)
        --
        if Prof1 then 
            local skillName, _, skillRank, _, _, _, _, _, _, _ = GetProfessionInfo(Prof1);

            --  First Profession.
            --
            TheNote = GuildNote_Output(skillName) .. " " .. skillRank;
        end

        --  Get the second Profession (This Profession may or may not be here).  Will be a zero Index if not present.
        --
        if Prof2 then 
            local skillName, _, skillRank, _, _, _, _, _, _, _ = GetProfessionInfo(Prof2);

            --  Second Profession.  (If here.)
            --
            TheNote = TheNote .. "/" .. GuildNote_Output(skillName) .. " " .. skillRank;
        end

        --  Post the PublicNote.  But only if changed.
        --
        local GuildIndex, GuildNote = GuildNote_FindPlayerIndex();

        if not (GuildNote == TheNote) then
            GuildRosterSetPublicNote(GuildIndex, TheNote);

            --  Refresh Local Guild Information.
            --
            GuildRoster();
        end

        --  All Finished.
        --
    end
end -- Function



--
-- GUI Functions
--

-- This function is run on pressing the Ok or Close Buttons.
--   Sets the Status of the Saved Variables to the new settings
--
function GuildNotePanel_Close()
    GuildNote_Config[Realm].Output[1] = GuildNote_GUI_EBAlch:GetText();
    GuildNote_Config[Realm].Output[2] = GuildNote_GUI_EBBlac:GetText();
    GuildNote_Config[Realm].Output[3] = GuildNote_GUI_EBLeat:GetText();
    GuildNote_Config[Realm].Output[4] = GuildNote_GUI_EBMini:GetText();
    GuildNote_Config[Realm].Output[5] = GuildNote_GUI_EBTail:GetText();
    GuildNote_Config[Realm].Output[6] = GuildNote_GUI_EBEngi:GetText();
    GuildNote_Config[Realm].Output[7] = GuildNote_GUI_EBEnch:GetText();
    GuildNote_Config[Realm].Output[8] = GuildNote_GUI_EBSkin:GetText();
    GuildNote_Config[Realm].Output[9] = GuildNote_GUI_EBJewe:GetText();
    GuildNote_Config[Realm].Output[10] = GuildNote_GUI_EBInsc:GetText();
    GuildNote_Config[Realm].Output[11] = GuildNote_GUI_EBHerb:GetText();
end


-- This function is run on pressing the Cancel Button or from the VARIABLES LOADED event function.
--   Sets the status of the Edit Boxes to the Values of the Saved Variables.
--
function GuildNotePanel_CancelOrLoad()
    GuildNote_GUI_EBAlch:SetText(GuildNote_Config[Realm].Output[1]);
    GuildNote_GUI_EBBlac:SetText(GuildNote_Config[Realm].Output[2]);
    GuildNote_GUI_EBLeat:SetText(GuildNote_Config[Realm].Output[3]);
    GuildNote_GUI_EBMini:SetText(GuildNote_Config[Realm].Output[4]);
    GuildNote_GUI_EBTail:SetText(GuildNote_Config[Realm].Output[5]);
    GuildNote_GUI_EBEngi:SetText(GuildNote_Config[Realm].Output[6]);
    GuildNote_GUI_EBEnch:SetText(GuildNote_Config[Realm].Output[7]);
    GuildNote_GUI_EBSkin:SetText(GuildNote_Config[Realm].Output[8]);
    GuildNote_GUI_EBJewe:SetText(GuildNote_Config[Realm].Output[9]);
    GuildNote_GUI_EBInsc:SetText(GuildNote_Config[Realm].Output[10]);
    GuildNote_GUI_EBHerb:SetText(GuildNote_Config[Realm].Output[11]);
end


-- This function is run on pressing the Reset All to Default Button.
--   Sets the status of the Edit Boxes to the Values of the Saved Default Variables.
--
function GuildNotePanel_ResetAll()
    GuildNote_GUI_EBAlch:SetText(string.sub(GuildNote_Config[Realm].Default[1],1,10));
    GuildNote_GUI_EBBlac:SetText(string.sub(GuildNote_Config[Realm].Default[2],1,10));
    GuildNote_GUI_EBLeat:SetText(string.sub(GuildNote_Config[Realm].Default[3],1,10));
    GuildNote_GUI_EBMini:SetText(string.sub(GuildNote_Config[Realm].Default[4],1,10));
    GuildNote_GUI_EBTail:SetText(string.sub(GuildNote_Config[Realm].Default[5],1,10));
    GuildNote_GUI_EBEngi:SetText(string.sub(GuildNote_Config[Realm].Default[6],1,10));
    GuildNote_GUI_EBEnch:SetText(string.sub(GuildNote_Config[Realm].Default[7],1,10));
    GuildNote_GUI_EBSkin:SetText(string.sub(GuildNote_Config[Realm].Default[8],1,10));
    GuildNote_GUI_EBJewe:SetText(string.sub(GuildNote_Config[Realm].Default[9],1,10));
    GuildNote_GUI_EBInsc:SetText(string.sub(GuildNote_Config[Realm].Default[10],1,10));
    GuildNote_GUI_EBHerb:SetText(string.sub(GuildNote_Config[Realm].Default[11],1,10));
end


-- This function is run on pressing the Reset All to Default Button.
--   Sets the status of the Edit Boxes to the Values of the Saved Default Variables.
--
function GuildNotePanel_Set1()
    GuildNote_GUI_EBAlch:SetText(GUILDNOTE_DB.Def1[1]);
    GuildNote_GUI_EBBlac:SetText(GUILDNOTE_DB.Def1[2]);
    GuildNote_GUI_EBLeat:SetText(GUILDNOTE_DB.Def1[3]);
    GuildNote_GUI_EBMini:SetText(GUILDNOTE_DB.Def1[4]);
    GuildNote_GUI_EBTail:SetText(GUILDNOTE_DB.Def1[5]);
    GuildNote_GUI_EBEngi:SetText(GUILDNOTE_DB.Def1[6]);
    GuildNote_GUI_EBEnch:SetText(GUILDNOTE_DB.Def1[7]);
    GuildNote_GUI_EBSkin:SetText(GUILDNOTE_DB.Def1[8]);
    GuildNote_GUI_EBJewe:SetText(GUILDNOTE_DB.Def1[9]);
    GuildNote_GUI_EBInsc:SetText(GUILDNOTE_DB.Def1[10]);
    GuildNote_GUI_EBHerb:SetText(GUILDNOTE_DB.Def1[11]);
end


-- The GUI OnLoad function.
--
function GuildNotePanel_OnLoad(panel)
    -- Set the name for the Category for the Panel
    --
    panel.name = "GuildNote " .. GetAddOnMetadata("GuildNote", "Version");

    -- When the player clicks okay, set the Saved Variables to the current Check Box setting
    --
    panel.okay = function (self) GuildNotePanel_Close(); end;

    -- When the player clicks cancel, set the Check Box status to the Saved Variables.
    panel.cancel = function (self)  GuildNotePanel_CancelOrLoad();  end;

    -- Add the panel to the Interface Options
    --
    InterfaceOptions_AddCategory(panel);
end


-- Defined Functions
--

-- Initialise all Variables.  These are saved Realm wide.
--
function GuildNote_Initialise()
    -- Get Realm name and Check for validity
    --
    Realm = GetRealmName();

    if (GuildNote_init or (not Realm)) then
        return;
    end


    -- Initialise Realm data structures
    --
    if (GuildNote_Config == nil) then
        GuildNote_Config = {};
    end

    -- Set the Tradeskill list using the Spellinfo data. This makes it fully localised, except for Herbalism.
    -- Store for Posterity.
    --
    if (GuildNote_Config[Realm] == nil) then
        local loop = 1;

        GuildNote_Config[Realm] = {};
        GuildNote_Config[Realm].Default = {};
        GuildNote_Config[Realm].Output = {};

        repeat
            SpellName, _, _, _, _, _, _, _, _, _ = GetSpellInfo(GUILDNOTE_DB.AppSkills[loop]);

            GuildNote_Config[Realm].Default[loop] = SpellName;
            GuildNote_Config[Realm].Output[loop] = string.sub(SpellName,1,10);

            loop = loop + 1;
        until GUILDNOTE_DB.AppSkills[loop] == -1;

        -- Set the Herb tradeskill to the Localised variable.
        -- 'Herb Gathering'  Urrggh!
        --
        GuildNote_Config[Realm].Default[loop] = GUILDNOTE_DB.HerbTrade;
        GuildNote_Config[Realm].Output[loop] = string.sub(GUILDNOTE_DB.HerbTrade,1,10);
    end

    -- Load up the Edit Boxes with the correct text.
    --
    GuildNotePanel_CancelOrLoad();


    -- Disable set Button if empty.
    --
    if GUILDNOTE_DB.Def1 == nil then
        GuildNote_GUI_BTSet1:Disable();
    end

    -- Set variable to say we have been through this.
    --
    GuildNote_init = true;
end


-- Match the Skill name to the Saved Default String.
--
function GuildNote_Output(strSkillName)
    local Loop = 1;

    repeat
        if strSkillName == GuildNote_Config[Realm].Default[Loop] then
            return GuildNote_Config[Realm].Output[Loop];
        end;

        Loop = Loop + 1;
    until GUILDNOTE_DB.AppSkills[Loop] == -1;

    -- Return Herbalism no matter what.  As this is the only Localised Text.
    --
    return GuildNote_Config[Realm].Output[Loop];
end


-- Match the Skill name to the Saved Default String.
--
function GuildNote_FindPlayerIndex()
    local GuildIndex = 0;
    local CurrentPlayer = UnitName("player");
    local RealmPlayer = UnitName("player") .. "-" .. Realm
    local numTotalMembers, _, _ = GetNumGuildMembers();
    local name, level, class, zone, note, officernote, online, isMobile;

    repeat
        GuildIndex = GuildIndex + 1;

        --  Searching for ME.  We do not want to change other peoples notes.  D'oh.
        --
        name, _, _, level, class, zone, note, officernote, online, _, _, _, _, isMobile = GetGuildRosterInfo(GuildIndex);
    until (name == RealmPlayer) or (numTotalMembers >= GuildIndex) --  Finaly Have the Index in the Guild List or guildIndex runs out.

    return GuildIndex, note;
end
