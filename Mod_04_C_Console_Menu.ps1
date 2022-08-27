Clear;

Write("`n`n");

         $Menu = "LOOP";
         $Min = 1;
         $Max = 10;
         $NumbersToGuess = 3;
         $NumberGuessesPerNumber = 3;
         $GUESS = 0;
         $Score = 0;
         $The_Number = Get-Random -Minimum $Min -Maximum ($Max + 1);

         Clear;
         Write("`nNumber Guessing Game 4.0`n");
         Write("`nYou have the opportunity to guess " + $NumbersToGuess + " different numbers.")

         while($Menu -EQ "LOOP")
         {
              Write("------------------------------------------");
              Write("|      Choose a level of difficulty:     |");
              Write("|                                        |");
              Write("|      1 = EASY (1-5)                    |");
              Write("|      2 = NORMAL (1-10)                 |");
              Write("|      3 = HARD (1-100)                  |");
              Write("|                                        |");
              Write("------------------------------------------`n");

              $CHOICE = Read-Host("CHOICE?");

              switch($CHOICE)
              {
                 1 
                 {  
                     $Min = 1;
                     $Max = 5;
                     $Menu = "EXIT";
                 }
                 2 
                 {  
                     $Min = 1;
                     $Max = 10;
                     $Menu = "EXIT";
                 }
                 3 
                 {  
                     $Min = 1;
                     $Max = 100;
                     $Menu = "EXIT";
                 }
                 default 
                 {  
                     Write("`nInvalid CHOICE. Choose again.");
                     Read-Host("Press ENTER to continue."); 
                 }
              }
         }

         for($x = 0; $x -LT $NumbersToGuess; $x++)
         {
               $The_Number = Get-Random -Minimum $Min -Maximum ($Max + 1);

               Write("`n-----------------------------------------");
               Write("Guessing for Number: " + ($x+1) + "");

               Write("`nNumber " + ($x+1) + " is between " + $Min + " and " + $Max + ".");
               Write("You get " + $NumberGuessesPerNumber + " guesses for this number.");

               for($z = 0; $z -LT $NumberGuessesPerNumber; $z++)
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
                            $Score++;
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
               Write("Score: " + $Score + "");
         }

         Write("Final score for all " + $NumbersToGuess + " numbers is: " + $Score + "");


Write("`n`n");