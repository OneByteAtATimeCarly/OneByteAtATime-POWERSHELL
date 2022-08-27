#Title: PowerShell - Module 07 - Classes - Checkers
#Author: Carly S. Germany
#Date: 06/10/2020

#Globals
[int] $RED = 0;
[int] $BLACK = 1;
[int] $BLANK = 2;
[boolean] $CONTINUE;
[boolean] $global:KeepPlaying = $true;

[PLAYER] $global:PLAYA_ONE = New-Object PLAYER;
[PLAYER] $global:PLAYA_TWO = New-Object PLAYER;

$global:CheckerBoard = New-Object 'object[,]' 8,8;

<# ---------------------------------------------------------------------------------------------------------------------- #>

class CHECKER
{
      #Constants
      [int] $RED = 0;
      [int] $BLACK = 1;
      [int] $BLANK = 2;

      #Data Members
      [int] $color;
      [boolean] $KING;
      [boolean] $selected;   

      #Oveloaded Constructors
      CHECKER() 
      { 
          Write-Host("Created a generic Checker."); 
          $this.KING = $false;
          $this.selected = $false;
      }
      
      CHECKER([int] $CLR)
      {
          $this.color = $CLR;
          $this.KING = $false; 
          $this.selected = $false;
          
          $MESSAGE = "Created a ";
          
          switch($this.color)
          {
              $this.BLACK  { $MESSAGE = $MESSAGE + "BLACK CHECKER."; }
              $this.RED    { $MESSAGE = $MESSAGE + "RED CHECKER."; }
              $this.BLANK  { $MESSAGE = $MESSAGE + "BLANK CHECKER Space."; }
              default {  $MESSAGE = "`nShould never happen!"; }    
          } 

          Write-Host($MESSAGE);           
      }

      [String] GetCheckerType() 
      { 
           if($this.selected)
           {
               switch($this.color)
               {
                  $this.BLACK { return "(B)"; }
                  $this.RED { return "(R)"; }
                  $this.BLANK { return "   "; }
                  default { Write-Host("`nShould never happen!"); }  
               }                        
           }
           else
           {
               switch($this.color)
               {
                  $this.BLACK { return " B "; }
                  $this.RED { return " R "; }
                  $this.BLANK { return "   "; }
                  default { Write-Host("`nShould never happen!"); }  
               }                
           }
           
           return "*";      
      }
      
      #Accessor Methods
      [int] GetColor() { return $this.color; }
      SetColor([int] $x) { $this.color = $x; }
      [boolean] GetKing() { return $this.KING; }
      SetKing([boolean] $x) { KING = x; }
      [boolean] GetSelected() { return $this.selected; }
      SetSelected([boolean] $x) { $this.selected = $x; }

}

<# ---------------------------------------------------------------------------------------------------------------------- #>

class PLAYER
{
      #Data members
      [String] $PlayerName;
      [int] $PlayerColor;
      [int] $PlayerScore;

      #Constructor
      PLAYER() 
      { 
          Write-Host("Creating a Player object."); 
          $this.PlayerName = "Anonymous";
          $this.PlayerScore = 0;
      }
      
