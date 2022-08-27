#Title: PowerShell - Module 07 - Classes 04 - Special Properties HIDDEN
#Author: Carly S. Germany
#Date: 06/14/2020

#The "hidden" keyword can be used to create  properties and methods within a class that
#the programmer does not want other users of the class to see or edit.
#It hides properties and methods from Get-Member, IntelliSense and tab completion
#UNLESS the user is INSIDE the class itself.

#It can be overidden by using the -Force option with Get-Member. 
#Example: $Monster | Get-Member -MemberType Properties -Force

#It has no effect on how you can view or make changes to members of a class
#Values of hidden properties can be set and read just like visible properties.


 <# --------------------------------------------------------------------------------- #>

 #1. Defining a Class with a CONSTRUCTOR, a FUNCTION and STATIC DATA MEMBERS
 

<# --------------------------------------------------------------------------------- #>

Class VisibleMonster
 {
       #Constructor
       VisibleMonster()
       { 
           Write-Host("`nInstantiating a VisibleMonster object.");
       }

       #Data Members
       [String]$Name = "Static Generic Monster";
       [int]$Health = 150;
       [int]$Attack = 10;

       #Member Methods
       DisplayMonster()
       {
            Write-Host("Name: " + $this.Name);
            Write-Host("Health: " + $this.Health);
            Write-Host("ATK: " + $this.Attack);
       }
 }

<# --------------------------------------------------------------------------------- #>

function Create_Monster1
{
           Clear;

           Write("`nNote we can SET and GET values of instantiated object when it is NOT HIDDEN.");

           $Monster = New-Object VisibleMonster;
           $Monster.Name = "Bubba";
           $Monster.Health = 9000;
           $Monster.Attack = 100;
           $Monster.DisplayMonster();

           
           Write("`n`nIf we call Get-Member, all NON-hidden data members are VISIBLE:")
           Write("Calling: Get-Member -MemberType Properties");

           $Monster | Get-Member -MemberType Properties;        
}

<# --------------------------------------------------------------------------------- #>

<# --------------------------------------------------------------------------------- #>

 Class HiddenMonster
 {
       #Constructor
       HiddenMonster()
       { 
           Write-Host("`nInstantiating a HiddenMonster object.");
       }

       #Data Members
       hidden [String]$Name = "Static Generic Monster";
       hidden [int]$Health = 150;;
       hidden [int]$Attack = 10;

       #Member Methods
       DisplayMonster()
       {
            Write-Host("Name: " + $this.Name);
            Write-Host("Health: " + $this.Health);
            Write-Host("ATK: " + $this.Attack);
       }
 }

  <# --------------------------------------------------------------------------------- #>

  #2. Creating an Instance of a Class once you have defined it

  function Create_Monster2
  {
           Clear;

           Write("`nNote we can still SET and GET values of instantiated object when it IS HIDDEN.");

           $Monster = New-Object HiddenMonster;
           $Monster.Name = "Bubba";
           $Monster.Health = 9000;
           $Monster.Attack = 100;
           $Monster.DisplayMonster();          

           Write("`n`nIf we call Get-Member, all hidden data members are INVISIBLE:")
           Write("Calling: Get-Member -MemberType Properties");

           $Monster | Get-Member -MemberType Properties;

           Write("`n`nBut if we use the -Force parameter with Get-Member? HIDDEN data members display:")
           Write("Calling: Get-Member -MemberType Properties -Force`n")

           $Monster | Get-Member -MemberType Properties -Force;

           Write("`nBut notice that we can SET and GET the values of an instantiated object, even when they are HIDDEN.");
  }

<# --------------------------------------------------------------------------------- #>




  
#------- Invocations -------
#Create_Monster1;
Create_Monster2;
