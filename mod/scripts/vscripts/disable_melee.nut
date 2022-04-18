global function DisableMeleeInit

void function DisableMeleeInit() {

	foreach (string mode in split(GetConVarString("disable_melee_whitelist").tolower(), ",")) {
		if (GameRules_GetGameMode() == strip(mode)) return;
	}

	// Only look at blacklist if whitelist is blank
	bool currentModeIsBlacklisted = false;
	if (GetConVarString("disable_melee_whitelist").len() == 0) {
		foreach (string mode in split(GetConVarString("disable_melee_blacklist").tolower(), ",")) {
			if (GameRules_GetGameMode() == strip(mode)) currentModeIsBlacklisted = true;
		}
	}
	else currentModeIsBlacklisted = true;

	if (currentModeIsBlacklisted) AddCallback_OnPlayerRespawned(OnPlayerRespawned);
}

void function OnPlayerRespawned( entity player ) {
	player.TakeOffhandWeapon(OFFHAND_MELEE);
}
