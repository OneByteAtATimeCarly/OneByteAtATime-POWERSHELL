#Title: PowerShell - Module 07 - Classes - RPG "A Knight in the Darkness" Part 3
#       Using an Inheritance Hierarchy - Writing Function that use Base/Parent and Derived/Child Classes
#Author: Carly S. Germany
#Date: 06/25/2020
#Last Modified: 07/06/2020 

#********************************************************************************************
# A. Globals and Constants
#********************************************************************************************

#Constants - Dammage and Defense
[int] $c_CombatPause = 3000;
[int] $global:MaxDammage = 50;
[int] $global:DaggerDammage = 11;
[int] $global:BOStaffDammage = 10;
[int] $global:LongBowDammage = 16;
[int] $global:CrossBowDammage = 18;
[int] $global:BroadSwordDammage = 20;
[int] $global:MagicFireDammage = 20;
[int] $global:MagicFireCost = 20;
[int] $global:MagicIceDammage = 10;
[int] $global:MagicIceCost = 10;
[int] $global:MagicLightningDammage = 30;
[int] $global:MagicLightningCost = 30;
[int] $global:MagicTelekineticDammage = 40;
[int] $global:MagicTelekineticForceCost = 40;
[int] $global:MagicInvisibilityDefense = 50;
[int] $global:MagicInvisibilityCost = 30;
[int] $global:MagicInvisibilityDuration = 5;
[int] $global:MagicHealingAmount = 20;
[int] $global:MagicHealingCost = 30;
[int] $global:HealthPotion_Restore_Amt = 10;

#Constants - Location
[int] $c_QUIT = 0;
[int] $c_INTRO = 1;
[int] $c_C1 = 2;
[int] $c_N1 = 3;
[int] $c_S1 = 4;
[int] $c_E1 = 5;
[int] $c_W1 = 6;
[int] $c_N2 = 7;
[int] $c_S2 = 8;
[int] $c_E2 = 9;
[int] $c_W2 = 10;
[int] $c_GATE =11;
[int] $c_SHAMANS_HUT = 12;
[int] $c_UNDERGRND = 13;

#Constants - Weapons/Inventory
[int] $global:Nothing = 0;
[int] $global:BroadSword = 1;
[int] $global:Dagger = 2;
[int] $global:CrossBow = 3;
[int] $global:LongBow = 4;
[int] $global:Staff = 5;

#Constants - Magic
[int] $global:No_Magic = 0;
[int] $global:Fire = 1;
[int] $global:Ice = 2;
[int] $global:Lightning = 3;
[int] $global:TelekineticForce = 4;
[int] $global:Invisibility = 5;
[int] $global:Healing = 6;

#Constants - Armor
[int] $global:No_Armor = 0;
[int] $global:CHAIN_MAIL = 5;
[int] $global:PLATE_MAIL = 10;

[int] $global:location;

#Global Booleans for Inventory Items
[boolean] $global:CENTERFirstTime;
[boolean] $global:FoundHealingPotion;
[boolean] $global:S1DragonAlive;
[boolean] $global:E1DragonAlive;
[boolean] $global:W1GiantAlive;
[boolean] $global:FirstTimeInShamanHut;
[boolean] $global:FoundHP_Shaman;
[boolean] $global:UNDERDragonPairAlive;
[boolean] $global:S2MotleyCrewAlive;
[boolean] $global:FoundHP_West2;

#Global Character and Monster Objects
$global:The_Player;
$global:WiseWoman;


#********************************************************************************************
# B. Classes
#********************************************************************************************

<# ------------------------------------------------------------------- #>
# BASE Class ADT (Abstract Data Type)
<# ------------------------------------------------------------------- #>

class ENTITY
{
      #Private Data Members
      [int] $HP;
      [int] $ATK;
      [int] $DEF;
      [int] $EXP;
      [int] $WeaponChoice;
      [int] $WeaponDammage;
      [int] $MagicChoice;
      [int] $MagicDammage;
      [int] $MagicCost;
      [int] $ArmorChoice;
      [String] $ENTITY_CLASS;
      [String] $NAME;
      [String] $Gender;
      [int] $InvisibilityCount; 
      [int] $MagicEnergy; 
      [boolean] $FirstTimeShowOpponentInfo;

      #Constructor
      ENTITY() 
      { 
           Write-Host("Creating an ENTITY object."); 
           $this.ENTITY_CLASS = "ENTITY"; 
           $this.HP = 100;
           $this.ATK = 5;
           $this.DEF = 5;
           $this.EXP = 1;
           $this.WeaponChoice = $global:Nothing;
           $this.MagicChoice = $global:No_Magic;
           $this.ArmorChoice = $global:No_Armor;
           $this.ENTITY_CLASS = "ENTITY";
           $this.NAME = "Anonymous"; 
           $this.Gender = "Female";
           $this.InvisibilityCount = 0;
           $this.MagicEnergy = 500;
           $this.FirstTimeShowOpponentInfo = $true; 
      }

      #Accessor Methods
      #----------------------------------------------
      Set_Armor($Armor)
      {
          switch($Armor)
          {
              $global:No_Armor { $this.ArmorChoice = $global:No_Armor; }
              $global:CHAIN_MAIL {  $this.ArmorChoice = $global:CHAIN_MAIL;
                                    $this.DEF += 5;
                                 }
              $global:PLATE_MAIL {  $this.ArmorChoice = $global:PLATE_MAIL;
                                    $this.DEF += 10;
                                 }
          }
      }
      [int] Get_Armor() { return $this.ArmorChoice; }

      #Member Methods
   #----------------------------------------------

      DisplayStats()
      {
           [String] $STATS = 
           "`n ---------------------STATS----------------------" +
           "`n     Name: " + $this.NAME + 
           "`n     Gender: " + $this.Gender + 
           "`n     HP: " + $this.HP +
           "`n     Attack: " + $this.ATK +
           "`n     Defense: " + $this.DEF +
           "`n     Experience: " + $this.EXP +
           "`n     Class: " + $this.ENTITY_CLASS;
           
           $STATS += "`n     Selected Weapon: ";
           
           switch($this.WeaponChoice)
           {
               $global:Nothing {$STATS += "Nothing but ";

                               if($this.Gender -EQ "Male") 
                               { $STATS += "his"; }
                               else
                               { $STATS += "her"; }

                               $STATS += " fists!"; 
                               break;
                               }
               $global:BroadSword { $STATS += "BroadSword"; break; }
               $global:Dagger { $STATS += "Dagger"; break; }
               $global:Staff { $STATS += "Staff"; break; }
               $global:CrossBow { $STATS += "CrossBow"; break; }
               $global:LongBow { $STATS += "LongBow"; break; }
               default { $STATS += "`nBad Input!"; break; }                   
           }   

           $STATS += "`n     Selected Armor: ";
           
           switch($this.ArmorChoice)
           {
                $global:No_Armor { $STATS += " No Armor"; break; }
                $global:CHAIN_MAIL { $STATS += "Chain Mail (+5 DEF)"; break; }
                $global:PLATE_MAIL { $STATS += "Plate Mail (+10 DEF)"; break; }
                default { $STATS += "`nBad Input!"; break; }                   
           }   
           
           $STATS += "`n     Selected Magic: ";
           
           switch($this.MagicChoice)
           {
                $global:No_Magic { $STATS += "None"; break; }
                $global:Fire { $STATS += "Fire"; break; }
                $global:Ice { $STATS += "Ice"; break; }
                $global:Lightning { $STATS += "Lightning"; break; }
                $global:TelekineticForce { $STATS += "TelekineticForce"; break; }
                $global:Invisibility { $STATS += "Invisibility"; break; }
                $global:Healing { $STATS += "Healing"; break; }           
                default { $STATS += "`nBad Input!"; break; }      
           }   

           $STATS += "`n     Magic Energy: " + $this.MagicEnergy;
                   
           $STATS += "`n ------------------------------------------------`n";
           
           Write-Host($STATS);               
      } 

   #----------------------------------------------  
   
      Attack([ENTITY] $Opponent)
      {   
           [String] $MESSAGE = "";

           $MESSAGE ="`n`nBeginning " + $this.NAME + "'s ENTITY attack sequence ...`n";
           $MESSAGE += "`n----------------------------- " + $this.NAME + "'s Attack -----------------------------`n";
           Write-Host($MESSAGE);
           Start-Sleep -s 1;
           $MESSAGE = "";

           #Display Opponent's Stats, but only in first round of combat. Then turn off.
           if($this.FirstTimeShowOpponentInfo -EQ $true)
           {
               Write-Host("`nOpponent's Information:");
               $Opponent.DisplayStats();
               Start-Sleep -s 4;
               $this.FirstTimeShowOpponentInfo = $false;
           }

           $MESSAGE += "`n " + $Opponent.NAME + "'s HP BEFORE " +
           $this.NAME + "'s attack: " + $Opponent.HP + "`n";

           Write-Host($MESSAGE);
           Start-Sleep -s 2;
           $MESSAGE = "";
  
           [int] $Dammage = Get-Random -Minimum 1 -Maximum ($global:MaxDammage + 1);
           
           #Derived Character Classes that can use Weapons
           if($this.ENTITY_CLASS -EQ "WARRIOR" -OR
              $this.ENTITY_CLASS -EQ "FIGHTER" -OR
              $this.ENTITY_CLASS -EQ "ELF")
           {
              $MESSAGE += " Weapon Attack: " + $this.NAME;
           
              switch($this.WeaponChoice)
              {
                  $global:Nothing { $this.WeaponDammage = 0;
                                    $MESSAGE += " fights with bare fists of fury!`n"; 
                                    break; 
                                  } 
                                
                  $global:Dagger { $this.WeaponDammage = $global:DaggerDammage; 
                                   $MESSAGE += " stabs with the dagger! Squish!`n"; 
                                   break; 
                                 }

                  $global:Staff { $this.WeaponDammage = $global:BOStaffDammage;
                                  $MESSAGE += " twirls the BO staff. Crack!`n"; 
                                  break;
                                }

                  $global:LongBow { $this.WeaponDammage = $global:LongBowDammage;
                                    $this.Arrows -= 1;
                                    $MESSAGE += " fires an arrow from the long bow! Zzzzt!";
                                    $MESSAGE += "`n Remaining arrows: " + $this.Arrows + "`n";
                                    break;
                                  }
                                                               
                  $global:CrossBow { $this.WeaponDammage = $global:CrossBowDammage;
                                     $this.Arrows -= 1;
                                     $MESSAGE += " fires a bolt from the crossbow! Twang!`n";
                                     $MESSAGE += "`n Remaining arrows: " + $this.Arrows + "`n";
                                     break;
                                   }
                                              
                  $global:BroadSword { $this.WeaponDammage = $global:BroadSwordDammage;
                                       $MESSAGE += " swings the broadsword with all their might! Slash!`n";
                                       break; 
                                     }

                  default { Write-Host("`nInvalid Input!"); break; } 
                                 
              }#close switch 

              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";



           }#close if

           $MESSAGE += " A random amount of [" + $Dammage + "] dammage was generated " + 
                          "by " + $this.NAME + "'s experience and luck.";
           Write-Host($MESSAGE);
           Start-Sleep -s 3;

           $Dammage += $this.ATK;
           $MESSAGE = " " + $this.NAME + "'s ATK combat skills add another [" + $this.ATK +
                          "] dammage to this, making it [" + $Dammage + "]."
           Write-Host($MESSAGE);
           Start-Sleep -s 3;

           #If class entity can use weapons?
           if($this.ENTITY_CLASS -EQ "WARRIOR" -OR
              $this.ENTITY_CLASS -EQ "FIGHTER" -OR
              $this.ENTITY_CLASS -EQ "ELF" -and
              $this.WeaponChoice -NE $global:Nothing)
           {
              $Dammage += $this.WeaponDammage;
              $MESSAGE = " " + $this.NAME + "'s weapon increases ";
              if($this.Gender -EQ "Male") { $MESSAGE += "his"; }
              else  { $MESSAGE += "her"; }
              $MESSAGE += " attack by [" + $this.WeaponDammage + 
              "] for a total of ";
              $MESSAGE += "[" + $Dammage + "] damage.`n";
              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";
           }

           #Derived Character Classes that can use Magic Attacks
           if($this.ENTITY_CLASS -EQ "MAGE" -OR
              $this.ENTITY_CLASS -EQ "SHAMAN" -OR
              $this.ENTITY_CLASS -EQ "ELF") 
           {
              $MESSAGE = "`n Magic Use: " + $this.NAME;
              
              switch($this.MagicChoice)
              {
                  $global:No_Magic { $this.MagicDammage = 0;
                                     $this.MagicCost = 0;
                                     $MESSAGE += " uses no magic and fights with bare fists of fury!"; break; 
                                   }

                  $global:Fire { $this.MagicDammage = $global:MagicFireDammage;
                                 $this.MagicCost = $global:MagicFireCost;
                                 $MESSAGE += " blasts a fire ball at their opponent " +
                                 "burning an`n additional " + $global:MagicFireDammage +
                                 " points of damage into them! Sizzle ...";
                                 break; 
                               }

                  $global:Ice { $this.MagicDammage = $global:MagicIceDammage;
                                $this.MagicCost = $global:MagicIceCost;
                                $MESSAGE += " lowers the ambient temperature around " +
                                "their opponent,`n freezing their internal organs" +
                                " at -" + $global:MagicIceDammage + " health. Brrr ...";
                                break;
                              }

                 $global:Lightning { $this.MagicDammage = $global:MagicLightningDammage
                                     $this.MagicCost = $global:MagicLightningCost;
                                     $MESSAGE += " blasts their opponent with a lightning " +
                                     " bolt!`n This ionizes their molecules and strips away" +
                                     " -" + $global:MagicLightningDammage + " health! Zzzzzt!";
                                     break;
                                   }

                 $global:TelekineticForce {  $this.MagicDammage = $global:MagicTelekineticDammage;
                                             $this.MagicCost = $global:MagicTelekineticForceCost;
                                             $MESSAGE += " telekinetically throws a massive amount" +
                                             " of force`n at their opponent, crushing -" +
                                             $global:MagicTelekineticDammage + " health from their" +
                                             " skull! Snap! ..."
                                             break; 
                                          }
                                  
              }#close switch

              if($this.MagicChoice -NE $global:Invisibility -AND
                 $this.MagicChoice -NE $global:Healing -AND
                 $this.MagicChoice -NE $global:No_Magic)
              {
                   Write-Host($MESSAGE);
                   Start-Sleep -s 3;
                   $MESSAGE = "";

                   if($this.MagicEnergy -GE $this.MagicCost)
                   {
                       $Dammage += $this.MagicDammage;
                       $MESSAGE += "`n This forceful burst of magic costs " +
                       $this.MagicCost + " units of magical energy.";
                       Write-Host($MESSAGE);
                       Start-Sleep -s 3;
                       $MESSAGE = "";
                       $this.MagicEnergy -= $this.MagicCost;
                       $MESSAGE += " But it increases "
                       if($this.Gender -EQ "Male") { $MESSAGE += "his"; }
                       else  { $MESSAGE += "her"; }
                       $MESSAGE += " attack by " + $this.MagicDammage + 
                       " for a total of ";
                       $MESSAGE += "" + $Dammage + " damage.`n";
                   }
                   else
                   {
                       $MESSAGE += "`n`nNOT! " + $this.NAME + " doesn't have enough" +
                       " magical energy to pull this off. Fizzle ..."
                   }
              }

              #If Character activated Invisibility
              if($this.InvisibilityCount -GT 0)
              {
                  $MESSAGE += "`n " + $this.NAME +  " has " + $this.InvisibilityCount +
                  " rounds of INVISIBILITY left.";

                  $this.InvisibilityCount--;

                  if($this.InvisibilityCount -LE 0) 
                  { $this.DEF -= $global:MagicInvisibilityDefense; } 
              }

              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";
                            
           }#close if 


           #After ATTACK choices/variations calculate final damage/prevent negative values

           $MESSAGE = " " + $Opponent.NAME + "'s DEFENSIVE skills reduce their " +
                      "dammage by " + $Opponent.DEF + ".";

           Write-Host($MESSAGE);

           if($Dammage -GT $Opponent.DEF)
           { $Dammage -= $Opponent.DEF; }
           else 
           { $Dammage = 0; }

           if($Opponent.HP - $Dammage -GT 0)
           { $Opponent.HP -= $Dammage; }
           else 
           { $Opponent.HP = 0; }

           Write-Host("`n  AFTER this attack sequence:");

           Write-Host("  " + $this.NAME + "'s Final HP: " + $this.HP + "");
           Write-Host("  " + $Opponent.NAME + "'s Final HP: " + $Opponent.HP + "");
           Start-Sleep -s 2;

      }#close function
                                                   
}#close class

