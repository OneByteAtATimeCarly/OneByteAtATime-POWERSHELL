#Title: PowerShell - Module 05 - Functions 7 - Parameters 2
#Author: Carly S. Germany
#Date: 06/07/2020

$global:Pokemon_Name = "Undefined";
$global:Pokemon_Species = "Undefined";
$global:Pokemon_Gender = "Undefined";
$global:Pokemon_Health = 0;
$global:Pokemon_Defense = 0;
$global:Pokemon_Attack = 0;

$global:Opponent_Name = "Undefined";
$global:Opponent_Species = "Undefined";
$global:Opponent_Gender = "Undefined";
$global:Opponent_Health = 0;
$global:Opponent_Defense = 0;
$global:Opponent_Attack = 0;

<# --------------------------------------------------------------------------------- #>

function Create_Pokemon
{
         param
         (
            $Species = "Pikachu",
            $Name = "Bubba",
            $Gender = "Male"
         );

         $Min_Health = 75;
         $Max_health = 100;
         $Min_Defense = 5;
         $Max_Defense = 10;
         $Min_Attack = 2;
         $Max_Attack = 8;

         $global:Pokemon_Species = $Species;
         $global:Pokemon_Name = $Name;
         $global:Pokemon_Gender = $Gender;

         Write("`n-----------------------------------------");
         Write("Creating your Pokémon!`n");

         Write("Species = " + $global:Pokemon_Species);
         Write("Name = " + $global:Pokemon_Name);
         Write("Gender = " + $global:Pokemon_Gender);

         Write("`nDetermining random stats ...");
         Write("Rolling dice ...`n");

         [Int] $global:Pokemon_Health = Get-Random -Minimum $Min_Health -Maximum ($Max_Health + 1);
         Write("Health = " + $global:Pokemon_Health);

         [Int] $global:Pokemon_Defense = Get-Random -Minimum $Min_Defense -Maximum ($Max_Defense + 1);
         Write("Defense = " + $global:Pokemon_Defense);

         [Int] $global:Pokemon_Attack = Get-Random -Minimum $Min_Attack -Maximum ($Max_Attack + 1);
         Write("Attack = " + $global:Pokemon_Attack);

         Write("`nA new Pokémon is born!")

         Write("`n-----------------------------------------");
}

<# --------------------------------------------------------------------------------- #>

function Display_Pokemon
{
         Write("`n----------Pokemon Stats----------");
         Write("Name: " + $global:Pokemon_Name);
         Write("Species: " + $global:Pokemon_Species);
         Write("Gender: " + $global:Pokemon_Gender);
         Write("Health: " + $global:Pokemon_Health);
         Write("Defense: " + $global:Pokemon_Defense);
         Write("Attack: " + $global:Pokemon_Attack);
         Write("-----------------------------------`n");
}

<# --------------------------------------------------------------------------------- #>


#------- INVOCATIONS -----------
Clear;
Create_Pokemon;
Display_Pokemon;
