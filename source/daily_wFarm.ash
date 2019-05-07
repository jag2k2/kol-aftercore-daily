import DailyMpRestore.ash
import DailyUseCasts.ash
import DailyFreeFights.ash
import MeatFarmDinsey.ash
import DailyNoms.ash
import Outfit Manager.ash
import DailyMallSales.ash
import Meat Buff Manager.ash

void main()
{
	if(property_exists("_dailyDone"))
		print("Daily scripts already run today", "blue");
	else
	{
		if(my_name()=="jag2k2")
		{
			if(!property_exists("_dailyDoneZed"))
			{
				set_property("_dailyDoneZed", "true");
				cli_execute("login zeddemore");
			}
			if(!property_exists("_dailyDoneBoba"))
			{
				set_property("_dailyDoneBoba", "true");
				cli_execute("login Boba the Fett");
			}
			
			if(my_inebriety() > inebriety_limit())
				print("jag2k2 is too drunk to adventure anymore", "blue");
			else
			{	
				check_cheap_mall_item();
				daily_chores();
				
				//sweet_synthesis(15);
				//cast_ancestralRecalls();
				//use_classChocolates();				
				
				nom_noms("hi mein", true);							// Do this before free fights to get extra hunger space from pantsgiving

				free_fight_prep();
				outfit_manager("Free Fight");
				fight_freely();

				nom_noms("jumping horseradish", false);	
				nom_noms("Ambitious Turkey", false);
				nom_noms("perfect booze", true);
				nom_noms("1-size epic booze", true);
				nom_noms("4-size spleen", true);
				nom_noms("3-size spleen", false);
				
				meat_farm_prep();

				outfit_manager("Min MP Cost");
				self_buff_meat_effects(my_adventures());
				meatFarm_base_potions(my_adventures());
				use_skill(1, $skill[Drescher's Annoying Noise]);	// Bump up ML to make embezzlers last a few more rounds each
				use_skill(1, $skill[Pride of the Puffin]);			
				
				outfit_manager("Max MP");
				nun_multiRestore();									// Use the nuns as much as makes sense
				generate_brickoEyeBricks();							// Cast Bricko libram until you get 3 bricko eye bricks
				generate_resolutions(100);
				
				use_mallMeatPotions();								// A list of buffs are defined in a text file and their use is determined by current profitability
				use_recipeBasedMeatBuffs();							// Buffs like demon summon and papier-mache toothpicks where components might need to be bought
				once_daily_meatBuffs();								// LOVE Tunnel restores all MP
				generate_resolutions(100);
				use_license();										// Get 5 adv and restore all MP
				generate_resolutions(100);
				use_express_card();									// Extend all buffs by 5 and restore all MP
				generate_resolutions(50);	

				outfit_manager("Embezzler Farm");					// Equip outfit for Embezzler Farming
				farm_emezzler_copies();								// Fight chain of copied embezzlers and create all wandering embezzlers

				outfit_manager("BM Farm");							// Go back to default meat farming outfit				
				int num_adv = my_adventures();

				farm_barf_mountain(num_adv);
	
				if(have_effect($effect[Fat Leon's Phat Loot Lyric]) > 0)
					cli_execute("uneffect Fat Leon's Phat Loot Lyric");
				if(have_effect($effect[Ode to Booze]) < 10)
					use_skill(1, $skill[The Ode to Booze]);
				
				use_familiar($familiar[Stooper]);
				nom_noms("1-size epic booze", false);
				
				overdrink(1, $item[cherry bomb]);
				if(item_amount($item[tiny plastic sword]) > 0)		// Just to ensure mafia doesn't try and purchase a tps from the mall
					cli_execute("mix cherry bomb");
				if(have_effect($effect[Ode to Booze]) > 0)
					cli_execute("uneffect Ode to Booze");
				outfit_manager("PJs");
				daily_put_into_mall();
			}			
		}
		
		if(my_name()=="zeddemore")
		{
			if(my_inebriety() > inebriety_limit())
				print("Zeddemore is too drunk to adventure anymore", "blue");
			else
			{
				outfit("Max MP");
				meat_farm_cast_buffs(500);
				nom_noms("hi mein", true);
				nom_noms("perfect booze", true);
				nom_noms("1-size awesome booze", true);
				nom_noms("4-size spleen", true);
				nom_noms("3-size spleen", true);
				outfit("volcano mining");
				harvest_velvet_gold_mine(my_adventures(), true);
				
				outfit("Adventure Pajamas");
				if(have_effect($effect[Ode to Booze]) < 10)
					use_skill($skill[The Ode to Booze]);
				retrieve_item(1, $item[Psychotic Train Wine]);
				overdrink(1, $item[Psychotic Train Wine]);
			}	
			print("Zed done", "blue");
			cli_execute("login jag2k2");
		}
			
		if(my_name()=="Boba the Fett")
		{			
			if(my_inebriety() > inebriety_limit())
				print("Boba the Fett is too drunk to adventure anymore", "blue");
			else
			{
				outfit("Max MP");
				meat_farm_cast_buffs(500);
				nom_noms("hi mein", true);
				nom_noms("perfect booze", true);
				nom_noms("1-size awesome booze", true);
				nom_noms("4-size spleen", true);
				nom_noms("3-size spleen", true);
				outfit("volcano mining");
				harvest_velvet_gold_mine(my_adventures(), true);
				
				outfit("Adventure Pajamas");
				if(have_effect($effect[Ode to Booze]) < 10)
					use_skill($skill[The Ode to Booze]);
				retrieve_item(1, $item[Psychotic Train Wine]);
				overdrink(1, $item[Psychotic Train Wine]);
			}
			print("Boba done", "blue");
			cli_execute("login jag2k2");
		}
		set_property("_dailyDone", "true");
		//cli_execute("exit");
	}	
}

