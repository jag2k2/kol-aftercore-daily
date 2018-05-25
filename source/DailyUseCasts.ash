import DailyMpRestore.ash

/*Daily Uses and Daily Casts*/
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

/*Summon 3 smithsness*/
int generate_smithsness()
{
	int old_flasks = item_amount($item[Flaskfull of Hollow]);
	int old_lumps = item_amount($item[lump of Brituminous coal]);
	int old_smithereeens = item_amount($item[handful of Smithereens]);
	
	use_skill(3, $skill[Summon Smithsness]);
	
	int flasks_gen = item_amount($item[Flaskfull of Hollow]) - old_flasks;
	int lumps_gen = item_amount($item[lump of Brituminous coal]) - old_lumps;
	int smithereens_gen = item_amount($item[handful of Smithereens]) - old_smithereeens;
	
	print("Generated " + flasks_gen + " flasks, " + lumps_gen + " coals, and " + smithereens_gen + " smithereens", "blue");
	return flasks_gen + lumps_gen + smithereens_gen;
	
}

/*Summon 3 Clip Arts*/
int generate_clip_art()
{
	int max_summons_per_day = 3;
	int buckets_old = item_amount($item[bucket of wine]);
	int summons_used = get_property("_clipartSummons").to_int();
	if (summons_used >= max_summons_per_day)
		print("Clip Art summons already used", "blue");
	else
	{
		for x from summons_used to (max_summons_per_day - 1)
			cli_execute("create bucket of wine");
		int buckets_gen = item_amount($item[bucket of wine]) - buckets_old;
		print("Generated " + buckets_gen + " buckets of wine", "blue");
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
	if(get_property("_timeSpinnerReplicatorUsed").to_boolean())
		print("Time-spinner replicator already used today", "blue");
	else if(get_property("_timeSpinnerMinutesUsed").to_int() > 8)
		print("Time-spinner doesn't have enough minutes remaining to run the replicator", "blue");
	else
	{
		int kardashian_old = item_amount($item[shot of kardashian gin]);
		visit_url("inv_use.php?pwd=&whichitem=9104");						//the use command causes manual control to be requested.  use the url instead
		run_choice(4);
		run_choice(1);
		run_choice(4);
		run_choice(2);
		run_choice(5);
		run_choice(2);
		
		kardashian_gen = item_amount($item[shot of kardashian gin]) - kardashian_old;
		print("Generated " + kardashian_gen + " kardashians", "blue");
	}
	return kardashian_gen;
}
	
/*Use Corked Genie Bottle*/
int generate_pocket_wishes()
{
	int wishes_used = get_property("_genieWishesUsed").to_int();
	int wishes_old = item_amount($item[pocket wish]);
	if(wishes_used >= 3)
		print("Genie has no more wishes for the day", "blue");
	else
	{
		for x from wishes_used to 2
		{
			cli_execute("genie wish for more wishes");
		}
	int wishes_gen = item_amount($item[pocket wish]) - wishes_old;
	print("Generated " + wishes_gen + " pocket wishes", "blue");
	cli_execute("mallsell " + wishes_gen + " pocket wish @ 52000");
	}
	return 0;
}

/*Cast Max Resolutions*/
int generate_resolutions()
{
	int old_kinders = item_amount($item[resolution: be kinder]);
	while (my_mp() > mp_cost($skill[Summon Resolutions]))
	{
		print("Resolutions MP cost: " + mp_cost($skill[Summon Resolutions]), "blue");
		use_skill($skill[Summon Resolutions]);
	}

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
	farm_buff[3].name = $skill[Fat Leon's Phat Loot Lyric];
	farm_buff[3].casts = target/turns_per_cast($skill[Fat Leon's Phat Loot Lyric]);
	farm_buff[3].prop = "_phatlootCasts";
	farm_buff[4].name = $skill[The Polka of Plenty];
	farm_buff[4].casts = target/turns_per_cast($skill[The Polka of Plenty]);
	farm_buff[4].prop = "_polkaCasts";
	farm_buff[5].name = $skill[Empathy of the Newt];
	farm_buff[5].casts = target/turns_per_cast($skill[Empathy of the Newt]);
	farm_buff[5].prop = "_empathyCasts";
	
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