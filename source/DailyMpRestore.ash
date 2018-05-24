/*Checking total remaining free rests*/
boolean rest_in_chateau()
{
	int rests_used = get_property("timesRested").to_int();
	int rests_left = total_free_rests() - rests_used;					//total_free_rests() is a kolmafia function
	print("You have " + rests_left + " free rests remaining", "blue");
	
	if (rests_left > 0)
	{
		visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
		return true;
	}
	else	
		return false;
}

/*Use Oscus Neverending Soda*/
boolean use_oscus_soda()
{
	if(get_property("oscusSodaUsed").to_boolean())
	{
		print("Oscus Neverending Soda already used", "blue");
		return false;
	}
	else
	{
		use(1, $item[Oscus's neverending soda]);
		return true;
	}
}

/*Get a nun massage*/
boolean get_nun_massage()
{
	if(get_property("nunsVisits").to_int() >= 3)
	{
		print("Nuns massages all used up", "blue");
		return false;
	}
	else
	{
		print("Trying to get a massage", "blue");
		cli_execute("nuns");
		return true;
	}
}

/*Use license to chill*/
boolean use_license()
{
	if(get_property("_licenseToChillUsed").to_boolean())
	{
		print("License to Chill already used today", "blue");
		return false;
	}
	else
	{
		int delights_old = item_amount($item[afternoon delight]);
		use(1, $item[license to chill]);
		int delights_gen = item_amount($item[afternoon delight]) - delights_old;
		print ("Generated " + delights_gen + " afternoon delights", "blue");
		return true;
	}
}

/*Use smaller sources of daily mp restore to bump available MP*/
int minor_mp_restore()
{
	if(!rest_in_chateau())
		if(!use_oscus_soda())
			get_nun_massage();
	return 0;
}