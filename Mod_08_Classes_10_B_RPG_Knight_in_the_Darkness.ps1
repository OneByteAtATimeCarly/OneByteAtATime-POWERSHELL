#Title: PowerShell - Module 07 - Classes - RPG "A Knight in the Darkness" Part 2
#       Creating an Inheritance Hierarchy - The Derived Child Classes
#Author: Carly S. Germany
#Date: 06/25/2020

#********************************************************************************************
# A. Globals and Constants
#********************************************************************************************

#Constants - Dammage and Defense
[int] $c_CombatPause = 3000;
[int] $global:MaxDammage = 25;
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
#$global:The_Player = New-Object Character;
#$global:A_Dragon = New-Object Dragon;
#$global:A_Giant = New-Object Giant;
#$global:Wise_Woman = New-Object Shaman;


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

           $MESSAGE ="`n Beginning ENTITY attack sequence ...`n";
           $MESSAGE += "`n----------------------------- Attack for " + $this.NAME + " -----------------------------`n";

           Write-Host($MESSAGE);
           Start-Sleep -s 1;
           $MESSAGE = "";

           Write-Host("`nOpponent's Information:");
           $Opponent.DisplayStats();
           Start-Sleep -s 3;

           $MESSAGE += "`n " + $Opponent.NAME + "'s hitpoints BEFORE " +
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
                                    $MESSAGE += " fires an arrow from the long bow! Zzzzt!`n";
                                    break;
                                  }
                                                               
                  $global:CrossBow { $this.WeaponDammage = $global:CrossBowDammage;
                                     $MESSAGE += " fires a bolt from the crossbow! Twang!`n";
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

              $MESSAGE += " A random amount of [" + $Dammage + "] dammage was generated " + 
                          "by " + $this.NAME + "'s experience and luck.";
              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";
              $Dammage += $this.ATK;
              $MESSAGE += " " + $this.NAME + "'s ATK combat skills add another [" + $this.ATK +
                          "] dammage to this, making it [" + $Dammage + "]."
              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";
              $Dammage += $this.WeaponDammage;
              $MESSAGE += " " + $this.NAME + "'s weapon increases ";
              if($this.Gender -EQ "Male") { $MESSAGE += "his"; }
              else  { $MESSAGE += "her"; }
              $MESSAGE += " attack by [" + $this.WeaponDammage + 
              "] for a total of ";
              $MESSAGE += "[" + $Dammage + "] damage.`n";
              Write-Host($MESSAGE);
              Start-Sleep -s 3;
              $MESSAGE = "";

           }#close if  


           #Derived Character Classes that can use Magic Attacks
           if($this.ENTITY_CLASS -EQ "MAGE" -OR
              $this.ENTITY_CLASS -EQ "SHAMAN" -OR
              $this.ENTITY_CLASS -EQ "ELF") 
           {
              $MESSAGE += "`n Magic Use: " + $this.NAME;
              
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
                 $this.MagicChoice -NE $global:Healing)
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
                
              #Reset Magic choice?
              #$this.MagicChoice = $global:No_Magic;        
                            
           }#close if 


           #After ATTACK choices/variations calculate final damage/prevent negative values

           $MESSAGE = "`n " + $Opponent.NAME + "'s DEFENSIVE skills reduce their " +
                      "dammage by " + $Opponent.DEF + ".";

           if($Dammage -GT $Opponent.DEF)
           { $Dammage -= $Opponent.DEF; }
           else 
           { $Dammage = 0; }

           if($Opponent.HP - $Dammage -GT 0)
           { $Opponent.HP -= $Dammage; }
           else 
           { $Opponent.HP = 0; }


           $MESSAGE += "`n " + $Opponent.NAME + "'s final resulting HP AFTER " +
                        $this.NAME + "'s attack: [" + $Opponent.HP + "].`n";

           $MESSAGE += "`n " + $Opponent.NAME + " has been defeated in battle.`n";

           Write-Host($MESSAGE);

           Write-Host("`n " + $this.NAME + "'s STATS after this attack:");
           $this.DisplayStats();

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
           Write-Host("`nBEFORE Selection: ");
           $this.DisplayStats();
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
                             $this.Arrows -= 1;
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
                             $this.Arrows -= 1;
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

               'q' { Write-Host("Exiting ..."); }

               default { Write-Host("`n  That's not a valid option here.");  }

           }#close switch

           Write-Host("`nAFTER Selection: ");
           $this.DisplayStats();

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
              $MagicAbilities += "`n  You have no magical abilities yet.`n"; 
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
           Write-Host("`nBEFORE Selection: ");
           $this.DisplayStats();
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

                                 $this.MagicEnergy -= $global:MagicFireCost;
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

                                 $this.MagicEnergy -= $global:MagicIceCost;
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

                                 $this.MagicEnergy -= $global:MagicLightningCost;
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

                                 $this.MagicEnergy -= $global:MagicTelekineticForceCost;
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

           Write-Host("`nAFTER Selection: ");
           $this.DisplayStats();

      }#close member-method

 #----------------------------------------------

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
         $null = Read-Host("`nHit ENTER to continue.`n");
}
<# ------------------------------------------------------------------- #>

