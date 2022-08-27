#Title: PowerShell - Module 06 - Arrays - Multi-dimensional vs Paralell Arrays - TRIVIA Game
#Author: Carly S. Germany
#Date: 06/10/2020

<# --------------------------------------------------------------------------------------------------------- #>

function QUIZ1_MULTI_DIMENSIONAL_ARRAY
{
         #Example of MULTI-DIMENSIONAL Array, an array with 5 rows and 4 columns.

         $MaxWrongGuesses = 3;
         $TotalWrongGuesses = 0;
         $WrongPerQuestionCount = 0;
         $RightCount = 0;
         $Score = 0;
         $GuessWasCorrect = $false;  

         $QandClueandA = ( ("El dia de los muertos? ","october 30","Same month as Halloween.","****"),
                           ("Favorite game? ","descent 3","Maze-like first person shooter game.","****"),
                           ("Best sci-fi series ever made? ","bsg","Frack off cylon!","****"),
                           ("Favorite hobby? ","music","The hills are alive...","****"),
                           ("Popular vacation destination? ","bahamas","Ja man, on da beaches.","****") );

         Clear;
         Write("`nQUIZ1 - Using a Multi-Dimensional Array`n");
         $null = Read-Host("Press ENTER to begin the QUIZ.");

         for($x = 0; $x -LT $QandClueandA.Count; $x++)
         { 
              Clear;
              Write("`nQuestion " + ($x+1) + ": " + $QandClueandA[$x][0]);

              $QandClueandA[$x][3] = (Read-Host("`nANSWER?")).ToLower();
              Write("You said: " + $QandClueandA[$x][3]);

              if($QandClueandA[$x][1] -NE $QandClueandA[$x][3])
              {
                    $TotalWrongGuesses++;
                    $WrongPerQuestionCount++;

                    if($WrongPerQuestionCount -LT $MaxWrongGuesses)
                    {
                        Write("`nSorry. That was wrong.");
                        Write("Here's a hint: " + $QandClueandA[$x][2] + "");
                        $x--;       
                    }
                    else
                    {
                        Write("`nUnfortunately, you have exceeded the maximim number" +
                              "`nof guesses for this question, which is: " + 
                              $MaxWrongGuesses + "." + "`n`nMoving on to next question now.");
                    }   
              }
             else
             { 
                 Write("`nThat's it! You got it right!");
                 $Score++; 
                 $RightCount++;
                 $GuessWasCorrect = $true;
             }  

             Write("`nCurrent Status:`nTotal Wrong Guesses: " + $TotalWrongGuesses +
                   "`nWrong Guesses for current question: " + $WrongPerQuestionCount +
                   "`nQuestions Answered Correctly: " + $RightCount + "`n`n");

             #Reset wrong counter for next question if exceeded max num guesses or player is correct
             if($WrongPerQuestionCount -GT ($MaxWrongGuesses-1) -OR $GuessWasCorrect -EQ $true) 
             { 
                 Write("`nResetting wrong question counter.");
                 $WrongPerQuestionCount = 0;
                 $GuessWasCorrect = $false; 
             } 

             $null = Read-Host("Press ENTER to continue.");
         }

         Write("`nQUIZ1 complete.`n");

         $FinalScore = $Score * 20; 

         switch($FinalScore)
         {                       
             0 {  Write("Score: " + $FinalScore +"`nComment: NOTHING? Not 1? Try GUESSING next time.`nGrade: F"); }
             20 { Write("Score: " + $FinalScore + "`nComment: Got at least 1 right.`nGrade: F"); }
             40 { Write("Score: " + $FinalScore + "`nComment: Got at least 2 right.`nGrade: F"); }
             60 { Write("Score: " + $FinalScore + "`nComment: Got at least 3 right.`nGrade: D"); }
             80 { Write("Score: " + $FinalScore + "`nComment: Got at least 4 right.`nGrade: B"); }
             100 { Write("Score: " + $FinalScore + "`nComment: Got ALL of them right! Well done!`nGrade: A"); }
             default { Write("Should never happen."); }                 
         }  

         Write("`nExiting QUIZ1 - using a Multi-Dimensional Array ...`n");
         $null = Read-Host("`nPress ENTER to continue.");
}

<# --------------------------------------------------------------------------------------------------------- #>