<# ------------------------------------------------------------------- #>
# Derived classes that inherit from BASE class ADT "ENTITY"
<# ------------------------------------------------------------------- #>

# A child class of ENTITY and intermidiate ADT for Dragon and Giant objects

class Monster : ENTITY
{
      #Constructor
      Monster() 
      { 
         Write-Host("Creating a Monster object."); 
         $this.ENTITY_CLASS = "MONSTER"; 
      }  
}

<# ------------------------------------------------------------------- #>

class Dragon : Monster
{
      #Data Members
      [boolean] $Breath_FIRE;
      [boolean] $Breath_ICE;
      [boolean] $Breath_ACID;
      [int] $Treasure;

      #Constructor
      Dragon() 
      { 
          Write-Host("Creating a Dragon object."); 
          $this.ENTITY_CLASS = "DRAGON";
          $this.Gender = "Female";
          $this.Breath_FIRE = $true;
          $this.Treasure = 3000;
      } 

      #Member Methods
      BreathAttack()
      { Write-Host("`n Deploying breath weapon!"); }     
}

<# ------------------------------------------------------------------- #>

class Giant : Monster
{
      #Data Members
      [boolean] $Club;
      [int] $Treasure;

      #Constructor
      Giant() 
      { 
          Write-Host("Creating a Giant object."); 
          $this.ENTITY_CLASS = "GIANT";
          $this.Gender = "Male";
          $this.Club = $true;
          $this.Treasure = 750;
      } 

      #Member Methods
      Club_Opponent()
      { Write-Host("`n Clubbing opponent!"); }       
}

<# ------------------------------------------------------------------- #>

# A child class of ENTITY and intermidiate ADT for Shaman, Mage, Elf, Fighter, etc.

class Character : ENTITY
{
      #Data Members
      [boolean] $Has_BroadSword;
      [boolean] $Has_Dagger;
      [boolean] $Has_Staff;      
      [boolean] $Has_CrossBow;
      [boolean] $Has_LongBow;
      [boolean] $Has_ChainMail;
      [boolean] $Has_PlateArmor;
      [boolean] $Has_FishKey;  
      [boolean] $Has_Fire;
      [boolean] $Has_Ice;
      [boolean] $Has_Lightning;
      [boolean] $Has_TelekineticForce;
      [boolean] $Has_Invisibility;
      [boolean] $Has_Healing;
      [int] $Arrows;
      [int] $HealingPotion;

      #Constructor
      Character()
      {
           Write-Host("Creating a Character object."); 
           $this.ENTITY_CLASS = "CHARACTER"; 

           #Initalize Inventory and Magic
           $this.Has_BroadSword = $false;
           $this.Has_Dagger = $false;
           $this.Has_Staff = $false;
           $this.Has_CrossBow = $false;
           $this.Has_LongBow = $false;
           $this.Has_ChainMail = $false;
           $this.Has_PlateArmor = $false;
           $this.Has_FishKey = $false;
           $this.Has_Fire = $false;
           $this.Has_Ice = $false;
           $this.Has_Lightning = $false;
           $this.Has_TelekineticForce = $false;
           $this.Has_Invisibility = $false;
           $this.Has_Healing = $false;
           $this.Arrows = 0; 
           $this.HealingPotion = 0;
      }

      #Member Methods
 #----------------------------------------------

     CHEAT()
     {
           Write-Host("`n You CHEATER! Hidden cheat function activated.`n");
           $this.Has_BroadSword = $true;
           $this.Has_Dagger = $true;
           $this.Has_Staff = $true;
           $this.Has_CrossBow = $true;
           $this.Has_LongBow = $true;
           $this.Has_ChainMail = $true;
           $this.Has_PlateArmor = $true;
           $this.Has_FishKey = $true;
           $this.Has_Fire = $true;
           $this.Has_Ice = $true;
           $this.Has_Lightning = $true;
           $this.Has_TelekineticForce = $true;
           $this.Has_Invisibility = $true;
           $this.Has_Healing = $true;
           $this.Arrows = 5000; 
           $this.HealingPotion = 5000;
           $this.HP = 10000;
           $this.ATK = 200;
           $this.DEF = 200;
           $this.MagicEnergy = 10000;
           $this.Set_Armor($global:PLATE_MAIL);
           $this.WeaponChoice = $global:BroadSword;
           $this.MagicChoice = $global:TelekineticForce;
           $this.DisplayStats(); 
           $this.DisplayInventory();
           $this.DisplayMagic(); 
                             
     }#close member-method

 #----------------------------------------------

      DisplayInventory()
      {
           [int] $ItemCount = 0;
           [String] $Inventory = "";

           $Inventory = "`n  ----------------------Inventory---------------------";

           if($this.Has_BroadSword) 
           {    
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (B)roadsword";
           }
   
           if($this.Has_Dagger) 
           { 
              $ItemCount++;
              $Inventory += "`n  " + $ItemCount + ". (D)agger"; 
           }

           if($this.Has_Staff) 
           { 
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (S)taff"; 
           }
 
           if($this.Has_CrossBow) 
           { 
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (C)rossBow"; 
           }
 
            if($this.Has_LongBow) 
           { 
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (L)ongBow"; 
           }
           
           if($this.Has_ChainMail) 
           { 
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (M)ail Armor"; 
           }
           
           if($this.Has_PlateArmor) 
           { 
                $ItemCount++;
                $Inventory += "`n  " + $ItemCount + ". (P)late Armor"; 
           }   
           
           if($this.Has_FishKey) 
           { 
              $ItemCount++;        
              $Inventory += "`n  " + $ItemCount + ". (F)ishKey"; 
           } 
           
           if($this.Arrows -GT 0) 
           {   
               $ItemCount++;            
               $Inventory += "`n  " + $ItemCount + ". (A)rrows: ";
               $Inventory += "" + $this.Arrows; 
           }       
           
           if($this.HealingPotion -GT 0)           
           {   
               $ItemCount++;
               $Inventory += "`n  " + $ItemCount + ". (H)ealing Potions: "; 
               $Inventory += "" + $this.HealingPotion; 
           }
           
           if($this.Has_BroadSword -EQ $false -AND $this.Has_Dagger -EQ $false -AND 
              $this.Has_Staff -EQ $false -AND $this.Has_CrossBow -EQ $false -AND 
              $this.Has_LongBow -EQ $false -AND $this.Has_ChainMail -EQ $false -AND 
              $this.Has_PlateArmor -EQ $false -AND $this.Has_FishKey -EQ $false -AND 
              $this.Arrows -EQ 0 -AND $this.HealingPotion -EQ 0)
           {    
                $Inventory += "`n`n                  Absolutely NOTHING!`n";
                #Write-Host("NOTHING!!!"); 
           }

           $Inventory += "`n  ----------------------------------------------------";

           Write-Host($Inventory);  

      }#close member-method

 #----------------------------------------------

