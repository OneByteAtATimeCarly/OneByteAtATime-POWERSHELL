#Title: PowerShell - Module 07 - Classes - Black Jack
#Author: Carly S. Germany
#Date: 06/10/2020

#Globals Accessible to All Functions (global namespace)

<# ------------------------------------------------------------------- #>

#Constants
[int] $NUMCARDS = 13;
[int] $NUMFACES = 4;
[int] $NUMCARDSINDECK = 52;
[int] $MaxHandSize = 20;
[int] $NumCardsToStartWith = 2;
[int] $HouseLimit = 17;
       
#The Card Values
[int] $DEUCE = 2;
[int] $THREE = 3;
[int] $FOUR = 4;
[int] $FIVE = 5;
[int] $SIX = 6;
[int] $SEVEN = 7;
[int] $EIGHT = 8;
[int] $NINE = 9;
[int] $TEN = 10;
[int] $JACK = 11;
[int] $QUEEN = 12;
[int] $KING = 13;
[int] $ACE = 14;
       
#The Faces
[int] $SPADES = 0;
[int] $HEARTS = 1;
[int] $DIAMONDS = 2;
[int] $CLUBS = 3;

#Dealer and Player
[int] $PLAYER = 1;
[int] $DEALER = 2;

[int] $global:DealerTotal = 0;
[int] $global:PlayerTotal = 0;
[int] $global:DealerStay = $false;
[int] $global:PlayerStay = $false;

#Count the Number of Deals for Indexing the Cards
#Used to advance array forward to hold new cards in hand
[int] $global:PlayerDeal = 0;
[int] $global:DealerDeal = 0;

[String] $PlayerName = "";
[boolean] $DisplayAllDealerCards = $false;
[boolean] $CHEAT = $false;
       
[int] $global:DealerWins = 0;
[int] $global:PlayerWins = 0;

#Build 3 Arrays to hold deck and different hands of CARDs
$global:DeckOfCards = New-Object CARD[] $NUMCARDSINDECK;
$global:DealerHand = New-Object CARD[] $MaxHandSize;
$global:PlayerHand = New-Object CARD[] $MaxHandSize;


<# ------------------------------------------------------------------- #>

class CARD
{
      #Data Members
      [int] $TheFace;
      [int] $TheCard;
      [int] $PointValue = 0;
      [boolean] $Drawn = $false;

      #The Card Values
      [int] $DEUCE = 2;
      [int] $THREE = 3;
      [int] $FOUR = 4;
      [int] $FIVE = 5;
      [int] $SIX = 6;
      [int] $SEVEN = 7;
      [int] $EIGHT = 8;
      [int] $NINE = 9;
      [int] $TEN = 10;
      [int] $JACK = 11;
      [int] $QUEEN = 12;
      [int] $KING = 13;
      [int] $ACE = 14;
       
      #The Faces
      [int] $SPADES = 0;
      [int] $HEARTS = 1;
      [int] $DIAMONDS = 2;
      [int] $CLUBS = 3;

      #Overloaded Constructors
      CARD() 
      { 
          Write-Host("Creating a generic CARD object."); 
          $this.TheCard = $this.DEUCE;
          $this.TheFace = $this.HEARTS;
          $this.Drawn = $false;
      }

      CARD([int] $card, [int] $face) 
      { 
          Write-Host("Creating a specific CARD object."); 
          $this.TheCard = $card;
          $this.TheFace = $face;
          $this.Drawn = $false;

          switch($this.TheCard)
          {
               $this.DEUCE { $this.PointValue = 2; break; }
               $this.THREE { $this.PointValue = 3; break; }
               $this.FOUR { $this.PointValue = 4; break; }
               $this.FIVE { $this.PointValue = 5; break; }
               $this.SIX { $this.PointValue = 6; break; }
               $this.SEVEN { $this.PointValue = 7; break; }
               $this.EIGHT { $this.PointValue = 8; break; }
               $this.NINE { $this.PointValue = 9; break; }
               $this.TEN { $this.PointValue = 10; break; }
               $this.JACK { $this.PointValue = 10; break; }
               $this.QUEEN { $this.PointValue = 10; break; }
               $this.KING { $this.PointValue = 10; break; }
               $this.ACE { $this.PointValue = 11; break ; }
               default { break; }
          }
      }

