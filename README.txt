GuildNote  6.1.0

By kcupit
Modified By Shaun Voysey

------------
INTRODUCTION
------------

Automatically and quietly places your tradeskill information in your public note each time you gain a skill point or close a tradeskill window.

-----------------------------
REQUIREMENTS and INSTALLATION
-----------------------------

Place the "GuildNote" folder here:
    (World of Warcraft folder) --> Interface --> AddOns --> 

--------------------
INSTRUCTIONS FOR USE
--------------------

This addon runs quietly and invisibly. It simply places your tradeskill information into your Public Note so that your guild members can see who in the guild is at what level when viewing the in-game guild roster.

Public notes will look something like this:

      Enchant 327/Mining 364

You can now enter what you want to see in the Public Note. These are stored for Realm wide access and entered through the Addon panels.

This addon also works great with RedBanker (http://wow.curse.com/downloads/wow-addons/details/sc_red-banker.aspx), which if installed will show you which guild member can use any item you pick up, in case you want to give back to your guildies.

------------
CHANGELOG
------------
1.0	- Initial release, based on GuildNote by Daelic (http://wow-en.curse-gaming.com/files/details/799/guildnote/),
	- which hasn't been updated since April 2005.

1.0.1	- Works with WoW 2.0.6
	- Shortened text to fit in public note

1.1	- Works with WoW 3.0.3
	- Updated for Wrath of the Lich King

2.0	- Works with WoW 3.1
	- Now Localised.  Will need the Other languages though.   <sv.public@hotmail.com>

3.3.0	- Works with WoW 3.3
	- Just a toc update  Still need the Other languages.      <sv.public@hotmail.com>

3.3.2	- Fully Localised (hopefully).  Also modified for Player adjustment.
	- Players can now enter what they want for the Public note to display.
beta	- Still limited to 10 Characters though.                  <sv.public@hotmail.com>

3.4.0	- Major Modifications with an Addon panel.
	- Should no be Completely Localised.  Though Herbalsism could cause some problems.
	- 
	- Players can now enter What they like for the Trades.  Still with the Maximum of 10 Characters.

3.4.1	- Corrected a Loop in the Output.
	- I was using a non-existent Realm variable and not the GUILDNOTE_DB.
	- 
	- Thankyou Dichune for Spotting it.  How I missed in testing...  Probably a last minute change.  :(

3.4.2	- Corrected the swapover of Jewelcrafting and Inscription.

4.0.0	- Major modification for Cataclysm.
	- 
	- New functions and such to replace several loops that we used to use.
	- No loops.  Faster done.
	-
	- Have to now pass variables for the Loading code.  Using GetRealmName() instead of getting the CVAR.
	- Also moved the Config Boxes and strings to the left.

4.0.1	- Force a refresh of the Local Guild Information.
	-
	- It seems that Blizz have stopped most of the Guild refreshes.
	- So I have inserted a GuildRoster() request so that the Local Public Note is updated.

4.0.2	- Blasted Indexing.  GetGuildRosterSelection() function can be dangerous if you have
	- selected someone else. And have full edit privs.
	-
	- Replaced with a looped function to get the players current index in the Guild list.

4.2.0	- Toc Update.

4.3.0	- Toc Update.

5.0.0	- Toc Update.

6.1.0	- Toc Update.


------------
KNOWN ISSUES
------------

- None for the Moment.

------------
FUTURE PLANS
------------

None so far.  If you have any suggestions, please contact the author at kspam@spaceman.ca or the Co-Author at <sv.public@hotmail.com>
