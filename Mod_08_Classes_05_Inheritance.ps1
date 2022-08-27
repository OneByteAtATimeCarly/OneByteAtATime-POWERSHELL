#Title: PowerShell - Module 07 - Classes 05 - Inheritance
#Author: Carly S. Germany
#Date: 06/14/2020

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
           Write-Host("`n");
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
      }
}

<# --------------------------------------------------------------------------------- #


<# --------------------------------------------------------------------------------- #>

#3. Creating an Instance of the DERIVED class once you have defined it

  function Create_Monster1
  {
           Clear;
           Write-Host("`n");

           $ODZILLA = New-Object Godzilla;

           $ODZILLA.Display();

           Write("Evolving Odzilla ...");

           $ODZILLA.Name = "Evolved Odzilla";
           $ODZILLA.Health = 200;
           $ODZILLA.Attack = 15;
           $ODZILLA.Defense = 25;

           $ODZILLA.Display();
  }

  <# --------------------------------------------------------------------------------- #>

  
#------- Invocations -------
  Create_Monster1;