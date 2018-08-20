import DailyLocations.ash
import default_consult.ash

/*Daily Free Fights*/

/*Fight the Penguin from Deck of Every Card*/
void free_fight_deck_penguin()
{
	string card_name = "Suit Warehouse Discount Card";
	int fishhead_gen = 0;
	
	if (get_property("_deckCardsSeen").contains_text(card_name))
		print("Already cheated " + card_name + " from Deck of Every Card today", "blue");
	else if (get_property("_deckCardsDrawn").to_int() >= 15)
		print("Deck of Every Card has been used 15 times already today", "blue");
	else
	{
		familiar original_fam = my_familiar();
		item original_weapon = equipped_item($slot[weapon]);
		
		use_familiar($familiar[robortender]);
		if(equipped_item($slot[familiar]) != $item[toggle switch (Bartend)] && item_amount($item[toggle switch (Bartend)]) > 0)
				equip($slot[familiar], $item[toggle switch (Bartend)]);
		
		if(equipped_item($slot[familiar]) != $item[toggle switch (Bounce)] && item_amount($item[toggle switch (Bounce)]) > 0)
			equip($slot[familiar], $item[toggle switch (Bounce)]);
		
		if(equipped_item($slot[familiar]) == $item[toggle switch (Bounce)])
			cli_execute("fold toggle switch (Bartend)");							

		equip($item[The Jokester's gun]);

		int fishhead_old = item_amount($item[fish head]);
		cli_execute("cheat " + card_name);					
		/*Make sure the kolmafia Custom Combat Script (CCS) is configured to use the skill "Fire the Jokester's Gun" when a penguin is encounterd
		http://kolmafia.us/showthread.php?18721-Deck-of-Every-Card/page3*/
		
		fishhead_gen = item_amount($item[fish head]) - fishhead_old;		
		print("Generated " + fishhead_gen + " fish head", "blue");
		
		use_familiar(original_fam);
		equip($slot[weapon], original_weapon);
	}
}

/*Free fights at the snojo*/
void free_fight_snojo()
{
	if(get_property("_snojoFreeFights").to_int() >= 10)
		print("Already fought at the snojo 10 times", "blue");
	else
	{
		for x from 1 to (10 - get_property("_snojoFreeFights").to_int())
		{
			adv1($location[The X-32-F Combat Training Snowman], -1, "");
			print("Fought in the snojo (" + get_property("_snojoFreeFights") + ")", "blue");
		}
	soak_hottub();
	}
}

/*Free Bricko fights*/
void free_fight_bricko()
{
	if(get_property("_brickoFights").to_int() >= 3)
		print("Already fought 3 bricko monsters today", "blue");
	else
	{
		for x from 1 to (3 - get_property("_brickoFights").to_int())
		{
			if(item_amount($item[bricko oyster]) == 0)
				create(1, $item[bricko oyster]);
			use(1, $item[bricko oyster]);
			print("Fought " + get_property("_brickoFights") + " bricko monsters", "blue");
		}
	}
}

/*Free Witchess Fights*/
void free_fight_witchess()
{
	if(get_property("_witchessFights").to_int() >= 5)
		print("Already fought 5 witchess monsters today", "blue");
	else
	{
		for x from 1 to (5 - get_property("_witchessFights").to_int())
		{
			visit_url("campground.php?action=witchess");
			run_choice(1);
			visit_url("choice.php?option=1&pwd="+my_hash()+"&whichchoice=1182&piece=1936", false);
			run_combat();
			print("Fought " + get_property("_witchessFights") + " witchess fights", "blue");
		}	
	}
}

/*Free Eldritch Tent Fight*/
void free_fight_eldritch_tent()
{
	if(get_property("_eldritchTentacleFought").to_boolean())
		print("Already fought eldritch tentacle (tent) today", "blue");
	else
	{
		visit_url("place.php?whichplace=forestvillage&action=fv_scientist");
		if(item_amount($item[eldritch essence]) > 0)
			run_choice(2);
		else
			run_choice(1);
		print("Fought eldritch tentacle at the tent", "blue");
	}
}

/*Free Eldritch Skill Fight*/
void free_fight_eldritch_skill()
{
	if(get_property("_eldritchHorrorEvoked").to_boolean())
		print("Already fought eldritch tentacle (skill) today", "blue");
	else
	{
		use_skill($skill[Evoke Eldritch Horror]);
		print("Fought eldritch tentacle using the skill", "blue");
	}
}

/*Combat filter functions for deep machine fights*/
string abstractions(int round, monster opp, string text)
{
	if (round == 1)
	{
		if(opp==$monster[Perceiver of Sensations] && item_amount($item[abstraction: thought]) > 0)
			return "item abstraction: thought";
		
		else if(opp==$monster[Thinker of Thoughts] && item_amount($item[abstraction: action]) > 0)
			return "item abstraction: action";

		else if(opp==$monster[Performer of Actions] && item_amount($item[abstraction: sensation]) > 0)
			return "item abstraction: sensation";
	}
	
	return efficient_spell();
}

/*Free Deep Machine Tunnel Fights*/
void free_fight_machine_tunnel()
{
	if(get_property("_machineTunnelsAdv").to_int() >= 5)
		print("Already fought 5 machine tunnel monsters today", "blue");
	else
	{
		for x from 1 to (5 - get_property("_machineTunnelsAdv").to_int())
		{
			adv1($location[The Deep Machine Tunnels], -1, "abstractions");
			print("Fought " + get_property("_machineTunnelsAdv") + " machine tunnel fights", "blue");
		}
	}
}

