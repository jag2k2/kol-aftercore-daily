/*Using the still*/
void use_still()
{
	int stills_avail = stills_available();
	buy(stills_avail, $item[olive]);
	create(stills_avail , $item[cocktail onion]);
}

/*Getting clovers from the hermit*/
int get_clovers()
{
	int prev_clovers = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]);
	hermit(999, $item[ten-leaf clover]);	//Make sure mafia preferences allow purchases from NPCs
	int clover_gen = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]) - prev_clovers;
	print("You acquired " + clover_gen +" clovers.", "blue");
	return clover_gen;
}

/*Visiting the Chateau Juice Bar*/
void harvest_Chateau_Juice_Bar()
{
	boolean harvested = get_property("_chateauDeskHarvested").to_boolean();
	if(harvested)
		print("Chateau Desk has already been harvested", "blue");
	else
	{
		string juice_bar_response = visit_url("place.php?whichplace=chateau&action=chateau_desk2", false);
		print("Attempted to harvest juicebar potions", "blue");
	}	
}

/*Harvest the Tea Tree*/
int harvest_tea_tree()
{
	boolean harvested = get_property("_pottedTeaTreeUsed").to_boolean();
	if(harvested)
		print("Tea Tree has already been harvested", "blue");
	else
	{
		cli_execute("teatree cuppa Royal tea");
		cli_execute("mallsell 1 cuppa Royal tea @ 99999");
		print ("Harvested tea tree", "blue");
	}
	return 0;
}

/*Harvest Gene Tonics*/
int harvest_gene_tonics()
{
	int max_potions_per_day = 3;
	int potions_made = get_property("_dnaPotionsMade").to_int();
	if (potions_made >= max_potions_per_day)
		print("DNA potions have already been harvested", "blue");
	else
	{
		for x from potions_made to (max_potions_per_day - 1)
		{
			string dnapotion_response = visit_url("campground.php?action=dnapotion", false);
			print ("Harvested DNA gene tonic", "blue");
		}
	}
	return 0;
}

/*Harvest Terminal Booze*/
int harvest_terminal_booze()
{
	int max_extrudes_per_day = 3;
	int old_gibsons = item_amount($item[hacked gibson]);
	int extrudes_harvested = get_property("_sourceTerminalExtrudes").to_int();
	if (extrudes_harvested >= max_extrudes_per_day)
		print("Terminal extrudes have already been harvested", "blue");
	else
	{
		for x from extrudes_harvested to (max_extrudes_per_day - 1)
			cli_execute("terminal extrude booze");
		int gibsons_gen = item_amount($item[hacked gibson]) - old_gibsons;
		print("Harvested " + gibsons_gen + " gibsons", "blue");
	}
	return 0;
}

int harvest_terminal_buffs()
{
	int max_enhances_per_day = 3;
	int enhances_used = get_property("_sourceTerminalEnhanceUses").to_int();
	if (enhances_used >= max_enhances_per_day)
		print("Terminal enhances have already been used", "blue");
	else
	{
		for x from enhances_used to (max_enhances_per_day - 1)
			cli_execute("terminal enhance meat");
	}
	return 0;
}

int harvest_garden()
{
	int [item] camp_stuff;
	camp_stuff = get_campground();
	
	if (camp_stuff contains $item[cornucopia])
	{
		if (camp_stuff[$item[cornucopia]] == 15)
		{
			cli_execute("garden pick");
			print("Thanksgiving garden harvested", "blue");
		}
		else
			print("Thanksgiving garden only has " + camp_stuff[$item[cornucopia]] + " cornucopias", "blue");
	}
	else if (camp_stuff contains $item[megacopia])
	{
		cli_execute("garden pick");
		print("Thanksgiving garden harvested megacopia", "blue");
	}
	else
	{
		print("Current garden not implemented by the script.", "blue");
	}
	return 0;
}

/*Harvest Rumpus Meat Tree*/
int harvest_clan_meat_tree()
{
	string tree_response = visit_url("clan_rumpus.php?action=click&spot=9&funi=3");
	if (contains_text (tree_response, "Both the tree and your efforts"))
		print("Clan meat tree already harvested today", "blue");
	return 0;
}