function TEST_Base_Class
{
         Clear;
         Write-Host("`n`n     A Knight in the Darkness 1.0" +
                    "`n      ©2006 Carly Salali Germany`n`n");
         PAUSE;

         Clear;
         Write("`nBuild Player.");
         $Player = New-Object ENTITY;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         $Player.ENTITY_CLASS = "Elf";
         $Player.ATK = 75;
         $Player.WeaponChoice = $global:CrossBow;
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

function TEST_Intermediate_ADT_Character_Class
{
         Clear;
         Write("`nBuild a Character object.");
         $Player = New-Object Character;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         $Player.ENTITY_CLASS = "ELF";
         PAUSE;
        
         Clear;
         Write("`nBEFORE calling CHEAT."); 
         $Player.DisplayStats();
         $Player.DisplayInventory();
         PAUSE;

         Clear;
         Write("`nAFTER calling CHEAT.");
         $player.CHEAT(); 
         PAUSE;            
}

<# ------------------------------------------------------------------- #>

function TEST_Derived_Character_Class_1
{
         Clear;
         Write("`nBuild a Character object.");
         $Player = New-Object Elf;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         $Player.CHEAT();
         PAUSE;       
         
         #Infinite loop
         for(;;)
         {
            Clear;
            $Player.UseItem();
            PAUSE;
         } 
}

<# ------------------------------------------------------------------- #>

function TEST_Derived_Character_Class_2
{
         Clear;
         Write("`nBuild a Character object.");
         $Player = New-Object Elf;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         PAUSE;  
         
         Clear;
         Write("`nBEFORE calling CHEAT."); 
         $Player.DisplayStats();
         $Player.DisplayInventory();
         $Player.DisplayMagic()
         PAUSE; 
         
         Clear;
         Write("`nAFTER calling CHEAT."); 
         $Player.CHEAT();
         PAUSE;        
}

<# ------------------------------------------------------------------- #>

function TEST_Derived_Character_Class_3
{
         Clear;
         Write("`nBuild a Character object.");
         $Player = New-Object Elf;
         $Player.Name = "Carly";
         $Player.Gender = "Female";
         $Player.CHEAT();
         PAUSE;       
         
         #Infinite loop
         for(;;)
         {
            Clear;
            $Player.UseMagic();
            PAUSE;
         } 
}

<# ------------------------------------------------------------------- #>

function TEST_Derived_Character_Class_4
{
         Clear;
         Write("`nBuild a Character object.");
         $Player = New-Object Shaman;
         $Player.Name = "Kaira";
         $Player.Gender = "Female";
         PAUSE;       
         
         #Infinite loop
         for(;;)
         {
            Clear;
            $Player.Talk();
            PAUSE;
         } 
}

<# ------------------------------------------------------------------- #>

#------- Invocations -------
#TEST_Base_Class;
#TEST_Intermediate_ADT_Character_Class;
#TEST_Derived_Character_Class_1;
#TEST_Derived_Character_Class_2;
#TEST_Derived_Character_Class_3;
TEST_Derived_Character_Class_4;

