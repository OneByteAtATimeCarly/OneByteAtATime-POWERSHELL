
<# --------------------------------------------------------------------------------- #>

function Create_Pokemon
{
         param($Species,$Name,$Gender);

         $Health = 0;
         $Defense = 0;
         $Attack = 0;
         $Min_Health = 75;
         $Max_health = 100;
         $Min_Defense = 5;
         $Max_Defense = 10;
         $Min_Attack = 2;
         $Max_Attack = 8;


         Write("`n-----------------------------------------");
         Write("Creating your Pokémon!`n");

         Write("Species = " + $Species);
         Write("Name = " + $Name);
         Write("Gender = " + $Gender);

         Write("`nDetermining random stats ...");
         Write("Rolling dice ...`n");

         [Int] $Health = Get-Random -Minimum $Min_Health -Maximum ($Max_Health + 1);
         Write("Health = " + $Health);

         [Int] $Defense = Get-Random -Minimum $Min_Defense -Maximum ($Max_Defense + 1);
         Write("Defense = " + $Defense);

         [Int] $Attack = Get-Random -Minimum $Min_Attack -Maximum ($Max_Attack + 1);
         Write("Attack = " + $Attack);

         Write("`nA new Pokémon is born!")

         Write("`n-----------------------------------------`n");

         Write("`n----------Pokemon Stats----------");
         Write("Name: " + $Name);
         Write("Species: " + $Species);
         Write("Gender: " + $Gender);
         Write("Health: " + $Pokemon_Health);
         Write("Defense: " + $Pokemon_Defense);
         Write("Attack: " + $Pokemon_Attack);
         Write("-----------------------------------`n");
}

<# --------------------------------------------------------------------------------- #>

Clear;
Write("`nInside Script 2.");

$SPECIES = $($args[0]);
$NAME = $($args[1]);
$GENDER = $($args[2]);

Create_Pokemon -Species $SPECIES -Name $NAME -Gender $GENDER;

#2. 
#CD to D:\Carly_Powershell\Module_05_Functions.
#Run: .\Script2 Create_Pokemon -Species "Mimikyu" -Name "Carly" -Gender "Female";