      UseItem()
      {
           [String] $CHOICE = " ";
           Write-Host("`n  ------------BEFORE Inventory Selection------------");

           $MESSAGE = "`n  Currently Selected Weapon: ";
           
           switch($this.WeaponChoice)
           {
               $global:Nothing {$MESSAGE += "Nothing but ";

                               if($this.Gender -EQ "Male") 
                               { $MESSAGE += "his"; }
                               else
                               { $MESSAGE += "her"; }

                               $MESSAGE += " fists!"; 
                               break;
                               }
               $global:BroadSword { $MESSAGE += "BroadSword"; break; }
               $global:Dagger { $MESSAGE += "Dagger"; break; }
               $global:Staff { $MESSAGE += "Staff"; break; }
               $global:CrossBow { $MESSAGE += "CrossBow"; break; }
               $global:LongBow { $MESSAGE += "LongBow"; break; }
               default { $MESSAGE += "`nBad Input!"; break; }                   
           }   

           $MESSAGE += "`n  Currently Selected Armor: ";
           
           switch($this.ArmorChoice)
           {
                $global:No_Armor { $MESSAGE += " No Armor"; break; }
                $global:CHAIN_MAIL { $MESSAGE += "Chain Mail (+5 DEF)"; break; }
                $global:PLATE_MAIL { $MESSAGE += "Plate Mail (+10 DEF)"; break; }
                default { $MESSAGE += "`nBad Input!"; break; }                   
           }   

           Write-Host($MESSAGE);
           $this.DisplayInventory();

           $CHOICE = (Read-Host("`n  Which item do you wish to use? (`"q`" = quit)")).ToLower();

           switch($CHOICE[0])
           {
               'b' {  if($this.Has_BroadSword -EQ $true)
                      { 
                          Write-Host("`n  Shwing! You unsheath your mighty broad sword!");
                          $this.WeaponChoice = $global:BroadSword;
                      }
                      else
                      {   Write-Host("`n  Sorry, you have no broadsword.");  }
                      break; 
                   }

               'd' {  if($this.Has_Dagger -EQ $true)
                      { 
                          Write-Host("`n  Ffwpt! You take our your dagger!");
                          $this.WeaponChoice = $global:Dagger;
                      }
                      else
                      {  Write-Host("`n  Sorry, you have no dagger.");  }
                      break; 
                   }

               's' {  if($this.Has_Staff -EQ $true)
                      { 
                         Write-Host("`n  You twirl your BO staff like a boss. It whips the air. Crack!");
                         $this.WeaponChoice = $global:Staff; 
                      }
                      else
                      {  Write-Host("`n  Sorry, you have no BO staff.");  }
                      break; 
                   }

               'c' {  if($this.Has_CrossBow -EQ $true)
                      { 
                         Write-Host("`n  You pull out your mighty CrossBow ") -NoNewline;
                         if($this.Arrows -GT 0)
                         { 
                             Write-Host("and prime it with an arrow."); 
                         }
                         else
                         {   
                             Write-Host("... If only you had some ARROWS?" +
                                        "`n  CrossBow is USELESS without them."); 
                             
                         }

                         $this.WeaponChoice = $global:CrossBow;                          
                      }
                      else
                      {  Write-Host("`n  Sorry, you have no CrossBow.");  }
                      break; 
                   }

               'l' {  if($this.Has_LongBow  -EQ $true)
                      { 
                         Write-Host("`n  You pull out your trusty LongBow ") -NoNewline;
                         if($this.Arrows -GT 0)
                         {  
                             Write-Host("and load an arrow."); 
                         }
                         else
                         {  
                             Write-Host("... If only you had any ARROWS?" +
                                        "`n  LongBow is POINTLESS without them.");
                              
                         }

                         $this.WeaponChoice = $global:LongBow;                          
                      }
                      else
                      {  Write-Host("`n  Sorry, you have no LongBow .");  }
                      break; 
                   }

               'm' {  if($this.Has_ChainMail)
                      { 
                          if($this.ArmorChoice -EQ $global:No_Armor)
                          {
                              Write-Host("`n  You put on the chain mail armor!");
                              $this.Set_Armor($global:CHAIN_MAIL);
                          }
                          elseif($this.ArmorChoice -EQ $global:PLATE_MAIL)
                          {
                              Write-Host("`n  You take off the plate mail armor.");
                              $this.DEF -= 10;
                              Write-Host("  You put on the chain mail armor. WHY?!?!");
                              $this.Set_Armor($global:CHAIN_MAIL);                          
                          }    
                          elseif($this.ArmorChoice -EQ $global:CHAIN_MAIL)
                          {  
                              Write-Host("`n  You take off the chain mail armor.");
                              $this.ArmorChoice = $global:No_Armor;
                              $this.DEF -= 5;     
                          }
                      }
                      else
                      {  Write-Host("`n  Sorry, you do not have the chainmail.");  }
                      break; 
                   }

               'p' {  if($this.Has_PlateArmor)
                      { 
                          if($this.ArmorChoice -EQ $global:No_Armor)
                          {
                              Write-Host("`n  You put on the plate mail armor!");
                              $this.Set_Armor($global:PLATE_MAIL);
                          }
                          elseif($this.ArmorChoice -EQ $global:CHAIN_MAIL)
                          {  
                              Write-Host("`n  You take off the chain mail armor.");
                              $this.DEF -= 5;
                              Write-Host("  You put on the plate mail armor.");
                              $this.Set_Armor($global:PLATE_MAIL); 
                                   
                          }
                          elseif($this.ArmorChoice -EQ $global:PLATE_MAIL)
                          {
                              Write-Host("`n  You take off the plate mail armor.");
                              $this.DEF -= 10;
                              $this.Set_Armor($global:No_Armor);                          
                          }    
                      }
                      else
                      {  Write-Host("`n  Sorry, you do not have the plate mail.");  }
                      break; 
                   }

               'h' {  if($this.HealingPotion -GT 0)
                      { 
                          Write-Host("`n  You drink the healing elixir and feel much better!");
                          $this.HP += $global:HealthPotion_Restore_Amt;
                          $this.HealingPotion -= 1;  
                      }
                      else
                      {
                          Write-Host("`n  Sorry, you have no healing potions.");    
                      }
                      break;
                   }

               'q' { Write-Host("  Exiting ..."); }

               default { Write-Host("`n  That's not a valid option here.");  }

           }#close switch

           Write-Host("`n  ------------AFTER Inventory Selection------------");
           $MESSAGE = "`n  Currently Selected Weapon: ";
           
           switch($this.WeaponChoice)
           {
               $global:Nothing {$MESSAGE += "Nothing but ";

                               if($this.Gender -EQ "Male") 
                               { $MESSAGE += "his"; }
                               else
                               { $MESSAGE += "her"; }

                               $MESSAGE += " fists!"; 
                               break;
                               }
               $global:BroadSword { $MESSAGE += "BroadSword"; break; }
               $global:Dagger { $MESSAGE += "Dagger"; break; }
               $global:Staff { $MESSAGE += "Staff"; break; }
               $global:CrossBow { $MESSAGE += "CrossBow"; break; }
               $global:LongBow { $MESSAGE += "LongBow"; break; }
               default { $MESSAGE += "`nBad Input!"; break; }                   
           }   

           $MESSAGE += "`n  Currently Selected Armor: ";
           
           switch($this.ArmorChoice)
           {
                $global:No_Armor { $MESSAGE += " No Armor"; break; }
                $global:CHAIN_MAIL { $MESSAGE += "Chain Mail (+5 DEF)"; break; }
                $global:PLATE_MAIL { $MESSAGE += "Plate Mail (+10 DEF)"; break; }
                default { $MESSAGE += "`nBad Input!"; break; }                   
           }   

           Write-Host($MESSAGE);

      }#close member-method

 #----------------------------------------------

      DisplayMagic()
      {
           [int] $MagicCount = 0;
           [String] $MagicAbilities = "";

           $MagicAbilities += "`n ------------------Magic Abilities-------------------";

           $MagicAbilities += "`n    " + $MagicCount + ". (U)nequip Magic [recharge]";

           if($this.Has_Fire -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". (F)ire";
           }
           if($this.Has_Ice -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". (I)ce";
           }
           if($this.Has_Lightning -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". (L)ightning";
           }
           if($this.Has_TelekineticForce -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". (T)elekinetic Force";
           }
           if($this.Has_Invisibility -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". In(V)isibility";
           }

           if($this.Has_Healing -EQ $true) 
           {    
               $MagicCount++;
               $MagicAbilities += "`n    " + $MagicCount + ". (H)ealing";
           }

           if($this.Has_Fire -EQ $false -AND $this.Has_Ice -EQ $false -AND 
              $this.Has_Lightning -EQ $false -AND $this.Has_TelekineticForce -EQ $false -AND 
              $this.Has_Invisibility -EQ $false -AND $this.Has_Healing -EQ $false)
           {    
              $MagicAbilities += "`n`n  You have no magical abilities yet.`n"; 
           }

           $MagicAbilities += "`n`n  Current Magic Energy: " + $this.MagicEnergy + "";

           $MagicAbilities += "`n  Current Magic Being Used: ";

           switch($this.MagicChoice)
           {
                $global:No_Magic { $MagicAbilities += "None"; break; }
                $global:Fire { $MagicAbilities += "Fire"; break; }
                $global:Ice { $MagicAbilities += "Ice"; break; }
                $global:Lightning { $MagicAbilities += "Lightning"; break; }
                $global:TelekineticForce { $MagicAbilities += "TelekineticForce"; break; }
                $global:Invisibility { $MagicAbilities += "Invisibility"; break; }
                $global:Healing { $MagicAbilities += "Healing"; break; }                
           } 

           $MagicAbilities += "`n-----------------------------------------------------";

           Write-Host($MagicAbilities);

      }#close member-method

 #----------------------------------------------

      UseMagic()
      {
           [String] $CHOICE = " ";
           Write-Host("`n  --------------BEFORE Magic Selection--------------");
           $this.DisplayMagic();

           $CHOICE = (Read-Host("`n  Which magic ability do you want to use? (`"q`" = quit)")).ToLower();

           switch($CHOICE[0])
           {
               'u' {   Write-Host("`n  You un-equip yourself of magic and rest to recharge.");
                       $this.MagicChoice = $global:No_Magic;
                   }

               'f' { if($this.Has_Fire)
                     {
                         if($this.MagicEnergy -GT $global:MagicFireCost)
                         { 
                                 Write-Host("`n  You charge a plasma ball with " +
                                            "magic energy!");

                                 $this.MagicChoice = $global:Fire;
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired" +
                                            " pyrotechnical capabilities?`n  You do not" +
                                            " yet possess enough magic energy to" +
                                            "`n  make use of them.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the Fire ability."); }    
                     break;                   
                   }

               'i' { if($this.Has_Ice)
                     {
                         if($this.MagicEnergy -GT $global:MagicIceCost)
                         { 
                                 Write-Host("`n  You lower the ambient temperature around your " +
                                            "opponent with magic energy!");

                                 $this.MagicChoice = $global:Ice;
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired" +
                                            " ice capabilities?`n  You do not" +
                                            " yet possess enough magic energy to" +
                                            "`n  make use of them.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the Ice ability."); }    
                     break;                   
                   }

               'l' { if($this.Has_Lightning)
                     {
                         if($this.MagicEnergy -GT $global:MagicLightningCost)
                         { 
                                 Write-Host("`n  The air sparks as you build up an enormous " +
                                            "electrical charge`n  with a burst of magic energy!");

                                 $this.MagicChoice = $global:Lightning;
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired" +
                                            " Lightning the ability?`n  You do not" +
                                            " possess enough magic energy to" +
                                            "`n  make use of it.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the Lightning ability."); }    
                     break;                   
                   }

               't' { if($this.Has_TelekineticForce)
                     {
                         if($this.MagicEnergy -GT $global:MagicTelekineticForceCost)
                         { 
                                 Write-Host("`n  You focus magic energy into thoughts of kinetic motion," +
                                            "`n  compressing the molecules surrounding your opppnent like" +
                                            "`n  a giant, invisible crushing hand of incredible strength!");

                                 $this.MagicChoice = $global:TelekineticForce;
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired the " +
                                            "powerful TelekineticForce the ability?`n  You do not" +
                                            " possess enough magic energy to" +
                                            "`n  make any use of it.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the TelekineticForce ability."); }    
                     break;                   
                   }

               'v' { if($this.Has_Invisibility)
                     {
                         if($this.MagicEnergy -GT $global:MagicInvisibilityCost)
                         { 
                             if($this.InvisibilityCount -LE 0)
                             {
                                 Write-Host("`n  You deploy invisibility, bending light around " +
                                            "yourself and`n  increasing your DEFENSE by " +
                                             $global:MagicInvisibilityDefense + " points for " +
                                             $global:MagicInvisibilityDuration + " combat rounds.");

                                 $this.MagicEnergy -= $global:MagicInvisibilityCost;
                                 $this.MagicChoice = $global:Invisibility;
                                 $this.DEF += $global:MagicInvisibilityDefense;
                                 $this.InvisibilityCount = $global:MagicInvisibilityDuration;
                             }
                             else
                             {
                                 Write-Host("`n  You are already using invisibility! You can't`n  activate " + 
                                            "it again when you are already using it.`n  You have " +
                                            $this.InvisibilityCount + " combat rounds of invisibility left.");
                             }
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired the " +
                                            "ability to make yourself Invisibile?`n  You do not" +
                                            " possess enough magic energy to" +
                                            "`n  make any use of it at this time.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the ability to make yourself Invisibile."); }    
                     break;                   
                   }

               'h' { if($this.Has_Healing)
                     {
                         if($this.MagicEnergy -GT $global:MagicHealingCost)
                         { 
                                 Write-Host("`n  You lay hands on yourself and focus your energy towards`n" +
                                            "  your core being. This adds " + $global:MagicHealingAmount + 
                                            " to your health.");

                                 $this.MagicEnergy -= $global:MagicHealingCost;
                                 $this.MagicChoice = $global:Healing;
                                 $this.Hp += $global:MagicHealingAmount;
                         }
                         else
                         {
                                 Write-Host("`n  Sorry, although you have acquired the " +
                                            "ability to HEAL yourselfe?`n  You do not" +
                                            " possess enough magic energy to" +
                                            "`n  successfully do it at this time.");    
                         }
                     }
                     else 
                     { Write-Host("`n  You have not yet acquired the ability to HEAL yourself.`n"); }    
                     break;                   
                   }

           }#close switch

           Write-Host("`n  --------------AFTER Magic Selection--------------");
           $MESSAGE = "`n  Currently Selected Magic: ";
           
           switch($this.MagicChoice)
           {
                $global:No_Magic { $MESSAGE += "None"; break; }
                $global:Fire { $MESSAGE += "Fire"; break; }
                $global:Ice { $MESSAGE += "Ice"; break; }
                $global:Lightning { $MESSAGE += "Lightning"; break; }
                $global:TelekineticForce { $MESSAGE += "TelekineticForce"; break; }
                $global:Invisibility { $MESSAGE += "Invisibility"; break; }
                $global:Healing { $MESSAGE += "Healing"; break; }           
                default { $MESSAGE += "`nBad Input!"; break; }      
           }   

           Write-Host($MESSAGE);

      }#close member-method

 #----------------------------------------------

      UsePotions()
      {
          Write-Host("`n  For use at a later time to expand potion usage ...");
      }

}#close class

