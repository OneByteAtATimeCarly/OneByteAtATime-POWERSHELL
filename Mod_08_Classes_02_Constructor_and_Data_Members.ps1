#Title: PowerShell - Module 07 - Classes 02 - Defining, Instantiating, Using
#Author: Carly S. Germany
#Date: 06/14/2020

 <# --------------------------------------------------------------------------------- #>

 #1. Defining a Class with a CONSTRUCTOR, a FUNCTION and DATA MEMBERS
 
 Class Monster
 {
       #Constructor
       Monster()
       { 
           Write-Host("`nInstantiating a Monster object.");
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

  #2. Creating an Instance of a Class once you have defined it

  function Create_Monster1
  {
           Clear;

           $MONSTER1 = New-Object Monster;

           $MONSTER1.Display();

           Write("Evolving Monster ...");

           $Monster1.Name = "Evolved Generic Monster";
           $Monster1.Health = 200;
           $Monster1.Attack = 15;
           $Monster1.Defense = 25;

           $MONSTER1.Display();
  }

  <# --------------------------------------------------------------------------------- #>

  
#------- Invocations -------
  Create_Monster1;