      #Accessor Methods
      SetPlayerName([String] $x) { $this.PlayerName = $x; }
      [String] GetPlayerName() { return $this.PlayerName; }
      SetPlayerColor([int] $x) { $this.PlayerColor = $x; }
      [int] GetPlayerColor() { return $this.PlayerColor; }
      SetPlayerScore([int] $x) { $this.PlayerScore = $x; }
      [int] GetPlayerScore() { return $this.PlayerScore; }

}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function MAIN
{
         Clear;
         Write-Host("`nCheckers 1.0`n`n");

         [String] $choice = "*";

         while($choice[0] -NE 'q')
         {
               Clear;
               Write-Host("`n`n");

               Write-Host("                    _______ Main Menu ______");
               Write-Host("                    |                       |");
               Write-Host("                    |    (P)lay Checkers    |");
               Write-Host("                    |    (H)elp             |");
               Write-Host("                    |    (S)ave Game        |"); 
               Write-Host("                    |    (L)oad Game        |");  
               Write-Host("                    |    (Q)uit             |");
               Write-Host("                    |_______________________|`n");

               $choice = (Read-Host("                    CHOICE")).ToLower();

               switch($choice[0])
               {
                         'p' { PlayGame; break; }
                         'h' { break; }
                         's' { break; }
                         'l' { break; }
                         'q' { break;}
                          default{ $null = Read-Host("Invalid choice. ENTER to continue."); }
               }
         }

}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function BeginGame
{
         [String] $GameType = "*";
         [String] $ColorChoice = "*";    
     
         $global:PLAYA_ONE = New-Object PLAYER;
         $global:PLAYA_TWO = New-Object PLAYER;
     
         CreateBoard;

         Start-Sleep -s 3;
     
         Clear;

         Write-Host("`nBeginning new game ...");

         while($GameType[0] -NE 'p' -AND $GameType[0] -NE 'c' -AND $GameType[0] -NE 'q')
         {
              Write-Host("`n`n" +
                         "__________________________________`n" +
                         "|                                |`n" +     
                         "|    Who do you wish to play?    |`n" +
                         "|    (C)omputer                  |`n" +
                         "|    (P)layer                    |`n" +
                         "|    (Q)uit                      |`n" +
                         "|                                |`n" +
                         "__________________________________`n");

              $GameType = (Read-Host("CHOICE")).ToLower();

              switch($GameType[0])
              {
                  'c' 
                  { 
                       Write-Host("`n`n");
                       $PlayerName = Read-Host("What is your name, PLAYER?");

                       $global:PLAYA_ONE.SetPlayerName($PlayerName);
                       $global:PLAYA_TWO.SetPlayerName("Computer");
     
                       while($ColorChoice[0] -NE 'r' -AND $ColorChoice[0] -NE 'b')
                       {
                          Write-Host("`n");
                          $ColorChoice = (Read-Host("Do you want to be RED or BLACK?")).ToLower();
          
                          switch($ColorChoice[0])
                          {
                               'r' { 
                                      Write-Host("`n" + $PlayerName + " chooses RED. Therefore, Computer is BLACK."); 
                                      $global:PLAYA_ONE.SetPlayerColor($RED);
                                      $global:PLAYA_TWO.SetPlayerColor($BLACK); 
                                      break; 
                                   }
                               'b' { 
                                      Write-Host("`n" + $PlayerName + " chooses BLACK. Therefore, Computer is RED."); 
                                      $global:PLAYA_ONE.SetPlayerColor($BLACK);
                                      $global:PLAYA_TWO.SetPlayerColor($RED); 
                                      break; 
                                   }
                                default { "`n   Invalid response. Choose RED or BLACK.`n"; break; }            
                          }
                       }
                       
                       break;
                  }

                  'p'
                  { 
                       Write-Host("`n`n");
                       $PlayerOneName = Read-Host("What is your name, PLAYER 1?");
                       $PlayerTwoName = Read-Host("What is your name, PLAYER 2?");

                       $global:PLAYA_ONE.SetPlayerName($PlayerOneName);
                       $global:PLAYA_TWO.SetPlayerName($PlayerTwoName);
     
                       while($ColorChoice[0] -NE 'r' -AND $ColorChoice[0] -NE 'b')
                       {
                          Write-Host("`n");
                          $ColorChoice = (Read-Host("PLAYER 1 - do you want to be RED or BLACK?")).ToLower();
          
                          switch($ColorChoice[0])
                          {
                               'r' { 
                                      Write-Host("`n" + $PlayerOneName + " chooses RED. Therefore, $PlayerTwoName is BLACK."); 
                                      $global:PLAYA_ONE.SetPlayerColor($RED);
                                      $global:PLAYA_TWO.SetPlayerColor($BLACK); 
                                      break; 
                                   }
                               'b' { 
                                      Write-Host("`n" + $PlayerOneName + " chooses BLACK. Therefore, $PlayerTwoName is RED."); 
                                      $global:PLAYA_ONE.SetPlayerColor($BLACK);
                                      $global:PLAYA_TWO.SetPlayerColor($RED); 
                                      break; 
                                   }
                                default { "`n   Invalid response. Choose RED or BLACK.`n"; break; }            
                          }
                       }
                       
                       break;                 
                  }

                  'q' { Write-Host("`nExiting ..."); break; }

                  default { Write-Host("`nInvalid choice. Choose again."); break; }
              }

         }
         
         $null = Read-Host("`n`nPress ENTER to continue.");
}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function CreateBoard
{
         Write-Host("`n`n");

         [boolean] $IsBlank = $false;
     
         #X = Horizontal rows moving across, Y = Vertical rows moving down
         
         #Create 1st 3 rows of (RED) CHECKERS with spaces in between
         for($ROWS = 0; $ROWS -LT 3; $ROWS++)
         {
             for($x = 0; $x -LT 8; $x++)
             {
                if($IsBlank -EQ $false)
                { 
                   $CheckerBoard[$ROWS,$x] = New-Object CHECKER($RED);
                   $IsBlank = $true;  
                }
                else
                {
                   $CheckerBoard[$ROWS,$x] = New-Object CHECKER($BLANK);
                   $IsBlank = $false; 
                }  
             }
             
             if(!$IsBlank) 
             { $IsBlank= $true; }
             else 
             { $IsBlank = $false; }                 
         }

         #Create next 2 rows of blank spaces for middle of board
         for($ROWS = 3; $ROWS -LT 5; $ROWS++)
         {
             for($x = 0; $x -LT 8; $x++)
             {             
                 $CheckerBoard[$ROWS,$x] = New-Object CHECKER($BLANK);
             }    
         }

         #Create last 3 rows
         $IsBlank = $true;
         
         for($ROWS = 5; $ROWS -LT 8; $ROWS++)
         {
             for($x = 0; $x -LT 8; $x++)
             {
                if($IsBlank -EQ $false)
                { 
                   $CheckerBoard[$ROWS,$x] = New-Object CHECKER($BLACK);
                   $IsBlank = $true;  
                }
                else
                {
                   $CheckerBoard[$ROWS,$x] = New-Object CHECKER($BLANK);
                   $IsBlank = $false; 
                }  
             }
             
             if(!$IsBlank) 
             { $IsBlank = $true; }
             else 
             { $IsBlank = $false; }                 
         }   
}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function DisplayBoard
{
         [String] $MESSAGE = "";

         #Clear;
         
         Write-Host("`n`n                     | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |");
         Write-Host("                  --------------------------------------");

         #Draw rows
         for($ROW = 0; $ROW -LT 8; $ROW++)
         {
             Write-Host("                   " + ($ROW+1) + " ") -NoNewline;

             #Draw columns
             for($COLUMN = 0; $COLUMN -LT 8; $COLUMN++)
             { 
                 Write-Host("|" + $CheckerBoard[$ROW,$COLUMN].GetCheckerType()) -NoNewline; 
             }
          
             Write-Host("|`n                   " +
                        "--|-------------------------------|" +
                        "                    ");
         } 
         

         $MESSAGE = "`n`n              --------------- PLAYER 1 Stats ---------------`n";

         $MESSAGE = $MESSAGE + "              Name: " + $PLAYA_ONE.GetPlayerName() + "    Color: ";
      
         switch($PLAYA_ONE.GetPlayerColor())
         {
              $RED { $MESSAGE = $MESSAGE + "[RED]"; break; }
              $BLACK { $MESSAGE = $MESSAGE +  "[BLACK]"; break; }
         } 

         $MESSAGE = $MESSAGE + "    Score: " + $PLAYA_ONE.GetPlayerScore();
      
         Write-Host($MESSAGE);

         $MESSAGE = "`n`n`n              --------------- PLAYER 2 Stats ---------------`n";

          $MESSAGE = $MESSAGE + "              Name: " + $PLAYA_TWO.GetPlayerName() + "    Color: ";
      
         switch($PLAYA_TWO.GetPlayerColor())
         {
              $RED { $MESSAGE = $MESSAGE + "[RED]"; break; }
              $BLACK { $MESSAGE = $MESSAGE +  "[BLACK]"; break; }
         } 

         $MESSAGE = $MESSAGE + "    Score: " + $PLAYA_TWO.GetPlayerScore() + "`n`n`n";
      
         Write-Host($MESSAGE);
}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function SelectChecker([int] $COLOR, [String] $pNAME)
{
         [String] $CHOICE = "*";
         [int] $NUM;
         $CurrentPosition = New-Object 'object[]' 2; #COL, ROW
           
         while($CurrentPosition[0] -LT 1 -OR $CurrentPosition[0] -GT 8 -OR 
               $CurrentPosition[1] -LT 1 -OR  $CurrentPosition[1] -GT 8)
         {
              DisplayBoard;
         
              Write-Host("`n`n  " + $pNAME + ", which CHECKER do you wish to move? (`"q`" = quit)" +
                         "`n  Example: 11 = COLUMN 1 ROW 1");
          
              $CHOICE = Read-Host("  CHOICE");

              $CurrentPosition[0] = [int]::Parse($CHOICE[0]); #convert string char to int
              $CurrentPosition[1] = [int]::Parse($CHOICE[1]); #convert string char to int

              if($CHOICE[0] -EQ 'q') 
              { 
                  $global:KeepPlaying = $false; 
                  return;
              }

              if($CurrentPosition[0] -LT 1 -OR $CurrentPosition[0] -GT 8 -OR 
                 $CurrentPosition[1] -LT 1 -OR  $CurrentPosition[1] -GT 8)
              {
                  Write("`n  That was an invalid choice! Outside available range");
              }
              else
              {
                  if($CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].GetColor() -EQ $BLANK) 
                  {
                      Write-Host("`n  There is no checker at that location!");
                      Start-Sleep -s 2;
                      $CurrentPosition[0] = 0;                                                                  
                  }
                  else
                  {
                     if($COLOR -EQ $RED)
                     {  
                        if($CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].GetColor() -EQ $BLACK)
                        {
                            Write-Host("`n  Can't move your opponent's black CHECKER, move your own - cheater!");
                            Start-Sleep -s 2;
                            $CurrentPosition[0] = 0;                                                                     
                        }
                        else
                        {  
                            if($CurrentPosition[1] -LT 2)
                            {
                                   if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLANK -AND
                                      $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLACK)
                                   {
                                        Write-Host("`n  Blocked!" +
                                                   "`n  If you selected this piece you would be trapped!");
                                        Start-Sleep -s 2;
                                        $CurrentPosition[0] = 0;
                                   }
                                   else
                                   {
                                      Write-Host("`n  You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                            
                                   }                                                        
                            }
                            elseif($CurrentPosition[1] -LT 7)
                            {
                                   if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLANK -AND 
                                      $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLACK)
                                   {
                                       Write-Host("`n  Blocked!" +
                                                  "`n  If you selected this piece you would be trapped!");
                                       Start-Sleep -s 2;
                                       $CurrentPosition[0] = 0;
                                  }
                                  else
                                  {
                                      Write-Host("`n  You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                           
                                  }                                                        
                            }                                                     
                            else
                            {
                                if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLANK -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLANK -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLACK -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLACK)
                                {
                                      Write-Host("`n  Blocked!" +
                                                 "`n  If you selected this piece you would be trapped!");
                                      Start-Sleep -s 2;
                                      $CurrentPosition[0] = 0;
                                }
                               else
                               {
                                      Write-Host("`n  You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                   
                               }#close else INNER
                               
                            }#close else MIDDLE 

                        }#close else OUTER

                     }#close else if COLOR RED

                     elseif($COLOR -EQ $BLACK)
                     {  
                        if($CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].GetColor() -EQ $RED)
                        {
                            Write-Host("`n  Can't move your opponent's red CHECKER, move your own - cheater!");
                            Start-Sleep -s 2;
                            $CurrentPosition[0] = 0;                                                                     
                        }
                        else
                        {  
                            if($CurrentPosition[1] -LT 2)
                            {
                                   if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLANK -AND
                                      $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $RED)
                                   {
                                        Write-Host("`n  Blocked!" +
                                                   "`n  If you selected this piece you would be trapped!");
                                        Start-Sleep -s 2;
                                        $CurrentPosition[0] = 0;
                                   }
                                   else
                                   {
                                      Write-Host("`n   You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                            
                                   }                                                        
                            }
                            elseif($CurrentPosition[1] -LT 7)
                            {
                                   if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLANK -AND 
                                      $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $RED)
                                   {
                                       Write-Host("`n  Blocked!" +
                                                  "`n  If you selected this piece you would be trapped!");
                                       Start-Sleep -s 2;
                                       $CurrentPosition[0] = 0;
                                  }
                                  else
                                  {
                                      Write-Host("`n  You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                           
                                  }                                                        
                            }                                                     
                            else
                            {
                                if($CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $BLANK -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $BLANK -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) + 1)].GetColor() -NE $RED -AND
                                   $CheckerBoard[(($CurrentPosition[0]-1) + 1),(($CurrentPosition[1]-1) - 1)].GetColor() -NE $RED)
                                {
                                      Write-Host("`n   Blocked!" +
                                                 "`n  If you selected this piece you would be trapped!");
                                      Start-Sleep -s 2;
                                      $CurrentPosition[0] = 0;
                                }
                               else
                               {
                                      Write-Host("`n   You select:  ROW = " + $CurrentPosition[0] +
                                                 " COL=" + $CurrentPosition[1]);
                                      Start-Sleep -s 1;
                                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($true);
                                      DisplayBoard;
                                                                   
                               }#close else INNER
                               
                            }#close else MIDDLE 

                       }#close else OUTER

                   }#close else if COLOR BLACK                   
                                             
                }#close if not blank

             }#close if not outside range                                                                                                                                                                                                       

         }#close while true loop 
         
      #-----------------------------------------------------------------------------------

         $CHOICE = "*";
         [boolean] $CanYaJump = $false;

         while($CHOICE[0] -NE 'm' -AND $CHOICE[0] -NE 'a')
         {
             Write-Host("`n   Now that you have selected a checker," +
                        "`n   what do you want to do with it?`n" +
                        "`n   (M)ove Checker to Another Location" +
                        "`n   (A)ttempt to Jump Your Opponent's Checker `n");
          
             $CHOICE = (Read-Host("CHOICE")).ToLower();
     
             switch($CHOICE[0])
             {
                'm' { 
                       MoveChecker -CurrentPosition $CurrentPosition -COLOR $COLOR -pNAME $pNAME; 
                       break; 
                    }
                'a' { 
                       $CanYaJump = JumpChecker -CurrentPosition $CurrentPosition -COLOR $COLOR -pNAME $pNAME; 
                       if(!$CanYaJump)
                       { 
                           MoveChecker -CurrentPosition $CurrentPosition -COLOR $COLOR -pNAME $pNAME; 
                       }
                       else
                       { 
                           Write-Host("`n   Finshed JUMP!"); 
                       }
                       break;
                    }
                default { Write-Host("`n   Invalid response."); break; }
                          
             }#close switch    
              
         }#close 2nd while true loop  
             
}#close function

