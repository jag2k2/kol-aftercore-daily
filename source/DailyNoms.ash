/*From inventory first then from mall, uses milk of mag and eats 3 hi meins*/

void nom_noms(string menu) 
//[hi meins, perfect drinks, 1-shots, 4-size spleen, 3-size spleen]
{
	item [int] consumable;
	switch(menu)
	{
		case "hi meins":
			print("Will eat hi meins until full", "blue");
			consumable[0] = $item[cold hi mein]; 
			consumable[1] = $item[hot hi mein];
			consumable[2] = $item[sleazy hi mein];
			consumable[3] = $item[spooky hi mein];
			consumable[4] = $item[stinky hi mein];
			break;
		case "perfect drinks":
			print("Will drink perfect drinks without getting drunk", "blue");
			consumable[0] = $item[perfect cosmopolitan];
			consumable[1] = $item[perfect dark and stormy];
			consumable[2] = $item[perfect mimosa];
			consumable[3] = $item[perfect negroni];
			consumable[4] = $item[perfect old-fashioned];
			consumable[5] = $item[perfect paloma];
			break;
		case "1-shots":
			print("Will drink a 1-shot drink without getting drunk", "blue");
			consumable[0] = $item[bottle of norwhiskey];
			consumable[1] = $item[splendid martini];
			consumable[2] = $item[Newark];
			consumable[3] = $item[vodka barracuda];
			consumable[4] = $item[eighth plague];
			consumable[5] = $item[distilled fortified wine];
			break;
		case "4-size spleen":
			print("Will chew as many 4-size spleens as possible", "blue");
			consumable[0] = $item[grim fairy tale];
			consumable[1] = $item[groose grease];
			consumable[2] = $item[powdered gold];
			consumable[3] = $item[Unconscious Collective Dream Jar];
			break;
		case "3-size spleen":
			print("Will chew as many 3-size spleens as possible", "blue");
			consumable[1] = $item[prismatic wad];
			break;
		default:
			print("Do not recognize that type: " + menu, "blue");
			break;
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
	//string item_type(item check_me )
	foreach key in nom
	{
		print(key + " " + nom[key].price + " " + nom[key].amount + " " + item_type(key), "blue");
	}
}

void eat_hi_meins()
{
	if(my_fullness() >= 15)
		print("Fullness is already 15 or above", "blue");
	else
	{
		record nom_deets{
			int price;
			int amount;
		};
		
		nom_deets [item] hi_mein;
		
		hi_mein[$item[cold hi mein]].price = mall_price($item[cold hi mein]);
		hi_mein[$item[cold hi mein]].amount = item_amount($item[cold hi mein]);
		hi_mein[$item[hot hi mein]].price = mall_price($item[hot hi mein]);
		hi_mein[$item[hot hi mein]].amount = item_amount($item[hot hi mein]);
		hi_mein[$item[sleazy hi mein]].price = mall_price($item[sleazy hi mein]);
		hi_mein[$item[sleazy hi mein]].amount = item_amount($item[sleazy hi mein]);
		hi_mein[$item[spooky hi mein]].price = mall_price($item[spooky hi mein]);
		hi_mein[$item[spooky hi mein]].amount = item_amount($item[spooky hi mein]);
		hi_mein[$item[stinky hi mein]].price = mall_price($item[stinky hi mein]);
		hi_mein[$item[stinky hi mein]].amount = item_amount($item[stinky hi mein]);

		retrieve_item(1, $item[milk of magnesium]);														// Get (if necessary) and use 1 milk of magnesium
		print("We have " + item_amount($item[milk of magnesium]) + " Milk of Magnesium", "blue");
		use(1, $item[milk of magnesium]);
		
		item cheapest;
		int price = 9999999;
		int to_eat = 0;
		
		foreach key in hi_mein																			// For each type of hi mein:
		{
			print(key + " " + hi_mein[key].price + " " + hi_mein[key].amount, "blue");
			if(hi_mein[key].price < price) 																// See if it is the mall cheapest just in case we need to buy some
			{
				cheapest = key;
				price = hi_mein[key].price;
			}
			
			to_eat = (15 - my_fullness())/5;															// Calc how many more hi meins we can eat today
			if(to_eat > 0)																				// If there is room to eat 1 or more hi mein
			{
				if(hi_mein[key].amount < to_eat)														// But if there are less hi meins of this type than we are hungry for
						to_eat = hi_mein[key].amount;													// Then we are going to eat just what we have (even 0 if that is what we have)
				eat(to_eat, key);																		// Lets eat this type of hi mein
			}	
		}
		
		to_eat = (15 - my_fullness())/5;																// After eating from our inventory, calc how many more hi meins we can eat today
		if(to_eat > 0)																					// If still rooom to eat 1 or more hi meins
		{
			print("Retrieving " + to_eat + " " + cheapest, "blue");
			retrieve_item(to_eat, cheapest);															// Retrieve the cheapest of that many hi meins
			eat(to_eat, cheapest);																		// And eat those too!
		}
	}		
}

/*From inventory first then from mall, cast ode and drink as many perfect drinks as possible*/

void drink_perfect_drinks()
{
	if (my_inebriety() > (inebriety_limit() - 3))														// inebriety_limit returns what you CAN drink without getting over-drunk (19 for instance)
		print("Inebriety is already at " + my_inebriety(), "blue");
	else
	{
		if(have_effect($effect[Fat Leon's Phat Loot Lyric]) > 0)
			cli_execute("uneffect Fat Leon's Phat Loot Lyric");
		
		chat_private("buffy", "ode");
		wait(10);
		
		record booze_deets{
			int price;
			int amount;
		};
		
		booze_deets [item] perfect_drink;
		perfect_drink[$item[perfect cosmopolitan]].price = mall_price($item[perfect cosmopolitan]);
		perfect_drink[$item[perfect cosmopolitan]].amount = item_amount($item[perfect cosmopolitan]);
		perfect_drink[$item[perfect dark and stormy]].price = mall_price($item[perfect dark and stormy]);
		perfect_drink[$item[perfect dark and stormy]].amount = item_amount($item[perfect dark and stormy]);
		perfect_drink[$item[perfect mimosa]].price = mall_price($item[perfect mimosa]);
		perfect_drink[$item[perfect mimosa]].amount = item_amount($item[perfect mimosa]);
		perfect_drink[$item[perfect negroni]].price = mall_price($item[perfect negroni]);
		perfect_drink[$item[perfect negroni]].amount = item_amount($item[perfect negroni]);
		perfect_drink[$item[perfect old-fashioned]].price = mall_price($item[perfect old-fashioned]);
		perfect_drink[$item[perfect old-fashioned]].amount = item_amount($item[perfect old-fashioned]);
		perfect_drink[$item[perfect paloma]].price = mall_price($item[perfect paloma]);
		perfect_drink[$item[perfect paloma]].amount = item_amount($item[perfect paloma]);
		
		item cheapest;
		int price = 9999999;
		int to_drink = 0;
		
		foreach key in perfect_drink																	// For each type of perfect drink:
		{
			print(key + " " + perfect_drink[key].price + " " + perfect_drink[key].amount, "blue");
			if(perfect_drink[key].price < price) 														// See if it is the mall cheapest just in case we need to buy some
			{
				cheapest = key;
				price = perfect_drink[key].price;
			}
			
			to_drink = (inebriety_limit() - my_inebriety())/3;											// Calc how many more perfect drinks we can drink today
			if(to_drink > 0)																			// If there is room to drink 1 or more perfect drink
			{
				if(perfect_drink[key].amount < to_drink)												// But if there are less perfect drinks of this type than we can handle
					to_drink = perfect_drink[key].amount;												// Then we are going to drink just what we have (even 0 if that is what we have)
				drink(to_drink, key);																	// Bottoms up!
			}
		}
		
		to_drink = (inebriety_limit() - my_inebriety())/3;												// After drinking from our inventory, calc how many more perfect drinks we can consume today
		if(to_drink > 0)																				// If still rooom to eat 1 or more perfect drink
		{
			print("Retrieving " + to_drink + " " + cheapest, "blue");
			retrieve_item(to_drink, cheapest);															// Retrieve the cheapest of that many perfect drinks
			drink(to_drink, cheapest);																	// And drink those too!
		}
	}
}

/*From inventory first then from mall, chew powdered gold*/

void chew_spleen_item()
{
	if (my_spleen_use() > (spleen_limit() - 4))														
		print("Spleen is already at " + my_spleen_use(), "blue");
		
	else
	{
		record spleen_deets{
			int price;
			int amount;
		};
		
		spleen_deets [item] spleen_item;
		spleen_item[$item[grim fairy tale]].price = mall_price($item[grim fairy tale]);
		spleen_item[$item[grim fairy tale]].amount = item_amount($item[grim fairy tale]);
		spleen_item[$item[groose grease]].price = mall_price($item[groose grease]);
		spleen_item[$item[groose grease]].amount = item_amount($item[groose grease]);
		spleen_item[$item[powdered gold]].price = mall_price($item[powdered gold]);
		spleen_item[$item[powdered gold]].amount = item_amount($item[powdered gold]);
		spleen_item[$item[Unconscious Collective Dream Jar]].price = mall_price($item[Unconscious Collective Dream Jar]);
		spleen_item[$item[Unconscious Collective Dream Jar]].amount = item_amount($item[Unconscious Collective Dream Jar]);
		
		item cheapest;
		int price = 9999999;
		int to_chew = 0;
		
		foreach key in spleen_item																		// For each type of spleen item:
		{
			print(key + " " + spleen_item[key].price + " " + spleen_item[key].amount, "blue");
			if(spleen_item[key].price < price) 															// See if it is the mall cheapest just in case we need to buy some
			{
				cheapest = key;
				price = spleen_item[key].price;
			}
			
			to_chew = (spleen_limit() - my_spleen_use())/4;												// Calc how many more spleen items we can chew today
			if(to_chew > 0)																				// If there is room to chew 1 or more spleen item
			{
				if(spleen_item[key].amount < to_chew)													// But if there are less spleen items of this type than we can handle
					to_chew = spleen_item[key].amount;													// Then we are going to chew just what we have (even 0 if that is what we have)
				print("Attempting " + to_chew + " " + key, "blue");
				chew(to_chew, key);																		// Lets chew!
			}
		}
		
		to_chew = (spleen_limit() - my_spleen_use())/4;													// After using from our inventory, calc how many more spleen items we can consume today
		if(to_chew > 0)																					// If still rooom to chew 1 or more spleen items
		{
			print("Retrieving " + to_chew + " " + cheapest, "blue");
			retrieve_item(to_chew, cheapest);															// Retrieve the cheapest of that many spleen items
			chew(to_chew, cheapest);																		// And chew those too!
		}
	}
}