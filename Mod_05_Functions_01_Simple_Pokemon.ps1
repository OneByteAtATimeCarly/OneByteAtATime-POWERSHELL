#Title: PowerShell - Module 05 - Functions 1
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

function Main
{
         Clear;
         Write("`nPokémon Tournament 1.0`n");

         Create_Pokemon;
         Display_Pokemon;
         #Create_Opponent;
         #Display_Opponent;
         #Pokemon_Tournament;
}

<# --------------------------------------------------------------------------------- #>

function Create_Pokemon
{
         $Min_Health = 75;
         $Max_health = 100;
         $Min_Defense = 5;
         $Max_Defense = 10;
         $Min_Attack = 2;
         $Max_Attack = 8;

         Write("`n-----------------------------------------");
         Write("Create your Pokémon!");

         $Menu = "LOOP";
         $CHOICE = "";

         while($Menu -EQ "LOOP")
         {
             Write("`nPick a species:");
             Write("`n   1. Pikachu`n   2. Mimikyu`n   3. Bulbasaur`n   4. Flareon`n   5. Charmander`n");

             $CHOICE = Read-Host("CHOICE?");

             switch($CHOICE)
             {
                 1 { $global:Pokemon_Species = "Pikachu"; $Menu = "EXIT"; }
                 2 { $global:Pokemon_Species = "Mimikyu"; $Menu = "EXIT"; }
                 3 { $global:Pokemon_Species = "Bulbasaur"; $Menu = "EXIT"; }
                 4 { $global:Pokemon_Species = "Flareon"; $Menu = "EXIT"; }
                 5 { $global:Pokemon_Species = "Charmander"; $Menu = "EXIT"; }
                 default 
                 {  
                     Write("`nInvalid CHOICE. Choose again.");
                     Read-Host("Press ENTER to continue."); 
                 }
              }
         }

         Write("`n");
         $global:Pokemon_Name = Read-Host("Name?");

         $Menu = "LOOP";

         while($Menu -EQ "LOOP")
         {
             Write("`nPick a gender:");
             Write("`n   (F)emale  or (M)ale?`n");

             $CHOICE = (Read-Host("CHOICE?")).ToLower();

             switch($CHOICE[0])
             {
                 'f' { $global:Pokemon_Gender = "Female"; $Menu = "EXIT"; }
                 'm' { $global:Pokemon_Gender = "Male"; $Menu = "EXIT"; }
                 default 
                 {  
                     Write("`nInvalid CHOICE. Choose again.");
                     Read-Host("Press ENTER to continue."); 
                 }
              }
         }

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
         Write("-----------------------------------");
}

<# --------------------------------------------------------------------------------- #>

function Create_Opponent
{
         
}

<# --------------------------------------------------------------------------------- #>

function Display_Opponent
{

}

<# --------------------------------------------------------------------------------- #>

function Pokemon_Tournament
{

}

<# --------------------------------------------------------------------------------- #>


#------- INVOCATIONS -----------
Main;