<# ---------------------------------------------------------------------------------------------------------------------- #>

function PlayGame
{
         $global:KeepPlaying = $true;
         [String] $choice = "*";
     
         BeginGame;
         #DisplayBoard; 

         while($global:KeepPlaying)
         {
             SelectChecker -COLOR $global:PLAYA_ONE.GetPlayerColor() -pNAME $global:PLAYA_ONE.GetPlayerName();

             Write-Host("`n   " + $global:PLAYA_ONE.GetPlayerName() +
                        "'s move has been completed.");
              
             Start-Sleep -s 2;    
         
             if($global:KeepPlaying)
             {
                SelectChecker -COLOR $global:PLAYA_TWO.GetPlayerColor() -pNAME $global:PLAYA_TWO.GetPlayerName();

                Write-Host("`n   " + $global:PLAYA_TWO.GetPlayerName() +
                           "'s move has been completed.");        

             }
         
             Start-Sleep -s 2;  
         }  
}

<# ---------------------------------------------------------------------------------------------------------------------- #>

#Note: Function accepts entire ARRAY as 1st argument.

function MoveChecker([int[]] $CurrentPosition, [int] $COLOR, [String] $pNAME)
{
         [String] $CHOICE = "*";
         [int] $NUM;
         $DestinationPosition = New-Object 'object[]' 2; #COL, ROW

         while($DestinationPosition[0] -LT 1 -OR $DestinationPosition[0] -GT 8 -OR
               $DestinationPosition[1] -LT 1 -OR $DestinationPosition[1] -GT 8)
         {
               DisplayBoard;
  
               Write-Host("`n`n  " + $pNAME + ", where do you wish to move it?  ");

               $CHOICE = Read-Host("  CHOICE");

               $DestinationPosition[0] = [int]::Parse($CHOICE[0]); #convert string char to int
               $DestinationPosition[1] = [int]::Parse($CHOICE[1]); #convert string char to int         
 
               #1. Check to see if move outside numerical range
               if($DestinationPosition[0] -LT 1 -OR $DestinationPosition[0] -GT 8 -OR
                  $DestinationPosition[1] -LT 1 -OR $DestinationPosition[1] -GT 8)
               {
                  Write-Host("`n  That was an invalid choice! Outside available range.");
                  Start-Sleep -s 2;   
               }
               else
               {   #2. Check to see if move is to spot with CHECKER already there
                   if($CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].GetColor() -NE $BLANK)
                   {
                        Write-Host("`n`n  You cannot move there. A CHECKER is already there!");
                        $DestinationPosition[0] = 0;
                        Start-Sleep -s 2;  
                   }
                   else
                   {    #3. Check to see if move is illegal sideways
                        if($DestinationPosition[0] -EQ $CurrentPosition[0])
                        {
                             Write-Host("`n   You cannot move sideways!");
                             $DestinationPosition[0] = 0;
                             Start-Sleep -s 2;  
                        }
                        else
                        {   
                            #---------------------------------------------------

                            #4. Check to see if color RED  
                            if($COLOR -EQ $RED)
                            {   
                                #5. If RED and not KING, don't allow to move backwards
                                if($DestinationPosition[0] -LT $CurrentPosition[0])
                                {
                                    Write-Host("`n  You cannot move the CHECKER backwards!"); 
                                    $DestinationPosition[0] = 0;
                                    Start-Sleep -s 2;                        
                                }
                                else
                                {   
                                    #6. Don't allow to move more than 1 forward if not jump
                                    if($DestinationPosition[0] -LT ($CurrentPosition[0]+1))
                                    {
                                        Write-Host("`n  You cannot move more than ONE row forward!");
                                        $DestinationPosition[0] = 0;
                                        Start-Sleep -s 2;  
                                    }
                                    else
                                    {
                                        #7. Move must be diagonal on board to be legal
                                            #Check if current position is EVEN number  
                                        if($CurrentPosition[1] % 2 -EQ 0)
                                        {
                                             Write-Host("`n  Current Position is an EVEN number!");
                                             
                                             #Check if destination position also EVEN number? ILLEGAL!
                                             if($DestinationPosition[1] % 2 -EQ 0)
                                             {
                                                 Write-Host("`n  Invalid move. Must be diagonal!");
                                                 $DestinationPosition[0] = 0;
                                                 Start-Sleep -s 2;                           
                                             }
                                             else
                                             {
                                                 Write-Host("  That is an ACCEPTABLE and LEGAL move!");
                                                 Write-Host("  Moving TO:  COL=" + $DestinationPosition[0] +
                                                            " ROW=" + $DestinationPosition[1]);

                                                 Start-Sleep -s 2;  
                                      
                                                 $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($false);
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                                 $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                      
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($true);
                                                 Start-Sleep -s 2;
                                                 DisplayBoard;
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($false); 
                                                                                        
                                            }#close invalid destination move % 2 is 0

                                        }#close if current position EVEN number

                                        else
                                        {   
                                            Write-Host("  Current Position is an ODD number!");
                              
                                            if($DestinationPosition[1] % 2 -NE 0)
                                            {
                                                 Write-Host("  Invalid move. Must be diagonal!");
                                                 $DestinationPosition[0] = 0; 
                                                 Start-Sleep -s 2;                          
                                            }
                                            else
                                            {
                                                Write-Host("  That is an ACCEPTABLE and LEGAL move!");
                                                Write-Host("  Moving TO:  COL=" + $DestinationPosition[0] +
                                                " ROW=" + $DestinationPosition[1]);
                                                Start-Sleep -s 2;  
                                           
                                                $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($false);
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                                $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                      
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($true);
                                                Start-Sleep -s 1;
                                                DisplayBoard;
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($false); 
                                            }    

                                        }#close if moving diagonal
                                        
                                    }#close can't move more than 1 row forward

                                }#close if CHECKER moving backwards     
                                                         
                            }#close if COLOR is RED

                            #---------------------------------------------------

                            #4. Check to see if color BLACK  
                            elseif($COLOR -EQ $BLACK)
                            {
                                
                                #5. If RED and not KING, don't allow to move backwards
                                if($DestinationPosition[0] -LT $CurrentPosition[0])
                                {
                                    Write-Host("`n  You cannot move the CHECKER backwards!"); 
                                    $DestinationPosition[0] = 0;
                                    Start-Sleep -s 2;                        
                                }
                                else
                                {   
                                    #6. Don't allow to move more than 1 forward if not jump
                                    if($DestinationPosition[0] -LT ($CurrentPosition[0]+1))
                                    {
                                        Write-Host("`n  You cannot move more than ONE row forward!");
                                        $DestinationPosition[0] = 0;
                                        Start-Sleep -s 2;  
                                    }
                                    else
                                    {
                                        #7. Move must be diagonal on board to be legal
                                            #Check if current position is EVEN number  
                                        if($CurrentPosition[1] % 2 -EQ 0)
                                        {
                                             Write-Host("`n  Current Position is an EVEN number!");
                                             
                                             #Check if destination position also EVEN number? ILLEGAL!
                                             if($DestinationPosition[1] % 2 -EQ 0)
                                             {
                                                 Write-Host("`n  Invalid move. Must be diagonal!");
                                                 $DestinationPosition[0] = 0;
                                                 Start-Sleep -s 2;                           
                                             }
                                             else
                                             {
                                                 Write-Host("  That is an ACCEPTABLE and LEGAL move!");
                                                 Write-Host("  Moving TO:  COL=" + $DestinationPosition[0] +
                                                            " ROW=" + $DestinationPosition[1]);

                                                 Start-Sleep -s 2;  
                                      
                                                 $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($false);
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                                 $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                      
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($true);
                                                 Start-Sleep -s 2;
                                                 DisplayBoard;
                                                 $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($false); 
                                                                                        
                                            }#close invalid destination move % 2 is 0

                                        }#close if current position EVEN number

                                        else
                                        {   
                                            Write-Host("  Current Position is an ODD number!");
                              
                                            if($DestinationPosition[1] % 2 -NE 0)
                                            {
                                                 Write-Host("  Invalid move. Must be diagonal!");
                                                 $DestinationPosition[0] = 0; 
                                                 Start-Sleep -s 2;                          
                                            }
                                            else
                                            {
                                                Write-Host("  That is an ACCEPTABLE and LEGAL move!");
                                                Write-Host("  Moving TO:  COL=" + $DestinationPosition[0] +
                                                " ROW=" + $DestinationPosition[1]);
                                                Start-Sleep -s 2;  
                                           
                                                $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($false);
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                                $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                      
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($true);
                                                Start-Sleep -s 1;
                                                DisplayBoard;
                                                $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetSelected($false); 
                                            }    

                                        }#close if moving diagonal
                                        
                                    }#close can't move more than 1 row forward

                                }#close if CHECKER moving backwards     
                                                         
                            }#close if COLOR is BLACK

                            #---------------------------------------------------

                        }#close if move sideways                 

                   }#close checker already there and not BLANK

               }#close if outside range   
                                    
         }#close while true loop

}#close function

