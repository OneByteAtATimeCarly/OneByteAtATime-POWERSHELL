#Title: PowerShell - Module 04 - Repetition Structures
#Author: Carly S. Germany
#Date: 05/04/2020


#A. Basic FOR LOOP

<# --------------------------------------------------------------------------------- #>

function Basic_For_Loop_1
{
         for($X = 0; $X -LT 5; $X++)
         {
             Write("Interation # " + ($X+1) + ".");
         }
}

<# --------------------------------------------------------------------------------- #>

function Basic_For_Loop_2
{
         Write("`n");
         $OUTPUT = "*";

         for($X = 0; $X -LT 5; $X++)
         {
             Write($OUTPUT);
             $OUTPUT = $OUTPUT + "*";
         }
}

<# --------------------------------------------------------------------------------- #>

function Basic_NESTED_For_Loop
{
         Write("`n");
         $ROWS = 5;
         $COLUMNS = 10;

         for($X = 0; $X -LT $ROWS; $X++)
         {
              for($Y = 0; $Y -LT $COLUMNS; $Y++)
              {
                  Write("Row = " + ($X+1) + ". Column = " + ($Y+1) + "");
              }

              Write("---------------------------------------");
         }
}

<# --------------------------------------------------------------------------------- #>


#B. ForEach LOOP

<# --------------------------------------------------------------------------------- #>

function Basic_ForEach_LOOP
{
         Write("`n");

         $MLP_Main_Characters = @("Twilight Sparkle",
                                  "Fluttershy",
                                  "Rainbow Dash",
                                  "Apple Jack",
                                  "Rarity",
                                  "Pinkie Pie");
         $PonyCounter = 0;

         ForEach($PONY in $MLP_Main_Characters)
         {
              $PonyCounter++;
              Write("Character " + $PonyCounter + " is " + $PONY);
         }
}

<# --------------------------------------------------------------------------------- #>

#C. While LOOP

<# --------------------------------------------------------------------------------- #>

function Basic_While_LOOP
{
         $LuckyNumber = 444;
         $Counter = 444;

         while($Counter -LT $LuckyNumber)
         {
            $Counter++;
            Write("LuckyNumber = " + $Counter + ".");
         }

}

<# --------------------------------------------------------------------------------- #>

#D. Do While LOOP (will always execute at least ONCE)

<# --------------------------------------------------------------------------------- #>

function Basic_Do_While_LOOP
{
         $LuckyNumber = 444;
         $Counter = 0;

         do
         {
            $Counter++;
            Write("LuckyNumber = " + $Counter + ".");
         }
         while($Counter -LT $LuckyNumber)
}

<# --------------------------------------------------------------------------------- #>

#E. Do Until LOOP

<# --------------------------------------------------------------------------------- #>

function BASIC_DO_Until_LOOP
{
         $LuckyNumber = 444;
         $Counter = 0;

         do
         {
            $Counter++;
            Write("LuckyNumber = " + $Counter + ".");
         }
         until($Counter -EQ $LuckyNumber)
}

<# --------------------------------------------------------------------------------- #>

