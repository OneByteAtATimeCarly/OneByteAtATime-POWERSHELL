#Title: PowerShell - Module 06 - Arrays - Word Guessing Game
#Author: Carly S. Germany
#Date: 06/08/2020

<# ------------------------------------------------------------------- #>

function RANDOM($NUM)
{
         $The_Number = Get-Random -Minimum 0 -Maximum ($NUM + 1);
         return $The_Number;
}

<# ------------------------------------------------------------------- #>

function MAIN
{
         $WordBank = @( ("entitlement", "You think you deserve it."),
                        ("plagiarism", "Taking the credit for someone else's work."),
                        ("revenge", "Don't get mad, get even."),
                        ("generation", "By survival of the FITTEST, the present one will soon be extinct."),
                        ("pathetic", "It's always someone else's fault, it's not my responsibility."),
                        ("obsolete", "No longer relevant to the situation."),
                        ("entrapment", "Deceptively misleading situation..."),
                        ("scapegoat", "Blame it on me."),
                        ("cryptic", "l00k @ th1s, 1 m sew kewl n a11 l0ft3"),
                        ("disembowel", "Gut-wrenching..."),
                        ("adolescent", "You're not the boss of me..."),
                        ("agoraphobia", "Fear of open spaces..."),
                        ("claustrophobia", "Fear of closed spaces..."),
                        ("apocalyptic", "Of or pertaining to the end..."),
                        ("karma", "Getting what you deserve..."));
         
         $NumberOfWords = $WordBank.Count;
         $NumWordsToGuess = 5;
         $RandomWords = New-Object int[] $NumWordsToGuess;
         $RANDNUM = 0;
         $Counter = 0;
         $NumGuesses = 3;
         $SCRAMBLE = "";
         $GUESS = "";
         $Score = 0;
         
         Clear;
         Write("`nGuess My WORD 1.0");

         Write("`nYou must guess " + $NumWordsToGuess + " scrambled words.");
         Write("You will get " + $NumGuesses + " guesses per word.");

         #Must Generate array of random numbers without DUPLICATES

         #Loop through EVERY element in RandomWords Array
         while($Counter -LT $RandomWords.Count)
         {
              #Generate a random number between 1 and Number of Words in Word Bank
              #$RANDNUM = Get-Random -Minimum 1 -Maximum ($NumberOfWords-1);
              $RANDNUM = RANDOM -NUM ($NumberOfWords-1);
              Write-Host("Random Number = " + $RANDNUM);

              $repeat = $false;

              do
              {
                  #Loop again through every element in RandomWords Array
                  #Note: This is a form of RECURSION
                  for($i=0; $i -LT $RandomWords.Count; $i++)
                  {
                      #If the new random number generated matches any number inside array?
                      #Set repeat from $false to $true to re-generate the random number.
                      if($RANDNUM -EQ $RandomWords[$i])
                      {
                          $repeat = $true;
                          break;
                      }
                      #We don't want to overwrite the previous element's value, so
                      #if $i is not equal to $Counter we increment $i to advance
                      #through array until $i IS equal to $Counter 
                      elseif($i -EQ $Counter)
                      {
                         $RandomWords[$Counter] = $RANDNUM;
                         $Counter++;
                         $repeat = $true;
                         break;
                      }
                  }

               }while(!$repeat);
         }

         Write-Host("`n`nFinal Values of Elements in RandomWords Array is:");
         
         for($x = 0; $X -LT $RandomWords.Count; $x++)
         {
             Write-Host("Element " + ($x+1) + " = " + $RandomWords[$x]);
         }


}

<# ------------------------------------------------------------------- #>

#------- Invocations -------
MAIN;




           

     

           

           

           

           

           

           

           

           

           

           

            