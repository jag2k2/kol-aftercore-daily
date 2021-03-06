/*Daily Free Fights*/

/*Fight the Penguin from Deck of Every Card*/
int free_fight_deck_penguin()
{
	string card_name = "Suit Warehouse Discount Card";
	int fishhead_gen = 0;
	
	if (get_property("_deckCardsSeen").contains_text(card_name))
		print("Deck of Every Card has already cheated " + card_name + " today", "blue");
	else if (get_property("_deckCardsDrawn").to_int() >= 15)
		print("Deck of Every Card has been used 15 times already today", "blue");
	else
	{
		use_familiar($familiar[robortender]);
		item fam_equip = familiar_equipment(my_familiar());
		if(fam_equip != $item[toggle switch (Bartend)] || fam_equip != $item[toggle switch (Bounce)])
		{	
			if(item_amount($item[toggle switch (Bartend)]) > 0)
				equip( $slot[familiar], $item[toggle switch (Bartend)]);
			else if(item_amount($item[toggle switch (Bounce)]) > 0)
				equip( $slot[familiar], $item[toggle switch (Bounce)]);
		}
		
		boolean switched = (cli_execute("fold toggle switch (Bartend)"));			// If switch is already set to "bartend" this function will just return false
		if(item_amount($item[stinky cheese eye]) == 0 && equipped_item($slot[acc1]) != $item[stinky cheese eye] && equipped_item($slot[acc2]) != $item[stinky cheese eye] && equipped_item($slot[acc3]) != $item[stinky cheese eye])
				cli_execute("fold stinky cheese eye");
		outfit("Free Fight");
		equip($item[The Jokester's gun]);

		int fishhead_old = item_amount($item[fish head]);
		cli_execute("cheat " + card_name);					
		/*Make sure the kolmafia Custom Combat Script (CCS) is configured to use the skill "Fire the Jokester's Gun" when a penguin is encounterd
		http://kolmafia.us/showthread.php?18721-Deck-of-Every-Card/page3*/
		
		fishhead_gen = item_amount($item[fish head]) - fishhead_old;		
		print("Generated " + fishhead_gen + " fish head", "blue");
	}
	return fishhead_gen;
}

/*Free fights at the snojo*/
int free_fight_snojo()
{
	while(get_property("_snojoFreeFights").to_int() < 10)
	{
		adv1($location[The X-32-F Combat Training Snowman], -1, "");
		print("Fought in the snojo (" + get_property("_snojoFreeFights") + ")", "blue");
	}
	print("Fought " + get_property("_snojoFreeFights") + " at the snojo", "blue");
	return 0;
}

/*Free Bricko fights*/
int free_fight_bricko()
{
	while(get_property("_brickoFights").to_int() < 10)
	{
		create(1, $item[bricko ooze]);
		use(1, $item[bricko ooze]);
		print("Fought a bricko ooze (" + get_property("_brickoFights") + ")", "blue");
	}
	print("Fought " + get_property("_brickoFights") + " bricko fights", "blue");
	return 0;
}

/*Free Witchess Fights*/
int free_fight_witchess()
{
	while(get_property("_witchessFights").to_int() < 5)
	{
		visit_url("campground.php?action=witchess");
		run_choice(1);
		visit_url("choice.php?option=1&pwd="+my_hash()+"&whichchoice=1182&piece=1936", false);
		run_combat();
		print("Fought " + get_property("_witchessFights") + " witchess fights", "blue");
	}
	print("Fought " + get_property("_witchessFights") + " witchess fights", "blue");
	return 0;
}

/*Free Eldritch Tent Fight*/
int free_fight_eldritch_tent()
{
	if(get_property("_eldritchTentacleFought").to_boolean())
		print("Eldritch tenactle (tent) already fought", "blue");
	else
	{
		visit_url("place.php?whichplace=forestvillage&action=fv_scientist");
		run_choice(1);
	}
	return 0;
}

/*Free Eldritch Skill Fight*/
int free_fight_eldritch_skill()
{
	if(get_property("_eldritchHorrorEvoked").to_boolean())
		print("Eldritch tenactle (skill) already fought", "blue");
	else
	{
		use_skill($skill[Evoke Eldritch Horror]);
	}
	return 0;
}

/*Combat filter functions for deep machine fights*/
string insert_use_abstraction(int round, monster opp, string text)
{
	if (round == 1)
	{
		if(opp==$monster[Perceiver of Sensations])
			return "item abstraction: thought";
	
		else if(opp==$monster[Thinker of Thoughts])
			return "item abstraction: action";

		else if(opp==$monster[Performer of Actions])
			return "item abstraction: sensation";
	}
	if(round > 1)
		round = round - 1;
	return get_ccs_action(round);
}

/*Free Deep Machine Tunnel Fights*/
int free_fight_machine_tunnel()
{
	use_familiar($familiar[Machine Elf]);
	while(get_property("_machineTunnelsAdv").to_int() < 5)
	{
		adv1($location[The Deep Machine Tunnels], -1, "insert_use_abstraction");
		print("Fought " + get_property("_machineTunnelsAdv") + " machine tunnel fights", "blue");
	}
	print("Fought " + get_property("_machineTunnelsAdv") + " machine tunnel fights", "blue");
	return 0;
}

