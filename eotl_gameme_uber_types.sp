#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_AUTHOR "ack"
#define PLUGIN_VERSION "0.03"

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <tf2_stocks>

public Plugin myinfo = {
	name = "eotl gameme uber types", 
	author = PLUGIN_AUTHOR, 
	description = "GameMe stats for each uber type", 
	version = PLUGIN_VERSION, 
	url = ""
};

bool g_dropNextMessage;

public void OnPluginStart() {
	HookEvent("player_chargedeployed", EventUberDeployed, EventHookMode_Pre);
	AddGameLogHook(OnGameLog);
}

public void OnMapStart() {
	g_dropNextMessage = false;
}

public Action EventUberDeployed(Handle event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(GetEventInt(event, "userid"));

	if(IsFakeClient(client) || !IsClientInGame(client)) {
		return Plugin_Continue;
	}

	// Don't allow logging of ubercharges during setup time
	if(GameRules_GetProp("m_bInSetup")) {
		LogMessage("client: %d dropping chargedeployed log message because round is in setup time", client);
		g_dropNextMessage = true;
		return Plugin_Continue;
	}

	int weaponEnt = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
	if(!IsValidEntity(weaponEnt)) {
		LogError("client: %d GetPlayerWeaponSlot() returned %d, allowing normal logging", client, weaponEnt);
		return Plugin_Continue;
	}

	int weaponIndex = GetEntProp(weaponEnt, Prop_Send, "m_iItemDefinitionIndex");
	if(weaponIndex < 0) {
		LogError("client: %d m_iItemDefinitionIndex returned %d, allowing normal logging", client, weaponIndex);
		return Plugin_Continue;
	}

	// values from scripts/items/items_game.txt
	switch(weaponIndex) {

		//   20 = TF_WEAPON_MEDIGUN
		//  211 = Upgradeable TF_WEAPON_MEDIGUN
		//  663 = Festive Medigun 2011
		//  796 = Silver Botkiller Medi Gun Mk.I
		//  805 = Gold Botkiller Medi Gun Mk.I
		//  885 = Rust Botkiller Medi Gun Mk.I
		//  894 = Blood Botkiller Medi Gun Mk.I
		//  903 = Carbonado Botkiller Medi Gun Mk.I
		//  912 = Diamond Botkiller Medi Gun Mk.I
		//  961 = Silver Botkiller Medi Gun Mk.II
		//  970 = Gold Botkiller Medi Gun Mk.II
		// 15008 = concealedkiller_medigun_maskedmender
		// 15010 = concealedkiller_medigun_wrappedreviver
		// 15025 = craftsmann_medigun_reclaimedreanimator
		// 15039 = teufort_medigun_civilservant
		// 15050 = powerhouse_medigun_sparkoflife
		// 15078 = harvest_medigun_wildwood
		// 15097 = pyroland_medigun_flowerpower
		// 15122 = gentlemanne_medigun_highrollers
		// 15145 = warbird_medigun_blitzkrieg
		// 15146 = warbird_medigun_corsair
		case 29, 211, 663, 796, 805, 885, 894, 903, 912, 961, 970, 15008, 15010, 15025, 15039, 15050, 15078, 15097, 15122, 15145, 15146:
		{
			LogToGame("\"%L\" triggered \"chargedeployed_medigun\"", client);
			g_dropNextMessage = true;
		}

		//    35 = The Kritzkrieg
		//  5749 = Kritzkrieg Killstreakifier Basic
		case 35, 5749:
		{
			LogToGame("\"%L\" triggered \"chargedeployed_kritzkrieg\"", client);
			g_dropNextMessage = true;
		}

		//   411 = The Quick-Fix
		case 411:
		{
			LogToGame("\"%L\" triggered \"chargedeployed_quickfix\"", client);
			g_dropNextMessage = true;		
		}
		//   988 = The Vaccinator
		//  5756 = Vaccinator Strangifier
		//  5800 = Vaccinator Killstreakifier Basic
		case 998, 5756, 5800:
		{
			LogToGame("\"%L\" triggered \"chargedeployed_vaccinator\"", client);
			g_dropNextMessage = true;
		}

		default:
		{
			LogMessage("player_chargedeployed client: %d weapon index: %d (Unknown), allowing normal logging", client, weaponIndex);
		}
	
	}
	return Plugin_Continue;
}

// this will allow us to drop the to be logged chargedeployed event, while still allowing
// other plugins to get the actual event
public Action OnGameLog(const char[] message) {
	if(g_dropNextMessage) {
		g_dropNextMessage = false;
		return Plugin_Handled;
    }
	return Plugin_Continue;
}