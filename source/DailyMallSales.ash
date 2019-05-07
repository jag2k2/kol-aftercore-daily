//Check for min-priced item

void check_cheap_mall_item()
{
	int old_count, item_acq, total_acq;
	int [item] shopping_list;
	file_to_map("/kol-aftercore-daily/data/ShoppingList.txt", shopping_list);
	print(count(shopping_list));
	
	foreach key in shopping_list
	{
		total_acq = 0;
		
		repeat
		{
			old_count = item_amount(key);
			//print("mallbuy " + key + " @ " + shopping_list[key], "blue");
			cli_execute("mallbuy " + key + " @ " + shopping_list[key]);
			item_acq = item_amount(key) - old_count;
			if (item_acq > 0)
				total_acq = total_acq + item_acq;
		}until (item_acq == 0 || total_acq > 5);
		if(total_acq > 0)
			print("You mall-bought " + total_acq + " " + key, "blue");
	}
}

//Daily Mall Sells

void daily_put_into_mall()
{
	int [item] to_sell_list;
	file_to_map("/kol-aftercore-daily/data/Daily_MallSell.txt", to_sell_list);
	print(count(to_sell_list));	
	
	foreach key in to_sell_list
	{
		int item_amt = item_amount(key);
		print("Placing " + to_string(item_amt) + " " + key + " in mall.", "blue");
		cli_execute("mallsell " + to_string(item_amt) + " " + key);
	}
}