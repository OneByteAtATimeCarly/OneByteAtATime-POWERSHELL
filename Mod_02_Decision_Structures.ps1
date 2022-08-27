#Title: PowerShell - Module 02 Decision Structures
#Author: Carly S. Germany
#Date: 04/24/2020

#Note: One of the most useful things to learn in Powershell or any programming language after variables and data
#types is DECISION STRUCTURES. These will allow you to do things with the values stored in your variables and
#code logic and behavior that will flow in different ways based on those values. There are two basic decision
#structures in most programming languages. Powershell is no exception.

<# ----------------------------------------------------------------------------------------------------- #>

#1. The IF/ELSE decision structure

#-----Example 1 - Guess My Number---------------

function Guess_My_Number_1
{
         $MyNumber = 444;
         $PlayersGuess = 0;

         Write("`nGreetings, player one.");
         Write-Host("Can you guess my number? ") -NoNewLine;

         $PlayersGuess = $Host.UI.ReadLine();

         if($PlayersGuess -EQ "444")
         { Write("Yes! That's it! You guessed my number!"); }
         else
         { Write("Sorry, that was wrong. You did NOT guess my number."); }
}

#-----------------------------------------------

function Guess_My_Number_2
{
         $MyNumber = 444;
         $PlayersGuess = 0;

         Write("`nGreetings, player one.");

         $PlayersGuess = Read-Host("Can you guess my number?");

         if($PlayersGuess -EQ "444")
         { Write("Yes! That's it! You guessed my number!"); }
         else
         { Write("Sorry, that was wrong. You did NOT guess my number."); }

}

#-----------------------------------------------

function Guess_My_Random_Number_1
{
         $MyNumber = 0;
         $PlayersGuess = 0;

         Write("`nGreetings, player one.");
         Write("Generating a random number between 1 and 10.");

         #Generates random #. Max must be +1 for offset
         $MyNumber = Get-Random -Minimum 1 -Maximum 11; 

         $PlayersGuess = Read-Host("Can you guess my number?");

         if($PlayersGuess -EQ $MyNumber)
         { Write("Wow! You guessed my number!"); }
         else
         { Write("Sorry. You did NOT guess my number."); }

         Write("`nThe random number generated was: " + $MyNumber);

}

#-----------------------------------------------

function Guess_My_Random_Number_2
{
         $MyNumber = 0;
         $PlayersGuess = 0;
         $MAXnum = 10;
         $MINnum = 1;

         Write("`nGreetings, player one.");
         Write("Generating a random number between " + $MINnum + " and " + $MAXnum + ".");

         #Remember: Max must be +1 for offset
         $MyNumber = Get-Random -Minimum $MINnum -Maximum ($MAXnum + 1);

         #Note: Still not what we expect cause processed as STRING, not INT.
         #So if we enter a negative number it won't process logic properly
         $PlayersGuess = Read-Host("Can you guess my number?");

         if($PlayersGuess -LT $MINnum)
         {
             Write("INVALID. Too low. Your guess is BELOW the minimum range.");
         }
         elseif($PlayersGuess -GT $MAXnum)
         { 
             Write("INVALID. Too high. Your guess is ABOVE the maximum range."); 
         }
         else
         {
             Write("You entered valid number between " + $MINnum + " and " + $MAXnum + ".");
             
             if($PlayersGuess -EQ $MyNumber)
             { 
                 Write("Wow! You guessed my number!"); 
             }
             else
             { 
                 Write("Sorry. You did NOT guess my number."); 
             }        
         }

         Write("`nThe random number generated was: " + $MyNumber);
}

#-----------------------------------------------

function Guess_My_Random_Number_3
{
         $MyNumber = 0;
         $PlayersGuess = 0;
         $MAXnum = 10;
         $MINnum = 1;

         Write("`nGreetings, player one.");
         Write("Generating a random number between " + $MINnum + " and " + $MAXnum + ".");

         #Remember: Max must be +1 for offset
         $MyNumber = Get-Random -Minimum $MINnum -Maximum ($MAXnum + 1);

         #Note: Here we take STRING data type and cast/convert to Int.
         #Now the logic will work properly
         [Int]$PlayersGuess = Read-Host("Can you guess my number?");

         if($PlayersGuess -LT $MINnum)
         {
             Write("INVALID. Too low. Your guess is BELOW the minimum range.");
         }
         elseif($PlayersGuess -GT $MAXnum)
         { 
             Write("INVALID. Too high. Your guess is ABOVE the maximum range."); 
         }
         else
         {
             Write("You entered valid number between " + $MINnum + " and " + $MAXnum + ".");
             
             if($PlayersGuess -EQ $MyNumber)
             { 
                 Write("Wow! You guessed my number!"); 
             }
             else
             { 
                 Write("Sorry. You did NOT guess my number."); 
             }        
         }

         Write("`nThe random number generated was: " + $MyNumber);
}

#-----------------------------------------------

#A. Hard Coding: Notice above that because we are no longer HARD CODING values into our logic?
#The program is MUCH easier to modify, adapt, evolve and change.
#By declaring our constants as variables at the top? We can change them only once
#and not have to change those values dozens or hundreds of times throughout the code
#when we are tweaking and modifying things or extending the program's funciotnality.
#Writing code that is easy to maintain, modify and read is good practice. Avoid hard docing values.

#B. Nesting: Notice above how we are NESTING one block of if/else decision structure inside another?
#This is a way to write code that can make more complex logic decisions based on the data fed to it.
#Complex logic in code can involve dozens or even hundreds of layers of decision structires nested
#inside each other that allows the logic to branch off into multiplt contingencies.

