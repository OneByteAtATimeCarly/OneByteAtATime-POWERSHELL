#Title: PowerShell - Module 06 - Arrays
#Author: Carly S. Germany
#Date: 06/08/2020


<# ------------------------------------------------------------------------------------------------- #>

function One_Dimensional_Array_ForEach
{
         $MLP_Main_Characters = @("Twilight Sparkle",
                                  "Fluttershy"
                                  "Rainbow Dash",
                                  "Rarity",
                                  "Apple Jack",
                                  "Pinkie Pie");

         $PonyCounter = 0;
         Write-Host("`n`n");
         Write-Host("Number of ELEMENTS in array = " + $MLP_Main_Characters.Count + ".");
         Write-Host("");

         ForEach($PONY in $MLP_Main_Characters)
         {
             $PonyCounter++;
             Write-Host("Pony " + $PonyCounter + " is " + $PONY + ".");
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function One_Dimensional_Array_For
{
         $MLP_Main_Characters = @("Twilight Sparkle",
                                  "Fluttershy"
                                  "Rainbow Dash",
                                  "Rarity",
                                  "Apple Jack",
                                  "Pinkie Pie");

         Write-Host("`n`n");
         Write-Host("Number of ELEMENTS in array = " + $MLP_Main_Characters.Count + ".");
         Write-Host("");

         for($x = 0; $x -LT $MLP_Main_Characters.Count; $x++)
         {
             Write-Host("Pony " + ($x+1) + " is " + $MLP_Main_Characters[$x] + ".");
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function Empty_Array_Of_Fixed_Size
{
         $Number_of_Cylons = 5;
         $Final_Five = New-Object String[] $Number_of_Cylons;

         Write-Host("`n`n");
         Write-Host("Number of ELEMENTS in array Final_Five = " + $Final_Five.Count + ".");
         Write-Host("");

         #Populate Fixed Empty Array With CYLON Identities
         $Final_Five[0] = "Saul Tigh";
         $Final_Five[1] = "Ellen Tigh";
         $Final_Five[2] = "Samuel Anders";
         $Final_Five[3] = "Galen Tyrol";
         $Final_Five[4] = "Tory Foster";

         #REVEAL the Final Five Cylons
         for($y = 0; $y -LT $Final_Five.Count; $y++)
         {
             Write-Host("   Cylon " + ($y+1) + " is `"" + $Final_Five[$y] + "`".");
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function Dynamic_Empty_Array_Of_Undetermined_Size
{
         $Babylon5_Main_Chars = @();

         Write-Host("`n`n");
         Write-Host("BEFORE: Number of ELEMENTS in array Babylon5_Main_Chars = " + $Babylon5_Main_Chars.Count + ".");

         #Add Babylon5 Charactesr to Empty Array
         $Babylon5_Main_Chars += "Satai Delenn";
         $Babylon5_Main_Chars += "John Sheridan";
         $Babylon5_Main_Chars += "Vorlon Ambassador Kosh";
         $Babylon5_Main_Chars += "Vir Cotto";
         $Babylon5_Main_Chars += "Susan Ivanova";
         $Babylon5_Main_Chars += "Talia Winters";
         $Babylon5_Main_Chars += "Michael Garibaldi";
         $Babylon5_Main_Chars += "Lennier";
         $Babylon5_Main_Chars += "G'Kar";
         $Babylon5_Main_Chars += "Londo Mollari";

         Write-Host("AFTER: Number of ELEMENTS in array Babylon5_Main_Chars = " + $Babylon5_Main_Chars.Count + ".");
         Write-Host("");

         #REVEAL the Final Five Cylons
         for($x = 0; $x -LT $Babylon5_Main_Chars.Count; $x++)
         {
             Write-Host("   Babylon 5 character " + ($x+1) + " is `"" + $Babylon5_Main_Chars[$x] + "`".");
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function One_Dimensional_Parallel_Array
{
         $MLP_Char_Names = @("Twilight Sparkle",
                             "Fluttershy"
                             "Rainbow Dash",
                             "Rarity",
                             "Apple Jack",
                             "Pinkie Pie");

         $MLP_Char_Ages = @("15","17","12","14","19","16");

         Write-Host("`n`n");
         Write-Host("Number of ELEMENTS in array MLP_Char_Names = " + $MLP_Char_Names.Count + ".");
         Write-Host("Number of ELEMENTS in array MLP_Char_Ages = " + $MLP_Char_Ages.Count + ".");
         Write-Host("");

         for($x = 0; $x -LT $MLP_Char_Names.Count; $x++)
         {
             Write-Host("-----------------------------------------");
             Write-Host("Pony # " + ($x+1) + "");
             Write-Host("Name: " + $MLP_Char_Names[$x] + "");
             Write-Host("Age: " + $MLP_Char_Ages[$x] + "");
         }

         Write-Host("-----------------------------------------");
}

<# ------------------------------------------------------------------------------------------------- #>

function Two_Dimensional_Array_1
{
         #2-D Array, 6 rows with 2 columns
         $MLP_Characters = @( ("Twilight Sparkle","15"),
                              ("Fluttershy","17"),
                              ("Rainbow Dash","12"),
                              ("Rarity","14"),
                              ("Apple Jack","19"),
                              ("Pinkie Pie","16")  );

         Write-Host("`n`n");
         Write-Host("Number of ELEMENTS in parallel array MLP_Characters = " + $MLP_Characters.Count + ".");
         Write-Host("Number of ROWs = " + $MLP_Characters.Count); #Note: Rows = same as # elements in this case
         Write-Host("Number of COLUMNS = " + $MLP_Characters[0].Count);
        
         Write-Host("");
         
         for($x = 0; $x -LT $MLP_Characters.Count; $x++)
         {
             Write-Host("-----------------------------------------");
             Write-Host("Pony # " + ($x+1) + "");
             Write-Host("Name: " + $MLP_Characters[$x][0] + "");
             Write-Host("Age: " + $MLP_Characters[$x][1] + "");
         }

         Write-Host("-----------------------------------------");
         
}

<# ------------------------------------------------------------------------------------------------- #>

function Two_Dimensional_Array_2_New_Object
{
         #Note: When you create an array with "New-Object"?
         #It CHANGES the way you access the INDEX/subscript values of the array.
         #Also, you can use the method GetUpperBound() to get the last index value in 
         #a particular dimension of that array. So just add 1 to get # elements for that
         #dimension to offset the fencepost/off-by-one issue.

         #2-D array with 64 elements (8 rows by 8 columns)
         $ChessBoard = New-Object 'object[,]' 8,8; 
 
         Write-Host("`nTotal # elements in ChessBoard array = " + $ChessBoard.Count);
         Write-Host("Total X row elements in ChessBoard array = " + ($ChessBoard.GetUpperBound(0)+1));
         Write-Host("Total Y col elements in ChessBoard array = " + ($ChessBoard.GetUpperBound(1)+1));

              #Consume more memory
              for($x = 0; $x -LT ($ChessBoard.GetUpperBound(0)+1); $x++)
              {
                  for($y = 0; $y -LT ($ChessBoard.GetUpperBound(1)+1); $y++)
                  {
                      $ChessBoard[$x,$y] = "  `"" + ($x+1) + "," + ($y+1) + "`"";
                  }
              }

              Write("`n");

              #Create display output values to tax resources
              for($x = 0; $x -LT ($ChessBoard.GetUpperBound(0)+1); $x++)
              {
                  for($y = 0; $y -LT ($ChessBoard.GetUpperBound(1)+1); $y++)
                  {
                      Write-Host("$x,$y element value = " + $ChessBoard[$x,$y]);
                  }
              }
}

<# ------------------------------------------------------------------------------------------------- #>




<# --------------------------------------------- #>

class UNICORN
{
      [String] $Name = "Anonymous Unicorn";
      [Int] $Age = 16;

      Unicorn() 
      { Write-Host("Instantiating a UNICORN object."); }
}

<# --------------------------------------------- #>

function An_Array_Of_Programmer_Defined_Objects_1
{
         Write-Host("`n`n"); 

         $HERD = @();

         $U1 = New-Object Unicorn;
         $U1.Name = "Twilight Sparkle";
         $HERD += $U1;

         $U2 = New-Object Unicorn;
         $U2.Name = "Rarity";
         $HERD += $U2;

         $U3 = New-Object Unicorn;
         $U3.Name = "Princess Celestia";
         $HERD += $U3;

         Write-Host("");

         for($x = 0; $x -LT $HERD.Count; $x++)
         {
             Write-Host("   Unicorn " + ($x+1) + " = " + $HERD[$x].Name);
         }
}

<# ------------------------------------------------------------------------------------------------- #>

class Klingon_Bird_of_Prey
{
      [String] $FleetDesignation = "Anonymous Kahless";
      [Int] $Disruptors = 12;
      [Int] $QuantumTorpedos = 100;

      Klingon_Bird_of_Prey() 
      { Write-Host("Instantiating a Klingon_Bird_of_Prey object."); }      
}

<# --------------------------------------------- #>

function An_Array_Of_Programmer_Defined_Objects_2
{
         Write-Host("`n`n"); 
         
         $KlingongBattleFleet = @();

         $KBP1 = New-Object Klingon_Bird_of_Prey;
         $KBP1.FleetDesignation = "Kahless 1";
         $KlingongBattleFleet += $KBP1;

         $KBP2 = New-Object Klingon_Bird_of_Prey;
         $KBP2.FleetDesignation = "Kahless 2";
         $KlingongBattleFleet += $KBP2;

         $KBP3 = New-Object Klingon_Bird_of_Prey;
         $KBP3.FleetDesignation = "Kahless 3";
         $KlingongBattleFleet += $KBP3;

         Write-Host("");

         for($y = 0; $y -LT $KlingongBattleFleet.Count; $y++)
         {
             Write-Host("   Bird of Prey " + ($y+1) + " = " + $KlingongBattleFleet[$y].FleetDesignation);
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function Fixed_Array_Of_Programmer_Defined_Objects_1
{
         $HERD = New-Object UNICORN[] 3;

         Write-Host("`nNumber of elements in HERD = " + $HERD.Count);

         Write("`nBUILDING the UNICORN objects and POPULATING the Array.`n");

         for($z = 0; $z -LT $HERD.Count; $z++)
         {
              $HERD[$z] = New-Object UNICORN;
              $HERD[$z].Name = "Unicorn " + ($z+1) + "";
         }

         Write("`nRetrieving the UNICORN objects.`n");

         for($z = 0; $z -LT $HERD.Count; $z++)
         {
              Write-Host("   " + ($z+1) + " = " + $HERD[$z].Name + "");
         }
}

<# ------------------------------------------------------------------------------------------------- #>

function Fixed_Array_Of_Programmer_Defined_Objects_2
{
         $KlingongBattleFleet = New-Object Klingon_Bird_of_Prey[] 3;

         Write-Host("`nNumber of elements in KlingongBattleFleet = " + $KlingongBattleFleet.Count);

         Write("`nBUILDING the Klingon_Bird_of_Prey objects and POPULATING the Array.`n");

         for($z = 0; $z -LT $KlingongBattleFleet.Count; $z++)
         {
              $KlingongBattleFleet[$z] = New-Object Klingon_Bird_of_Prey;
              $KlingongBattleFleet[$z].FleetDesignation = "Kahless " + ($z+1) + "";
         }

         Write("`nRetrieving the Klingon_Bird_of_Prey objects.`n");

         for($z = 0; $z -LT $KlingongBattleFleet.Count; $z++)
         {
              Write-Host("   " + ($z+1) + " = " + $KlingongBattleFleet[$z].FleetDesignation + "");
         }
}

<# ------------------------------------------------------------------------------------------------- #>


#---------------Invocations---------------
#One_Dimensional_Array_ForEach;
#One_Dimensional_Array_For;
#Empty_Array_Of_Fixed_Size;
#Dynamic_Empty_Array_Of_Undetermined_Size;
#One_Dimensional_Parallel_Array;
#Two_Dimensional_Array_1;
#Two_Dimensional_Array_2_New_Object;
#An_Array_Of_Programmer_Defined_Objects_1;
#An_Array_Of_Programmer_Defined_Objects_2;
#Fixed_Array_Of_Programmer_Defined_Objects_1;
#Fixed_Array_Of_Programmer_Defined_Objects_2;