<# ------------------------------------------------------------------- #>

#Class for building a derived NPC Object 

class Shaman : Character
{
      #Data Members
      [boolean] $MedicineBag;
      [boolean] $ShamanStaff;

      #Constructor
      Shaman()
      {
           Write-Host("Creating a Shaman object.");
           $this.ENTITY_CLASS = "SHAMAN";
           $this.MedicineBag = $true;
           $this.ShamanStaff = $true;  
      }  

      #Member-Methods
      Heal() 
      { Write-Host("Healing person..."); }  
      
      Talk()
      {
           [int] $SayWhat = Get-Random -Minimum 1 -Maximum (10 + 1);

           Write-Host("`n  The Shaman gazes deeply into your eyes. Obscured by her flowing" +
                      "`n  priestly garments, she turns her head to the side and says:`n"); 

           switch($SayWhat)
           {
               1  { Write-Host("  `"I like wild flowers. They are very beautiful, and their`n" +
                               "   restorative powers are merely a fringe benefit.`"");
                    break;
                  }

               2  { Write-Host("  `"Do not look at the outward appearance of things.`n" +
                               "   character should be judged by what is on the inside.`"")
                    break;
                  }

               3  { Write-Host("  `"Good karma? Bad karma? it's all the same ...`n" +
                               "   Or IS it?`"");
                    break;
                  }

               4  { Write-Host("  `"I have a secret to tell ... But I'll never tell it.`"");
                    break;
                  }

               5  { Write-Host("  `"To unlock the gate between worlds? One needs a KEY.`"");
                    break;
                  }

               6  { Write-Host("  `"You are not from this world! I can see that now.`"");
                    break;
                  }

               7  { Write-Host("  `"You do not yet know it, traveler. But you must`n" +
                               "   seek the key of the accursed sea demon!`"");
                    break;
                  }

               8  { Write-Host("  `"Sometimes? I wish I'd never taken that vow of chastity.`"");
                    break;
                  }

               9  { Write-Host("  `"Do you think I'm pretty? Don't judge a book by its cover!`"");
                    break;
                  }

               10 { Write-Host("  `"Beware the edge of the forest. Giants are afoot!`"");
                    break;
                  }

               default { Write-Host("  `"Uh oh, this should never happen ...`""); break; }

           }

           Write-Host("`n");

      }#close function
       
}#close class

<# ------------------------------------------------------------------- #>

class Warrior : Character
{
      #Constructor
      Warrior()
      {
           Write-Host("Creating a Warrior object.");
           $this.ENTITY_CLASS = "WARRIOR";      
      }       
}

<# ------------------------------------------------------------------- #>

class Mage : Character
{
      #Constructor
      Mage()
      {
           Write-Host("Creating a Mage object.");
           $this.ENTITY_CLASS = "MAGE";      
      }       
}

<# ------------------------------------------------------------------- #>

class Fighter : Character
{
      #Constructor
      Fighter()
      {
           Write-Host("Creating a Fighter object.");
           $this.ENTITY_CLASS = "FIGHTER";      
      }        
}

<# ------------------------------------------------------------------- #>

class Elf : Character
{
      #Constructor
      Elf()
      {
           Write-Host("Creating an Elf object.");
           $this.ENTITY_CLASS = "ELF";     
      }        
}      

<# ------------------------------------------------------------------- #>



#********************************************************************************************
# C. FUNCTIONS
#********************************************************************************************

<# ------------------------------------------------------------------- #>

function PAUSE
{
         $null = Read-Host("`n  Hit ENTER to continue.");
}

<# ------------------------------------------------------------------- #>

function MAIN
{
         $global:location = $c_INTRO;

         [String] $CHOICE = " ";

         while($CHOICE[0] -NE 'q')
         {    
              Clear;

              Write-Host("`n`n       A Knight in the Darkness 1.0" +
                         "`n        ©2006 Carly Salali Germany`n");

              Write-Host("`n        --------Main Menu-------" +
                           "`n        |                      |" +
                           "`n        |     (N)ew Game       |" +
                           "`n        |     (L)oad Game      |" + 
                           "`n        |     (S)ave Game      |" +
                           "`n        |     (Q)uit           |" +
                           "`n        |                      |" +
                           "`n        ------------------------`n");

              $CHOICE = (Read-Host("              Choice?")).ToLower();

              switch($CHOICE[0])
              { 
                  'n' { Write-Host("`n`n  Beginning a NEW campaign.");
                        PAUSE;
                        Setup_Character;
                        SwitchBoard;       
                        Write-Host("`n`nEnding game."); 
                        break; 
                      }

                  'l' { $null = Read-Host("`nLOAD GAME. ENTER to continue.");
                        InitializeGlobals;
                        LoadCharacter;
                        if($global:The_Player -NE $null)
                        {
                            SwitchBoard;       
                        }
                        break; 
                      }

                  's' { $null = Read-Host("`nSAVE GAME. ENTER to continue.");
                        SaveCharacter;
                        break; 
                      }

                  'q' { break; }
                  default { $null = Read-Host("Invalid choice. ENTER to continue."); }

              }#close switch

         }#close while true loop

         Write-Host("`n`n  Exiting A Knight in the Darkness 1.0 ...");
         PAUSE;                 
                     
}#close function

<# ------------------------------------------------------------------- #>

function SwitchBoard
{
         while($global:location -NE $c_QUIT)
         {
              switch($global:location)
              {
                 $c_INTRO { INTRODUCTION; break; }
                 $c_C1   { CENTER1; break; }
                 $c_N1   { NORTH1; break; }
                 $c_S1 {  SOUTH1; break; }
                 $c_E1 {  EAST1; break; }
                 $c_W1 {  WEST1; break; }
                 $c_GATE {  GATES; break; }
                 $c_SHAMANS_HUT {  Shamans_Hut; break; }
                 $c_N2 {  NORTH2; break; }
                 $c_S2 {  SOUTH2; break; }
                 $c_E2 {  EAST2; break; }
                 $c_W2 {  WEST2; break; }
                 $c_UNDERGRND {  UnderGroundPassage; break; }       
                 $c_QUIT {  break; }
                 default { Write-Host("`nInvalid value in switchboard."); break; }
  
              }#close switch

         }#close while true loop

}#close function

<# ------------------------------------------------------------------- #>

function Setup_Character
{
         Clear;
         [String] $CHOICE = "";

         Write-Host("`n Decide which type of character you wish to create." +
                   "`n Choose carefully - each type has its own strengths" + 
                   "`n and weaknesses.`n");

         while($CHOICE[0] -NE 'q' -AND 
               $CHOICE[0] -NE 'w' -AND 
               $CHOICE[0] -NE 'm' -AND
               $CHOICE[0] -NE 'f' -AND 
               $CHOICE[0] -NE 'e' -AND
               $CHOICE[0] -NE 's')
         {
               Write-Host("`n Choose your character's class:`n" +
                "`n (W)arrior" +
                "`n (M)age" +
                "`n (F)ighter" +
                "`n (E)lf" +
                "`n (S)haman" +
                "`n (H)elp Me Choose a Character" +
                "`n (Q)uit`n");
          
                $CHOICE = (Read-Host("Choice?")).ToLower();
                Write("`n");

                switch($CHOICE[0])
                {
                    'w' { $global:The_Player = New-Object Warrior; break; }
                    'm' { $global:The_Player = New-Object Mage; break; }
                    'f' { $global:The_Player = New-Object Fighter; break; }
                    'e' { $global:The_Player = New-Object Elf; break; }
                    's' { $global:The_Player = New-Object Shaman; break; }
                    'h' { RoleHelp; break; }
                    'q' { $global:location = $c_QUIT; break; }

                     default { Write-Host("`n Invalid input!`n"); }
                      
                }#close switch

         }#close while true loop

         if($CHOICE[0] -NE 'q') 
         { 
             Write-Host("`n");
             $CHOICE = Read-Host(" Enter a name for your character ");
             $global:The_Player.NAME = $CHOICE;
          
             while($CHOICE[0] -NE 'f' -AND $CHOICE[0] -NE 'm')
             {
                 $CHOICE = Read-Host(" What will be your players gender? (m/f) ");
         
                 switch($CHOICE[0])
                 {
                      'm' { $global:The_Player.Gender = "Male"; break; }
                      'f' { $global:The_Player.Gender = "Female"; break; }
                      default { Write-Host("`n Invalid input!"); break; }    
                 }#close switch

             }#close while true loop

             $global:The_Player.HP = 200;

             InitializeGlobals;

         }#close if
         
}#close function

<# ------------------------------------------------------------------- #>

function InitializeGlobals
{
         $global:FoundHealingPotion = $false;
         $global:S1DragonAlive = $true;
         $global:E1DragonAlive = $true;
         $global:CENTERFirstTime = $true;
         $global:W1GiantAlive = $true; 
         $global:FirstTimeInShamanHut = $true;
         $global:FoundHP_Shaman = $false;
         $global:UNDERDragonPairAlive = $true;
         $global:S2MotleyCrewAlive = $true; 
         $global:FoundHP_West2 = $false; 
         $global:location = $c_INTRO;

}#close function

<# ------------------------------------------------------------------- #>

function INTRODUCTION
{
     InitializeGlobals;
     Clear;

     [String] $MESSAGE = "`n`n`n                   A Knight in the Darkness 1.0`n`n";

     $MESSAGE += "`n   You awake from what appears to be a disturbing dream, knowing" +
                 "`n   neither where you've been? Nor how you got where you are now." +
                 "`n   You slowly rise to your feet, bewildered and almost oblivious" +
                 "`n   to the throbbing ache pulsating between your ringing ears." +
                 "`n   The air surrounding you feels cold and damp.`n" +
                 "`n   As you open your eyes and they grow accustomed to the darkness?" +
                 "`n   You find yourself standing on a flowing grassy knoll amidst" +
                 "`n   dark green hills, towering stone fortresses and distant villages" +
                 "`n   that somewhat resemble the feudal townships and castles of" + 
                 "`n   medieval Scotland.`n" +
                 "`n   In the skies above? Dark gray clouds are passing in billowing," +
                 "`n   whispy tendrils. They randomly shape-shift into obscure patterns." +
                 "`n   As you gaze towards the horizon to the north? You see a storm " + 
                 "`n   approaching from the east.`n" + 
                 "`n   A few black ravens fly over your head towards some unknown" +
                 "`n   destination, their cries echoing softly against the creeping" +
                 "`n   shadows." +
                 "`n`n`n";

     Write-Host($MESSAGE);
     PAUSE;
     $global:location = $c_C1;  
           
}#close function

<# ------------------------------------------------------------------- #>

function OPTIONS
{
         Clear;
         [String] $CHOICE = "";

         while($CHOICE[0] -NE 'x')
         {
             Write-Host("`n`n -------------- Options ------------" +
                        "`n |                                 |" +
                        "`n |       (I)nventory List          |" +
                        "`n |       (U)se Inventory Item      |" +
                        "`n |       (M)agic Abilities         |" +
                        "`n |       (P)otions                 |" +
                        "`n |       (D)isplaystats            |" +
                        "`n |       (L)oad Character          |" +
                        "`n |       (S)ave Character          |" +       
                        "`n |       (Q)uit game               |" +
                        "`n |       E(x)it menu               |" + 
                        "`n |                                 |" +
                        "`n -----------------------------------"); 

             Write-Host("`n");
             $CHOICE = (Read-Host(" Choice? ")).ToLower();

             #Clear;

             switch($CHOICE[0])
             {
                 'i' { $global:The_Player.DisplayInventory(); break; }

                 'u' { $global:The_Player.UseItem(); break; }

                 'm' { if($global:The_Player.ENTITY_CLASS -EQ "MAGE" -OR
                          $global:The_Player.ENTITY_CLASS -EQ "SHAMAN" -OR
                          $global:The_Player.ENTITY_CLASS -EQ "ELF")
                       {  
                            $global:The_Player.UseMagic(); 
                       }
                       else 
                       {   
                           Write-Host("`n Your character doesn't do magic!`n"); 
                       }
                       break;
                     }

                     'p' { $global:The_Player.UsePotions(); break; }

                     'd' { $global:The_Player.DisplayStats(); break; }

                     'l' {  if(LoadCharacter -EQ $true)
                            {  
                               Write-Host("`n Character Loaded:`n");
                               $global:The_Player.DisplayStats();
                               $global:The_Player.DisplayInventory();
                               Write-Host("`n");
                               PAUSE;
                               SwitchBoard;
                            }
                            else 
                            { Write-Host("`n Sorry, could not load character.`n"); } 
                            break; 
                         }

                     's' { SaveCharacter; break; }
                           
                     'q' { $global:location = $c_QUIT; $CHOICE = "x"; break; }

                     'x' { break; }

                     '~' { $global:The_Player.CHEAT(); break; }


                 default { Write-Host("`nInvalid choice."); break; }

             }#close switch

         }#close while true loop

         PAUSE;
         Clear;

}#close function

<# ------------------------------------------------------------------- #>

function RoleHelp
{
         Clear;

         $MESSAGE = "`n`n  Carefully choose your character's class. As you choose?" +
                    "`n  Remember that each class has its own strengths and weaknesses.`n" +
                    
                    "`n`n        (W)arriors are strong and skilled with heavy" +
                    "`n        weapons. Also, they can wear heavy armor. But" +
                    "`n        they are slower than other characters and less" +
                    "`n        adept at magic." +
 
                    "`n`n        (M)ages are intelligent and can skillfully use" +
                    "`n        all magic, but they are generally poor handlers" +
                    "`n        of heavy weapons and do not possess the strength" +
                    "`n        to field the heavier types of armor." +
         
                    "`n`n        (F)ighters are dextrous, fast and agile. They" +
                    "`n        do not require heavy armor or weapons, as their" +
                    "`n        martial arts skills give them multiple attack" +
                    "`n        and defense maneuvers in combat. They can weild" +
                    "`n        some weapons when required, though not as much" +
                    "`n        as warriors. And they can use some magic, though" +
                    "`n        not as much or as well as mages." + 
  
                    "`n`n        (E)lves make the most stealthy opponents - they" +
                    "`n        are swift and dextrous, nimble and light on their" +
                    "`n        feet. They generally can communicate with animals" +
                    "`n        and can handle projectile weapons with great" +
                    "`n        precision. They are not as strong as the other" +
                    "`n        classes and therefore can not handle heavy weapons" +
                    "`n        or armor. On the other hand, elves may skillfully" +
                    "`n        employ magic, second only to Mages in ability." +   
              
                    "`n`n        (S)hamans are excellent healers and skillful" +
                    "`n        in the use of magic. They are especially good at" +
                    "`n        reading signs and ruins. They are also gifted with" +
                    "`n        a somewhat supernatural intuition and discernment" +
                    "`n        that's very useful for helping them detect and" + 
                    "`n        avoid traps and ambushes.`n`n`n";  

         Write-Host($MESSAGE);
         PAUSE;
}

<# ------------------------------------------------------------------- #>

function SaveCharacter
{
         Clear;

         $DataDirectory = Split-Path -Parent $PSCommandPath;
         $CharacterFile = $global:The_Player.NAME + "_Character.csv";
         $CharacterOutput = $DataDirectory + "\" + $CharacterFile;
         $GameStateFile = $global:The_Player.NAME + "_GameState.csv";
         $GameStateOutput = $DataDirectory + "\" + $GameStateFile;

         Write-Host("`nSaving Character and Game State Data");
         Write-Host("`nSave location:`n" + $DataDirectory);
         Write-Host("`nCharacter file name:`n" + $CharacterFile);
         Write-Host("`nCharacter output:`n" + $CharacterOutput);
         Write-Host("`nGame state file name:`n" + $GameStateFile);
         Write-Host("`nGame state output:`n" + $GameStateOutput)

         #Serialize all data members of base class and derived classes
         $CharState = New-Object -TypeName PSObject;
         $CharState | Add-Member -MemberType Noteproperty -Name NAME -Value $global:The_Player.NAME;
         $CharState | Add-Member -MemberType Noteproperty -Name Gender -Value $global:The_Player.Gender;
         $CharState | Add-Member -MemberType Noteproperty -Name ENTITY_CLASS -Value $global:The_Player.ENTITY_CLASS;
         $CharState | Add-Member -MemberType Noteproperty -Name HP -Value $global:The_Player.HP;
         $CharState | Add-Member -MemberType Noteproperty -Name ATK -Value $global:The_Player.ATK;
         $CharState | Add-Member -MemberType Noteproperty -Name DEF -Value $global:The_Player.DEF;
         $CharState | Add-Member -MemberType Noteproperty -Name EXP -Value $global:The_Player.EXP;
         $CharState | Add-Member -MemberType Noteproperty -Name WeaponChoice -Value $global:The_Player.WeaponChoice;
         $CharState | Add-Member -MemberType Noteproperty -Name WeaponDammage -Value $global:The_Player.WeaponDammage;
         $CharState | Add-Member -MemberType Noteproperty -Name MagicChoice -Value $global:The_Player.MagicChoice;
         $CharState | Add-Member -MemberType Noteproperty -Name MagicDammage -Value $global:The_Player.MagicDammage;
         $CharState | Add-Member -MemberType Noteproperty -Name MagicCost -Value $global:The_Player.MagicCost;
         $CharState | Add-Member -MemberType Noteproperty -Name ArmorChoice -Value $global:The_Player.ArmorChoice;                           
         $CharState | Add-Member -MemberType Noteproperty -Name InvisibilityCount -Value $global:The_Player.InvisibilityCount;
         $CharState | Add-Member -MemberType Noteproperty -Name MagicEnergy -Value $global:The_Player.MagicEnergy;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_BroadSword -Value $global:The_Player.Has_BroadSword;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Dagger -Value $global:The_Player.Has_Dagger;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Staff -Value $global:The_Player.Has_Staff;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_CrossBow -Value $global:The_Player.Has_CrossBow;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_LongBow -Value $global:The_Player.Has_LongBow;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_ChainMail -Value $global:The_Player.Has_ChainMail;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_PlateArmor -Value $global:The_Player.Has_PlateArmor;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_FishKey -Value $global:The_Player.Has_FishKey;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Fire -Value $global:The_Player.Has_Fire;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Ice -Value $global:The_Player.Has_Ice;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Lightning -Value $global:The_Player.Has_Lightning;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_TelekineticForce -Value $global:The_Player.Has_TelekineticForce;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Invisibility -Value $global:The_Player.Has_Invisibility;
         $CharState | Add-Member -MemberType Noteproperty -Name Has_Healing -Value $global:The_Player.Has_Healing;
         $CharState | Add-Member -MemberType Noteproperty -Name Arrows -Value $global:The_Player.Arrows;
         $CharState | Add-Member -MemberType Noteproperty -Name HealingPotion -Value $global:The_Player.HealingPotion;

         #Write class object with all Player values to file 
         $CharState | Export-CSV $CharacterOutput -NoTypeInformation;

         #Gather all data and globals for Game State into class Object
         $GameState = New-Object -TypeName PSObject;
         $GameState | Add-Member -MemberType Noteproperty -Name Location -Value $global:location;
         $GameState | Add-Member -MemberType Noteproperty -Name CENTERFirstTime -Value $global:CENTERFirstTime;
         $GameState | Add-Member -MemberType Noteproperty -Name FoundHealingPotion -Value $global:FoundHealingPotion;
         $GameState | Add-Member -MemberType Noteproperty -Name S1DragonAlive -Value $global:S1DragonAlive;
         $GameState | Add-Member -MemberType Noteproperty -Name E1DragonAlive -Value $global:E1DragonAlive;
         $GameState | Add-Member -MemberType Noteproperty -Name W1GiantAlive -Value $global:W1GiantAlive;
         $GameState | Add-Member -MemberType Noteproperty -Name FirstTimeInShamanHut -Value $global:FirstTimeInShamanHut;
         $GameState | Add-Member -MemberType Noteproperty -Name FoundHP_Shaman -Value $global:FoundHP_Shaman;
         $GameState | Add-Member -MemberType Noteproperty -Name UNDERDragonPairAlive -Value $global:UNDERDragonPairAlive;
         $GameState | Add-Member -MemberType Noteproperty -Name S2MotleyCrewAlive -Value $global:S2MotleyCrewAlive;
         $GameState | Add-Member -MemberType Noteproperty -Name FoundHP_West2 -Value $global:FoundHP_West2;

         #Write class object with all Player values to file 
         $GameState | Export-CSV $GameStateOutput -NoTypeInformation;

         Write-Host("`nCharacter and Game State saving process completed.");
         PAUSE;
}

<# ------------------------------------------------------------------- #>

function LoadCharacter
{
         Clear;

         Write-Host("`n------------ Load Game State and Character State ------------`n");

         $DataDirectory = Split-Path -Parent $PSCommandPath;
         Write-Host("Saved Game Files:`n");
         Get-ChildItem -Path ($DataDirectory + "\*") -Include *.csv -Name;

         $CHOICE = Read-Host("`nEnter name of character to load ");
         
         $CharacterFile = $CHOICE + "_Character.csv";
         $CharacterInput = $DataDirectory + "\" + $CharacterFile;
         $GameStateFile = $CHOICE + "_GameState.csv";
         $GameStateInput = $DataDirectory + "\" + $GameStateFile;

         Write-Host("`nLoading Character and Game State Data");
         Write-Host("`nLoad location: " + $DataDirectory);
         Write-Host("`nCharacter file name: " + $CharacterFile);
         Write-Host("`nGame state file name: " + $GameStateFile);
         Write-Host("`n");

         #Load Character data from file
         $CharState = Import-CSV $CharacterInput;

         $CharType = $CharState.ENTITY_CLASS;

         switch($CharType)
         {
             "SHAMAN" { $global:The_Player = New-Object Shaman; }
             "FIGHTER" { $global:The_Player = New-Object Fighter; }
             "MAGE" { $global:The_Player = New-Object Mage; }
             "WARRIOR" { $global:The_Player = New-Object Warrior; }
             "ELF" { $global:The_Player = New-Object Elf; }
             default { Write-Host("`nInvalid Character type."); }

         }

         #Assign values from file to New Character Object
         $global:The_Player.NAME = $CharState.NAME;
         $global:The_Player.Gender = $CharState.Gender;        
         $global:The_Player.HP = $CharState.HP;
         $global:The_Player.ATK = $CharState.ATK;
         $global:The_Player.DEF = $CharState.DEF;
         $global:The_Player.EXP = $CharState.EXP;
         $global:The_Player.WeaponChoice = $CharState.WeaponChoice;
         $global:The_Player.WeaponDammage = $CharState.WeaponDammage;
         $global:The_Player.MagicChoice = $CharState.MagicChoice;
         $global:The_Player.MagicDammage = $CharState.MagicDammage;
         $global:The_Player.MagicCost = $CharState.MagicCost;
         $global:The_Player.ArmorChoice = $CharState.ArmorChoice;
         $global:The_Player.InvisibilityCount = $CharState.InvisibilityCount;
         $global:The_Player.MagicEnergy = $CharState.MagicEnergy;

         #Note: can use [System.Convert]::ToBoolean, but I want to stay native here


         $global:The_Player.Has_BroadSword = BOOLEANATE_IT($CharState.Has_BroadSword);

         $global:The_Player.Has_Dagger = BOOLEANATE_IT($CharState.Has_Dagger);
         $global:The_Player.Has_Staff = BOOLEANATE_IT($CharState.Has_Staff);
         $global:The_Player.Has_CrossBow = BOOLEANATE_IT($CharState.Has_CrossBow);
         $global:The_Player.Has_LongBow = BOOLEANATE_IT($CharState.Has_LongBow);
         $global:The_Player.Has_ChainMail = BOOLEANATE_IT($CharState.Has_ChainMail);
         $global:The_Player.Has_PlateArmor = BOOLEANATE_IT($CharState.Has_PlateArmor);
         $global:The_Player.Has_FishKey = BOOLEANATE_IT($CharState.Has_FishKey);
         $global:The_Player.Has_Fire = BOOLEANATE_IT($CharState.Has_Fire);
         $global:The_Player.Has_Ice = BOOLEANATE_IT($CharState.Has_Ice);
         $global:The_Player.Has_Lightning = BOOLEANATE_IT($CharState.Has_Lightning);
         $global:The_Player.Has_TelekineticForce = BOOLEANATE_IT($CharState.Has_TelekineticForce);
         $global:The_Player.Has_Invisibility = BOOLEANATE_IT($CharState.Has_Invisibility);
         $global:The_Player.Has_Healing = BOOLEANATE_IT($CharState.Has_Healing);
         $global:The_Player.Arrows = $CharState.Arrows;
         $global:The_Player.HealingPotion = $CharState.HealingPotion;

         #Load Game State data from file
         $GameState = Import-CSV $GameStateInput;

         #Assign values from Game State file to globals
         $global:location = $GameState.location;
         $global:CENTERFirstTime = BOOLEANATE_IT($GameState.CENTERFirstTime);
         $global:FoundHealingPotion = BOOLEANATE_IT($GameState.FoundHealingPotion);
         $global:S1DragonAlive = BOOLEANATE_IT($GameState.S1DragonAlive);
         $global:E1DragonAlive = BOOLEANATE_IT($GameState.E1DragonAlive);
         $global:W1GiantAlive = BOOLEANATE_IT($GameState.W1GiantAlive);
         $global:FirstTimeInShamanHut = BOOLEANATE_IT($GameState.FirstTimeInShamanHut);
         $global:FoundHP_Shaman = BOOLEANATE_IT($GameState.FoundHP_Shaman);
         $global:UNDERDragonPairAlive = BOOLEANATE_IT($GameState.UNDERDragonPairAlive);
         $global:S2MotleyCrewAlive = BOOLEANATE_IT($GameState.S2MotleyCrewAlive);
         $global:FoundHP_West2 = BOOLEANATE_IT($GameState.FoundHP_West2);

         Write-Host("`nFinished loading Character State and Game State.`n");
         PAUSE;
}

<# ------------------------------------------------------------------- #>

#Convert STRING values to BOOLEAN values
function BOOLEANATE_IT([String] $x)
{
         if($x -EQ "TRUE") 
         { return $true; }
         elseif($x -EQ "FALSE")
         { return $false; }
         else
         { Write-Host("`nThis data is not BOOLEANABLE!"); }
}

<# ------------------------------------------------------------------- #>

function PRE_COMBAT
{
         Write-Host("`n  " + $global:The_Player.NAME + ", you are about to enter into mortal combat." + 
                    "`n  If you need to equip yourself with armor, weapons," + 
                    "`n  potions or magic? Do so now.");

         $global:The_Player.UseItem();
         $global:The_Player.UseMagic();
         PAUSE;
}

<# ------------------------------------------------------------------- #>

function COMBAT($x,$y)
{
         Clear;
         Write-Host("`n  " + $x.NAME + " and " + $y.NAME + " are locked into combat!`n");
         Write-Host("  Opponent 1:   Name = `"" + $x.NAME + "`"   Class = `"" + 
                    $x.ENTITY_CLASS + "`"   HP = " + $x.HP);
         Write-Host("  Opponent 2:   Name = `"" + $y.NAME + "`"   Class = `"" + 
                    $y.ENTITY_CLASS + "`"   HP = " + $y.HP + "`n");

         Start-Sleep -s 2;

         #Randomize who attacks first
         [int] $FirstAttack= Get-Random -Minimum 1 -Maximum (2 + 1);

         if($FirstAttack -EQ 1)
         { 
              Write-Host("`n  By sheer luck? " + $x.NAME + " gets the first attack.");
              Start-Sleep -s 2;

              while($x.HP -GT 0 -AND $y.HP -GT 0)
              { 
                       if($x.HP -GT 0) 
                       { 
                           $x.Attack($y); 
                           Start-Sleep -s 2;
                       }

                       if($y.HP -GT 0) 
                       {
                           $y.Attack($x); 
                           Start-Sleep -s 2;
                       }

              }#close while true loop

         }#close if FirstAttack is 1

         if($FirstAttack -EQ 2)
         {
              Write-Host("`n  By sheer luck? " + $y.NAME + " gets the first attack.");
              Start-Sleep -s 2;

              while($x.HP -GT 0 -AND $y.HP -GT 0)
              { 
                       if($y.HP -GT 0) 
                       { 
                           $y.Attack($x); 
                           Start-Sleep -s 2;
                       }

                       if($x.HP -GT 0) 
                       {
                           $x.Attack($y); 
                           Start-Sleep -s 2;
                       }

              }#close while true loop

         }#close if FirstAttack is 2

         #Reset Combat Stat Displays
         $x.FirstTimeShowOpponentInfo = $true;
         $y.FirstTimeShowOpponentInfo = $true;

         if($x.HP -GT 0)
         { 
             Write-Host("`n  " + $x.NAME + " is the sole survivor of this battle!" +
                        "`n  " + $y.NAME + " was terminated with extreme prejudice."); 
             $x.EXP += 50;
         }
         else
         { 
             Write-Host("`n  " + $y.NAME + " wins the battle!" +
                        "`n  " + $x.NAME + " was dispatched without mercy."); 
             $y.EXP += 50;
         }
}

<# ------------------------------------------------------------------- #>

function CENTER1
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: CENTER1");

         if($global:CENTERFirstTime -EQ $true)
         {    
              Write-Host("`n  " + $global:The_Player.NAME + 
              ", confused? You try to get your bearings. You see nothing" +
              "`n  but large stone tablets and columns with what appear to be odd" +
              "`n  and archaic symbols engraved upon them.");         
         }  
     
         else
         {   
              Write-Host("`n  You return to the location where you first mysteriously appeared" +
                  "`n  in this strange medieval world. You notice that the large stone" +
                  "`n  tablets and columns have arranged themselves into arched and hinged" +
                  "`n  gates. The symbols are constantly changing, disappearing and re-" +
                  "`n  appearing at random intervals across the surface of the tablets.");
         }  
     
         Write-Host("`n  You see that you can move to the north, south, east or west.`n" +
         "`n  To the north? You see the ruins of an ancient castle spread" +
         "`n  out across the horizon. " + 
         "`n`n  To the east? You see the pounding waves of an ocean against a rocky," +
         "`n  jagged shore. A thin veil of fog obscures the horizon." + 
         "`n`n  To the south? You see a small village with gray cobblestone houses" +
         "`n  and smoldering chimneys." +
         "`n`n  To the west? You see an abandoned farm house.");     
     
         while($CHOICE[0] -NE 'n' -AND 
               $CHOICE[0] -NE 's' -AND 
               $CHOICE[0] -NE 'e' -AND 
               $CHOICE[0] -NE 'w' -AND
               $CHOICE[0] -NE 'l' -AND
               $global:location -NE $c_QUIT)
         {
               Write-Host("`n  Where will you go (N, S, E, W)?  " +
                          "`n  Other choices: (O)ptions  (L)ook around  ") -NoNewLine;
               
               if($global:CENTERFirstTime -EQ $false) 
               {  Write-Host("(T)ry the gates") ; } 
                    
               $CHOICE = (Read-Host("`n`n  Choice?")).ToLower();
               
               Clear;
               $global:The_Player.DisplayStats();
         
               switch($CHOICE[0])
               {
                   'n' { $global:location = $c_N1; break; }
                   's' { $global:location = $c_S1; break; }
                   'e' { $global:location = $c_E1; break; }
                   'w' { $global:location = $c_W1; break; }
                   'o' { OPTIONS; break; }
                   'l' { $global:location = $c_C1; break; }
                   't' {  if($global:CENTERFirstTime -EQ $false)
                          {  
                              $global:location = $c_GATE;
                              $CHOICE[0] = 'n';
                          }
                          else 
                          {  "`n  This way is currently COMPLETELY impassible!"; }
                          break;
                       }
                    default {  Write-Host("`n  Invalid input"); break; }

               }#close switch  
                        
     }#close while true loop
     
     $global:CENTERFirstTime = $false;  

}#close function

<# ------------------------------------------------------------------- #>

function NORTH1
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: NORTH1");
     
         Write-Host("`n  You find yourself amidst the ruins of an ancient castle...");
     
         Write-Host("`n  Further to the north? You see a delapidated entrance to an" +
         "`n  abandoned castle. It is adjoined by crumbling towers, one at" +
         "`n  each corner of the foundation." + 
         "`n`n  The entrance to the castle is a frail wooden door, looking as" +
         "`n  though it had been abandoned for over a hundred years. It" +
         "`n  probably would not be too difficult to force the door open ..." +
         "`n`n  At this point, you may explore the castle ruins to the NORTH," +
         "`n  or go back to the SOUTH. You are surrounded by impassible," +
         "`n  moss-covered stone walls to the EAST and the WEST.");          
     
         while($CHOICE[0] -NE 's' -AND 
               $CHOICE[0] -NE 'n' -AND
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {            
               Write-Host("`n  Where will you go (N, S, E, W)?  " +
               "`n  Other choices: (O)ptions  (L)ook around   ");
                          
               $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
               Clear;
               $global:The_Player.DisplayStats();
         
               switch($CHOICE[0])
               {
                  'n' { $global:location = $c_N2; break; }
                  's' { $global:location = $c_C1; break; }
                  'e' {  "`n  You fail to scale the east wall.";
                         break;
                      }
                  'w' {   Write-Host("`n  You press against cold, hard stone.");
                          if($global:The_Player.Has_ChainMail -EQ $false)
                          {
                             Write-Host("`n  A secret, hinged panel gives way." + 
                                        "`n  You find a suit of chain mail!");
                             $global:The_Player.Has_ChainMail = $true;
                             $global:The_Player.EXP += 20;
                             $global:The_Player.DisplayInventory();                              
                          }
                          else 
                          {  Write-Host("`n  Previously, you found the" +
                                        " chain mail at this location."); 
                          } 
                          break; 
                      }
                  'o' { OPTIONS; break; }
                  'l' { $global:location = $c_N1; break; }
                  default {  "`n  Invalid input"; break; }   
                    
               }#close switch 
                        
     }#close while true loop       

}#close function

<# ------------------------------------------------------------------- #>

function SOUTH1
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: SOUTH1");

         Write-Host("`n  You stumble into the gates of a rustic village. You see what" +
         "`n  appears to be a tavern to the north. Further south, you see a winding" +
         "`n  dirt road that meanders towards the horizon. All around you are" +
         "`n  peasants buying and selling wares in an open market place. Near" +
         "`n  the center of the village several children are playing, and in the" +
         "`n  midst of them sits an elderly woman, looking very wise and thoughtful.");
  
         Write-Host("`n  At this point, you may only go back to the NORTH or further SOUTH." +
         "`n  if you so desire. You are surrounded by what seems impassible" +
         "`n  terrain to the east and the west and several cottages. Towards the" +
         "`n  center of the villiage, you notice a small though nicely maintained" +
         "`n  Shaman's lodge with smoke billowing from its roof.");
     
         while($CHOICE[0] -NE 's' -AND 
               $CHOICE[0] -NE 'n' -AND
               $CHOICE[0] -NE 'g' -AND
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {     
               Write-Host("`n  Possible directions for you are: (N, S, E, W)?" +
               "`n  Other choices: (O)ptions  (G)o into Shaman's Hut  " +
               "(L)ook around");
                          
               $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
               Clear;
               $global:The_Player.DisplayStats();
         
               switch($CHOICE[0])
               {
                  'n' { $global:location = $c_C1; break; }
                  's' { $global:location = $c_S2; break;}
                  'e' {  Write-Host("`n  You see a window."); break;}
                  'w' { if($global:FoundHealingPotion -EQ $false)
                       { 
                           "`n  You find a healing potion!";
                          $global:The_Player.HealingPotion += 1;
                          $global:FoundHealingPotion = $true;
                          $global:The_Player.EXP += 20;
                          $global:The_Player.DisplayInventory(); 
                       }
                       else
                       {
                          Write-Host("`n  You see a wall. (previously you found hp here...)"); 
                       } 
                       break;
                      }
                  'g' { $global:location = $c_SHAMANS_HUT; break; }            
                  'o' { OPTIONS; break;}
                  'l' { $global:location = $c_S1; break;}
                  default {  "`n  Invalid input"; break; }
                      
               }#close switch          
     
     }#close while true loop   

}#close function

<# ------------------------------------------------------------------- #>

function EAST1
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: EAST1");

         Write-Host("`n  You arrive at a sandy shore where green and blue, translucent" +
                    "`n  waves are crashing against rocky outcroppings. To the NORTH?");
        
         if($global:E1DragonAlive -EQ $true)
         {     
             Write-Host("`n  A magnificent red dragon folds its wings and wraps its tail around" +
                        "`n  its taloned feet, smoke billowing from its flaring nostrils.");
         }
         else
         {  Write-Host("`n  A slain dragon is being devoured by ravens...");       
       
            Write-Host("`n  At this point?  You may go back to the WEST, or you may" +
                       "`n  proceed EAST. You are surrounded by turbulent waters" +
                       "`n  and razor sharp rocks to the EAST and the SOUTH.`n");
         }

         while($CHOICE[0] -NE 'w' -AND 
               $CHOICE[0] -NE 'e' -AND
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {
               Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
                          "`n  Other choices: (O)ptions  (L)ook around");
                         
               $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
               Clear;
               $global:The_Player.DisplayStats();
                        
               switch($CHOICE[0])
               {
                    'n' {  if($global:E1DragonAlive)
                           {
                              Write-Host("`n  A dragon attacks!`n");
                              $A_Dragon = New-Object Dragon;
                              $A_Dragon.NAME = "Deloria";
                              PRE_COMBAT;
                              COMBAT -x $global:The_Player -y $A_Dragon;
                              $A_Dragon = $null;
                              $global:The_Player.EXP += 50;

                              if($global:The_Player.HP -GT 0)
                              {  
                                  Write-Host("`n  You absorb 50 points of magic energy. Beneath the" +
                                             "`n  the giant beast's carcass, you find a scroll! It" +
                                             "`n  teaches you a magic spell for creating Lightning.");

                                  $global:The_Player.Has_Lightning = $true;
                                  $global:The_Player.MagicEnergy += 50;
                                  $global:The_Player.DisplayMagic();
                                  $global:E1DragonAlive = $false;
                              } 
                           }
                           else
                           {
                               Write-Host("`n  You see a dead dragon carcass.");     
                           }
                           break;
                        }
                    's' {  Write-Host("`n  Ouch! You feel stinging, burning ripples of pain travel" +
                                      "`n  up and down your spine. Something cold, wet and slimy" + 
                                      "`n  has wrapped itself around the bare flesh of your leg.");

                           $global:The_Player.HP -= 30;
                           $global:The_Player.EXP += 30;

                           if($global:The_Player.HP -GT 0)
                           { 
                                Write-Host("`n  You stepped on a massive jellyfish! " + 
                                           "`n  Its flailing tentacles inject venom benath your skin.");
                           }
                           else 
                           {     
                                Write-Host("`n  How sad! Slain by a jellyfish!");
                                $global:location = $c_QUIT;
                                PAUSE;
                           } 
                           $global:The_Player.DisplayStats();   
                           break;
                        }
                    'e' { $global:location = $c_E2; break; }
                    'w' { $global:location = $c_C1; break; }
                    'o' { OPTIONS; break; }
                    'l' { $global:location = $c_E1; break; }
                    default {  Write-Host("`n  Invalid input"); break; } 
                
         }#close switch
                   
     }#close while true loop 

}#close function

<# ------------------------------------------------------------------- #>

function WEST1
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: WEST1");

         Write-Host("`n  You arrive at an abandoned farm house. You see a picket fence," +
         "`n  a rustic delapidated barn, and a decaying hovel that used to be " +
         "`n  someone's residence. There are chickens walking around the." +
         "`n  premesis.`n`n  To the SOUTH? You see: ");
         
         if($global:W1GiantAlive)
         {     
             Write-Host("`n  A Giant wearing old, brown " +
             "sackcloth. He is taunting you with`n  offensive " +
             "gestures and lewd comments.`n`n  You really don't want to " +
             "tangle with a giant, do you?");
         }
         else
         {  
             Write-Host("`n  Barbed wire, blood, sackcloth and carnage..." +
                        "`n  The remains of a brutish giant with a foul mouth" +
                        "`n  and a nasty disposition."); 
         }
                  
         Write-Host("`n  At this point, you may go NORTH, or back EAST." +
         "`n`n  You see only thick undergrowth and thick brush" +
         "`n  to the WEST.");

              
            while($CHOICE[0] -NE 'w' -AND 
                  $CHOICE[0] -NE 'e' -AND
                  $CHOICE[0] -NE 'l' -AND 
                  $global:location -NE $c_QUIT)
     {
            Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
                       "`n  Other choices: (O)ptions  (L)ook around");
                          
            $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
            Clear;
            $global:The_Player.DisplayStats();
         
            switch($CHOICE[0])
            {
                'n' {   Write-Host("`n  You are attacked by a flock of vicious chickens!" +
                                   "`n  They will not let you proceed further north.");
                        if($global:The_Player.Has_Dagger -EQ $false)
                        {
                             Write-Host("`n  But lieing on the ground? You find a bronze dagger!");
                             $global:The_Player.Has_Dagger = $true;
                             $global:The_Player.EXP += 20;
                             $global:The_Player.DisplayInventory();
                        }
                        else 
                        {  Write-Host("`n  Previously, you found the dagger here."); } 
                        break;
                    }
                's' { if($global:W1GiantAlive)
                       {
                           Write-Host("`n  The giant sees you walking in his direction..." + 
                                      "`n  He charges!`n");

                           $A_Giant = New-Object Giant;
                           $A_Giant.NAME = "Grothem";
                           PRE_COMBAT;
                           COMBAT -x $global:The_Player -y $A_Giant; 
                           $A_Giant = $null;
                           $global:The_Player.EXP += 50;
                           if($global:The_Player.HP-GT 0)
                           { 
                                Write-Host("`n  You defeated the giant!");
                               
                                Write-Host("`n  You absorb 50 points of magic energy. Beneath" +
                                           "`n  the giant you find a scroll! It teaches you a" +
                                           "`n  magic spell for creating Fireballs.");
                                $global:The_Player.Has_Fire = $true;
                                $global:The_Player.MagicEnergy += 50;
                                $global:The_Player.DisplayMagic();
                               
                               $global:W1GiantAlive = $false;
                           } 
                       }
                       else
                       {
                            Write-Host("`n  You see the corpse of the giant you recently dispatched.");     
                       }
                       break;
                    }
                'e' { $global:location  = $c_C1; break; }
                'w' { $global:location  = $c_W2; break; }
                'o' { OPTIONS; break; }
                'l' { $global:location  = $c_W1; break; }
                default {  Write-Host("`n  Invalid input"); break; }
                
         }#close switch  
                 
     }#close while true loop     
      
}#close function

<# ------------------------------------------------------------------- #>

function NORTH2
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: NORTH2");

         Write-Host("`n  You walk inside the castle. It is dark and musty, but" +
         "`n  enough daylight is leaking through the cracks in between" +
         "`n  stones and mortar that you can ascertain your surroundings" +
         "`n  in a dim, colorless twilight.`n" + 
         "`n  Against the wall to the EAST you see a long wooden box, about" +
         "`n  the size of a coffin. You can see a table, chairs and several" +
         "`n  candle stands to the WEST of the room.`n" +
         "`n  To the NORTH? And to the SOUTH? The walls are adorned with" +
         "`n  dusty, thread-bare tapestries.`n" + 
         "`n  You notice stairs descending deep UNDERGROUND to some" +
         "`n  unknown passage to your right.");
              
         while($CHOICE[0] -NE 's' -AND 
               $CHOICE[0] -NE 'u' -AND
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {
               Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
               "`n  Other choices: (O)ptions  (U)nderground  (L)ook around");
                          
            $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
            Clear;
            $global:The_Player.DisplayStats();
         
            switch($CHOICE[0])
            {
                'n' {  Write-Host("`n  Hanging on the wall are beautiful tapestries," +
                                  "`n  woven of fine silk and canvas. They appear " +
                                  "`n  to be elven artistry, though dry and dusty."); 
                       break; 
                    }
                's' { $global:location = $c_N1; break; }
                'e' {  Write-Host("`n  You approach the box and cautiously open it..."); 
                       if($global:The_Player.Has_PlateArmor -EQ $false)
                       {
                             Write-Host("`n  You find a well preserved suit of full body armor!");
                             $global:The_Player.Has_PlateArmor = $true;
                             $global:The_Player.EXP += 20;
                             $global:The_Player.DisplayInventory();                              
                       }
                       else { Write-Host("`n  The box is empty - you already took the armor."); } 
                       break; 
                    }
                'w' {  Write-Host("`n  You press against the cold stone wall and grope" +
                                  "`n  its cracks and crevices, but find nothing of" +
                                  "`n  any interest or value.");
                       break; 
                    }
                'u' { $global:location = $c_UNDERGRND; break; }
                'o' { OPTIONS; break; }
                'l' { $global:location = $c_N2; break; }
            default {  Write-Host("`n  Invalid input"); break; }  
              
         }#close switch      
             
     }#close while true loop   
        
}#close function

<# ------------------------------------------------------------------- #>

function SOUTH2
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: SOUTH2");

         Write-Host("`n  You wander through the village further to the SOUTH." +
         "`n  You notice several of the villagers are staring at you" +
         "`n  strangely as you walk by.`n" + 
         "`n  You come to the southern gate that guards the entrance" +
         "`n  to the village and pass through its open doors.`n" +
         "`n  You follow a meandering dirt path towards the" +
         "`n  edge of a dense hardwood forest. As you walk along the" +
         "`n  road, you pass several merchants hauling their wares" +
         "`n  by horse and cart.`n" + 
         "`n  Continuing SOUTH? You see a group of three giants " +
         "`n  resting with their backs against the trees.");
              
         while($CHOICE[0] -NE 'n' -AND 
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {
               Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
                          "`n  Other choices: (O)ptions   (L)ook around   ");
                          
            $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
            Clear;
            $global:The_Player.DisplayStats();
         
            switch($CHOICE[0])
            {
                'n' { $global:location = $c_S1; break; }
                's' { if($global:S2MotleyCrewAlive -EQ $true)
                      {    
                          Write-Host("`n  You're either really brave, or really stupid." +
                                          "`n`n  Are you sure you want to fight 3 giants," +
                                          "`n  and all at the same time?");
                            
                          $CHOICE = (Read-Host("`n  Choice?")).ToLower();
                            
                          if($CHOICE[0] -EQ 'y')
                          {
                              $GangOfGiants = @();
                              $Giant1 = New-Object Giant;
                              $Giant1.NAME = "Zult";
                              $GangOfGiants += $Giant1;
                              $Giant2 = New-Object Giant;
                              $Giant2.NAME = "Marook";
                              $GangOfGiants += $Giant2;
                              $Giant3 = New-Object Giant;
                              $Giant3.NAME = "Leotol";
                              $GangOfGiants += $Giant3;

                              Write-Host("`n  All three giants charge you at once!");
                              PRE_COMBAT;

                              for($x = 0; $x -LT $GangOfGiants.Count; $x++)
                              {
                                  COMBAT -x $global:The_Player -y $GangOfGiants[$x];     
                              }

                              $Giant1 = $null;
                              $Giant2 = $null;
                              $Giant3 = $null;
                              $global:S2MotleyCrewAlive = $false;
                              $global:The_Player.EXP += 200;
                          }                                 
                          else 
                          {   Write-Host("`n  Intelligently, you decide to walk away..."); }   
                       }
                       else 
                       {   Write-Host("`n  You see three dead giant carcasses."); }
                       break; 
                    }
                'e' {   Write-Host("`n  You see a lake, covered with lily pads and algae." +
                                   "`n  The water glistens and ripples along the shore.");
                        break; 
                    }
                'w' {   Write-Host("`n  You see cat tails and dragon flies skimming across" +
                                   " the water.");
                        break; 
                    }
                'o' { OPTIONS; break; }
                'l' { $global:location = $c_S2; break; }
                default {  Write-Host("`n  Invalid input"); break; }    
                 
            }#close switch
                      
     }#close while truye loop      

}#close function

<# ------------------------------------------------------------------- #>

function EAST2
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: EAST2");

         Write-Host("`n  You swim out to the sand bars hundreds of feet beyond" +
                    "`n  the shore. In every direction? You see dolphins and" +
                    "`n  sharks swimming around you.");
              
         while($CHOICE[0] -NE 'w' -AND 
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {
               Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
                          "`n  Other choices: (O)ptions  (L)ook around");
                          
            $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
            Clear;
            $global:The_Player.DisplayStats();
         
            switch($CHOICE[0])
            {
               'n' {  Write-Host("`n  You see dolphins and sharks."); break; }
               's' {  Write-Host("`n  You swim out amidst a pod of dolphins.");
                      if($global:The_Player.Has_FishKey -EQ $false)
                      {
                          Write-Host("`n  You notice something metalic shining in the sand" +
                                     "`n  beneath your feet.`n" + 
                                     "`n  You dig into the sand and find a gilded bronze key" +
                                     "`n  with a Fish symbol engraved upon its head.");

                          $global:The_Player.Has_FishKey = $true; 
                          $global:The_Player.EXP += 20;
                          $global:The_Player.DisplayInventory();
                          $global:The_Player.DisplayStats();      
                      }
                      else
                      {  Write-Host("`n  Hey, this is the same place you found that Fish key!"); }
                      break; 
                   }
               'e' {  Write-Host("`n  You see beds of seaweed in blue and green patches."); 
                      break; 
                   }
               'w' { $global:location = $c_E1; break; }
               'o' { OPTIONS; break; }
               'l' { $global:location = $c_E2; break; }
               default {  Write-Host("`n  Invalid input"); break; }  
               
         }#close switch  
                 
     }#close while true  
              
}#close fuction

<# ------------------------------------------------------------------- #>

function WEST2
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: WEST2");

         Write-Host("`n  You find yourself walking in golden fields of wheat.");
              
         while($CHOICE[0] -NE 'e' -AND 
               $CHOICE[0] -NE 'l' -AND 
               $global:location -NE $c_QUIT)
         {
             Write-Host("`n  Possible directions for you are: (N, S, E, W)?  " +
                        "`n  Other choices: (O)ptions  (L)ook around");
                          
            $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
            Clear;
            $global:The_Player.DisplayStats();
         
            switch($CHOICE[0])
            {
               'n' { if($global:The_Player.Has_LongBow -EQ $false)
                     {
                         Write-Host("`n  You find a well-strung long bow and arrows!");
                         $global:The_Player.Has_LongBow = $true;
                         $global:The_Player.Arrows += 20;
                         $global:The_Player.EXP += 20;
                         $global:The_Player.DisplayInventory();                              
                     }
                     else {  Write-Host("`n  You already found the long bow."); }
                     break; 
                   }
               's' {  Write-Host("`n  You see... golden fields of WHEAT!"); 
                       if($global:FoundHP_West2 -EQ $false)
                       {
                            Write-Host("`n  Buried under a mound among the wheat," +
                                       "you find a healing potion!");

                           $global:The_Player.HealingPotion += 1;
                           $global:FoundHP_West2 = $true;
                           $global:The_Player.EXP += 20;
                           $global:The_Player.DisplayInventory();
                       }
                       else {  Write-Host("`n  You already found the healing potion."); }
                       break; 
                   }
               'e' { $global:location = $c_W1; break; }
               'w' {  Write-Host("`n  You see staple crops planted in distinct rows." +
                            "`n  Cabbages, carrots, string beans and radishes.");
                      break;
                   }
               'o' { OPTIONS; break; }
               'l' { $global:location = $c_W2; break; }
               default {  Write-Host("`n  Invalid input"); break; } 
                  
         }#close switch
                   
     }#close while true loop
                 
}#close function

<# ------------------------------------------------------------------- #>

function GATES
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: GATES");  
         