<# ---------------------------------------------------------------------------------------------------------------------- #>

#Note: Function accepts entire ARRAY as 1st argument.

function JumpChecker([int[]] $CurrentPosition, [int] $COLOR, [String] $pNAME)
{
         [String] $CHOICE = "*";
         [int] $NUM;
         $DestinationPosition = New-Object 'object[]' 2; #COL, ROW         

         while($DestinationPosition[0] -LT 1 -OR $DestinationPosition[0] -GT 8 -OR
               $DestinationPosition[1] -LT 1 -OR $DestinationPosition[1] -GT 8)
         {
               DisplayBoard;
             
               Write-Host("`n  " + $pNAME + ", where do you wish to move CHECKER for jump?" +
                          "`n  If you cannot make a valid jump? Enter `"q`" to quit." + 
                          "`n  You will then be allowed to move CHECKER to another location.");

               $CHOICE = Read-Host("  CHOICE");

               $DestinationPosition[0] = [int]::Parse($CHOICE[0]); #convert string char to int
               $DestinationPosition[1] = [int]::Parse($CHOICE[1]); #convert string char to int  

               #1. Did they input numbers outside the valid range?
               if($DestinationPosition[0] -LT 1 -OR $DestinationPosition[0] -GT 8 -OR
                  $DestinationPosition[1] -LT 1 -OR $DestinationPosition[1] -GT 8)
               {
                    Write-Host("`n  That was an invalid choice! Outside available range.");
                    Start-Sleep -s 2;  
               }
               else
               {
                   #2. Are they trying to JUMP where another CHECKER is already at?
                   if($CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].GetColor() -NE $BLANK)
                   {
                       Write-Host("`n   You cannot jump there. A CHECKER is already there!");
                       $DestinationPosition[0] = 0;
                       Start-Sleep -s 2;   
                   }
                   else
                   {   
                       #3. Are they trying to JUMP sideways?
                       if($DestinationPosition[0] -EQ $CurrentPosition[0])
                       {
                           Write-Host("  You cannot jump sideways!");
                           $DestinationPosition[0] = 0;
                           Start-Sleep -s 2;  
                       }
                       else
                       { 

                    #RED-------------------------------------------------------------------------- 
                           #4. Is it a RED CHECKER?
                           if($COLOR -EQ $RED)
                           {
                                #5. Are they trying to move backwards?
                                if($DestinationPosition[0] -LT $CurrentPosition[0])
                                {
                                     Write-Host("`n  You cannot jump a normal RED CHECKER backwards!"); 
                                     $DestinationPosition[0] = 0;
                                     Start-Sleep -s 2;                        
                                }
                                else
                                {
                                     #6. Are they moving more than 1 row forward for JUMP?
                                     if($DestinationPosition[0] -LT ($CurrentPosition[0]+1))
                                     {
                                         Write-Host("  Good! To jump, you must move a normal RED" +
                                                    "`n   CHECKER more than ONE row forward!");
                                                    
                                         #7. Is it an EVEN number?
                                         if($CurrentPosition[1] % 2 -EQ 0)
                                         { 
                                             Write-Host("  Current Position of RED CHECKER is an EVEN number!"); 
                                            
                                             #8. Is it BLANK and 2 rows ahead?
                                             if($DestinationPosition[1] % 2 -EQ 0)
                                             {
                                                 Write-Host("  Good! Jumping RED CHECKER to a BLANK, EVEN square 2 rows ahead!"); 
                                             
                                                  #9. Are they Moving RIGHT?
                                                  if($DestinationPosition[1] -GT $CurrentPosition[1])
                                                  {
                                                      Write-Host("Moving to the RIGHT for this JUMP.");

                                                      #10. Is it a legal jump over opponent's CHECKER?
                                                      if($CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].GetColor() -EQ $BLACK)
                                                      {
                                                          Write-Host("   You jumped your RED CHECKER over your opponent's" +
                                                                     "`n   BLACK checker. That is a LEGAL jump! Nice job.");
                                                          
                                                          #BLANK jumped CHECKER
                                                          $CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].SetColor($BLANK);     
                                                          
                                                          #BLANK previous spot
                                                          $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);

                                                          #Set new position of RED CHECKER
                                                          $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                             
                                                          if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                                                          {
                                                             $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                          }                                                                
                                                          else  
                                                          { 
                                                             $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                          }
                                             
                                                          #Is a DoubleJump possible?
                                                          DoubleJump($DestinationPosition, $COLOR);
                                             
                                                      }

                                                      #11. Did they try to jump over a blank space?
                                                      elseif($CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].GetColor() -EQ $BLANK)
                                                      {
                                                          Write-Host("  You can't jump over a BLANK space.");
                                                      }

                                                      #12. Did they try to jump over their own CHECKER?
                                                      else
                                                      {
                                                          Write-Host("  You can't jump over your own RED CHECKERS." +
                                                                     "`n   That's an illegal jump. Shame on you!");
                                                          $DestinationPosition[0] = 0;
                                                          Start-Sleep -s 2;      
                                                      }

                                                  }#close are they Moving RIGHT? 

                                                  #13. Are they Moving LEFT?
                                                  else
                                                  {
                                                      Write-Host("Moving to the LEFT for this JUMP.");

                                                      #14. Is move over opponent's CHECKER (BLACK)?
                                                      if($CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].GetColor() -EQ $BLACK)
                                                      {
                                                           Write-Host("   You jumped your RED CHECKER over your opponent's" +
                                                                      "`n   BLACK checker. That is a LEGAL jump! Nice job."); 
                                                                       
                                                           #BLANK jumped checker
                                                           $CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].SetColor($BLANK);

                                                           #BLANK previous spot
                                                           $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                                           
                                                           #Set current position     
                                                           $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                             
                                                           if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                                                           {
                                                              $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                           }                                                                
                                                           else  
                                                           { 
                                                              $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                           }
                                           
                                                           DoubleJump($DestinationPosition, $COLOR);                                                                              
                                                      }
                                                      else
                                                      {
                                                          Write-Host("  You can't jump over your own RED CHECKERS." +
                                                                     "`n   That's an illegal jump. Shame on you!");
                                                          $DestinationPosition[0] = 0;
                                                          Start-Sleep -s 2;    
                                                            
                                                      }#close if CHECKER is opponent's (BLACK)

                                                  }#close if moving LEFT
                                             }
                                             else
                                             {
                                                  Write-Host("  Invalid move. You must jump your RED CHECKER to an EVEN numbered square.");
                                                  $DestinationPosition[0] = 0;
                                                  Start-Sleep -s 2;

                                             }#close is it BLANK, ODD and 2 rows ahead?                                             
                                         }
                                         else
                                         {
                                              Write-Host("  Current Position of RED CHECKER is an ODD number!");

                                              if($DestinationPosition[1] % 2 -NE 0)
                                              {
                                                  Write-Host("  Good! Jumping RED CHECKER to a BLANK, ODD square 2 rows ahead!");                         
                                                  
                                                  #Are they Moving RIGHT?
                                                  if($DestinationPosition[1] -GT $CurrentPosition[1])
                                                  {
                                                     Write-Host("Moving to the RIGHT for this JUMP.");

                                                     #Is JUMP over opponent's CHECKER (BLACK)?
                                                     if($CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].GetColor() -EQ $BLACK)
                                                     {
                                                         Write-Host("  You jumped your RED CHECKER over your opponent's" +
                                                                   "`n   BLACK checker. That is a LEGAL jump! Nice job.");

                                                         #BLANK jumped checker
                                                         $CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].SetColor($BLANK);  
                                                        
                                                         #BLANK previous spot   
                                                         $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK); 

                                                         #Set current position
                                                         $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                             
                                                         if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                                                         {
                                                            $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                         }                                                                
                                                         else  
                                                         { 
                                                            $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                         }
                                              
                                                         DoubleJump($DestinationPosition, $COLOR);
                                                     }
                                                     else
                                                     {
                                                         Write-Host("  You can't jump over your own RED CHECKERS." +
                                                                    "`n   That's an illegal jump. Shame on you!");
                                                         $DestinationPosition[0] = 0;
                                                         Start-Sleep -s 2; 
                                                             
                                                     }#close if JUMP over opponent's CHECKER

                                                  }#close if moving RIGHT

                                                  #Are they moving LEFT?
                                                  else
                                                  {
                                                     Write-Host("Moving to the LEFT for this JUMP.");

                                                     #Is JUMP over opponent's CHECKER (BLACK)?
                                                     if($CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].GetColor() -EQ $BLACK)
                                                     {
                                                         Write-Host("  You jumped your RED CHECKER over your opponent's" +
                                                                    "`n   BLACK checker. That is a LEGAL jump! Nice job.");  

                                                         #BLANK jumped checker
                                                         $CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].SetColor($BLANK);  
                                                         
                                                         #BLANK previous spot     
                                                         $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);

                                                         #Set current position
                                                         $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($RED);
                                             
                                                         if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                                                         {
                                                            $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                         }                                                                
                                                         else  
                                                         { 
                                                            $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                         }
                                           
                                                         DoubleJump($DestinationPosition, $COLOR);                                                                                        
                                                     }
                                                     else
                                                     {
                                                         Write-Host("  You can't jump over your own RED CHECKERS." +
                                                                    "`n   That's an illegal jump. Shame on you!");
                                                         $DestinationPosition[0] = 0;
                                                         Start-Sleep -s 2; 

                                                     }#close if JUMP over opponent 
                                                                                              
                                                  }#close if moving LEFT 

                                               }#close is it BLANK, ODD and 2 rows ahead?

                                             }                                      
                                             else
                                             {
                                                  Write-Host("  Invalid move. You must jump RED CHECKER to an ODD numbered square.");
                                                  $DestinationPosition[0] = 0;
                                                  Start-Sleep -s 2;

                                             }#close is it an EVEN or ODD number?                                                                                                                                          
                                     }
                                     else
                                     {
                                         Write-Host("  You are not moving your RED CHECKER" +
                                               "`n   forward far enough for a jump!");
                                         $DestinationPosition[0] = 0;
                                         Start-Sleep -s 2;

                                     }#close if more than one row forward for JUMP?

                                }#close if CHECKER moving backwards

                           }#close if CHECKER RED

                    #BLACK-------------------------------------------------------------------------- 
                           
                           #15. Is it a BLACK CHECKER?
                           if($COLOR -EQ $BLACK)
                           {
                                #16. Are they trying to move backwards?
                                if($DestinationPosition[0] -GT $CurrentPosition[0])
                                {
                                     Write-Host("`n  You cannot jump a normal BLACK CHECKER backwards!"); 
                                     $DestinationPosition[0] = 0;
                                     Start-Sleep -s 2;                        
                                }
                                else
                                {
                                     #17. Are they moving more than 1 row forward for JUMP?
                                     if($DestinationPosition[0] -LT ($CurrentPosition[0]-1))
                                     {
                                         Write-Host("  Good! To jump, you must move a normal BLACK" +
                                                    "`n   CHECKER more than ONE row forward!");
                                                    
                                         #18. Is it an EVEN number?
                                         if($CurrentPosition[1] % 2 -EQ 0)
                                         { 
                                             Write-Host("  Current Position of BLACK CHECKER is an EVEN number!"); 
                                            
                                             #19. Is it BLANK and 2 rows ahead?
                                             if($DestinationPosition[1] % 2 -EQ 0)
                                             {
                                                 Write-Host("  Good! Jumping BLACK CHECKER to a BLANK, EVEN square 2 rows ahead!"); 
                                             
                                                  #20. Are they Moving RIGHT?
                                                  if($DestinationPosition[1] -GT $CurrentPosition[1])
                                                  {
                                                      Write-Host("Moving to the RIGHT for this JUMP.");

                                                      #21. Is it a legal jump over opponent's CHECKER?
                                                      if($CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].GetColor() -EQ $RED)
                                                      {
                                                          Write-Host("   You jumped your BLACK CHECKER over your opponent's" +
                                                                     "`n   RED checker. That is a LEGAL jump! Nice job.");
                                                          
                                                          #BLANK jumped CHECKER
                                                          $CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].SetColor($BLANK);     
                                                          
                                                          #BLANK previous spot
                                                          $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);

                                                          #Set new position of RED CHECKER
                                                          $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                             
                                                          if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                                                          {
                                                             $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                          }                                                                
                                                          else  
                                                          { 
                                                             $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                          }
                                             
                                                          #Is a DoubleJump possible?
                                                          DoubleJump($DestinationPosition, $COLOR);
                                             
                                                      }

                                                      #22. Did they try to jump over a blank space?
                                                      elseif($CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].GetColor() -EQ $BLANK)
                                                      {
                                                          Write-Host("  You can't jump over a BLANK space.");
                                                      }

                                                      #23. Did they try to jump over their own CHECKER?
                                                      else
                                                      {
                                                          Write-Host("  You can't jump over your own BLACK CHECKERS." +
                                                                     "`n   That's an illegal jump. Shame on you!");
                                                          $DestinationPosition[0] = 0;
                                                          Start-Sleep -s 2;      
                                                      }

                                                  }#close are they Moving RIGHT? 

                                                  #24. Are they Moving LEFT?
                                                  else
                                                  {
                                                      Write-Host("Moving to the LEFT for this JUMP.");

                                                      #25. Is move over opponent's CHECKER (BLACK)?
                                                      if($CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].GetColor() -EQ $RED)
                                                      {
                                                           Write-Host("   You jumped your BLACK CHECKER over your opponent's" +
                                                                      "`n   RED checker. That is a LEGAL jump! Nice job."); 
                                                                       
                                                           #BLANK jumped checker
                                                           $CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].SetColor($BLANK);

                                                           #BLANK previous spot
                                                           $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                                                           
                                                           #Set current position     
                                                           $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                             
                                                           if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                                                           {
                                                              $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                           }                                                                
                                                           else  
                                                           { 
                                                              $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                           }
                                           
                                                           DoubleJump($DestinationPosition, $COLOR);                                                                              
                                                      }
                                                      else
                                                      {
                                                          Write-Host("  You can't jump over your own BLACK CHECKERS." +
                                                                     "`n   That's an illegal jump. Shame on you!");
                                                          $DestinationPosition[0] = 0;
                                                          Start-Sleep -s 2;    
                                                            
                                                      }#close if CHECKER is opponent's (BLACK)

                                                  }#close if moving LEFT
                                             }
                                             else
                                             {
                                                  Write-Host("  Invalid move. You must jump your BLACK CHECKER to an EVEN numbered square.");
                                                  $DestinationPosition[0] = 0;
                                                  Start-Sleep -s 2;

                                             }#close is it BLANK, ODD and 2 rows ahead?                                             
                                         }
                                         else
                                         {
                                              Write-Host("  Current Position of RED CHECKER is an ODD number!");

                                              if($DestinationPosition[1] % 2 -NE 0)
                                              {
                                                  Write-Host("  Good! Jumping RED CHECKER to a BLANK, ODD square 2 rows ahead!");                         
                                                  
                                                  #Are they Moving RIGHT?
                                                  if($DestinationPosition[1] -GT $CurrentPosition[1])
                                                  {
                                                     Write-Host("Moving to the RIGHT for this JUMP.");

                                                     #Is JUMP over opponent's CHECKER (BLACK)?
                                                     if($CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].GetColor() -EQ $RED)
                                                     {
                                                         Write-Host("  You jumped your BLACK CHECKER over your opponent's" +
                                                                   "`n   RED checker. That is a LEGAL jump! Nice job.");

                                                         #BLANK jumped checker
                                                         $CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].SetColor($BLANK);  
                                                        
                                                         #BLANK previous spot   
                                                         $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK); 

                                                         #Set current position
                                                         $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                             
                                                         if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                                                         {
                                                            $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                         }                                                                
                                                         else  
                                                         { 
                                                            $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                         }
                                              
                                                         DoubleJump($DestinationPosition, $COLOR);
                                                     }
                                                     else
                                                     {
                                                         Write-Host("  You can't jump over your own BLACK CHECKERS." +
                                                                    "`n   That's an illegal jump. Shame on you!");
                                                         $DestinationPosition[0] = 0;
                                                         Start-Sleep -s 2; 
                                                             
                                                     }#close if JUMP over opponent's CHECKER

                                                  }#close if moving RIGHT

                                                  #Are they moving LEFT?
                                                  else
                                                  {
                                                     Write-Host("Moving to the LEFT for this JUMP.");

                                                     #Is JUMP over opponent's CHECKER (BLACK)?
                                                     if($CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].GetColor() -EQ $RED)
                                                     {
                                                         Write-Host("  You jumped your RED CHECKER over your opponent's" +
                                                                    "`n   BLACK checker. That is a LEGAL jump! Nice job.");  

                                                         #BLANK jumped checker
                                                         $CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].SetColor($BLANK);  
                                                         
                                                         #BLANK previous spot     
                                                         $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);

                                                         #Set current position
                                                         $CheckerBoard[($DestinationPosition[0]-1),($DestinationPosition[1]-1)].SetColor($BLACK);
                                             
                                                         if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                                                         {
                                                            $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                                                         }                                                                
                                                         else  
                                                         { 
                                                            $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                                                         }
                                           
                                                         DoubleJump($DestinationPosition, $COLOR);                                                                                        
                                                     }
                                                     else
                                                     {
                                                         Write-Host("  You can't jump over your own BLACK CHECKERS." +
                                                                    "`n   That's an illegal jump. Shame on you!");
                                                         $DestinationPosition[0] = 0;
                                                         Start-Sleep -s 2; 

                                                     }#close if JUMP over opponent 
                                                                                              
                                                  }#close if moving LEFT 

                                               }#close is it BLANK, ODD and 2 rows ahead?

                                             }                                      
                                             else
                                             {
                                                  Write-Host("  Invalid move. You must jump BLACK CHECKER to an ODD numbered square.");
                                                  $DestinationPosition[0] = 0;
                                                  Start-Sleep -s 2;

                                             }#close is it an EVEN or ODD number?                                                                                                                                          
                                     }
                                     else
                                     {
                                         Write-Host("  You are not moving your BLACK CHECKER" +
                                               "`n   forward far enough for a jump!");
                                         $DestinationPosition[0] = 0;
                                         Start-Sleep -s 2;

                                     }#close if more than one row forward for JUMP?

                                }#close if CHECKER moving backwards

                           }#close if CHECKER BLACK
                     
                        #----------------------------------------------------

                       }#close if jump sideways             
                                    
                   }#close if a CHECKER is already there (not BLANK)

               }#close if outside range  

         }#close while true loop  

         $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetSelected($false);
         return $true; 
         
}#close function          

