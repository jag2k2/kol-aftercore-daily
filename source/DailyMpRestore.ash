/*Checking total remaining free rests*/
boolean rest_in_chateau()
{
	int rests_used = get_property("timesRested").to_int();
	int rests_left = total_free_rests() - rests_used;					//total_free_rests() is a kolmafia function
	boolean rested = false;
	print("You have " + rests_left + " free rests remaining", "blue");
	if (rests_left > 0)
	{
		visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
		rested = true;
	}
	else	
		rested = false;
	return rested;
}

/*Use Oscus Neverending Soda*/
boolean use_oscus_soda()
{
	boolean success = false;
	if(get_property("oscusSodaUsed").to_boolean())
		print("Oscus Neverending Soda already used", "blue");
	else
	{
		use(1, $item[Oscus's neverending soda]);
		success = true;
	}
	return success;
}

/*Use license to chill*/
int use_license()
{
	int delights_gen = 0;
	if(get_property("_licenseToChillUsed").to_boolean())
		print("License to Chill already used today", "blue");
	else
	{
		int delights_old = item_amount($item[afternoon delight]);
		use(1, $item[license to chill]);
		delights_gen = item_amount($item[afternoon delight]) - delights_old;
		print ("Generated " + delights_gen + " afternoon delights", "blue");
	}
	return delights_gen;
}

/*Use smaller sources of daily mp restore to bump available MP*/
int minor_mp_restore()
{
	if(!rest_in_chateau())
		use_oscus_soda();
	return 0;
}