         if($global:The_Player.Has_FishKey -EQ $true)
         {
             Write-Host("`n  Fumbling around the gate, you find a slot to insert the" +
             "`n  Fish key. The tablets and columns begin to rumble and shake." +
             "`n  Large stones rise, levitating off the ground, rearranging" +
             "`n  themselves to and fro in a pattern of sacred geometry.");
         }
         else
         {
             Write-Host("`n  You look around, trying every nook and crevice, but can not" +
             "`n  seem to find the means to open the gate, nor alter anything" +
             "`n  else around it.`n" + 
             "`n  You see what appears to be a key hole to one" +
             "`n  side of the ruins. If only you had a key? ...");
             
             $global:location = $c_C1;       
         }
    
         if($global:The_Player.Has_FishKey -AND $global:The_Player.EXP -LT 300)
         {
             Write-Host("`n  It appears that, although you have the key, you lack enough" +
             "experience with the ways of this world to cause the gate to" +
             "`n  function in any useful manner.");
             
             $global:location = $c_C1;
         }
    
         if($global:The_Player.Has_FishKey -AND $global:The_Player.EXP -GE 300)
         {
             Write-Host("`n  With the experience you have gained since entering this" +
             "`n  strange world, you manage to figure out the correct sequence of" +
             "`n  actions to perform while turning the Fish key within the gate." +
             "`n  You hear a loud hiss followed by a dull hum as cascading beams of" +
             "`n  light blind you from the opening dimensional portal." +
             "`n  You feel as though you have won a series of battles in a" +
             "`n  long campaign, but that the war is far from being over." +
             "`n  Having made several new friends and vanquished many foes as" +
             "`n  a soujourner in a strange land, you step through the gates," +
             "`n  uncertain yet hopeful that this may bring you one step closer" +
             "`n  to home...");

             PAUSE;

             Write-Host("`n  You win this campaign and end the game with:");     
             $global:The_Player.DisplayStats(); 
             $global:The_Player.DisplayInventory();
             $global:location = $c_QUIT;                                  
         }

