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

/* Get a nun massage */
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

/* Use nuns to retore close to maxmp */
void nun_multiRestore()
{
	int nun_visits = min(3, (my_maxmp() - my_mp())/1000) - get_property("nunsVisits").to_int();
	print("Could visit nun " + nun_visits + " times", "blue");
	for x from 1 to nun_visits
		get_nun_massage();
}

/* Use psychokinetic energy blob */

boolean use_energyBlob()
{
	if((my_maxmp()-my_mp()) < 30 || item_amount($item[psychokinetic energy blob]) == 0)
	{
		print("Cannot use psychokinetic energy blob", "blue");
		return false;
	}
	else
	{
		use(1, $item[psychokinetic energy blob]);
		return true;
	}
}

/* Use Grogpagne */
boolean use_grogpagne()
{
	if((my_maxmp()-my_mp()) < 40 || item_amount($item[grogpagne]) == 0)
	{
		print("Cannot use grogpagne", "blue");
		return false;
	}
	else
	{
		use(1, $item[grogpagne]);
		return true;
	}
}

/*Use smaller sources of daily mp restore to bump available MP*/
void minor_mp_restore()
{
	if(!rest_in_bed())
		if(!use_oscus_soda())
			if(!get_nun_massage())
				if(!use_energyBlob())
					use_grogpagne();
}