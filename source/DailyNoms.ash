/*From inventory first then from mall, uses milk of mag and eats 3 hi meins*/

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