      #Member Methods
      DisplayCard()
      {        
          [String] $OUT = "     A ";

          switch($this.TheCard)
          {
               $this.DEUCE { $OUT = $OUT + "DEUCE"; break; }
               $this.THREE { $OUT = $OUT + "THREE"; break; }
               $this.FOUR { $OUT = $OUT + "FOUR"; break; }
               $this.FIVE { $OUT = $OUT + "FIVE"; break; }
               $this.SIX { $OUT = $OUT + "SIX"; break;; }
               $this.SEVEN { $OUT = $OUT + "SEVEN"; break; }
               $this.EIGHT { $OUT = $OUT + "EIGHT"; break; }
               $this.NINE { $OUT = $OUT + "NINE"; break; }
               $this.TEN { $OUT = $OUT + "TEN"; break; }
               $this.JACK { $OUT = $OUT + "JACK"; break; }
               $this.QUEEN { $OUT = $OUT + "QUEEN"; break; }
               $this.KING { $OUT = $OUT + "KING"; break; }
               $this.ACE { $OUT = $OUT + "ACE"; break; }
               default { break; }
          }

          $OUT = $OUT + " of ";

          switch($this.TheFace)
          {
                 $this.SPADES { $OUT = $OUT + "SPADES"; break; }
                 $this.HEARTS { $OUT = $OUT + "HEARTS"; break; }
                 $this.DIAMONDS { $OUT = $OUT + "DIAMONDS"; break; }
                 $this.CLUBS { $OUT = $OUT + "CLUBS"; break; }
                 default { break; }
          }

          $OUT = $OUT + ". Points = " + $this.PointValue + ".";

          Write-Host($OUT);
      }
}

<# ------------------------------------------------------------------- #>

function MAIN
{
         Clear;
         Write-Host("`nBlackJack 1.0`n`n");
         $PlayerName = Read-Host("What's your name, player?");

         Write-Host("`n`nHi " + $PlayerName + "! Before we start you should know:`n`n");
         Write-Host("      Activating CHEAT forces DEALER to display all cards.");
         Write-Host("      DeActivating CHEAT allows DEALER to hide cards (normal).`n`n");

         $null = Read-Host("ENTER to continue.");

         [String] $choice = "*";

         while($choice[0] -NE 'q')
         {
               Clear;
               Write-Host("`n`n");

               Write-Host("                    _________ Main Menu ________");
               Write-Host("                    |                          |");
               Write-Host("                    |    (P)lay BlackJack      |");
               Write-Host("                    |    (I)nstructions        |");
               Write-Host("                    |    (A)ctivate Cheat      |"); 
               Write-Host("                    |    (D)eactivate Cheat    |");  
               Write-Host("                    |    (Q)uit                |");
               Write-Host("                    |__________________________|`n");

               Write-Host("                           " + 
                          "CHEAT = " + $DisplayAllDealerCards) -ForegroundColor Red;

               Write-Host("`n                              Scores:           ");
               Write-Host("                          Dealer Wins = " + $global:DealerWins + "");
               Write-Host("                          Player Wins = " + $global:PlayerWins + "`n");


               $choice = (Read-Host("CHOICE")).ToLower();

               switch($choice[0])
               {
                         'p' { The_Game; }
                         'i' { Instructions; }
                         'a' { $DisplayAllDealerCards = $true; }
                         'd' { $DisplayAllDealerCards = $false; }
                         'q' { break;}
                          default{ $null = Read-Host("Invalid choice. ENTER to continue.");
                                 }
               }
         }

}

<# ------------------------------------------------------------------- #>

