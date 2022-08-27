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

         #Generate array of random numbers without DUPLICATES
         while($Counter -LT $RandomWords.Count)
         {
              $RANDNUM = RANDOM -NUM ($NumberOfWords-1);
              $repeat = $false;

              do
              {
                  for($i=0; $i -LT $RandomWords.Count; $i++)
                  {
                      if($RANDNUM -EQ $RandomWords[$i])
                      {
                          $repeat = $true;
                          break;
                      }
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

         Write-Host("RandomWords array = " + $RandomWords);
         
              for($x = 0; $x -LT $NumWordsToGuess; $x++)
              {
                  $RandWord = $RandomWords[$x];

                  $WORD = $WordBank[$RandWord][0];
                  $CLUE = $WordBank[$RandWord][1];
                  $SCRAMBLE = $WORD.ToCharArray();
                  
                  #Scramble Randomly Chosen Word like a Bubble Sort
                  for($y = 0; $y -LT $WORD.length; $y++)
                  {
                      $RandNum = RANDOM -NUM ($WORD.length - 1);
                      $TEMP1 = $SCRAMBLE[$RandNum];
                      $TEMP2 = $SCRAMBLE[$RandNum-1];
                      $SCRAMBLE[$RandNum-1] = $TEMP1;
                      $SCRAMBLE[$RandNum] = $TEMP2;
                  }

                  Write("`nGuessing for word # " + ($x+1) + ".");
                  Write("Clue: " + $CLUE);
                  Write("Scramble: " + $SCRAMBLE);
                  Write("------------------------`n");

                  for($a = 0; $a -LT $NumGuesses; $a++)
                  {
                      $GUESS = Read-Host("Attempt # " + ($a+1) + "?");

                      if($GUESS -EQ $WORD)
                      {
                         Write("`nYou did it! You guessed my word.");
                         Write("My word was: " + $WORD);
                         $a = $NumGuesses;
                         $Score++;
                         $null = Read-Host("`nPress ENTER to continue");
                      }
                      else
                      {
                         if($a -LT ($NumGuesses-1))
                         { 
                            Write("Sorry, you did not guess my word.`n"); 
                         }
                         else
                         { 
                            Write("Sorry, you did not guess my word.`n");
                            Write("You are all out of guesses for this word.");
                            Write("My word was: " + $WORD);
                            $null = Read-Host("`nPress ENTER to continue");
                         }
                      }
                  }

                  Clear;
              }

         Write("`nFinal SCORE: " + $Score);
         Write("`n");
         
}

<# ------------------------------------------------------------------- #>

#------- Invocations -------
MAIN;




           

     

           

           

           

           

           

           

           

           

           

           

            