/*Harvest Mr. Klaw*/
int harvest_mr_klaw()
{
	int max_summons_per_day = 3;
	int summons_used = get_property("_deluxeKlawSummons").to_int();
	if (summons_used >= max_summons_per_day)
		print("Mr. Klaw already harvested today", "blue");
	else
	{
		for x from summons_used to (max_summons_per_day - 1)
		{
			string klaw_response = visit_url("clan_viplounge.php?action=klaw");
		}	
	}	
	return 0;
}

/*Harvest Floundry*/
boolean harvest_floundry()
{
	boolean success = false;
	boolean floundry_used = get_property("_floundryItemCreated").to_boolean();
	if (floundry_used)
		print("Floundry has already been harvested today", "blue");
	else
		{
			success = cli_execute("create carpe");
			if (success)
				print("Harvested Carpe from Clan Floundry", "blue");
			else
				print("Could not harvest Carpe from Clan Floundry", "blue");
		}
	return success;
}

/*Harvest Clan Looking Glass*/
int harvest_clan_mirror()
{
	boolean harvested = get_property("_lookingGlass").to_boolean();
	if(harvested)
		print("Clan Mirror has already been harvested", "blue");
	else
	{
		string mirror_response = visit_url("clan_viplounge.php?action=lookingglass&whichfloor=2");
	}
	return 0;
}

/*Harvest April Shower*/
boolean harvest_clan_shower()
{
	boolean harvested = get_property("_aprilShower").to_boolean();
	boolean success = false;
	if(harvested)
		print("Clan Shower has already been harvested", "blue");
	else
	{
		success = cli_execute("shower cold");
	}
	return success;
}

/*Harvest Clan Swimming Pool*/
boolean harvest_clan_pool()
{
	boolean harvested = get_property("_olympicSwimmingPoolItemFound").to_boolean();
	boolean success = false;
	if(harvested)
		print("Clan Pool has already been harvested", "blue");
	else
	{
		success = cli_execute("swim item");
	}
	return success;
}

/*Harvest Clan Fax Machine*/
boolean harvest_clan_fax()
{
	boolean success = false;
	if (item_amount($item[photocopied monster]) == 0)
	{
		boolean there = cli_execute("/whitelist cult of the naughty sorceress");
		success = cli_execute("fax receive");
		boolean back_again = cli_execute("/whitelist reddit united");
	}
	else
	{
		print("Already have a photocopied monster", "blue");
	}
	return success;
}

/*Harvest Dinsey Maintenance Tunnel*/
boolean harvest_dinsey_maint_tunnel()
{
	boolean harvested = get_property("_dinseyGarbageDisposed").to_boolean();
	if(harvested)
		print("Dinsey maintenance tunnel already harvested", "blue");
	else
	{
		visit_url( "place.php?whichplace=airport_stench&action=airport3_tunnels" );
		run_choice(6);
	}
	return false;
}

/*Harvest Inferno Tower*/
boolean harvest_inferno_tower()
{
	boolean harvested = get_property("_infernoDiscoVisited").to_boolean();
	if(harvested)
		print("Inferno Tower already harvested", "blue");
	else
	{
		outfit("smooth velvet");
		visit_url("place.php?whichplace=airport_hot&action=airport4_zone1");
		run_choice(7);
	}
	return false;
}

