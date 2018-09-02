import DailyMpRestore.ash
/*Daily Uses and Daily Casts*/

/*Auto places designated item into the mall if specified price is greater than 0*/

void auto_mallsell(item item_to_sell, int item_amount, int item_price)
{
	if(item_price > 0)
		cli_execute("mallsell " + item_amount + " " + item_to_sell + " @ " + item_price);
}

/*Cast Advanced Saucecrafting*/

int generate_reagents()
{
	int old_reagent_count = item_amount($item[scrumptious reagent]);
	
	use_skill($skill[Advanced Saucecrafting]);
	
	int reagent_gen = item_amount($item[scrumptious reagent]) - old_reagent_count;
	print("Generated " + reagent_gen + " reagents", "blue");
	return reagent_gen;
}

/*Cast Pastamastery*/
int generate_noodles()
{
	int old_noodle_count = item_amount($item[dry noodles]);
	
	use_skill($skill[Pastamastery]);
	
	int noodle_gen = item_amount($item[dry noodles]) -  old_noodle_count;
	print("Generated " + noodle_gen + " noodles", "blue");
	return noodle_gen;
}

/*Cast Superhuman Cocktailcrafting*/
int generate_cocktail_ingredients()
{
	int old_shell_count = item_amount($item[coconut shell]);
	int old_umbrella_count = item_amount($item[little paper umbrella]);
	int old_cube_count = item_amount($item[magical ice cubes]);
	
	use_skill($skill[Advanced Cocktailcrafting]);
	
	int shell_gen = item_amount($item[coconut shell]) - old_shell_count;
	int umbrella_gen = item_amount($item[little paper umbrella]) - old_umbrella_count;
	int cube_gen = item_amount($item[magical ice cubes]) - old_cube_count;
	
	print("Generated " + shell_gen + " shells, " + umbrella_gen + " umbrellas, and " + cube_gen + " cubes", "blue");
	return shell_gen + umbrella_gen + cube_gen;
}

/*Summon 3 Sugar Sheets*/
int generate_sugar_sheets()
{
	int max_summons_per_day = 3;
	int summons_used = get_property("_sugarSummons").to_int();
	if (summons_used >= max_summons_per_day)
		print("Sugar summons already used", "blue");
	else
	{
		int to_summon = max_summons_per_day - summons_used;
		int sheets_old = item_amount($item[Sugar Sheet]);
		use_skill(to_summon, $skill[Summon Sugar Sheets]);
		int sheets_gen = item_amount($item[Sugar Sheet]) - sheets_old;
		print("Generated " + sheets_gen + " sugar sheets", "blue");
	}
	return 0;
}

/*Summon 3 smithsness*/
int generate_smithsness()
{
	int max_summons_per_day = 3;
	int summons_used = get_property("_smithsnessSummons").to_int();
	if (summons_used >= max_summons_per_day)
		print("Smithsness summons already used", "blue");
	else
	{
		int to_summon = max_summons_per_day - summons_used;
		int flasks_old = item_amount($item[Flaskfull of Hollow]);
		int lumps_old = item_amount($item[lump of Brituminous coal]);
		int smithereeens_old = item_amount($item[handful of Smithereens]);
		use_skill(to_summon, $skill[Summon Smithsness]);
		int flasks_gen = item_amount($item[Flaskfull of Hollow]) - flasks_old;
		int lumps_gen = item_amount($item[lump of Brituminous coal]) - lumps_old;
		int smithereens_gen = item_amount($item[handful of Smithereens]) - smithereeens_old;
		print("Generated " + flasks_gen + " flasks, " + lumps_gen + " coals, and " + smithereens_gen + " smithereens", "blue");
	}
	return 0;
}

/*Summon 3 Clip Arts*/
int generate_clip_art(string clip_string)
{
	int max_summons_per_day = 3;
	int summons_used = get_property("_clipartSummons").to_int();
	if (summons_used >= max_summons_per_day)
		print("Clip Art summons already used", "blue");
	else
	{
		int to_summon = max_summons_per_day - summons_used;
		item clip_item = to_item(clip_string);
		int clip_item_old = item_amount(clip_item);
		for x from 1 to to_summon
			cli_execute("create " + clip_string);
		int clip_item_gen = item_amount(clip_item) - clip_item_old;
		print("Generated " + clip_item_gen + " " + clip_item, "blue");
		//auto_mallsell(clip_item, clip_item_gen, sale_price);
	}
	return 0;
}

