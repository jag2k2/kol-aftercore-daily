/*Return room left in organ based on specified item type*/
int organ_room(string consume_type)
{
	switch(consume_type)
	{
		case "food":
			return(fullness_limit() - my_fullness());
		case "booze":
			return(inebriety_limit() - my_inebriety());
		case "spleen item":
			return(spleen_limit() - my_spleen_use());
		default:
			return 0;
	}
}

/*Eat, drink or chew consumable based on item parameter and returns the number of items that were consumed*/
int consume(int to_consume, item consumable)
{
	switch(item_type(consumable))
	{
		case "food":
			eatsilent(to_consume, consumable);
			break;
		case "booze":
			overdrink(to_consume, consumable);
			break;
		case "spleen item":
			chew(to_consume, consumable);
			break;
		default:
			return 0;
	}
	return to_consume;
}

/*Find number of times we could time-spin the specified consumable*/
int nom_spinsAvail(item consumable)
{
	int spins_avail = 0;
	if (item_amount($item[time-spinner])==0)
		return 0;
	else if (get_property("_timeSpinnerFoodAvailable").contains_text(consumable.to_int().to_string()) || consumable == $item[none])
		spins_avail = (10 - get_property("_timeSpinnerMinutesUsed").to_int())/3;
	return spins_avail;
}

/*Spin-eat as many of the specified item as possible*/
int travelBack_deliciousMeals(int to_spin, item consumable)						// Returns the number of meal spins that were actually performed
{
	int spins_available = nom_spinsAvail(consumable);							// Represents number of spins available for a particular consumable
	if(to_spin > 0 && spins_available > 0)										// If there is room in the appropriate organ for 1 or more of the consumable and it is available for at least 1 time-spin
	{
		if(spins_available < to_spin)											// If there are less spins available than what is needed to fill the stomach
			to_spin = spins_available;											// Then we are just going to spin-eat what we can.  Otherwise we will spin as much as will fit into the stomach.
		print("Spinning " + to_spin + " " + consumable, "blue");
		for x from 1 to to_spin													// One at a time, use the time-spinner to consume	
			cli_execute("timespinner eat " + consumable);
		return to_spin;
	}
	else
		return 0;
}

/*From inventory first then from mall, uses consumables of specified type*/