/*Harvest WLF Bunker*/
boolean harvest_wlf_bunker()
{
	boolean harvested = (get_property("_volcanoItemRedeemed").to_boolean() || get_property("_volcanoItemRedeemedAttempted").to_boolean());
	boolean turn_in(string wlf_page)
	{
		int choice_index = wlf_page.index_of("value='Turn In!'") - 34;  	//There is an exclamation mark when the "Turn In" button is enabled.  In that situation the value of the choice is 34 characters behind the substring "value='Turn In!"
		if(choice_index < 0)
			return false;
		run_choice(wlf_page.char_at(choice_index).to_int());		//This actually redeems times for a volcoino
		return true;
	}

	if(harvested)
		print("WLF Bunker already harvested", "blue");
	else
	{
		string wlf_html = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");
		if(!turn_in(wlf_html))
		{
			if(wlf_html.contains_text("New Age healing crystal"))
				retrieve_item(5, $item[New Age healing crystal]);
			else if(wlf_html.contains_text("SMOOCH bottlecap"))
				retrieve_item(1, $item[SMOOCH bottlecap]);
			else if(wlf_html.contains_text("gooey lava globs"))
				retrieve_item(5, $item[gooey lava globs]);
			else if(wlf_html.contains_text("smooth velvet bra"))
				retrieve_item(3, $item[smooth velvet bra]);
			else if(wlf_html.contains_text("SMOOCH bracers"))
				retrieve_item(3, $item[SMOOCH bracers]);
				
		wlf_html = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");  //reload the html to see if any of the buttons were enabled and with an "!"
		turn_in(wlf_html);
		set_property("_volcanoItemRedeemedAttempted", "true");
		}
	}
	return false;
}

/*Harvest Velvet / Gold Mine*/
int harvest_velvet_gold_mine(int mine_target, boolean ignore_free_mine_limit)
{
	//Each mine is a grid of 7 rows and 8 columns with each cell being labeled from 0 to 55.  The rock walls on the side and back are not mineable.
	//This script mines sparkly wall chunks on the bottom two rows, so cells with ids [41 to 46] and [49 to 54].
	//https://www.reddit.com/r/kol/comments/76atwk/someone_explain_volcano_farming_to_me/?st=jhea9mtq&sh=f8c01c8d

	int mine_count=0;
	int cell_id = -1;
	int max_free_mines = 5;
	//set_property("_volcanoMiningActionsUsed", "0");

	void incFreeMineProperty()
	{
		if(!property_exists("_volcanoMiningActionsUsed"))
			set_property("_volcanoMiningActionsUsed", 0);
		int free_mine = get_property("_volcanoMiningActionsUsed").to_int() + 1;
		set_property("_volcanoMiningActionsUsed", free_mine);
	}

	int findNewCavern()
	//This function looks for the "Find New Cavern" button.  If it cannot find the button then it will mine an arbitrary cell (52) to enable it.
	//This function returns 0 if the cavern was successfully reset and 1 if it could not find the button and mined a rock wall instead.
	{
		int times_mined = 0;
		string cave_html=visit_url("mining.php?mine=6");
		matcher new_cavern_match = create_matcher("Find New Cavern", cave_html); 	
		
		if (new_cavern_match.find())
		{
			print("restart!","red");
			visit_url("mining.php?reset=1&mine=6&pwd="+my_hash());			//Reset the Mine
		}
		else
		{
			//print("Can't find reset button.  Mining cell 52", "blue");	
			visit_url("mining.php?mine=6&which=52&pwd="+my_hash());       	//mine cell 52     
			times_mined = 1;
			incFreeMineProperty();
		}
		return times_mined;
	}

	outfit("volcano mining");
	if(elemental_resistance($element[hot])<83.0)
		print("Not enough hot resistance to mine the volcano", "blue");
	else if ((get_property("_volcanoMiningActionsUsed").to_int() >= max_free_mines) && (ignore_free_mine_limit == false))
		print("Free mines have already been used today", "blue");
	else
	{
		while(mine_count < mine_target)
		{
			cell_id = -1;
			string mine_html = visit_url("mining.php?mine=6");
			matcher promising_match = create_matcher("mine=6&which=(\\d+)&pwd=[^<]*<[^<]*wallsparkle", mine_html);
			
			while(promising_match.find())							//Finds last instance of a rock chunk with the wallsparkle.gif pattern
			{
				cell_id = promising_match.group(1).to_int();		//Round brackes "( )" indicate a group within the pattern.  In this case the pattern is extracting the cell id.	
			}
			
			if((cell_id > 40) && !(get_property("mineLayout6").contains_text("gold")))		//If promising rock chunk is above the bottom two rows or if gold has already been discovered then reset.  Otherwise mine it!
			{
				//print("Mining cell at " + cell_id, "blue");
				if (my_hp() < 100)
					use_skill(1, $skill[cannelloni cocoon]);		//Make sure you have enough health to survive a cave-in
				visit_url("mining.php?mine=6&which="+cell_id+"&pwd="+my_hash());
				mine_count+=1;
				incFreeMineProperty();
			}
			else
			{
				mine_count = mine_count + findNewCavern();
			}
			print("Mine count is " + mine_count + ". Number of times mined at volcano so far is " + (get_property("_volcanoMiningActionsUsed").to_string()), "blue");
		}
	}
	return 0;
}