/*Cast Perfect Freeze*/
int generate_perfect_ice_cubes()
{
	int cubes_gen = 0;
	if(get_property("_perfectFreezeUsed").to_boolean())
		print("Perfect Freeze already used today", "blue");
	else
	{
		int old_cubes = item_amount($item[perfect ice cube]);
		use_skill($skill[Perfect Freeze]);
		cubes_gen = item_amount($item[perfect ice cube]) - old_cubes;
		print("Generated " + cubes_gen + " perfect ice cube", "blue");
	}
	return cubes_gen;
}

/*Summon Alice's Army Cards*/
int generate_army_cards()
{
	int old_packs = item_amount($item[Pack of Alice's Army Cards]);
	int old_vouchers = item_amount($item[Ye Wizard's Shack snack voucher]);
	
	use_skill($skill[Summon Alice's Army Cards]);
	
	int packs_gen = item_amount($item[Pack of Alice's Army Cards]) - old_packs;
	int vouchers_gen = item_amount($item[Ye Wizard's Shack snack voucher]) - old_vouchers;
	
	print("Generated " + packs_gen + " packs, and " + vouchers_gen + " vouchers", "blue");
	return packs_gen + vouchers_gen;
}

/*Summon Confiscated Things*/
int generate_confiscated_things()
{
	use_skill($skill[Summon Confiscated Things]);
	print("Generated unknown confiscated things", "blue");
	return 0;
}

/*Cast Rainbow Gravitation*/
int generate_prismatic_wads()
{
	int init_wads_twinkly = item_amount($item[twinkly wad]);
	int init_wads_hot = item_amount($item[hot wad]);
	int init_wads_cold = item_amount($item[cold wad]);
	int init_wads_stench = item_amount($item[stench wad]);
	int init_wads_spooky = item_amount($item[spooky wad]);
	int init_wads_sleaze = item_amount($item[sleaze wad]);
	int old_prismatic_wads = item_amount($item[prismatic wad]);
	
	if((init_wads_twinkly < 3)&&(init_wads_hot < 3)&&(init_wads_cold < 3)&&(init_wads_stench < 3)&&(init_wads_spooky < 3)&&(init_wads_sleaze < 3))
	{
		print("Not enough elemental wads to cast Rainbow Gravitation", "blue");
	}
	else
	{
		use_skill(3, $skill[Rainbow Gravitation]);
	}
	
	int prismatic_wads_gen = item_amount($item[prismatic wad]) - old_prismatic_wads;
	print("Generated " + prismatic_wads_gen + " prismatic wads", "blue"); 
	print(item_amount($item[twinkly wad]) + " twinkly wads", "blue");
	print(item_amount($item[hot wad]) + " hot wads", "red");
	print(item_amount($item[cold wad]) + " cold wads", "blue");
	print(item_amount($item[stench wad]) + " stench wads", "green");
	print(item_amount($item[spooky wad]) + " spooky wads", "gray");
	print(item_amount($item[sleaze wad]) + " sleaze wads", "purple");
	return 0;
}

/*Cast Grab a Cold One*/
int generate_cold_one()
{
	int cold_one_gen = 0;
	if(get_property("_coldOne").to_boolean())
		print("Grab a Cold One already cast today", "blue");
	else
	{
			int cold_one_old = item_amount($item[Cold One]);
			use_skill($skill[Grab a Cold One]);
			cold_one_gen = item_amount($item[Cold One]) - cold_one_old;
			print("Generated " + cold_one_gen + " Cold One", "blue");
	}
	return cold_one_gen;
}

/*Cast Spaghetti Breakfast*/
int generate_spaghetti_breakfast()
{
	int spaghetti_breakfast_gen = 0;
	if(get_property("_spaghettiBreakfast").to_boolean())
		print("Spaghetti Breakfast already cast today", "blue");
	else
	{
		int spaghetti_breakfast_old = item_amount($item[Spaghetti Breakfast]);
		use_skill($skill[Spaghetti Breakfast]);
		spaghetti_breakfast_gen = item_amount($item[Spaghetti Breakfast]) - spaghetti_breakfast_old;
		print("Generated " + spaghetti_breakfast_gen + " Spaghetti Breakfast", "blue");
	}
	return spaghetti_breakfast_gen;
}

/*Cast Summon Crimbo Candy*/
int generate_crimbo_candy()
{
	int crimbo_fudge_gen = 0;
	int crimbo_bark_gen = 0;
	int crimbo_pecan_gen = 0;
	
	if(get_property("_candySummons").to_int() > 0)
		print("Summon Crimbo candy already cast today", "blue");
	else
	{
		int crimbo_fudge_old = item_amount($item[Crimbo Fudge]);
		int crimbo_bark_old = item_amount($item[Crimbo Peppermint Bark]);
		int crimbo_pecan_old = item_amount($item[Crimbo Candied Pecan]);
		
		use_skill($skill[Summon Crimbo Candy]);
	
		crimbo_fudge_gen = item_amount($item[Crimbo Fudge]) - crimbo_fudge_old;
		crimbo_bark_gen = item_amount($item[Crimbo Peppermint Bark]) - crimbo_bark_old;
		crimbo_pecan_gen = item_amount($item[Crimbo Candied Pecan]) - crimbo_pecan_old;
		print("Generated " + crimbo_fudge_gen + " fudges, " + crimbo_bark_gen + " peppermint barks, " + crimbo_pecan_gen + " pecans", "blue");
	}
	return crimbo_fudge_gen + crimbo_bark_gen + crimbo_pecan_gen;
}

/*Use Picky Tweezers*/
int generate_single_atom()
{
	int atoms_gen = 0;
	if(get_property("_pickyTweezersUsed").to_boolean())
		print("Picky Tweezers alreday used today", "blue");
	else
	{
		int old_atoms = item_amount($item[Single Atom]);
		use(1, $item[Picky Tweezers]);
		int atoms_gen = item_amount($item[Single Atom]) - old_atoms;
		print ("Generated " + atoms_gen + " Single Atom", "blue");
	}
	return atoms_gen;
}

/*Use Chroner Cross*/
int generate_chroners()
{
	int chroner_gen = 0;
	if(get_property("_chronerCrossUsed").to_boolean())
		print("Chroner Cross already used", "blue");
	else
	{
		int old_chroners = item_amount($item[Chroner]);
		use(1, $item[Chroner Cross]);
		chroner_gen = item_amount($item[Chroner]) - old_chroners;
		print ("Generated " + chroner_gen + " Chroners", "blue");
	}
	return chroner_gen;
}

/*Use Chester's Bag of Candy*/
int generate_chester_candy()
{
	int farmers_gen = 0;
	int skulls_gen = 0;
	int rice_candies_gen = 0;
	int yummy_beans_gen = 0;
	
	if(get_property("_bagOfCandyUsed").to_boolean())
		print("Chester's bag of candy already used today", "blue");
	else
	{
		int farmers_old = item_amount($item[Angry Farmer candy]);
		int skulls_old = item_amount($item[marzipan skull]);
		int rice_candies_old = item_amount($item[Tasty Fun Good rice candy]);
		int yummy_beans_old = item_amount($item[Yummy Tummy bean]);
	
		use(1, $item[Chester's Bag of Candy]);
	
		farmers_gen = item_amount($item[Angry Farmer candy]) - farmers_old;
		skulls_gen = item_amount($item[marzipan skull]) - skulls_old;
		rice_candies_gen = item_amount($item[Tasty Fun Good rice candy]) - rice_candies_old;
		yummy_beans_gen = item_amount($item[Yummy Tummy bean]) - yummy_beans_old;
	
		print("Generated " + farmers_gen + " Farmer candies, " + skulls_gen + " marzipan skulls, " + rice_candies_gen + " rice candies, " + yummy_beans_gen + " Yummy Tummy beans", "blue");
	}
	return farmers_gen + skulls_gen + rice_candies_gen + yummy_beans_gen;
}
/*Cheat using Deck of Every Card*/
int cheat_deck_every_card(string card_name)
{
	if (get_property("_deckCardsSeen").contains_text(card_name))
		print("Deck of Every Card has already cheated " + card_name + " today", "blue");
	else if (get_property("_deckCardsDrawn").to_int() >= 15)
		print("Deck of Every Card has been used 15 times already today", "blue");
	else
	{
		cli_execute("cheat " + card_name);
	}
	return 0;
}


/*Use infinite BACON machine*/
int generate_bacon()
{
	int bacon_gen = 0;
	if(get_property("_baconMachineUsed").to_boolean())
		print("Infinite Bacon Machine already used today", "blue");
	else
	{
		int bacon_old = item_amount($item[bacon]);
		use(1, $item[infinite BACON machine]);
		int bacon_gen = item_amount($item[bacon]) - bacon_old;
		print ("Generated " + bacon_gen + " bacon", "blue");
	}
	return bacon_gen;
}

/*Use Time-Spinner*/
int generate_kardashians()
{
	int kardashian_gen = 0;
	item kardashian_shot = $item[shot of kardashian gin];
	if(get_property("_timeSpinnerReplicatorUsed").to_boolean())
		print("Time-spinner replicator already used today", "blue");
	else if(get_property("_timeSpinnerMinutesUsed").to_int() > 8)
		print("Time-spinner doesn't have enough minutes remaining to run the replicator", "blue");
	else
	{
		int kardashian_old = item_amount(kardashian_shot);
		visit_url("inv_use.php?pwd=&whichitem=9104");									// The "use" command causes manual control to be requested.  use the "visit_url" instead
		
		visit_url("choice.php?whichchoice=1195&option=4&pwd");							// Visit the far future
		string quarters_page = visit_url("choice.php?whichchoice=1199&option=1&pwd");	// Don't think this choice matters.  Chose any ship name
		
																						// ..e=option value=3><input class=button type=submit value="Use the Replicator"></f..		
		int choice_index = quarters_page.index_of("value=\"Use the Replicator\"")-35;  	// Look for the choice to use the replicator.  The value of the choice is 34(or 35 for some reason) characters behind the substring "value='Use the Replicator'
		run_choice(quarters_page.char_at(choice_index).to_int());						// This visits the replicator
		
		quarters_page = visit_url("choice.php?whichchoice=1199&option=2&pwd");			// Replicate a Shot of kardashian gin

		choice_index = quarters_page.index_of("value=\"Go to sleep\"")-35;				// Look for choice to go to sleep
		run_choice(quarters_page.char_at(choice_index).to_int());						// This choice goes to sleep

		visit_url("choice.php?whichchoice=1199&option=2&pwd");							// Confirm choice
		
		kardashian_gen = item_amount(kardashian_shot) - kardashian_old;
		print("Generated " + kardashian_gen + " kardashians", "blue");
		//auto_mallsell(kardashian_shot, kardashian_gen, sale_price);
	}
	return kardashian_gen;
}
	
/*Use Corked Genie Bottle*/
int generate_pocket_wishes()
{
	item pocket_wish = $item[pocket wish];
	int wishes_used = get_property("_genieWishesUsed").to_int();
	int wishes_old = item_amount(pocket_wish);
	if(wishes_used >= 3)
		print("Genie has no more wishes for the day", "blue");
	else
	{
		for x from wishes_used to 2
		{
			cli_execute("genie wish for more wishes");
		}
	int wishes_gen = item_amount(pocket_wish) - wishes_old;
	print("Generated " + wishes_gen + " pocket wishes", "blue");
	//auto_mallsell(pocket_wish, wishes_gen, 49999);
	}
	return 0;
}
/* Generate BRICKO Eye Bricks */
void generate_brickoEyeBricks()
{
	int brickoEye_old = item_amount($item[BRICKO eye brick]);
	int brickoEye_gen = 0;
	int max_casts = 15;
	int casts = 0;
	if(property_exists("_BrickoEyeBricksGenerated"))
		print("Bricko eye bricks have already been generated", "blue");
	else
	{	
		while(brickoEye_gen < 3 && get_property("libramSummons") < max_casts)
		{
			if(my_mp() < mp_cost($skill[Summon BRICKOs]))
				minor_mp_restore();
			else
			{
				use_skill(1, $skill[Summon BRICKOs]);
				casts++;
			}
			brickoEye_gen = item_amount($item[BRICKO eye brick]) - brickoEye_old;
		}
		set_property("_BrickoEyeBricksGenerated", "true");
		print("Generated " + brickoEye_gen + " Bricko eye bricks with " + casts + " casts.  Total libram summons: " + get_property("libramSummons"), "blue");
	}
}

/* Cast Max Resolutions */
int generate_resolutions(int mp_pct)
{
	int already_cast = get_property("libramSummons").to_int();
	int mp_to_use = (my_mp()* mp_pct / 100).to_int();
	
	int n = already_cast;
	int mp_total_cost = 0;
	while(mp_total_cost < mp_to_use)
	{
		n++;
		mp_total_cost = mp_total_cost + 1+(n*(n-1)/2);
	}
	
	n--;
	int to_cast = n - already_cast;
	
	to_cast = max(0,to_cast);

	print("Have cast libram " + already_cast + " times. Can cast " + to_cast + " more times.", "blue");
	
	use_skill(to_cast, $skill[Summon Resolutions]);

	return 0;
}

/*Cast farm buffs on player*/
int meat_farm_cast_buffs(int target)
{
	record skill_deets{
		skill name;
		int casts;
		string prop;
	};
	
	skill_deets [int]farm_buff;

	farm_buff[1].name = $skill[Chorale of Companionship];
	farm_buff[1].casts = 10;
	farm_buff[1].prop = "_companionshipCasts";
	farm_buff[2].name = $skill[The Ballad of Richie Thingfinder];
	farm_buff[2].casts = 10;
	farm_buff[2].prop = "_thingfinderCasts";
	farm_buff[3].name = $skill[The Polka of Plenty];
	farm_buff[3].casts = target/turns_per_cast($skill[The Polka of Plenty]);
	farm_buff[3].prop = "_polkaCasts";
	farm_buff[4].name = $skill[Empathy of the Newt];
	farm_buff[4].casts = target/turns_per_cast($skill[Empathy of the Newt]);
	farm_buff[4].prop = "_empathyCasts";
	
	foreach key in farm_buff
	{
		if(!property_exists(farm_buff[key].prop))
			set_property(farm_buff[key].prop, "0");
		
		int current_casts = get_property(farm_buff[key].prop).to_int();
		if(!have_skill(farm_buff[key].name))
			print("You do not have the skill " + farm_buff[key].name, "blue");
		else if(current_casts >= farm_buff[key].casts)
			print(farm_buff[key].name + " has already been casted " + current_casts + " times", "blue");
		else
		{
			while(current_casts < farm_buff[key].casts)
			{
				print("Start: " + farm_buff[key].name + " casted " + get_property(farm_buff[key].prop).to_int() + " of " + farm_buff[key].casts, "blue");		
				
				int to_cast = farm_buff[key].casts - current_casts;
				int casts_afford = my_mp()/mp_cost(farm_buff[key].name);
				
				if(to_cast <= 0)
					print(farm_buff[key].name + " has been casted " + farm_buff[key].casts + " times", "blue");
				else
				{
					boolean mp_restore = false;
					if(casts_afford < to_cast)
					{
						to_cast = casts_afford;
						mp_restore = true;
					}
					use_skill(to_cast, farm_buff[key].name, "jag2k2");
					current_casts = current_casts + to_cast;
					if(mp_restore)
						minor_mp_restore();
				}
			}
		}
		set_property(farm_buff[key].prop, current_casts.to_string());
	}
	return 0;
}
/* Get the Amulet Coin */
void generate_amulet_coin()
{
	if(item_amount($item[amulet coin]) > 0)
		print("Already generated amulet coin today", "blue");
	else
	{
		use_familiar($familiar[Cornbeefadon]);
		retrieve_item(1, $item[Box of Familiar Jacks]);
		use(1, $item[Box of Familiar Jacks]);
	}
}

/* Get KGB Briefcase buff */
void kbg_briefcase_buff()
{
	if(get_property("_kgbClicksUsed").to_int() >= 24)
		print("Already received kgb buffs for the day", "blue");
	else
		for x from 1 to 8
			cli_execute("briefcase buff meat");
}

/*Use license to chill*/
void use_license()
{
	if(get_property("_licenseToChillUsed").to_boolean())
		print("License to Chill already used today", "blue");
	else
	{
		int delights_old = item_amount($item[afternoon delight]);
		use(1, $item[license to chill]);
		int delights_gen = item_amount($item[afternoon delight]) - delights_old;
		print ("Generated " + delights_gen + " afternoon delights", "blue");
	}
}

/* Use Express Card */
void use_express_card()
{
	if(get_property("expressCardUsed").to_boolean())
		print("Express Card already used today", "blue");
	else
		use(1, $item[Platinum Yendorian Express Card]);
}

/* Have a ChibiChat */
void use_ChibiChat()
{
	void activate_chibi()
	{
		string chibi_html = visit_url("inv_use.php?pwd&whichitem=5925");				// Try to use ChibiBuddy(Off)
		if(contains_text(chibi_html, "ChibiBuddy"))										// If html contain text "ChibiBuddy" then chibi was off (item exists) and it needs to be activated
		{
			int activate_index = chibi_html.index_of("value=\"turn on the ChibiBuddy")-100;
			if(activate_index > 0)
				run_choice(chibi_html.char_at(activate_index).to_int());
			else
				print("ChibiBuddy needs to be activated but can't find the activate choice", "blue");
		}
	}

	boolean attempt_ChibiChat()
	{
		string chibi_html = visit_url("inv_use.php?pwd&whichitem=5908");				// Try to use ChibiBuddy(On)
		if(contains_text(chibi_html, "ChibiBuddy"))										// If html contains text "ChibiBuddy" then chibi was on (item exists) and we can attempt a chibichat
		{
			int activate_index = chibi_html.index_of("value=\"turn on the ChibiBuddy")-100;
			int chat_index = chibi_html.index_of("value=\"Have a ChibiChat")-35;		// Find index of chibichat choice
			int leave_index = chibi_html.index_of("value=\"Put your ChibiBuddy")-35;	// Find index of chibichat 
			if(chat_index > 0)
			{
				print("Found and running ChibiChat choice", "blue");
				run_choice(chibi_html.char_at(chat_index).to_int());
				return true;
			}
			else if(activate_index > 0)
			{
				print("Found and activating Chibibuddy while it was already on?!?", "blue");
				if(activate_index > 0)
				run_choice(chibi_html.char_at(activate_index).to_int());
			}		
			else
			{
				print("Could not find chat choice.  Attempting to run leave choice", "blue");
				run_choice(chibi_html.char_at(leave_index).to_int());
				return false;
			}
		}
		return false;
	}
	
	if(property_exists("_chibiChatted"))
		print("Already chatted with your ChibiBuddy today", "blue");
	else
	{
		for x from 1 to 2
		{
			activate_chibi();															// Activate chibi if necessary
			if(attempt_ChibiChat())
			{
				set_property("_chibiChatted", "true");
				return;
			}
		}
		print("Unable to run ChibiChat", "blue");
	}
}

/* Get and use daily Blue Mana */

void cast_ancestralRecalls()
{
	if(get_property("_ancestralRecallCasts").to_int() >= 10)
		print("10 Ancestral Recalls already performed today", "blue");
	else
	{
		int max_price = 13500;
		int to_cast = 10 - get_property("_ancestralRecallCasts").to_int();
		int to_buy = to_cast - item_amount($item[blue mana]);
		if(to_buy > 0)
			for x from 1 to to_buy
				cli_execute("mallbuy blue mana @ " + max_price);
		if(to_cast > 0)
			use_skill(to_cast, $skill[ancestral recall]);
	}
}

/* Get and use class-specific chocolates */

void use_classChocolates()
{
	if(property_exists("_classChocolatesUsed"))
		print("Class chocolates already used today", "blue");
	else
	{
		int max_price = 8000;
		int to_use = 2;
		item class_choc = $item[none];
		switch (my_class())
		{
			case $class[seal clubber]:
				class_choc = $item[chocolate seal-clubbing club];
				break;
			case $class[turtle tamer]:
				class_choc = $item[chocolate turtle totem];
				break;
			case $class[Pastamancer]:
				class_choc = $item[chocolate pasta spoon];
				break;
			case $class[Sauceror]:
				class_choc = $item[chocolate saucepan];
				break;
			case $class[Disco Bandit]:
				class_choc = $item[chocolate disco ball];
				break;
			case $class[Accordion Thief]:
				class_choc = $item[chocolate stolen accordion];
				break;
			default:
				break;
		}
		int to_buy = to_use - item_amount(class_choc);
		if(to_buy > 0)
			for x from 1 to to_buy
				cli_execute("mallbuy " + class_choc + " @ " + max_price);
		use(to_use, class_choc);
		set_property("_classChocolatesUsed", "true");
	}
}

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
void harvest_tea_tree()
{
	item royal_tea = $item[cuppa Royal tea];
	boolean harvested = get_property("_pottedTeaTreeUsed").to_boolean();
	if(harvested)
		print("Tea Tree has already been harvested", "blue");
	else
	{
		cli_execute("teatree cuppa Royal tea");
		print ("Harvested tea tree", "blue");
		//auto_mallsell(royal_tea, 1, sale_price);
	}
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
	item hacked_gibson = $item[hacked gibson];
	int max_extrudes_per_day = 3;
	int old_gibsons = item_amount(hacked_gibson);
	int extrudes_harvested = get_property("_sourceTerminalExtrudes").to_int();
	if (extrudes_harvested >= max_extrudes_per_day)
		print("Terminal extrudes have already been harvested", "blue");
	else
	{
		for x from extrudes_harvested to (max_extrudes_per_day - 1)
			cli_execute("terminal extrude booze");
		int gibsons_gen = item_amount(hacked_gibson) - old_gibsons;
		print("Harvested " + gibsons_gen + " gibsons", "blue");
		//auto_mallsell(hacked_gibson, gibsons_gen, sale_price);
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

/* Harvest Clan Fax Machine */
void harvest_clan_fax()
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
}

/* Soak in VIP hottub */
void soak_hottub()
{
	if(get_property("_hotTubSoaks").to_int() >= 5)
		print("Already soaked in hottub 5 times today", "blue");
	else
		cli_execute("hottub");
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
	boolean harvested = (get_property("_volcanoItemRedeemed").to_boolean());
	
	record proof_deets{
			int to_redeem;
			item sub_item;													// Some proofs need to be made from sub items.  If that is not the case then this should be populated with the proof item itself
			int sub_per;													
	};
	
	proof_deets [item] wlf_proof;

	wlf_proof[$item[New Age healing crystal]].to_redeem = 5;
	wlf_proof[$item[New Age healing crystal]].sub_item = $item[New Age healing crystal];
	wlf_proof[$item[New Age healing crystal]].sub_per = 1;
	
	wlf_proof[$item[SMOOCH bottlecap]].to_redeem = 1;
	wlf_proof[$item[SMOOCH bottlecap]].sub_item = $item[SMOOCH bottlecap];
	wlf_proof[$item[SMOOCH bottlecap]].sub_per = 1;
	
	wlf_proof[$item[gooey lava globs]].to_redeem = 5;
	wlf_proof[$item[gooey lava globs]].sub_item = $item[gooey lava globs];
	wlf_proof[$item[gooey lava globs]].sub_per = 1;
	
	wlf_proof[$item[smooth velvet bra]].to_redeem = 3;
	wlf_proof[$item[smooth velvet bra]].sub_item = $item[unsmoothed velvet];
	wlf_proof[$item[smooth velvet bra]].sub_per = 3;
	
	wlf_proof[$item[SMOOCH bracers]].to_redeem = 3;
	wlf_proof[$item[SMOOCH bracers]].sub_item = $item[superheated metal];
	wlf_proof[$item[SMOOCH bracers]].sub_per = 5;
	
	boolean turn_in(string wlf_page)
	{
		int choice_index = wlf_page.index_of("value='Turn In!'") - 34;  	//There is an exclamation mark when the "Turn In" button is enabled.  In that situation the value of the choice is 34 characters behind the substring "value='Turn In!"
		if(choice_index < 0)
			return false;
		run_choice(wlf_page.char_at(choice_index).to_int());				//This actually redeems times for a volcoino
		return true;
	}

	if(harvested)
		print("WLF Bunker already harvested", "blue");
	else
	{
		int volcoino_worth = (mall_price($item[one-day ticket to That 70s Volcano])*0.8/3).to_int();	// Take % of the current ticket price and divide by 3	
		string wlf_html = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");
		
		if(!turn_in(wlf_html))
		{
			print("Turn In! button is not active.  Let's see if we can purchase any of the items from the mall", "blue");
			foreach key in wlf_proof
				if(wlf_html.contains_text(key))
				{
					print("WLF Proof is " + key + " and is based on " + wlf_proof[key].sub_item, "blue");
					
					int subs_needed = wlf_proof[key].to_redeem * wlf_proof[key].sub_per;
					int subs_toBuy = subs_needed - item_amount(wlf_proof[key].sub_item);
					int sub_priceLimit = volcoino_worth / subs_needed;
					
					if(mall_price(wlf_proof[key].sub_item) > sub_priceLimit)
						print("WLF Proof is not worth buying", "blue");
					else
					{
						print("Need to buy " + subs_toBuy + " " + wlf_proof[key].sub_item + " for less than " + sub_priceLimit, "blue");
						for x from 1 upto subs_toBuy
							cli_execute("mallbuy " + wlf_proof[key].sub_item + " @ " + sub_priceLimit);
						
						if(item_amount(wlf_proof[key].sub_item) >= subs_needed)
							retrieve_item(wlf_proof[key].to_redeem, key);
					}
					
					break;
				}
			
			wlf_html = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");  //reload the html to see if any of the buttons were enabled and with an "!"
			turn_in(wlf_html);
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
			print("Can't find reset button.  Mining cell 52", "blue");	
			visit_url("mining.php?mine=6&which=52&pwd="+my_hash());       	//mine cell 52     
			times_mined = 1;
			incFreeMineProperty();
		}
		return times_mined;
	}


	//if(elemental_resistance($element[hot])<83.0)
	//	print("Not enough hot resistance to mine the volcano", "blue");

	if ((get_property("_volcanoMiningActionsUsed").to_int() >= max_free_mines) && (ignore_free_mine_limit == false))
		print("Free mines have already been used today", "blue");
	else
	{
		outfit("volcano mining");
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
	if(!property_exists("_precinctHqVisited"))
		set_property("_precinctHqVisited", "false");

	if(get_property("_precinctHqVisited").to_boolean())
		print("11th precinct headquarters already visited today", "blue");
	else
	{
		int copdollar_old = item_amount($item[cop dollar]);	
		visit_url("place.php?whichplace=town_wrong&action=townwrong_precinct");
		set_property("_precinctHqVisited", "true");
		int copdollar_gen = item_amount($item[cop dollar]) - copdollar_old;
		print("Harvested " + copdollar_gen + " cop dollars", "blue");	
	}
	return 0;
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

/* Jump into An Awesome Ball Pit */
void get_ballPit_buff()
{
	if(get_property("_ballpit").to_boolean())
		print("Already jumped in the ball pit today", "blue");
	else
		cli_execute("ballpit");
}

/* Look high in your telescope */
void get_telescope_buff()
{
	if(get_property("telescopeLookedHigh").to_boolean())
		print("Already looked high with the telescope today", "blue");
	else
		cli_execute("telescope high");
}

/* Get monorail buff */
void get_monorail_buff()
{
	if(get_property("_lyleFavored").to_boolean())
		print("Already favored by Lyle today", "blue");
	else
		cli_execute("monorail buff");
}

/* Clan Fortune Teller Consults */
void take_clan_consults()
{
	int consults_used = get_property("_clanFortuneConsultUses").to_int();
	if(consults_used >= 3)
		print("Clan consults already used today", "blue");
	else
	{
		if(get_property("clanFortuneWord1") != "pizza")
			set_property("clanFortuneWord1", "pizza");
		if(get_property("clanFortuneWord2") != "robin")
			set_property("clanFortuneWord2", "robin");
		if(get_property("clanFortuneWord3") != "thick")
			set_property("clanFortuneWord3", "thick");

		for x from 1 to (3 - consults_used)
		{
			cli_execute("fortune alterior motives");
			waitq(15);
			print("countdown: 30", "blue");
			waitq(20);
			print("countdown: 10", "blue");
			waitq(10);
		}
	}
}

/* Aggregated daily chores function */

void daily_chores()
{
	generate_reagents();
	generate_noodles();
	generate_cocktail_ingredients();
	generate_sugar_sheets();
	generate_smithsness();
	generate_clip_art("box of Familiar Jacks");
	generate_perfect_ice_cubes();
	generate_army_cards();
	generate_confiscated_things();
	generate_prismatic_wads();
	generate_cold_one();
	generate_spaghetti_breakfast();
	generate_crimbo_candy();
	generate_single_atom();
	generate_chroners();
	generate_chester_candy();
	cheat_deck_every_card("Island");
	if(my_class() == $class[Seal Clubber])
		cheat_deck_every_card("Rope");
	else
		cheat_deck_every_card("Ancestral Recall");
	generate_bacon();
	generate_kardashians();
	generate_pocket_wishes();
	get_clovers();
	harvest_Chateau_Juice_Bar();
	harvest_tea_tree();
	harvest_gene_tonics();
	harvest_terminal_booze();
	harvest_terminal_buffs();
	harvest_garden();
	harvest_clan_meat_tree();
	harvest_mr_klaw();
	harvest_floundry();
	harvest_clan_mirror();
	harvest_clan_shower();
	harvest_clan_pool();
	harvest_clan_fax();
	take_clan_consults();
	visit_hippy_store();
	check_plumber_arcade();
	visit_precinct_headquarters();
	harvest_sea_jelly();
	harvest_dinsey_maint_tunnel();
	harvest_inferno_tower();
	harvest_wlf_bunker();
	harvest_velvet_gold_mine(5, false);
	operate_control_panel();
}