function The_Game
{
         #Initialize Values for a New Game
         $global:DealerTotal= 0;
         $global:PlayerTotal = 0;
         $global:PlayerDeal = 0;
         $global:DealerDeal = 0;
         $global:DealerStay = $false;
         $global:PlayerStay = $false;
         $DisplayAllDealerCards = $false;

         #Start populating deck with DEUCES
         [int] $CardType = $DEUCE;

         #Populate the Deck Array With Card Values
         CLEAR;
         Write-Host("`n     -------------- Creating a 52 CARD Deck Now --------------`n");

         Start-Sleep -s 2;

         for($CardInDeck = 0; $CardInDeck -LT $NUMCARDSINDECK; )
         {
              #For each card value? Give it 4 faces.
              for($CardFace = 0; $CardFace -LT $NUMFACES; $CardFace++)
              {
                   $global:DeckOfCards[$CardInDeck] = New-Object CARD($CardType,$CardFace);
                   $global:DeckOfCards[$CardInDeck].DisplayCard();
                   $CardInDeck++;
              }

              #Started with DEUCE, we go to next CARD THREE, and so on
              $CardType++;
         }

         Start-Sleep -s 1;

         Write-Host("`n`n     ---------------------- DONE ---------------------------`n");

         Write-Host("`n     The Dealer shuffles the DECK and deals out the CARDs...`n");

         #Dealer and Player Start Hand By Drawing 2 Cards Each
         for($x = 0; $x -LT $NumCardsToStartWith; $x++)
         {
              DRAW($PLAYER);
              DRAW($DEALER);
         }

         DisplayHand($PLAYER);
         DisplayHand($DEALER);

         Deal;

         #Stop hiding Dealer's CARDs and POINTs
         $DisplayAllDealerCards = $true;
              
         Write-Host("`n     Closing HANDs:`n");
         
         DisplayHand($PLAYER);
         DisplayHand($DEALER);

         #If someone WINS or BUSTS
         if($global:PlayerTotal -EQ 21)
         { 
              Write-Host("     " + $PlayerName + " nails it and wins! A perfect 21!");
              $global:PlayerWins++;
         }
         elseif($global:DealerTotal  -EQ 21)
         { 
              Write-Host("     Dealer nails it and wins! A perfect 21!");  
              $global:DealerWins++;
         }
         elseif($global:PlayerTotal -GT 21)
         {
              Write-Host("`n     " + $PlayerName + ", you BUSTED! Sorry, you lost this round.");
              $global:DealerWins++;
         }
         elseif($global:DealerTotal -GT 21)
         {
              Write-Host("`n     Dealer BUSTED. Woo-hoo! " + $PlayerName + " wins this round.");
              $global:PlayerWins++;
         }

         
         #Player STAYs, see whose hand is better
         if($global:PlayerStay)
         {
              if($global:PlayerTotal -EQ $DealerTotal)
              { 
                   Write-Host("`n     Unbelieveable! " + $PlayerName + " and the Dealer tie!");
                   $global:PlayerWins++;
                   $global:DealerWins++;
              }
              elseif($global:PlayerTotal -GT $DealerTotal -AND 
                     $global:PlayerTotal -LE 21)
              { 
                    Write-Host("`n     " + $PlayerName + " wins this round!"); 
                    $global:PlayerWins++;
              }
              elseif($global:DealerTotal -GT $PlayerTotal -AND 
                     $global:DealerTotal -LE 21)
              { 
                    Write-Host("`n     The Dealer wins this round!");
                    $global:DealerWins++;
              }
         }

         Write-Host("`n`n     This round of BlackJack is now complete!`n");

         #Re-initialize the DECK for a new round
         for($x = 0; $x -LT $MaxHandSize; $x++)
         {
              $global:DealerHand[$x] = $null;
              $PlayerHand[$x] = $null;
         }

         $null = Read-Host("`n     Press ENTER to continue.");
}

<# ------------------------------------------------------------------- #>

function DRAW([int] $Hand)
{
         #Pick a random CARD. Note that we must subtract 1 from NUMCARDSINDECK
         #in order to avoid fencepost/off by one error since it's 0-51, not 1-52

         [int] $ACard = Get-Random -Minimum 1 -Maximum (($NUMCARDSINDECK-1) + 1);

         #Create random number RECURSIVELY until find CARD not already DRAWN
         while($global:DeckOfCards[$ACard].Drawn -EQ $true)
         { $ACard = Get-Random -Minimum 1 -Maximum (($NUMCARDSINDECK-1) + 1); }

         #After finding undrawn random CARD, mark it as DRAWN
         $global:DeckOfCards[$ACard].Drawn = $true;

         #Add CARDs to appropriate hand and calculate point value
         if($Hand -EQ $PLAYER)
         {
            $PlayerHand[$global:PlayerDeal] = $global:DeckOfCards[$ACard];
            $global:PlayerTotal = $global:PlayerTotal + $PlayerHand[$global:PlayerDeal].PointValue;
            $global:PlayerDeal++;
         }
         else
         {
            $global:DealerHand[$global:DealerDeal] = $global:DeckOfCards[$ACard];
            $global:DealerTotal= $global:DealerTotal+ $global:DealerHand[$global:DealerDeal].PointValue;
            $global:DealerDeal++;
         }        
}