<# ---------------------------------------------------------------------------------------------------------------------- #>

#Note: Function accepts entire ARRAY as 1st argument.

function DoubleJump([int[]] $CurrentPosition, [int] $COLOR)
{
         [String] $CHOICE = "*";
         [int] $NUM; 
         
         #1. If CHECKER is RED
         if($COLOR -EQ $RED)
         {         
             #2. Is Double Jump Available to RIGHT?
             if($CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].GetColor() -EQ $BLACK -AND 
                $CheckerBoard[($CurrentPosition[0]+1),($CurrentPosition[1]+1)].GetColor() -EQ $BLANK)
             {
                  Write-Host("`n  You have a DOUBLE jump available to the RIGHT!");
                  $CHOICE = (Read-Host("Do you wish to take it?")).ToLower(); 
                 
                  if($CHOICE[0] -EQ 'y')
                  {
                      #BLANK jumped checker
                      $CheckerBoard[$CurrentPosition[0],$CurrentPosition[1]].SetColor($BLANK); 
                      
                      #BLANK previous spot    
                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK); 

                      #Set current position
                      $CheckerBoard[($CurrentPosition[0]+1),($CurrentPosition[1]+1)].SetColor($RED);
                                             
                      if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                      {
                          $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                      }                                                                
                      else  
                      { 
                          $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                      }

                      return;
                   }
                   else
                   {
                       Write-Host("`n  O.k., for whatever reason? You decide not to take it.");
                       Start-Sleep -s 2;
                   }

             }#close is Double Jump Available to RIGHT

             #3. Is Double Jump Available to LEFT?
             if($CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].GetColor() -EQ $BLACK -AND 
                $CheckerBoard[($CurrentPosition[0]+1),(($CurrentPosition[1]-3))].GetColor() -EQ $BLANK)
             {
                  Write-Host("`n  You have a DOUBLE jump available to the LEFT!");
                  $CHOICE = (Read-Host("Do you wish to take it?")).ToLower(); 
                 
                  if($CHOICE[0] -EQ 'y')
                  {
                      #BLANK jumped checker
                      $CheckerBoard[$CurrentPosition[0],($CurrentPosition[1]-2)].SetColor($BLANK); 
                      
                      #BLANK previous spot    
                      $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK); 

                      #Set current position
                      $CheckerBoard[($CurrentPosition[0]+1),(($CurrentPosition[1]-3))].SetColor($RED);
                                             
                      if($global:PLAYA_ONE.GetPlayerColor() -EQ $RED)
                      {
                          $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                      }                                                                
                      else  
                      { 
                          $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                      }

                      return;
                   }
                   else
                   {
                       Write-Host("`n  O.k., for whatever reason? You decide not to take it.");
                       Start-Sleep -s 2;
                   }

             }#close is Double Jump Available to LEFT

         }#close if CHECKER RED  
         
         #4. Is CHECKER BLACK?
         else
         {
             #5. Is opponent in position for double jump RIGHT?
             if($CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].GetColor() -EQ $RED)
             {
                 #6. Is Double Jump Available to RIGHT?
                 if($CheckerBoard[($CurrentPosition[0]-3),($CurrentPosition[1]+1)].GetColor() -EQ $BLANK)
                 {
                     Write-Host("   Awesome! Double jump to RIGHT!");
                   
                     #BLANK jumped checker
                     $CheckerBoard[($CurrentPosition[0]-2),$CurrentPosition[1]].SetColor($BLANK);
                     
                     #BLANK previous spot     
                     $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);
                     
                     #Set current position   
                     $CheckerBoard[($CurrentPosition[0]-3),($CurrentPosition[1]+1)].SetColor($BLACK);
                                             
                     if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                     {
                         $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                     }                                                                
                     else  
                     { 
                         $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                     }
                    
                     Start-Sleep -s 2;  
                 }
                 else
                 {
                     Write-Host("   Space required for BLACK to Double Jump RIGHT is not BLANK.");

                 }#close is double jump available to RIGHT?  

             }#close is opponent in position for double jump RIGHT?
          
             #7. Is opponent in position for double jump LEFT?
             elseif($CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].GetColor() -EQ $RED)
             {
                 #8. Is Double Jump Available to LEFT?
                 if($CheckerBoard[($CurrentPosition[0]-3),($CurrentPosition[1]-3)].GetColor() -EQ $BLANK)
                 {
                     Write-Host("   Awesome! Double jump to LEFT!");
                   
                     #BLANK jumped checker
                     $CheckerBoard[($CurrentPosition[0]-2),($CurrentPosition[1]-2)].SetColor($BLANK); 
                         
                     #BLANK previous spot
                     $CheckerBoard[($CurrentPosition[0]-1),($CurrentPosition[1]-1)].SetColor($BLANK);

                     $CheckerBoard[($CurrentPosition[0]-3),($CurrentPosition[1]-3)].SetColor($BLACK);
                                             
                     if($global:PLAYA_ONE.GetPlayerColor() -EQ $BLACK)
                     {
                         $global:PLAYA_ONE.SetPlayerScore(($global:PLAYA_ONE.GetPlayerScore() + 1));
                     }                                                                
                     else  
                     { 
                         $global:PLAYA_TWO.SetPlayerScore(($global:PLAYA_TWO.GetPlayerScore() + 1));
                     }
                                      
                     Start-Sleep -s 2;  
                 }
                 else
                 {
                      Write-Host("  Space required for BLACK to Double Jump LEFT is not BLANK.");

                 }#close is Double Jump Available to LEFT?      
                          
             }          
             else
             {
                 Write-Host("`n  No DOUBLE JUMP available on either side.");

             }# is opponent in position for double jump LEFT?   
                    
        }#close if CHECKER is BLACK  

}#close function