         PAUSE;     
}

<# ------------------------------------------------------------------- #>

function Shamans_Hut
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: SHAMAN's HUT");      
     
         if($global:FirstTimeInShamanHut -eq $true)
         { 
             Write-Host(" ");
             $global:WiseWoman = New-Object Shaman;
             $global:WiseWoman.NAME = "Kaileigh";
             $global:WiseWoman.Gender = "Female";
         
             Write-Host("`n  You duck down and enter into the Shaman's hut." + 
                        "`n  Towards the center of the mud dwelling, beneath" +
                        "`n  an overhanging shelf descending from the thatched" +
                        "`n  roof, sits an elderly priestess.`n" + 
                        "`n  Unphased by your presence, she continues to stare" +
                        "`n  into the flames of a small fire burning within a" + 
                        "`n  set of blackened stone rings in the center of the" +
                        "`n  hut.`n" + 
                        "`n  Directly over her head? An opening in the ceiling" +
                        "`n  allows the smoke to escape. She gazes at you and" + 
                        "`n  whispers. `"Not expecting an old  temple preistess," +
                        "`n  were you? Well, in this village? I guess you could" + 
                        "`n  say that I'm the `"Shaman`" in these parts?"); 
        
           
             $global:FirstTimeInShamanHut = $false;
         }
         else
         { 
             Write-Host("`n  You re-enter the Shaman's hut. She turns her head in a" + 
                        "`n  peculiar fashion and remarks, `"Back so soon, traveler?`"" +
                        "`n  She offers you a cup of freshly brewed tea, which you" +
                        "`n  gladly accept to quench your thirst.");
           
             if($global:FoundHP_Shaman -EQ $false)
             {
                 Write-Host("`n  She opens her medicine bag and begins creating" + 
                            "`n  an acrid mixture of herbs. She pours it into a" +
                            "`n  vial and places it in your hand, saying:`n" +
                            "`n  `"Drink this if you become wounded, my friend." + 
                            "`n  It may restore you to a measure of your former" +
                            "`n  health and constitution.`"");
                  
                 $global:The_Player.HealingPotion += 1;
                 $global:FoundHP_Shaman = $true;
                 Write-Host("`n  You receive - a HEALNG potion!`n");
                 $global:The_Player.DisplayInventory();
                 PAUSE;
                 Clear;
             }
             else 
             { 
                  Write-Host("`n  You feel a sense of debt and gratitiude towards" +  
                             "`n  this kind old woman, remembering the healing" +
                             "`n  elixir she gave you on your last visit.");
             }     
         }         
  
         Write-Host("`n  At this point, you may`n" + 
         "`n  (l)eave the Shaman's hut" +
         "`n  (t)alk with her if you so desire" + 
         "`n  (S)teal her medicine bag and staff");
          
         while($CHOICE[0] -NE 'l' -AND 
               $CHOICE[0] -NE 's' -AND 
               $CHOICE[0] -NE 'o')
         {                
              Write-Host("`n  Your choices: (L)eave  (T)alk  (S)teal" +
                  "`n  Other: (o)ptions  ");
                  
               $CHOICE = (Read-Host("`n  Choice?")).ToLower();
               
               Clear;
               $global:The_Player.DisplayStats();
             
               switch($CHOICE[0])
               {
                  'n' {  "You run into a straw and mud wall. Yippee!"; break; }
                  'o' { OPTIONS; break; }
                  'l' { $global:location = $c_S1; break; }
                  's' { Clear;
                        $global:The_Player.DisplayStats();
                        Write-Host("`n  You get the uneasy feeling that you are going" +
                                   "`n  to reap serious bad karma for this unwise action."); 
                        Start-Sleep -s 3;
                        
                        Write-Host("`n  Bellowing thunder cracks and the clouds darken" + 
                                   "`n  as the sea spirit of the temple preistess fills" +
                                   "`n  with indignation and anger!");
                        Start-Sleep -s 3;;  
                                  
                        Write-Host("`n  In an instant? Lighting falls from the heavens" + 
                                   "`n  and strikes you down!");
                        Start-Sleep -s 3;
                             
                        Write-Host("`n  You go into the afterlife a loser, ashamed" +
                                   "`n  for the despicable deeds you have done. The warriors" +
                                   "`n  who have gone on before you, the great warriors of" +
                                   "`n  reknown and the kings of the past will ridicule you" +
                                   "`n  for all of eternity for dieing without honor.");
                        Start-Sleep -s 5;
                               
                        PAUSE;
                        $global:The_Player.HP = 0; 
                        $global:The_Player.DisplayStats();
                        $global:location = $c_QUIT; 
                        $CHOICE[0] = 'o';
                        break; 
                      }
                  't' {  Write-Host("`n  You seek audience with the preistess."); 
                         $global:WiseWoman.Talk(); 
                         break; 
                      }
                  'i' { $global:The_Player.DisplayInventory(); break; }
                  'd' { $global:The_Player.DisplayStats(); break; }                           
                  default {  Write-Host("`n  That was an invalid choice."); break; }              
             }
          }           
}

