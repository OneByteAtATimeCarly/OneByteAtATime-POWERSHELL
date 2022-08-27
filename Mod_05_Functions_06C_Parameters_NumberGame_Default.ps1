#Title: PowerShell - Module 05 - Functions 6 - Parameters 1
#Author: Carly S. Germany
#Date: 06/07/2020


<# --------------------------------------------------------------------------------- #>

function Guess_Number
{
         param 
         (
             [Int]$Min = $(throw "-Min is REQUIRED"), 
             [Int]$Max = $(throw "-Max is REQUIRED"),
             [Int]$NumGuesses = $(Read-Host "How many guesses?")
         )

         Write("`nGuess my number between " + $Min + " and " + $Max + ".");
         Write("You get " + $NumGuesses + " guesses.");

         $The_Number = Get-Random -Minimum $Min -Maximum ($Max + 1);

         for($z = 0; $z -LT $NumGuesses; $z++)
         {
             [Int]$GUESS = Read-Host("`nAttempt # " + ($z+1) + "?");
             
             if($GUESS -LT $Min)
             {
                  Write("Invalid guess. Less than minimum.");
             }
             elseif($GUESS -GT $Max)
             {
                  Write("Invalid guess. Greater than maximum.");
             }
             else
             {
                  Write("Guess is valid - within range.");

                  if($GUESS -EQ $The_Number)
                  {
                      Write("You did it! You guessed my number.");
                      $z = 3;
                  }
                  elseif($GUESS -GT $The_Number)
                  {
                      Write("My number was smaller.");
                  }
                  else
                  {
                      Write("My number was bigger.");
                  }

             } 
         }

         Write("`nMy number was: " + $The_Number + "");       
}

<# --------------------------------------------------------------------------------- #>

#------- INVOCATIONS -----------
Clear;
Write("`nNumber Guessing Game 1.0`n");

#Guess_Number;
Guess_Number -Min 1 -Max 5 -NumGuesses 3;