<# ---------------------------------------------------------------------------------------------------------------------- #>
<# ---------------------------------------------------------------------------------------------------------------------- #>

function Test_Two_Dimensional_Arrays
{
         Clear;

         Write-Host("`nTotal COUNT (both dimensions) = " + $global:CheckerBoard.Count);
         Write-Host("Number X elements = " + $global:CheckerBoard.GetUpperBound(0));
         Write-Host("Number Y elements = " + $global:CheckerBoard.GetUpperBound(1));


         [boolean] $Toggle = $true;

         #Test linear instantiation
         Write-Host("`n");
         $global:CheckerBoard[0,0] = New-Object CHECKER($RED);
         $global:CheckerBoard[0,1] = New-Object CHECKER($BLACK);
         Write-Host("CheckerBoard[0,0]  =  " + $global:CheckerBoard[0,0].GetCheckerType());
         Write-Host("CheckerBoard[0,1]  =  " + $global:CheckerBoard[0,1].GetCheckerType());

         
         #Populate Array with CHECKER objects
         for($x = 0; $x -LT ($global:CheckerBoard.GetUpperBound(0) + 1); $x++)
         {
              if($Toggle -EQ $true)
              { 
                 Write-Host("`nAdding RED CHECKER to [$x,0]");
                 $global:CheckerBoard[$x,0] = New-Object CHECKER($RED);
                 $Toggle = $false;
              }
              else
              {
                 Write-Host("`nAdding BLACK CHECKER to [$x,0]");
                 $global:CheckerBoard[$x,0] = New-Object CHECKER($BLACK);
                 $Toggle = $true;
              }


         }

         #Display CHECKER objects
         for($x = 0; $x -LT ($global:CheckerBoard.GetUpperBound(0) + 1); $x++)
         {
               Write-Host("`n---------------------------------------------");
               Write-Host("" + ($x+1) + ". [$x,0]  =  " + $global:CheckerBoard[$x,0].GetCheckerType());
         }

}

<# ---------------------------------------------------------------------------------------------------------------------- #>

function Test1
{
         Clear;

         CreateBoard;
         #Start-Sleep -s 3;
                  
         $global:PLAYA_ONE.SetPlayerName("Carly");
         $global:PLAYA_ONE.SetPlayerColor($RED);
         $global:PLAYA_TWO.SetPlayerName("Computer");
         $global:PLAYA_TWO.SetPlayerColor($BLACK); 
     
         DisplayBoard;

         Write-Host("Selecting Checker ...")
         SelectChecker -COLOR $global:PLAYA_ONE.GetPlayerColor() -pNAME $global:PLAYA_ONE.GetPlayerName();
}

<# ---------------------------------------------------------------------------------------------------------------------- #>



<# ------- Invocations ------- #>
#Test_Two_Dimensional_Arrays;
#Test1;
MAIN;