<# ------------------------------------------------------------------- #>

function UnderGroundPassage
{
         Clear;
         [String] $CHOICE = "";
         $global:The_Player.DisplayStats(); 
         Write-Host("`n  Location: UNDERGROUND PASSAGE"); 

         Write-Host("`n  You descend into the darkness underground...");
    
         if($global:UNDERDragonPairAlive -EQ $true)
         {
             Write-Host("`n  Peeking around a corner, you see a group of red dragons" +
             "`n  breathing fire!`n" + 
             "`n  Think about whether you want to fight? Or flee?" +
             "`n  Are you SURE you want to fight 5 dragons, all at" + 
             "`n  at the same time? (y,n)");

             $CHOICE = (Read-Host("`n  Choice?")).ToLower();
      
             if($CHOICE -EQ 'y')
             {
                 $DragonGroup = @();
                 $Dragon1 = New-Object Dragon;
                 $Dragon1.NAME = "Bayreux";
                 $DragonGroup += $Dragon1;
                 $Dragon2 = New-Object Dragon;
                 $Dragon2.NAME = "Jonjeil";
                 $DragonGroup += $Dragon2;
                 $Dragon3 = New-Object Dragon;
                 $Dragon3.NAME = "KaiRenLo";
                 $DragonGroup += $Dragon3;
                 $Dragon4 = New-Object Dragon;
                 $Dragon4.NAME = "Taurine";
                 $DragonGroup += $Dragon4;
                 $Dragon5 = New-Object Dragon;
                 $Dragon5.NAME = "Jeuxis";
                 $DragonGroup += $Dragon5;

                 PRE_COMBAT;

                 for($x = 0; $x -LT $DragonGroup.Count; $x++)
                 {
                     COMBAT -x $global:The_Player -y $DragonGroup[$x];   
                 }

                 $Dragon1 = $null;
                 $Dragon2 = $null;
                 $Dragon3 = $null;
                 $Dragon4 = $null;
                 $Dragon5 = $null;

                 $global:The_Player.EXP += 350;
                 $global:UNDERDragonPairAlive = $false;
             }   
             else 
             { 
                 Write-Host("`n  Intelligently, you run back up the stairs...");
                 $global:location = $c_N2;   
             }   
         }
         else 
         { 
            Write-Host("`n  You see a group of dead red dragons and the carnal" +
                       "`n  aftermath of your last great battle with these" + 
                       "`n  fierce and worthy opponents.");

            $global:location = $c_N2; 
         }
    
    PAUSE;
              
}#close function

