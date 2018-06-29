

void main(int round, monster foe, string page)
{
	if(item_amount($item[Spooky Putty sheet]) > 0 && get_property("spookyPuttyCopiesMade").to_int() < 1)
	{
		if(item_amount($item[LOV Enamorang]) > 0 && !property_exists("_enamorangUsed"))
		{
			throw_items($item[Spooky Putty sheet], $item[LOV Enamorang]);
			set_property("_enamorangUsed", "1");
		}
		else
			throw_item($item[Spooky Putty sheet]);
	}
	
	if(my_familiar() == $familiar[Reanimated Reanimator] && get_property("_badlyRomanticArrows").to_int()==0)
		visit_url("fight.php?action=skill&whichskill=7168");

	
	int digitizeUses = get_property("_sourceTerminalDigitizeUses").to_int();
	if(digitizeUses >= 3)
		print("Already used 3 digitizes today", "blue");													
	else if (digitizeUses == 0 || get_property("_sourceTerminalDigitizeMonsterCount").to_int() >= 5)
	{
		use_skill(1,$skill[Digitize]);
		print("Digitizing Embezzler!!", "blue");	
	}

	if(item_amount($item[Rain-Doh black box]) > 0 && get_property("_raindohCopiesMade").to_int() < 5)
		throw_item($item[Rain-Doh black box]);
		
	if(item_amount($item[4-d camera]) > 0 && !property_exists("_cameraCopyMade"))
	{
		throw_item($item[4-d camera]);
		set_property("_cameraCopyMade", "true");
	}
	
	if(item_amount($item[unfinished ice sculpture]) > 0 && !property_exists("_sculptureCopyMade"))
	{
		throw_item($item[unfinished ice sculpture]);
		set_property("_sculptureCopyMade", "ture");
	}
	
	if(get_property("_meteorShowerUses").to_int() >= 5)
		print("Already used 5 Meteor Showers today", "blue");
	else if(my_familiar()==$familiar[Robortender])
	{
		print("Casting Meteor Shower!!", "blue");
		use_skill(1, $skill[Meteor Shower]);
	}
	
	else
		use_skill($skill[Furious Wallop]);
}