<# ------------------------------------------------------------------- #>

function DisplayHand([int] $Hand)
{
         #If PLAYER display player's hand
         if($Hand -EQ $PLAYER)
         {
             Write-Host("`n     " + $PlayerName + "'s  Hand:");

             for($x = 0; $x -LT $MaxHandSize; $x++)
             {
                  if($PlayerHand[$x] -NE $null)
                  {
                      $PlayerHand[$x].DisplayCard();
                  }
                  else 
                  { break; }
             }

             Write-Host("     Total " + $PlayerName +
                        " points = " + $global:PlayerTotal + ".`n`n");
        }

        else
        {
             Write-Host("`n     Dealer's Hand:");

             if($DisplayAllDealerCards)
             {
                  #Display all the Dealer's CARDs
                  for($x = 0; $x -LT $MaxHandSize; $x++)
                  {
                      if($global:DealerHand[$x] -NE $null)
                      {
                              $global:DealerHand[$x].DisplayCard();
                      }
                      else
                      { break; }
                  }

                  Write-Host("     Total Dealer points = " + $global:DealerTotal+ ".`n");

             }
             else
             {
                  #Hide 1st CARD (Element 0) so x = 1
                  Write-Host("     A Hidden CARD! What could it be?");

                  for($x = 1; $x -LT $MaxHandSize; $x++)
                  {
                      if($global:DealerHand[$x] -NE $null)
                      {
                          $global:DealerHand[$x].DisplayCard();
                      }
                      else
                      { break; }
                  }

                  Write-Host("     Total Dealer points = ??? (HIDDEN).`n`n");
              }

          }
}

<# ------------------------------------------------------------------- #>

function Deal
{
         [String] $choice = "*";

         #Player Goes First. Play until Player or Dealer reaches 21.
         #Or until Player or Dealer Bust or decide to STAY.

         while($choice[0] -NE 'q' -AND
               $global:DealerTotal -LT 21 -AND
               $global:PlayerTotal -LT 21 -AND
               $global:PlayerStay -EQ $false )
              {
                  Write-Host("`n     The Dealer asks:`n`n     " + $PlayerName +
                             ", do you want a HIT? Or will you STAY?`n`n");

                  Write-Host("     _______________ Options _____________ `n");
                  Write-Host("     |                                    |`n");
                  Write-Host("     |  (H)it       (S)tay      (Q)uit    |`n");
                  Write-Host("     |____________________________________|`n`n");

                  $choice = (Read-Host("     CHOICE")).ToLower();

                  switch($choice[0])
                  {
                      'h' { Write-Host("`n     " + $PlayerName + " requests a HIT.`n");
                            Hit($PLAYER);
                            break; 
                          }
                      's' { Write-Host("`n     " + $PlayerName + " decides to STAY.`n");
                            $global:PlayerStay = $true;
                            DisplayHand($PLAYER);
                            break; 
                          }
                      'q' {  break; }
                      default { Write-Host("`n     Invalid input!`n");
                                $choice = "INVALID_INPUT";
                                break;
                              }
                  }

                  #If invalid input? Skip Dealer events and go back to Player
                  if(!$choice -NE "INVALID_INPUT")
                  {
                       #Dealer Only Draws if Player Not Busted
                       if($global:PlayerTotal -LT 21)
                       {
                            if($global:DealerTotal-LT $HouseLimit)
                            {
                                Write-Host("`n     The Dealer decides to take a card.`n");
                                Hit($DEALER);
                            }
                            else
                            {
                                Write-Host("`n     The Dealer decides to STAY.`n");
                                $global:DealerStay = $true;
                                DisplayHand($DEALER);
                            }
                       }
                  }
              }                  
}

<# ------------------------------------------------------------------- #>