<# ------------------------------------------------------------------- #>

function TEST_IT_1
{
         Clear;
         Write("`nBuild Player.");
         $Player = New-Object ENTITY;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         $Player.ENTITY_CLASS = "Elf";
         $Player.ATK = 75;
         $Player.WeaponChoice = $global:Crossbow;
         $Player.MagicChoice = $global:Lightning;
         $Player.Set_Armor($global:PLATE_MAIL);
         $Player.DisplayStats();
         PAUSE;

         Clear;
         Write("`nBuild Enemy.");
         $Enemy = New-Object ENTITY;
         $Enemy.Name = "Enemy";
         $Enemy.Gender = "Male";
         $Enemy.ENTITY_CLASS = "Warrior";
         $Enemy.DisplayStats();
         PAUSE;

         Clear;
         $Player.Attack($Enemy);
}

<# ------------------------------------------------------------------- #>

function TEST_IT_2
{
         #Options;
         #RoleHelp;
         #Introduction;
         #SaveCharacter;
         #LoadCharacter;

         Clear;

         $Player = New-Object Elf;
         $player.NAME = "Carly";
         $Player.CHEAT();

         $Enemy = New-Object Dragon;
         $Enemy.NAME = "Puff";

         PAUSE;

         PRE_COMBAT;
         COMBAT -x $Player -y $Enemy; 

}

<# ------------------------------------------------------------------- #>

function TEST_IT_3
{
         Clear;

         $global:The_Player = New-Object Elf;
         $global:The_Player.NAME = "Carly";
         #$global:The_Player.CHEAT();

         PAUSE;

         InitializeGlobals;
         #CENTER1;
         #NORTH1;
         #SOUTH1;
         #EAST1;
         #WEST1;
         #NORTH2;
         #SOUTH2;
         #EAST2;
         #WEST2;
         #GATES;
         #Shamans_Hut;
         #UnderGroundPassage;
}

<# ------------------------------------------------------------------- #>

#-------Invocations -------
#TEST_IT_1
#TEST_IT_2;
#TEST_IT_3;
MAIN;
