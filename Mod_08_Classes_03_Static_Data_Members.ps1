#Title: PowerShell - Module 07 - Classes 03 - Special Properties STATIC
#Author: Carly S. Germany
#Date: 06/14/2020

#A variable or data member can be defined as STATIC inside a class if it won't change.
#Wheras normal data members can have different values for each instantiated object?
#STATIC data members are the same throughout all instantiated objects of a class.
#STATIC data members can be used without instantiating a class. They can be pulled
#directly from its definition.

#You access static data by using the class definition name inside brackets and ::, 
#instead of an instance name. Example:  [Monster]::Health


 <# --------------------------------------------------------------------------------- #>

 #1. Defining a Class with a CONSTRUCTOR, a FUNCTION and STATIC DATA MEMBERS
 
 Class Monster
 {
       #Constructor
       Monster()
       { 
           Write-Host("`nInstantiating a Monster object.");
       }

       #Data Members
       static [String]$Name = "Static Generic Monster";
       static [int]$Health = 150;
       static [int]$Attack = 10;
       static [int]$Defense = 30;
 }

  <# --------------------------------------------------------------------------------- #>

  #2. Creating an Instance of a Class once you have defined it

  function Create_Monster1
  {
           Clear;

           Write("`n`nWe can pull static data directly from a class without instantiating it.");

           Write("`n");
           Write("STATIC Name: " + [Monster]::Name);
           Write("STATIC Health: " + [Monster]::Health);
           Write("STATIC Attack: " + [Monster]::Attack);
           Write("STATIC Defense: " + [Monster]::Defense);
           Write("`n");

           Write("Notice that we never built a Monster object.`n")

  }

  <# --------------------------------------------------------------------------------- #>

  
#------- Invocations -------
  Create_Monster1;