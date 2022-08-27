#Title: PowerShell - Module 07 - Classes 06 - Inheritance
#Game Title: Monster Combat 1.0
#Author: Carly S. Germany
#Date: 06/14/2020

#Globals (like C++ pointers)
$global:Monster1;
$global:Monster2;

 <# --------------------------------------------------------------------------------- #>

 #1. Defining a Class with a CONSTRUCTOR, a FUNCTION and DATA MEMBERS
 
class Monster
{
       #Constructor
       Monster()
       { 
           Write-Host("Instantiating a Monster object.");
           $this.Name = "Generic Monster";
           $this.Health = 100;
           $this.Attack = 7;
           $this.Defense = 12;
       }

       #Member Methods
       Display()
       {
           Write-Host("`n");
           Write-Host("Name: " + $this.Name);
           Write-Host("Health: " + $this.Health);
           Write-Host("Attack: " + $this.Attack);
           Write-Host("Defense: " + $this.Defense);
       }

       #Data Members
       [String]$Name;
       [int]$Health;
       [int]$Attack;
       [int]$Defense;
 }

<# --------------------------------------------------------------------------------- #>

#2. Create a DERIVED class that INHERITS from the BASE class and reuses its code and methods.

class Godzilla : Monster
{
      Godzilla()
      {
          Write-Host("Instantiating a Godzilla object.");
          $this.Name = "Godzilla";
          $this.Health = 200;
          $this.Attack = 100;
          $this.Defense = 50;
      }

      #Member Methods
      Nuclear_RadioActive_Lightning()
      {
        Write-Host("Godzilla breathes Radioactive Lightning.");
      }
}

<# --------------------------------------------------------------------------------- #>

class Mothra : Monster
{
      Mothra()
      {
          Write-Host("Instantiating a Mothra object.");
          $this.Name = "Mothra";
          $this.Health = 125;
          $this.Attack = 85;
          $this.Defense = 65;
      }

      Wing_Flap_Hurricane()
      {
             Write-Host("`nMothra flaps wings and makes HURRICAN attack!");  
      }
}

<# --------------------------------------------------------------------------------- #>

#3. Creating an Instance of the DERIVED class once you have defined it

  function Create_Monsters
  {
           Clear;
           Write-Host("`n         Monster Combat 1.0`n");

           $global:Monster1 = New-Object Godzilla;
           $global:Monster1.Display();

           $global:Monster2 = New-Object Mothra;
           $global:Monster2.Display();

           $null = Read-Host("`n`nPress ENTER to continue.");
  }

  <# --------------------------------------------------------------------------------- #>

function Monster_Combat
{
         Clear;

         $MinDammage = 5;
         $MaxDammage = 30;
         $Monster1Turn = $false;
         
         Clear;
         Write("`nMonster Battle!`n");
         Write( $global:Monster2.Name + " vs. " + $global:Monster1.Name + "!");

         $global:Monster2.Display();
         $global:Monster1.Display();

         Write("`nRolling for who gets first attack ...");

         [Int] $CHANCE = Get-Random -Minimum 1 -Maximum (2 + 1);

         switch($CHANCE)
         {
            1 { $Monster1Turn = $true; Write("`nMonster 1 gets 1st attack!");}
            2 { $Monster1Turn = $false; Write("`nMonster 2 gets 1st attack!"); }
         }

         while($global:Monster1.Health -GT 0 -AND $global:Monster2.Health -GT 0)
         {
             if($Monster1Turn)
             {
                 if($global:Monster1.Health -GT 0)
                 {
                     Write("`n" + $global:Monster1.Name + " attacks " + $global:Monster2.Name + "!");

                     $Dammage = Get-Random -Minimum $MinDammage -Maximum ($MaxDammage + 1);

                     Write($global:Monster1.Name + " generates " + $Dammage + " dammage.");
                     Write("Attack skills add " + $global:Monster1.Attack + " dammage.");
                     $Dammage = $Dammage + $global:Monster1.Attack;

                     Write("Total dammage generated = " + $Dammage);

                     Write($global:Monster2.Name + " defends subtracting " + 
                           $global:Monster2.Defense + " from dammage.");

                     $Dammage = $Dammage - $global:Monster2.Defense;

                     Write("After final attack " + $global:Monster1.Name + " does " + 
                            $Dammage + " total dammage to " + $global:Monster2.Name);

                     #Prevent negative dammage which would add health to opponent
                     if($Dammage -LT 0) { $Dammage = 0; }

                     $global:Monster2.Health = $global:Monster2.Health - $Dammage;

                     $Monster1Turn = $false;
                 }
                 else
                 {
                     Write($global:Monster1.Name + " cannot attack on account of being DEAD.");
                 }
             }
             else
             {
                 if($global:Monster2.Health -GT 0)
                 {
                     Write("`n" + $global:Monster2.Name + " attacks " + $global:Monster1.Name + "!");

                     $Dammage = Get-Random -Minimum $MinDammage -Maximum ($MaxDammage + 1);

                     Write($global:Monster2.Name + " generates " + $Dammage + " dammage.");
                     Write("Attack skills add " + $global:Monster2.Attack + " dammage.");
                     $Dammage = $Dammage + $global:Monster2.Attack;

                     Write("Total dammage generated = " + $Dammage);

                     Write($global:Monster1.Name + " defends subtracting " + 
                           $global:Monster1.Defense + " from dammage.");

                     $Dammage = $Dammage - $global:Monster1.Defense;

                     Write("After final attack " + $global:Monster2.Name + " does " + 
                            $Dammage + " total dammage to " + $global:Monster1.Name);

                     #Prevent negative dammage which would add health to opponent
                     if($Dammage -LT 0) { $Dammage = 0; }

                     $global:Monster1.Health = $global:Monster1.Health - $Dammage;

                     $Monster1Turn = $true;
                 }
                 else
                 {
                   Write($global:Monster2.Name + " was terminated with extreme prejudice.");
                 }
             }

             Write("`n$global:Monster1.Name HEALTH = " + $global:Monster1.Health);
             Write("$global:Monster2.Name HEALTH = " + $global:Monster2.Health);

             Start-Sleep -s 4;
         }

         if($global:Monster1.Health -GT 0)
         {
             Write("`n" + $global:Monster1.Name + " wins the tournament!");
         }
         else
         {
             Write("`n" + $global:Monster2.Name + " wins the tournament.");
         }

}

<# --------------------------------------------------------------------------------- #>

  
#------- Invocations -------
Create_Monsters;
Monster_Combat;