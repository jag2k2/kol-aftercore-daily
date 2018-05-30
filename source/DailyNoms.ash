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

/*Eat, drink or chew consumable based on item parameter*/
void consume(int to_consume, item consumable)
{
	switch(item_type(consumable))
	{
		case "food":
			eat(to_consume, consumable);
			return;
		case "booze":
			drink(to_consume, consumable);
			return;
		case "spleen item":
			chew(to_consume, consumable);
			return;
		default:
			return;
	}
}

/*Find number of times we could time-spin the specified consumable*/
			
int nom_spinsAvail(item consumable)
{
	int spins_avail = 0;
	if (item_amount($item[time-spinner])==0)
		print("Do not have time-spinner", "blue");
	else if (!get_property("_timeSpinnerFoodAvailable").contains_text(consumable.to_int().to_string()))
		print(consumable + " is not available for time-spinning", "blue");
	else
	{
		spins_avail = (10 - get_property("_timeSpinnerMinutesUsed").to_int())/3;
		print("Spins available for " + consumable + " consumption: " + spins_avail, "blue");
	}
	return spins_avail;
}

/*From inventory first then from mall, uses consumables of specified type*/

void nom_noms(string menu) 
//[hi mein, perfect drink, 1-size booze, 4-size spleen, 3-size spleen]
{
	item [int] consumable;
	int nom_size;
	switch(menu)
	{
		case "hi meins":
			print("Will eat hi meins until full", "blue");
			nom_size = 5;
			consumable[0] = $item[cold hi mein]; 
			consumable[1] = $item[hot hi mein];
			consumable[2] = $item[sleazy hi mein];
			consumable[3] = $item[spooky hi mein];
			consumable[4] = $item[stinky hi mein];
			break;
		case "perfect drinks":
			print("Will drink perfect drinks without getting drunk", "blue");
			nom_size = 3;
			consumable[0] = $item[perfect cosmopolitan];
			consumable[1] = $item[perfect dark and stormy];
			consumable[2] = $item[perfect mimosa];
			consumable[3] = $item[perfect negroni];
			consumable[4] = $item[perfect old-fashioned];
			consumable[5] = $item[perfect paloma];
			break;
		case "1-size booze":
			print("Will drink a 1-shot drink without getting drunk", "blue");
			nom_size = 1;
			consumable[0] = $item[bottle of norwhiskey];
			consumable[1] = $item[splendid martini];
			consumable[2] = $item[Newark];
			consumable[3] = $item[vodka barracuda];
			consumable[4] = $item[eighth plague];
			consumable[5] = $item[distilled fortified wine];
			break;
		case "4-size spleen":
			print("Will chew as many 4-size spleens as possible", "blue");
			nom_size = 4;
			consumable[0] = $item[grim fairy tale];
			consumable[1] = $item[groose grease];
			consumable[2] = $item[powdered gold];
			consumable[3] = $item[Unconscious Collective Dream Jar];
			break;
		case "3-size spleen":
			nom_size = 3;
			print("Will chew as many 3-size spleens as possible", "blue");
			consumable[0] = $item[prismatic wad];
			break;
		default:
			print("Do not recognize that type: " + menu, "blue");
			return;
	}
	
	string nom_type = item_type(consumable[0]);
	
	if(organ_room(nom_type) < nom_size)
		print("Not enough room to consume a " + nom_type + " of size " + nom_size, "blue");
	else
	{
		if(nom_type == "food")
		{
			if(have_effect($effect[Got Milk]) > 0)
				print("Already have milk of mag effect", "blue");
			else
			{
				retrieve_item(1, $item[milk of magnesium]);														// Get (if necessary) and use 1 milk of magnesium
				print("Using milk of magnesium", "blue");
				use(1, $item[milk of magnesium]);
			}
		}
		
		else if(nom_type == "booze")
		{
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
		};
		
		nom_deets [item] nom;
			
		foreach key in consumable
		{
			nom[consumable[key]].price = mall_price(consumable[key]);
			nom[consumable[key]].amount = item_amount(consumable[key]);
		}
		
		item cheapest;
		int price = 9999999;
		int to_nom = 0;
		
		foreach key in nom													// Go through all consumables of the specified type and see if you can spin them first before consuming from inventory or mall
		{
			to_nom = organ_room(nom_type)/nom_size;							// Represents number of consumables we intend to take
			int spins_avail = nom_spinsAvail(key);							// Represents number of spins available for a particular consumable
			if(to_nom > 0 && spins_avail > 0)								// If there is room in the appropriate organ for 1 or more of the consumable and it is available for at least 1 time-spin
			{
				if(spins_avail < to_nom)									// If there are less spins available than what is needed to fill the stomach
					to_nom = spins_avail;									// Then we are just going to spin what we can.  Otherwise we will spin as much as will fit into the stomach.
				print("Want to spin " + to_nom + " " + key, "blue");
				for x from 1 to to_nom										// One at a time, use the time-spinner to consume
					cli_execute("timespinner eat " + key);
			}
		}
		
		foreach key in nom													// For each item in this map
		{
			print(key + " " + nom[key].price + " " + nom[key].amount + " " + item_type(key), "blue");
			if(nom[key].price < price)										// See if it s the mall cheapest just in case we need to buy some
			{
				cheapest = key;
				price = nom[key].price;
			}
			
			/*to_nom = organ_room(nom_type)/nom_size;						// Calc how many more consumables we can consume today
			if(to_nom > 0 && nom[key].amount > 0)							// If there is room in the appropriate organ for 1 or more of the consumable and there is atleast one of these consumables in inventory
			{
				if(nom[key].amount < to_nom)								// But if inventory has less consumables of this type than we can consume
					to_nom = nom[key].amount;								// Then we are going to consume just what we have.  Otherwise we will consume as much as will fit into the organ.
				print("Want to consume " + to_nom + " " + key, "blue");
				consume(to_nom, key);
			}*/
		}
		
		/*to_nom = organ_room(nom_type)/nom_size;							// After consuming from inventory, calc how many more consumables of this type and size we can consume today
		if(to_nom > 0)														// If still room to eat 1 or more of this type of consumable		
		{
			print("Retrieving " + to_nom + " " + cheapest, "blue");
			retrieve_item(to_nom, cheapest);								// Retrieve the cheapest of that many consumables
			consume(to_nom, cheapest);										// And consume those too!
		}*/
	}
}