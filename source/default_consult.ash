/* Calculates spell efficiency */
skill efficient_spell()
{
	float spell_pct = 1 + numeric_modifier("Spell Damage Percent") / 100;
	int cold_vuln = 0;
	int hot_vuln = 0;
	
	switch (monster_element())
	{
		case $element[hot]:    	hot_vuln = 0; cold_vuln = 1;    break;
		case $element[spooky]: 	hot_vuln = 2; cold_vuln = 1;    break;
		case $element[cold]:   	hot_vuln = 2; cold_vuln = 0;    break;
		case $element[sleaze]: 	hot_vuln = 1; cold_vuln = 2;    break;
		case $element[stench]: 	hot_vuln = 1; cold_vuln = 2;    break;
		default:				hot_vuln = 1; cold_vuln = 1;	break;
	}
	
	int monsterHP = monster_hp();
	int buffedMyst = my_buffedstat($stat[mysticality]);

	skill spell_dmgEff = $skill[saucestorm];
	float spell_mpRatio = mp_cost($skill[saucegeyser]) / to_float(mp_cost($skill[saucestorm]));
	
	float ss_dmg = (50 * cold_vuln + 50 * hot_vuln) * spell_pct;
	float sg_dmg = (75 + 0.4*buffedMyst) * max(hot_vuln, cold_vuln) * spell_pct;
	
	if (sg_dmg / ss_dmg > spell_mpRatio)
		spell_dmgEff = $skill[saucegeyser];

	print("This monster hp: " + monsterHP + " - Saucestorm damage: " + ss_dmg.to_int() + " - Saucegeyser damage: " + sg_dmg.to_int(), "blue");
		
	if(monsterHP > ss_dmg * spell_mpRatio)
		return spell_dmgEff;
	else
		return $skill[saucestorm];
}

void main(int round, monster foe, string page)
{
	use_skill(1, efficient_spell());
}