void nom_noms(string menu, boolean fill_up) 
//[hi mein, perfect drink, 1-size booze, 4-size spleen, 3-size spleen]
{
	int [item] consumable;
	string nom_type;
	int nom_size;
	switch(menu)
	{
		case "hi mein":
			print("Attempting to eat hi mein", "blue");
			nom_size = 5;
			nom_type = "food";
			file_to_map("/kol-aftercore-daily/data/Food_HiMein.txt", consumable);
			break;
		case "jumping horseradish":
			print("Attempting to eat jumping horseradish", "blue");
			nom_size = 1;
			nom_type = "food";
			file_to_map("/kol-aftercore-daily/data/Food_1SizeMeatBuff.txt", consumable);
			break;
		case "perfect booze":
			print("Attempting to drink perfect booze without getting drunk", "blue");
			nom_size = 3;
			nom_type = "booze";
			file_to_map("/kol-aftercore-daily/data/Booze_Perfect.txt", consumable);
			break;
		case "1-size booze":
			print("Attempting to drink generic 1-shot drink without getting drunk", "blue");
			nom_size = 1;
			nom_type = "booze";
			file_to_map("/kol-aftercore-daily/data/Booze_1SizeGeneric.txt", consumable);
			break;
		case "Ambitious Turkey":
			print("Attempting to drink Ambitious Turkey without getting drunk", "blue");
			nom_size = 1;
			nom_type = "booze";
			file_to_map("/kol-aftercore-daily/data/Booze_1SizeMeatBuff.txt", consumable);
			break;
		case "Cold One":
			print("Attempting to drink Cold One without getting drunk", "blue");
			nom_size = 1;
			nom_type = "booze";
			file_to_map("/kol-aftercore-daily/data/Booze_1SizeEpicGen.txt", consumable);
			break;
		case "4-size spleen":
			print("Attempting to chew 4-size spleen items", "blue");
			nom_size = 4;
			nom_type = "spleen item";
			file_to_map("/kol-aftercore-daily/data/Spleen_4SizeGood.txt", consumable);
			break;
		case "3-size spleen":
			nom_size = 3;
			nom_type = "spleen item";
			print("Attempting to chew 3-size spleens items", "blue");
			file_to_map("/kol-aftercore-daily/data/Spleen_3SizeGood.txt", consumable);
			break;
		default:
			print("Do not recognize that type: " + menu, "blue");
			return;
	}
		
	if(organ_room(nom_type) < nom_size)
		print("Not enough room to consume a " + nom_type + " of size " + nom_size, "blue");
	else
	{
		if(nom_type == "food")
		{
			if(have_effect($effect[Got Milk]) > 0 || organ_room(nom_type) < 3)
				print("Already have milk of mag effect or not enough stomach room to make it worth it", "blue");
			else
			{
				retrieve_item(1, $item[milk of magnesium]);														// Get (if necessary) and use 1 milk of magnesium
				print("Using milk of magnesium", "blue");
				use(1, $item[milk of magnesium]);
			}
		}
		
		else if(nom_type == "booze")
		{
			if(have_effect($effect[Fat Leon's Phat Loot Lyric]) > 0)
				cli_execute("uneffect Fat Leon's Phat Loot Lyric");
			if(have_effect($effect[Ode to Booze]) >= organ_room(nom_type))
				print("Already enough Ode to Booze to fill entire liver", "blue");
			else
			{
				repeat
				{
					boolean mp_restore = false;
					int to_cast = ceil(organ_room(nom_type)/to_float(turns_per_cast($skill[The Ode to Booze])));	// Calc how many times you would need to cast ode to cover liver room
					int casts_afford = my_mp()/mp_cost($skill[The Ode to Booze]);									// Calc how many times you can cast Ode
					print("Want to cast ode " + to_cast + " times.  Can afford " + casts_afford, "blue");
					if(casts_afford < to_cast)
						{
							to_cast = casts_afford;
							mp_restore = true;
						}
					use_skill(to_cast, $skill[The Ode to Booze]);
					if(mp_restore)
						minor_mp_restore();
				}until(have_effect($effect[Ode to Booze]) >= organ_room(nom_type));
			}
		}
		
		record nom_deets{
			int price;
			int amount;
			int limit;
		};
		
		nom_deets [item] nom;
			
		foreach key in consumable
		{
			nom[key].price = mall_price(key);
			nom[key].amount = item_amount(key);
			nom[key].limit = consumable[key];
		}
		
		item cheapest;
		int price = 9999999;
		int to_nom = 0;
		int to_buy = 0;
		int spins_avail = 0;
		int consumed = 0;
		
		foreach key in nom													// Go through all consumables of the specified type and see if you can spin them first before consuming from inventory or mall
		{
			int to_nom = organ_room(nom_type)/nom_size;						// Represents number of consumables we intend to take
			if(!fill_up)
				to_nom = 1;
			consumed += travelBack_deliciousMeals(to_nom, key);				// Spin-eat the specified consumable up to either the number of spins we have left or the stomach room
			if(consumed > 0 && !fill_up)
				return;
		}
		
		foreach key in nom													// For each item in this map
		{
			print(key + ": Found " + nom[key].amount + " in inventory. Could buy from mall for " + nom[key].price + " (price limit " + nom[key].limit + ")", "blue");
			if(nom[key].price < price)										// See if it s the mall cheapest just in case we need to buy some
			{
				cheapest = key;
				price = nom[key].price;
			}
			
			to_nom = organ_room(nom_type)/nom_size;							// Calc how many more consumables we can consume today
			if(nom_type == "food")
				spins_avail = nom_spinsAvail($item[none]);					// If the nom_type type is food then get the number of spins avail
			if(to_nom > 0 && nom[key].amount > 0)							// If there is room in the appropriate organ for 1 or more of the consumable and there is atleast one of these consumables in inventory
			{
				to_nom -= spins_avail;										// Reduce the number of consumables to eat by the number of spins available (coerce to a minimum of 1).
				if (to_nom < 1 || !fill_up)												
					to_nom = 1;
				if(nom[key].amount < to_nom)								// If inventory has less consumables of this type than we want to consume
					to_nom = nom[key].amount;								// Then we are going to consume just what we have.  Otherwise we will consume as much as will fit into the organ.
				print("Consuming " + to_nom + " " + key, "blue");
				consumed += consume(to_nom, key);
				if(consumed > 0 && !fill_up)
					return;
			}
			to_nom = organ_room(nom_type)/nom_size;							// Recheck the number of consumables we have room for
			consumed += travelBack_deliciousMeals(to_nom, key);				// Time-spin that many consumables
			if(consumed > 0 && !fill_up)
				return;
		}
		
		to_nom = organ_room(nom_type)/nom_size;								// After consuming from inventory, calc how many more consumables of this type and size we can consume today
		if(nom_type == "food")		
			spins_avail = nom_spinsAvail($item[none]);						// See how many spins we have left in the time spinner regardless of consumable
		if(to_nom > 0)														// If still room to eat 1 or more of this type of consumable		
		{
			to_nom -= spins_avail;											// Reduce the number of consumables to eat by the number of spins available (coerce to a minimum of 1).
			if (to_nom < 1 || !fill_up)												
				to_nom = 1;
			print("Retrieving and consuming " + to_nom + " " + cheapest, "blue");
			to_buy = to_nom;
			if(menu == "perfect booze")
				to_buy -= item_amount($item[perfect ice cube]);
			for x from 1 upto to_buy
				cli_execute("mallbuy " + cheapest + " @ " + nom[cheapest].limit);			
			retrieve_item(to_nom, cheapest);								// Retrieve the cheapest of that many consumables
			consumed += consume(to_nom, cheapest);							// And consume those too!
			if(consumed > 0 && !fill_up)
				return;
			
			to_nom = organ_room(nom_type)/nom_size;							// Recheck the number of consumables we have room for
			travelBack_deliciousMeals(to_nom, cheapest);					// Time-spin that many consumables
		}
	}
}