function Hit([int] $WHOEVER)
{
         DRAW($WHOEVER);

         if($WHOEVER -EQ $PLAYER)
         {
             if($global:PlayerTotal -GT 21)
             {
                 for($x = 0; $x -LT $MaxHandSize; $x++)
                 {
                     if($PlayerHand[$x] -NE $null)
                     {
                         #Set points of only ONE ACE to 1 if over 21
                         if($PlayerHand[$x].TheCard-EQ $ACE)
                         {
                             Write-Host("`n     " + $PlayerName + 
                                        ", your HAND is over 21 but an ACE was found.`n" +
                                        "     We'll convert the ACE from 11 points to 1 point!`n");

                             $PlayerHand[$x].PointValue = 1;
                             break;
                         }
                      }
                      else
                      { break; }
                 }

                 #Recount Point values of cards after converting ACE
                 #Alternatively, you could just subtract 10 from PlayerTotal and set
                 #its point value to 1 without looping theough the arrays above/below

                 $global:PlayerTotal = 0;

                 for($x = 0; $x -LT $MaxHandSize; $x++)
                 {
                     if($PlayerHand[$x] -NE $null)
                     {
                         $global:PlayerTotal = $global:PlayerTotal + $PlayerHand[$x].PointValue;
                     }
                     else { break; }
                 }

             }#close if PlayerTotal > 21

         }#close if WHOEVER == PLAYER

         #If not Player? Must be Dealer
         else
         {
             if($global:DealerTotal -GT 21)
             {
                 for($x = 0; $x -LT $MaxHandSize; $x++)
                 {
                       if($global:DealerHand[$x] -NE $null)
                       {
                           #Set points of only ONE ACE to 1 if over 21
                           if($global:DealerHand[$x].TheCard -EQ $ACE)
                           {
                                Write-Host("`n     Dealer's HAND is over 21 but an ACE was found.`n" +
                                + "     We'll convert the ACE from 11 points to 1 point!`n");

                                $global:DealerHand[$x].PointValue = 1;
                                break; 
                           }
                       }
                       else
                       { break; }
                 }

                 #Recount Point values of cards after converting ACE.
                 #Alternatively? You could just subtract 10 from PlayerTotal
                 #and set its point value to 1 without looping theough the arrays above/below.
                 
                 $global:DealerTotal= 0;

                 for($x = 0; $x -LT $MaxHandSize; $x++)
                 {
                     if($global:DealerHand[$x] -NE $null)
                     {
                         $global:DealerTotal= $global:DealerTotal+ $global:DealerHand[$x].PointValue;
                     }
                     else { break; }
                 }
             }                
         }

         DisplayHand($WHOEVER);
}

<# ------------------------------------------------------------------- #>

function Instructions()
{        
         Clear;
         Write-Host("`n`n");
         Write-Host("Welcome to Blackjack 1.0, " + $PlayerName + "!`n`n"); 
         Write-Host("        Blackjack is a short, fast card game of luck and skill.");
         Write-Host("        The dealer will start you with two cards from the deck.");
         Write-Host("        Your goal is to draw cards to get as close to the number");
         Write-Host("        21 as possible. If you go over 21? You are BUSTED! If you");
         Write-Host("        get closer to 21 than the dealer, but not over? You win.`n");
         Write-Host("        The card values are:`n`n");
         Write-Host("                   DEUCES = 2          EIGHT = 8");
         Write-Host("                   THREE =  3          NINE =  9");
         Write-Host("                   FOUR =   4          TEN =   10 ");
         Write-Host("                   FIVE =   5          JACK =  10");
         Write-Host("                   SIX =    6          QUEEN = 10");
         Write-Host("                   SEVEN =  7          KING =  10");
         Write-Host("                                       ACE =   11 or 1`n`n");
         Write-Host("        ACEs are 1 or 11 depending on which value is advantageous.");
         Write-Host("`n`n        Activating the CHEAT allows you to see all the dealer's cards,");
         Write-Host("        giving you an unfair advantage. Normally, one of the Dealer's");
         Write-Host("        cards is hidden, making the game more challenging.`n`n");

         PAUSE;         
}

<# ------------------------------------------------------------------- #>

function PAUSE
{
         $null = Read-Host("`nPress ENTER to continue.");
}

<# ------------------------------------------------------------------- #>



#------- Invocations -------
#Test;
#The_Game;
#Instructions;
MAIN;


<# ------------------------------------------------------------------------------------------------------------ #>

