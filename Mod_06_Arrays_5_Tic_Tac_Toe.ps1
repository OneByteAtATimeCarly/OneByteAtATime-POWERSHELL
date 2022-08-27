#Title: PowerShell - Module 06 - Arrays - Tic Tac Toe
#Author: Carly S. Germany
#Date: 06/08/2020

$global:EASY = $false;

<# ------------------------------------------------------------------- #>

function MAIN
{
         $GameBoard = @(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
         $SQUARES = 9;
         $PlayerPiece = "";
         $ComputerPiece = "";
         $CurrentPlayer = "";

         #Start game and get player's choice to go first or last.
         $PlayerPiece = Introduction;

         #Whatever player chooses, 'X' or 'O'? The computer gets the other.    
         if($PlayerPiece -EQ "X")  
         { $ComputerPiece = "O"; }
         else 
         { $ComputerPiece = "X"; }
    
         $CurrentPlayer = "X";
         
         Display -BOARD $GameBoard;

         while((CheckForAWinner -BOARD $GameBoard -SQUARES $SQUARES) -EQ 'N')
         {
             Write("CurrentPlayer = " + $CurrentPlayer);

             if($CurrentPlayer -EQ $PlayerPiece)
             {
                 Write("Player's move.");
                 $CHOICE = PlayerPlays -BOARD $GameBoard -SQUARES $SQUARES -PlayerP $PlayerPiece;
                 $N = $CHOICE[1] -as [int]; #Note: Have to shave off xtra from Read-Host
                 $GameBoard[$N] = $PlayerPiece;
             }
             else
             {   
                 Write("Computer's move.");
                 $CHOICE = ComputerPlays -BOARD $GameBoard -SQUARES $SQUARES -PlayerP $PlayerPiece -ComputerP $ComputerPiece;
                 $N = $CHOICE -as [int];
                 $GameBoard[$N] = $ComputerPiece;
             }

             Display -BOARD $GameBoard;
        
             if($CurrentPlayer -EQ $PlayerPiece)
             { $CurrentPlayer = $ComputerPiece; }
             else
             { $CurrentPlayer = $PlayerPiece; }
               
         }  
         
         DisplayWinner -TheWinner (CheckForAWinner -BOARD $GameBoard -SQUARES $SQUARES) -ComputerP $ComputerPiece -PlayerP $PlayerPiece;

         Write("`n`nGame Over");
         Write("Exiting Tic Tac Toe 1.0`n`n");
         
}

<# ------------------------------------------------------------------- #>

function Introduction
{
         $FirstOrSecond = "";
         $intelligence = "";
         $PlayerPiece = "z";

         Clear;
         
         Write-Host("`n                   Welcome to Tic Tac Toe 1.0.`n");
         Write-Host("This game uses very simple A.I. in the form of several decision structures.");
         Write-Host("To play, enter a number, 0 - 8.  The number you enter will");
         Write-Host("indicate which of 9 positions you desire below:`n`n");
    
         Write-Host("                 0 | 1 | 2`n");
         Write-Host("                 ---------`n");
         Write-Host("                 3 | 4 | 5`n");
         Write-Host("                 ---------`n");
         Write-Host("                 6 | 7 | 8`n`n");

         Write-Host("The computer will play as your oponent in this game.`n"); 

         

         while($intelligence -NE "i" -AND $intelligence -NE "s")
         {
            Write-Host("`tDo you want your computer opponent to be (i)ntelligent or (s)imple?`n" +
                  "`tChoosing this option for your opponent sets the difficulty of the game.`n");

            $intelligence = (Read-Host("CHOICE")).ToLower();
    
            switch($intelligence)
            {
                "i" {
                       Write-Host("`nO.k., your computer opponent will be more dificult to beat.`n"); 
                       $global:EASY = $false;
                       break;
                    }
                        
                "s" { 
                       Write-Host("`nO.k., your computer opponent will be easier to beat.`n"); 
                       $global:EASY = $true;
                       break;
                    }

                default { Write-Host("That is an invalid response.`n`n"); break; }                     
            }

         }

         while($FirstOrSecond -NE "y" -AND $FirstOrSecond -NE "n")
         {
              Write-Host("Do you want to make the first move (y/n)?`n");
              $FirstOrSecond = (Read-Host("CHOICE")).ToLower();
    
              switch($FirstOrSecond)
              {
                 "y" {
                       Write-Host("`nOk, you take the first move.");
                       Write-Host("You are X. Computer is O.");
                       $PlayerPiece = "X";
                       break;
                     }

                 "n"{
                       Write-Host("`nO.k., the computer takes the first move."); 
                       Write-Host("You are O. Computer is X.");
                       $PlayerPiece = "O";
                       break;
                     }

                 default { Write-Host("That is an invalid response.`n`n"); break; }                     
              }
         }

         $null = Read-Host("`nPress ENTER to continue.");
         Clear;
       
         return $PlayerPiece;
}

<# ------------------------------------------------------------------- #>


#This function accepts an entire array as an argument
function Display([char[]] $BOARD)
{
         Write-Host("`n");
         Write-Host("`t" + $BOARD[0] + " | " + $BOARD[1] + " | " + $BOARD[2]);
         Write-Host("`t---------");
         Write-Host("`t" + $BOARD[3] + " | " + $BOARD[4] + " | " + $BOARD[5]);
         Write-Host("`t---------");
         Write-Host("`t" + $BOARD[6] + " | " + $BOARD[7] + " | " + $BOARD[8]);
         Write-Host("`n`n");      
}

<# ------------------------------------------------------------------- #>

#This function accepts an entire array as an argument
function CheckForAWinner([char[]] $BOARD,$SQUARES)
{
         #Define all the wining combinations: horizontal + vertical + diagonal
         $WINNING_ROWS = @( (0, 1, 2),
                            (3, 4, 5),
                            (6, 7, 8),
                            (0, 3, 6),
                            (1, 4, 7),
                            (2, 5, 8),
                            (0, 4, 8),
                            (2, 4, 6) );  

         $TOTAL_ROWS = 8; 
    
         #If an row has three values that are the same? We have a winner.
         #We will either return 'X' or 'O' as the winner. Or a TIE and 
         #end the game. Or else we will return 'N' and keep playing the game.
    
         for($row = 0; $row -LT $TOTAL_ROWS; ++$row)
         {
             if ( ($BOARD[$WINNING_ROWS[$row][0]] -NE ' ') -AND 
                  ($BOARD[$WINNING_ROWS[$row][0]] -EQ $BOARD[$WINNING_ROWS[$row][1]]) -AND 
                  ($BOARD[$WINNING_ROWS[$row][1]] -EQ $BOARD[$WINNING_ROWS[$row][2]]) )
             {
                  return $GameBoard[$WINNING_ROWS[$row][0]];
             }
         }           

         #If we don't have a winner? Check for a possible TIE.
         $NoEmptySpaces = $true;
    
         for($x = 0; $x -LT $SQUARES; $x++)
         {
             if($BOARD[$x] -EQ ' ') 
             { $NoEmptySpaces = $false; }
         }

         if($NoEmptySpaces -EQ $true)
         {   return 'T'; }

         #If nobdy wins and it's not a tie return 'N' to keep playing.
         return 'N';
}

<# ------------------------------------------------------------------- #>

function LegalMove($Move,$BOARD)
{
         return ($BOARD[$Move] -EQ ' ');
}

<# ------------------------------------------------------------------- #>

function PlayerPlays([char[]] $BOARD,$SQUARES,$PlayerP)
{
         Write-Host("`nHuman choosing location: ");

         $PlayersMove;

         while($PlayersMove -GT $SQUARES -OR $PlayersMove -LT 0 -OR 
         ((LegalMove -Move $PlayersMove -BOARD $BOARD) -EQ $false))
         {
             Write-Host("`nChoose a location (0-8): ");
             $PlayersMove = Read-Host("Move");

             if($PlayersMove -GT $SQUARES -OR $PlayersMove -LT 0) 
             { 
                Write-Host("`nThat number is outside of the valid range of 1-8."); 
             }
             elseif((LegalMove -Move $PlayersMove -BOARD $BOARD) -EQ $false) 
             {
                Write-Host("`nYou cannot choose that location. It already has a(n) " +
                           $BOARD)[$PlayersMove] + " in it.`n"; 
             }
         } 

         return $PlayersMove; 
}

<# ------------------------------------------------------------------- #>

function ComputerPlays([char[]] $BOARD,$SQUARES,$PlayerP,$ComputerP)
{
         Write-Host -NoNewLine ("`nComputer choosing location: ");

         #1. If computer can win on next choice, then make that choice.
         for($x = 0; $x -LT $SQUARES; ++$x)
         {
             if(LegalMove -Move $x -BOARD $BOARD)
             {
                 $BOARD[$x] = $ComputerP;

                 if((CheckForAWinner -BOARD $BOARD -SQUARES $SQUARES) -EQ $ComputerP)
                 {
                     Write-Host -NoNewLine ("$x" + "`n");
                     return $x;
                 }
                 #Done checking this choice, undo it.
                 $BOARD[$x] = ' ';
             }
         } 

         #Note: Computer will not try to block player's winning move if EASY = true
         if($global:EASY -EQ $false)
         {   
             #2. If human can win on next choice, block that choice.

             for($y = 0; $y -LT $SQUARES; ++$y)
             {
                 if(LegalMove -Move $y -BOARD $BOARD)
                 {
                     $BOARD[$y] = $PlayerP;

                     if((CheckForAWinner -BOARD $BOARD -SQUARES $SQUARES) -EQ $PlayerP)
                     {
                         Write-Host -NoNewLine ("$y" + "`n");
                         return $y;
                     }

                     #done checking this choice, undo it
                     $BOARD[$y] = ' ';
                 } 
             }

             #3. If no one can win on next choice? Pick best open square.
             $PreferredChoices = @(4, 0, 2, 6, 8, 1, 3, 5, 7);

             for($i = 0; $i -LT $SQUARES; ++$i)
             {
                 $choice = $PreferredChoices[$i];

                 if(LegalMove -Move $choice -BOARD $BOARD)
                 {
                     Write-Host -NoNewLine ("$choice" + "`n");
                     return $choice;
                 }
             }
         }
}

<# ------------------------------------------------------------------- #>

function DisplayWinner($TheWinner,$ComputerP,$PlayerP)
{
       	if($TheWinner -EQ $ComputerP)
        {
            Write-Host("`n" + $TheWinner + " wins the game.");
            Write-Host("The computer wins this match.");
            Write-Host("Sorry, you loose.`n`n");
        }
	    elseif ($TheWinner -EQ $PlayerP)
        {
            Write-Host("`n" + $TheWinner + " wins the game.");
            Write-Host("Excellent. You win this match.");
            Write-Host("The computer looses.`n`n");
        }
	    else
        {
            Write-Host("`nThe game ends in a tie.");
            Write-Host("Neither you nor the computer wins.`n`n");
	    }         
}

<# ------------------------------------------------------------------- #>



#------- Function Invocations -------
MAIN;
