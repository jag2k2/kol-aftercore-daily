import DailyUseCasts.ash
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
	int fights_avail = 10 - get_property("_snojoFreeFights").to_int();
	if(fights_avail <= 0)
		print("Already fought at the snojo 10 times", "blue");
	else
	{
		for x from 1 to fights_avail
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
	int fights_avail = 3 - get_property("_brickoFights").to_int();
	if(fights_avail <= 0)
		print("Already fought 3 bricko monsters today", "blue");
	else
	{
		for x from 1 to fights_avail
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
	int fights_avail = 5 - get_property("_witchessFights").to_int();
	if(fights_avail <= 0)
		print("Already fought 5 witchess monsters today", "blue");
	else
	{
		for x from 1 to fights_avail
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

//Free Deep Machine Tunnel Fights
void free_fight_machine_tunnel()
{
	int fights_avail = 5 - get_property("_machineTunnelsAdv").to_int();
	
	if(fights_avail <= 0)
		print("Already fought 5 machine tunnel monsters today", "blue");
	else
	{
		for x from 1 to fights_avail
		{
			adv1($location[The Deep Machine Tunnels], -1, "abstractions");
			print("Fought " + get_property("_machineTunnelsAdv") + " machine tunnel fights", "blue");
		}
	}
}

//Free God Lobster Fights
void free_fight_godLobster()
{
	int fights_avail = 3 - get_property( "_godLonsterFights" ).to_int();
	if ( fights_avail <= 0 ) 
	{
		print("God Lobster already fought today", "blue");
		return;
	}

	equip($item[Mayflower bouquet]);

	for x from 1 to fights_avail 
	{
		string page = visit_url("main.php?fightgodlobster=1");
		if (!page.contains_text("fight.php")) 
		{
			print("Unexpected text on God Lobster fight page", "blue");
			break;
		}

		page = run_combat();

		if (!page.contains_text("choice.php"))
			print("Unexpected text.  Perhaps you lost the fight?", "red");

		page = visit_url("choice.php");

		// Options 1, 2, or 3 - unless you are wearing the crown, in
		// which case the "regalia" option is not available and the
		// others are 1 and 2. We'll go for "experience"
		// 
		// "I'd like part of your regalia."
		// "I'd like a blessing."
		// "I'd like some experience."
	
		run_choice(3);
    }
}

// Free Neverending Party Fights
void free_fight_neverendingparty()
{
    int fights_avail = 10 - get_property( "_neverendingPartyFreeTurns" ).to_int();
    if ( fights_avail <= 0 )
	{
		print("Already fought at NEP today", "blue");
		return;
	}
	
	while ((10 - get_property( "_neverendingPartyFreeTurns" ).to_int()) > 0) 
	{
		string page = visit_url($location[The Neverending Party].to_url());
		if ( page.contains_text("fight.php")) 
			run_combat();

		else if ( last_choice() == 1322 ) 
		{
			// The Beginning of the Neverend
			//
			// Choice 1 = accept quest
			// Choice 2 = reject quest
			// Choice 3 (?( come back later
			//
			// This script wants 10 free fights and nothing more.
			// Quests require non-free turns. Therefore, reject quest
			// This choice does not consume a turn
			run_choice( 2 );
		}
		
		else if (last_choice() == 1324) 
		{
			// It Hasn't Ended, It's Just Paused
			//
			// Choice 1 = Head upstairs
			// Choice 2 = Check out the kitchen
			// Choice 3 = Go to the back yard
			// Choice 4 = Investigate the basement
			// Choice 5 = Pick a fight.
			//
			// The first 4 are only for progressing quests

			run_choice( 5 );
			run_combat();
		}
		else					// Turtle taming or ghost dog?
			run_choice( -1 );
	}
}

void free_fight_prep()
{
	cli_execute("ccs default");
	set_auto_attack(0);
	get_ballPit_buff();
	get_telescope_buff();
	get_monorail_buff();
}

void fight_freely()
{
	free_fight_deck_penguin();
	free_fight_snojo();
	free_fight_witchess();
	//free_fight_bricko();
	free_fight_eldritch_tent();
	//free_fight_eldritch_skill();
	use_familiar($familiar[Machine Elf]);
	free_fight_machine_tunnel();
	use_familiar($familiar[God Lobster]);
	free_fight_godLobster();
	use_familiar($familiar[Fist Turkey]);
	free_fight_neverendingparty();
}