<# ----------------------------------------------------------------------------------------------------- #>

#2. The SWITCH decision structure

#Switch statements are more simplistic decision structures. They cannot handle the comparisons, evaluations
#and complexity of nested if/else structures. However, they can be a very effective way to handle simple 
#decisions in powershell. Such as if you want to create a menu in your program.

#-----------------------------------------------

function Simple_Switch
{
         Write("`nEmotions I understand are: happy,sad,angry")

         $Feelings = Read-Host("How do you feel today?");

         switch($Feelings)
         {
            "happy" { Write("Yay! I will rejoice with you."); }
            "sad" { Write("I'm sorry. Need a hug?"); }
            "angry" { Write("Close your eyes. Breath deep. Count to 10."); }
            default { Write("Sorry. I do not understand that emotion."); }
         }
}

#-----------------------------------------------

function Simple_Number_Game_Using_Switch
{
         $MyNumber = 3;

         $MyNumber = Read-Host("Guess my number?");

         switch($MyNumber)
         {
            1 { Write("My number is HIGHER."); }
            2 { Write("My number is HIGHER."); }
            3 { Write("YES! You guessed my number!"); }
            4 { Write("My number is LOWER."); }
            5 { Write("My number is LOWER."); }
            default { Write("INVALID guess. Guess between 1 and 5."); }
         }
}

#-----------------------------------------------

function Menu_Main_Using_Switch
{
         Write("`n");
         Write("     -------- Main Menu --------");
         Write("     |                          |");
         Write("     |    (C)reate Pokemon      |");
         Write("     |    (D)isplay Pokemon     |");
         Write("     |    (S)ave Pokemon        |");
         Write("     |    (L)oad Pokemon        |");
         Write("     |    (B)uild Pokemon Test  |");
         Write("     |    (X) Exit              |");
         Write("     |                          |");
         Write("     ---------------------------");
         Write("");

            switch(Read-Host "Choose")
            { 
                c {   
                      Write-Host("`n  Create Pokemon Method.`n") -foregroundcolor "Red"; 
                      break;
                  };

                d {  
                     Write-Host("`n  Display Pokemon Method.`n") -foregroundcolor "Red"; 
                     break;
                  };

                s {   
                     Write-Host("`n  Save Pokemon Method.`n") -foregroundcolor "Red";
                     break;
                  };

                l {  
                     Write-Host("`n  Load Pokemon Method.`n") -foregroundcolor "Red";
                     break;
                  };

                b {  
                     Write-Host("`n  Build Pokemon Test.`n") -foregroundcolor "Red";
                     break;
                  };

                x {  Write-Host("`n  Exiting ...") -foregroundcolor "Red"; $LOOP = "STOP";
                     break;
                  };

                default {   
                           Write-Host("`n  Invalid entry");
                        };

           } #close switch 
}

<# ----------------------------------------------------------------------------------------------------- #>

#A bit more complex swtich statment using {} to evaluate an expression before switching on the result.
#We will combine a switch statment in with our if/else decision structure.

function Guess_My_Random_Number_Using_Switch
{
         $MyNumber = 0;
         $PlayersGuess = 0;
         $MAXnum = 5;
         $MINnum = 1;

         Write("`nGreetings, player one.");
         Write("Generating a random number between " + $MINnum + " and " + $MAXnum + ".");

         #Remember: Max must be +1 for offset
         $MyNumber = Get-Random -Minimum $MINnum -Maximum ($MAXnum + 1);

         #Note: Here we take STRING data type and cast/convert to Int.
         #Now the logic will work properly
         [Int]$PlayersGuess = Read-Host("Can you guess my number?");

         if($PlayersGuess -LT $MINnum)
         {
             Write("INVALID. Too low. Your guess is BELOW the minimum range.");
         }
         elseif($PlayersGuess -GT $MAXnum)
         { 
             Write("INVALID. Too high. Your guess is ABOVE the maximum range."); 
         }
         else
         {
             switch($PlayersGuess)
             {
                {$PlayersGuess -LT $MyNumber} { Write("Guessed LESS than my number."); }
                {$PlayersGuess -GT $MyNumber} { Write("Guessed MORE than my number."); }
                {$PlayersGuess -EQ $MyNumber} { Write("Yes! You guessed my number!"); }
                default { Write("Invalid response."); }

             }   
         }

         Write("`nThe random number generated was: " + $MyNumber);

         <# ----------------------------------------------------------------------------------------------------- #>
}

#Last note: Using "break". It is common to use break after a switch statement. This will become more important
#after we cover repetition structures in the near future. The key word "break" stops the flow of the program 
#from executing any evaluations or switch cases below the case that has been matches and exits the switch.

#Example:

function Simple_Number_Game_Using_Switch_Break
{
         $MyNumber = 3;

         $MyNumber = Read-Host("Guess my number?");

         switch($MyNumber)
         {
            1 { Write("My number is HIGHER."); 
                break;
              }
            2 { Write("My number is HIGHER.");  
                break;
              }
            3 { Write("YES! You guessed my number!");  
                break;
              }
            4 { Write("My number is LOWER.");  
                break;
              }
            5 { Write("My number is LOWER.");  
                break;
              }
            default { Write("INVALID guess. Guess between 1 and 5.");  
                      break;
                    }
         }
}

<# ----------------------------------------------------------------------------------------------------- #>