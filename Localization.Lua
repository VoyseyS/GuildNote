--[[
     Filename:	Localisation.lua
 
       Author:	Karin
  Modified By:	Shaun Voysey

      Version:	6.1.1

  Modified On:	16th June, 2015

	Herbalism Locale is complete.  Or should be.  The rest of the trades are pulled from the Game.
	We cannot do this with Herbalism as the Spell is listed as "Herb Gathering".

	If there is a problem with the Trades, please let me know.
	Send to <sv.public@hotmail.com>

	Created an Addon panel for inserting your own text for Display.  Defaults to First ten Characters.  Enjoy.  :)

	The GuildNote Layout is :-

		Profession + space + 3 digit Rank value * 2 + Seperator <= 31

]]--

    GUILDNOTE_INCOLOUR = "|cff44ff44G|r|cff55ff55u|r|cff66ff66i|r|cff77ff77l|r|cff88ff88d|r|cff99ff99N|r|cffaaffaao|r|cffbbffbbt|r|cffccffcce|r"

    GUILDNOTE_DB = {};

    -- Setup the Apprentice spell list, minus 'Herb Gathering' (Herbalism).
    --
    GUILDNOTE_DB.AppSkills = {};

    GUILDNOTE_DB.AppSkills[1] = 2259; ---- Alchemy
    GUILDNOTE_DB.AppSkills[2] = 2018; ---- Blacksmithing
    GUILDNOTE_DB.AppSkills[3] = 2108; ---- Leatherworking
    GUILDNOTE_DB.AppSkills[4] = 2575; ---- Mining
    GUILDNOTE_DB.AppSkills[5] = 3908; ---- Tailoring
    GUILDNOTE_DB.AppSkills[6] = 4036; ---- Engineering
    GUILDNOTE_DB.AppSkills[7] = 7411; ---- Enchanting
    GUILDNOTE_DB.AppSkills[8] = 8613; ---- Skinning
    GUILDNOTE_DB.AppSkills[9] = 25229 ---- Jewelcrafting;
    GUILDNOTE_DB.AppSkills[10] = 45357; -- Inscription
    GUILDNOTE_DB.AppSkills[11] = -1; ----- End of list.


    -- Now for the Herbalism Localisation.
    --
    if (GetLocale() == "frFR") then
        -- french part

        GUILDNOTE_DB.HerbTrade = "Herboristerie"; -- French (frFR)
    elseif (GetLocale() == "deDE") then
        -- German part

        GUILDNOTE_DB.HerbTrade = "Kräuterkunde"; --- German (deDE)
    elseif (GetLocale() == "zhTW") then
        -- Taiwan part

        GUILDNOTE_DB.HerbTrade = "¯óÃÄ¾Ç"; --------- (zhTW)
    elseif (GetLocale() == "zhCN") then
        -- China part

        GUILDNOTE_DB.HerbTrade = "²ÝÒ©Ñ§"; --------- Chinese (zhCN)
    elseif (GetLocale() == "ruRU") then
        -- Russian part

        GUILDNOTE_DB.HerbTrade = "Òðàâíè÷åñòâî"; --- Russian (ruRU)
    elseif (GetLocale() == "koKR") then
        -- Korean part

        GUILDNOTE_DB.HerbTrade = "¾àÃÊÃ¤Áý"; ------- Korean (koKR)
    elseif (GetLocale() == "esMX") then
        -- Mexican Spanish part

        GUILDNOTE_DB.HerbTrade = "Herboristería"; -- Mexican Spanish (esMX)

    elseif (GetLocale() == "esES") then
        -- Spanish part

        GUILDNOTE_DB.HerbTrade = "Herboristería"; -- Spanish (esES)
    else
        -- default, english

        GUILDNOTE_DB.HerbTrade = "Herbalism"; ------ English (of course)


        -- Set 1
        --
        GUILDNOTE_DB.Def1 = {};

        GUILDNOTE_DB.Def1[1] = "Alchemy";
        GUILDNOTE_DB.Def1[2] = "Blksmth";
        GUILDNOTE_DB.Def1[3] = "Lthrwkg";
        GUILDNOTE_DB.Def1[4] = "Mining";
        GUILDNOTE_DB.Def1[5] = "Tailor";
        GUILDNOTE_DB.Def1[6] = "Tinker";
        GUILDNOTE_DB.Def1[7] = "Enchant";
        GUILDNOTE_DB.Def1[8] = "Skinning";
        GUILDNOTE_DB.Def1[9] = "Jewel";
        GUILDNOTE_DB.Def1[10] = "Inscribe";
        GUILDNOTE_DB.Def1[11] = "Herb";
    end
