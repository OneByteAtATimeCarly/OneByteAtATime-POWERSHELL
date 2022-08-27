#Title: PowerShell - Module 07 - Classes - RPG "A Knight in the Darkness" Part 1
#       Creating an Inheritance Hierarchy - The ADT Base/Parent class
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
[int] $global:MagicHealingAmount = 20;
[int] $global:MagicHealingCost = 30;
[int] $global:HP_Restore_Amt = 40;

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
[int] $global:Broadsword = 1;
[int] $global:Dagger = 2;
[int] $global:Crossbow = 3;
[int] $global:Longbow = 4;
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
$global:The_Player = New-Object Character;
$global:A_Dragon = New-Object Dragon;
$global:A_Giant = New-Object Giant;
$global:Wise_Woman = New-Object Shaman;


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
      [int] $score;
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
           $this.HP = 100;
           $this.ATK = 5;
           $this.DEF = 5;
           $this.EXP = 1;
           $this.score = 0;
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
           "`n     Score: " + $this.score +
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
               $global:Broadsword { $STATS += "BroadSword"; break; }
               $global:Dagger { $STATS += "Dagger"; break; }
               $global:Staff { $STATS += "Staff"; break; }
               $global:Crossbow { $STATS += "CrossBow"; break; }
               $global:Longbow { $STATS += "LongBow"; break; }
               default { $STATS += "`nBad Input!"; break; }                   
           }   

           $STATS += "`n     Selected Armor:";
           
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
  
           [int] $Dammage =  Get-Random -Minimum 1 -Maximum ($global:MaxDammage + 1);
           
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

                  $global:Longbow { $this.WeaponDammage = $global:LongBowDammage;
                                    $MESSAGE += " fires an arrow from the long bow! Zzzzt!`n";
                                    break;
                                  }
                                                               
                  $global:Crossbow { $this.WeaponDammage = $global:CrossBowDammage;
                                     $MESSAGE += " fires a bolt from the crossbow! Twang!`n";
                                     break;
                                   }
                                              
                  $global:Broadsword { $this.WeaponDammage = $global:BroadSwordDammage;
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

              #If Character activates Invisibility
              if($this.MagicChoice -EQ $global:Invisibility)
              {
                  $this.MagicCost = $global:MagicInvisibilityCost;

                  if($this.MagicEnergy -GE $this.MagicCost)
                  {
                      if($this.InvisibilityCount -LE 0)
                      {
                          $this.MagicEnergy -= $this.MagicCost;
                          $this.DEF += $global:MagicInvisibilityDefense;
                          $this.InvisibilityCount = 5;

                          $MESSAGE += " employs invisibility, bending light" +
                          " around ";

                          if($this.Gender -EQ "Male") { $MESSAGE += "him"; }
                          else  { $MESSAGE += "her"; }

                          $MESSAGE += "self and`n increasing their DEFENSE " +
                          "capability by [" + $global:MagicInvisibilityDefense + 
                          "] for " + $this.InvisibilityCount + " combat rounds.`n " +
                          $this.NAME + "'s DEFENSE capability has been raised to: ["+
                          $this.DEF + "] .";

                          $MESSAGE += "`n`n This costs " + $this.NAME + " " +
                          $this.MagicCost + " units of magical energy.";
                      }
                      else
                      {
                          $MESSAGE += "You are already using invisibility!" +
                          "`nYou can't activate it again when you are already using it."; 
                      }
                  }
                  else
                  {
                      $MESSAGE += "`n" + $this.NAME + " doesn't have enough" +
                      " magical energy to use Invisibility."
                  }                 
              }

              if($this.InvisibilityCount -GT 0)
              {
                  $MESSAGE += "`n " + $this.NAME +  " has " + $this.InvisibilityCount +
                  " rounds of INVISIBILITY left.";

                  $this.InvisibilityCount--;

                  if($this.InvisibilityCount -LE 0) 
                  { $this.DEF -= $global:MagicInvisibilityDefense; } 
              }

              #If Character Uses Healing
              if($this.MagicChoice -EQ $global:Healing)
              {
                  $this.MagicCost = $global:MagicHealingCost;

                  if($this.MagicEnergy -GE $this.MagicCost)
                  {
                      $this.MagicEnergy -= $this.MagicCost;
                      $this.HP += $global:MagicHealingAmount;
                      
                      $MESSAGE += " uses the magic art of " +
                      "HEALING!`n This restores [" + $global:MagicHealingAmount + 
                      "] health, but costs " + $this.MagicCost + " units of magic." +
                      "`n " + $this.NAME + "`s health now = [" + $this.HP + "].";
                  }
                  else
                  {
                      $MESSAGE += "`n" + $this.NAME + " doesn't have enough" +
                      " magical energy to use Healing."                      
                  }
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
           $Opponent.DisplayStats();

      }#close function
                                                   
}#close class

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

#-------Invocations -------
TEST_Base_Class;