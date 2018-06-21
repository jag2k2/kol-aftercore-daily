/*Checking total remaining free rests*/
boolean rest_in_bed()
{
	int rests_used = get_property("timesRested").to_int();
	int rests_left = total_free_rests() - rests_used;					//total_free_rests() is a kolmafia function
	print("You have " + rests_left + " free rests remaining", "blue");
	
	if (rests_left > 0)
	{
		if(get_property("chateauAvailable")==true)	
			visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
		else
			visit_url("campground.php?action=rest");
		return true;
	}
	else	
		return false;
}

/*Use Oscus Neverending Soda*/
boolean use_oscus_soda()
{
	if(item_amount($item[Oscus's neverending soda]).to_int() == 0)
	{
		print("Do not have Oscus's neverending soda", "blue");
		return false;
	}
	else
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
}

/*Get a nun massage*/
boolean get_nun_massage()
{
	if(get_property("sidequestNunsCompleted")!="fratboy" || get_property("warProgress")!="finished")
	{
		print("Cannot heal at the nunnery", "blue");
		return false;
	}
	else
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
}

/*Use Grogpagne*/
boolean use_grogpagne()
{
	if((my_maxmp()-my_mp()) < 40)
	{
		print("Your mp level is within 40mp of your max", "blue");
		return false;
	}
	else
	{
		retrieve_item(1, $item[grogpagne]);
		use(1, $item[grogpagne]);
		return true;
	}
}

/*Use smaller sources of daily mp restore to bump available MP*/
int minor_mp_restore()
{
	if(!rest_in_bed())
		if(!use_oscus_soda())
			if(!get_nun_massage())
				use_grogpagne();
	return 0;
}