/*Operate Control Panel*/
/*
questESpClipper=unstarted
questESpEVE=unstarted
questESpFakeMedium=unstarted
questESpGore=started
questESpJunglePun=unstarted
questESpOutOfOrder=unstarted
questESpSerum=unstarted
questESpSmokes=unstarted
*/

int operate_control_panel()
{
	if(get_property("_controlPanelUsed").to_boolean())
		print("Control Panel already used today", "blue");
	else
	{
		int i = 9;
		boolean enabled = true;
		while(i > 0 && enabled)
		{
			enabled = get_property("controlPanel" + i.to_string()).to_boolean();
			if(enabled)
				i--;		
		}
		print("Button " + i + " is not activated", "blue");
		visit_url("place.php?whichplace=airport_spooky_bunker&action=si_controlpanel"); 	// Enters choice adventure 986
		if(i==0)
			i++;																			// If all buttons are pushed then it doesn't matter which button we push next																
		run_choice(i);																		// Press button "i"
		if(get_property("controlPanelOmega").to_int()>99)
		{
			print("All buttons are activated.  Attempting to activate omega device", "blue");
			run_choice(10);																	// Activate omega device
		}
	}
	return 0;
}

/*Visiting the hippy store*/
int visit_hippy_store()
{
	if(get_property("_hippyMeatCollected").to_boolean())
		print ("Hippy shop already visited", "blue");
	else
	{
		string hippy_response = visit_url("shop.php?whichshop=hippy");
		if (contains_text (hippy_response, "Here's your cut"))
			print ("Meat collected", "blue");	
	}
	return 0;	
}

/*Checking the plumber arcade*/
boolean check_plumber_arcade()
{

	if(get_property("_defectiveTokenChecked").to_boolean())
		print("Already checked the plumber today", "blue");
	else 
	{
		string plumber_html = visit_url("place.php?whichplace=arcade&action=arcade_plumber", false);
		if(contains_text(plumber_html, "No such luck, though."))
			print("Arcade check.  No defective token today.", "blue");
		else
			print("Arcade check.  Maybe you got something?!?", "blue");
	}
	return false;
}

/*Visiting the 11th precinct headquarters*/
int visit_precinct_headquarters()
{
	int copdollar_old = item_amount($item[cop dollar]);	
	string headq_html = visit_url("place.php?whichplace=town_wrong&action=townwrong_precinct");
	int copdollar_gen = item_amount($item[cop dollar]) - copdollar_old;
	print("Harvested " + copdollar_gen + " cop dollars", "blue");
	return copdollar_gen;
}

/*Harvest Sea Jelly*/
boolean harvest_sea_jelly()
{
	if(get_property("_seaJellyHarvested").to_boolean())
		print("Sea Jelly already harvested", "blue");
	else
	{
		use_familiar($familiar[space jellyfish]);
		int seajelly_old = item_amount($item[sea jelly]);
		visit_url("place.php?whichplace=thesea&action=thesea_left2");
		run_choice(1);
		int seajelly_gen = item_amount($item[sea jelly]) - seajelly_old;
		print("Harvested " + seajelly_gen + " sea jelly", "blue");
	}
	return false;
}

/*Grab the Dark Horse*/
boolean get_dark_horse()
{
	if(get_property("_horsery") == "dark horse")
		print("Dark Horse already taken from the horsery", "blue");
	else
	{
		cli_execute("horsery meat");
	}
	return false;
}