function QUIZ2_PARALELL_ARRAY
{
         #Example of PARALELL Arrays
         $MaxWrongGuesses = 3;
         $TotalWrongGuesses = 0;
         $WrongPerQuestionCount = 0;
         $RightCount = 0;
         $Score = 0;  

         $Questions= @("Most lethal, maneuverable dog fighter America ever made?", 
                       "Who was the harbinger of death that actually saved humans and Cylons?", 
                       "In the end it doesn't even matter?", 
                       "Sci-Fi novel by Isaac Asimov that introduced `"3 Laws Safe`"?", 
                       "Quantum theory that allows instantaneous FTL communication over any distance?");

         $Answers = @("f-14 tomcat", 
                      "starbuck", 
                      "lincoln park", 
                      "i robot", 
                      "entanglement");

         $Clues= @("When jet fighters MEOW ...", 
                   "Apollo's BFF", 
                   "One thing, I don't know why, doesn't even matter how hard you try.", 
                   "Cannot by action or omission of action harm a human.", 
                   "Even if on opposite sides of the universe, 1 spin relates to the other.");

         $UsersInput = @( "", "", "", "", "");

         Clear;
         Write("`nQUIZ2 - Using a Parallel Array`n");
         $null = Read-Host("Press ENTER to begin the QUIZ.");

         for($x = 0; $x -LT $Questions.Count; $x++)
         { 
              Clear;
              Write("`nQuestion " + ($x+1) + ": " + $Questions[$x]);

              $UsersInput[$x] = (Read-Host("Answer?")).ToLower(); 
              Write("You said: " + $UsersInput[$x]);

              if($UsersInput[$x] -NE $Answers[$x])
              {
                  $TotalWrongGuesses++;
                  $WrongPerQuestionCount++;

                  if($WrongPerQuestionCount -LT $MaxWrongGuesses)
                  {
                        Write("`nSorry. That was wrong.");
                        Write("Here's a hint: " + $Clues[$x] + "");
                        $x--;       
                  }
                  else
                  {
                        Write("`nUnfortunately, you have exceeded the maximim number" +
                              "`nof guesses for this question, which is: " + 
                              $MaxWrongGuesses + "." + "`n`nMoving on to next question now.");
                  }                    
               }
               else
               { 
                  Write("`nThat's it! You got it right!");
                  $Score++; 
                  $RightCount++;
                  $WrongPerQuestionCount = 0;  
               }     

             Write("`nCurrent Status:`nTotal Wrong Guesses: " + $TotalWrongGuesses +
                   "`nWrong Guesses for current question: " + $WrongPerQuestionCount +
                   "`nQuestions Answered Correctly: " + $RightCount + "`n`n");

             #Reset wrong counter for next question if exceeded max num guesses or player is correct
             if($WrongPerQuestionCount -GT ($MaxWrongGuesses-1)) 
             { 
                 Write("`nResetting wrong question counter.");
                 $WrongPerQuestionCount = 0; 
             } 

             $null = Read-Host("Press ENTER to continue.");

          }

          Write("`nQUIZ2 complete.`n");

          $FinalScore = $Score * 20; 

          switch($FinalScore)
          {                       
              0 {  Write("Score: " + $FinalScore +"`nComment: NOTHING? Not 1? Try GUESSING next time.`nGrade: F"); }
              20 { Write("Score: " + $FinalScore + "`nComment: Got at least 1 right.`nGrade: F"); }
              40 { Write("Score: " + $FinalScore + "`nComment: Got at least 2 right.`nGrade: F"); }
              60 { Write("Score: " + $FinalScore + "`nComment: Got at least 3 right.`nGrade: D"); }
              80 { Write("Score: " + $FinalScore + "`nComment: Got at least 4 right.`nGrade: B"); }
              100 { Write("Score: " + $FinalScore + "`nComment: Got ALL of them right! Well done!`nGrade: A"); }
              default { Write("Should never happen."); }                 
          }

          Write("`nExiting QUIZ2 - Using a Parallel Array ...`n");
          $null = Read-Host("`nPress ENTER to continue.`n");
}

<# --------------------------------------------------------------------------------------------------------- #>

function MAIN
{
         $choice = "";

         Write("`n    Array QUIZ 1.0`n`n");

         while($choice[0] -NE 'q')
         {
             Clear;

             Write("`nChoose an example to run:`n`n" +
                   "--------------------------------------`n" +
                   "|                                    |`n" +
                   "|   (M)ulti-dimensional Array Quiz   |`n" +
                   "|   (P)arallel Array Quiz            |`n" +
                   "|   (Q)uit                           |`n" +
                   "|                                    |`n" + 
                   "--------------------------------------" );

             $choice = (Read-Host("`nCHOICE?")).ToLower();

             switch($choice)
             {
                 'm' { QUIZ1_MULTI_DIMENSIONAL_ARRAY; }
                 'p' { QUIZ2_PARALELL_ARRAY; }
                 'q' { break; }
                 default { $null = Read-Host("`nInvalid choice. Press ENTER to continue."); }
             }           
         }         

        Write("`nExiting Array QUIZ 1.0 ...");
}

<# --------------------------------------------------------------------------------------------------------- #>



# ---------- Invocations ----------
MAIN;

