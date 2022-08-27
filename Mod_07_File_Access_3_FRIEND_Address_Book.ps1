#Title: PowerShell - Module 08 - File Access - Address Book Database
#       Using an Inheritance Hierarchy - Writing Function that use Base/Parent and Derived/Child Classes
#Author: Carly S. Germany
#Date: 06/25/2020
#Last Modified: 07/06/2020 

<# -------------------------------------------------------------------------------- #>

#Globals
$global:GroupOfFriends = @();

<# -------------------------------------------------------------------------------- #>


#Classes
<# -------------------------------------------------------------------------------- #>
#BASE class 

class FRIEND
{
      #----- Data Members -----
      [String] $FirstName = " ";
      [String] $LastName = " ";
      [String] $EmailAddress= " ";
      [String] $MobilePhone = " ";
      [String] $StreetAddress = " ";
      [String] $City = " ";
      [String] $State = " ";
      [String] $Country = " ";
      [String] $BirthDay = " ";
      [String] $FaveColor = " ";
      [String] $FaveFood = " ";

      #----- Constructor -----
      FRIEND()
      { Write-Host("  Creating a FRIEND object."); }

      #------- Member-Methods -------
      Display_Friend()
      {
           [String] $Message = "";

           $Message += "  First Name: " + $this.FirstName;
           $Message += "`n  Last Name: " + $this.LastName;
           $Message += "`n  Email: " + $this.EmailAddress;
           $Message += "`n  Mobile Phone: " + $this.MobilePhone;
           $Message += "`n  Street Address: " + $this.StreetAddress;
           $Message += "`n  City: " + $this.City;
           $Message += "`n  State: " + $this.State;
           $Message += "`n  Country: " + $this.Country;
           $Message += "`n  Birthday: " + $this.BirthDay;
           $Message += "`n  Favorite Color: " + $this.FaveColor;
           $Message += "`n  Favorite Food: " + $this.FaveFood;

           Write-Host($Message);
      }

   #------------------------------------------------------------------

      New_Friend()
      {
           Write-Host("`n");
           $this.FirstName = Read-Host("First Name? ");
           $this.LastName= Read-Host("Last Name? ");
           $this.EmailAddress= Read-Host("Email? ");
           $this.MobilePhone= Read-Host("Mobile Phone? ");
           $this.StreetAddress= Read-Host("Street Address? ");
           $this.City= Read-Host("City? ");
           $this.State= Read-Host("State? ");
           $this.Country= Read-Host("Country? ");
           $this.BirthDay= Read-Host("Birthday? ");
           $this.FaveColor= Read-Host("Favorite Color? ");
           $this.FaveFood= Read-Host("Favorite Food? ");           
      }

   #------------------------------------------------------------------


      Edit_Friend()
      {
           Write-Host("`n  Choose an attbiute to change:`n")

           [String] $Message = "";

           $Message += "`n  1. First Name: " + $this.FirstName;
           $Message += "`n  2. Last Name: " + $this.LastName;
           $Message += "`n  3. Email: " + $this.EmailAddress;
           $Message += "`n  4. Mobile Phone: " + $this.MobilePhone;
           $Message += "`n  5. Street Address: " + $this.StreetAddress;
           $Message += "`n  6. City: " + $this.City;
           $Message += "`n  7. State: " + $this.State;
           $Message += "`n  8. Country: " + $this.Country;
           $Message += "`n  9. Birthday: " + $this.BirthDay;
           $Message += "`n  10. Favorite Color: " + $this.FaveColor;
           $Message += "`n  11. Favorite Food: " + $this.FaveFood;

           Write-Host($Message);

           $CHOICE = Read-Host("`nWhich value do you wish to edit? (1-11) ");

           switch($CHOICE[0])
           {
               1 { $this.FirstName = Read-Host("First Name? "); }
               2 { $this.LastName= Read-Host("Last Name? "); }
               3 { $this.EmailAddress= Read-Host("Email? "); }
               4 { $this.MobilePhone= Read-Host("Mobile Phone? "); }
               5 { $this.StreetAddress= Read-Host("Street Address? "); }
               6 { $this.City= Read-Host("City? "); }
               7 { $this.State= Read-Host("State? "); }
               8 { $this.Country= Read-Host("Country? "); }
               9 { $this.BirthDay= Read-Host("Birthday? "); }
               10 { $this.FaveColor= Read-Host("Favorite Color? "); }
               11 { $this.FaveFood= Read-Host("Favorite Food? "); }
               default { Write-Host("`n  Invalid option."); }
           }

           Write-Host("`n");
           $this.Display_Friend();
      }

}

<# -------------------------------------------------------------------------------- #>

#Functions:
<# -------------------------------------------------------------------------------- #>

function IsANumber($TEST)
{
         return $TEST -match "^[\d\.]+$";
         #$testvar -match '^[0-9]+$'
         #$testvar -match '^\d+$'
}

<# -------------------------------------------------------------------------------- #>

function MAIN
{
         [String] $CHOICE = "*";

         Write-Host("`n`n  `"Friends`" 1.0 (Address Book)`n");

         while($CHOICE[0] -NE "q")
         {
               Clear;

               Write-Host("`n`n     -----------Main Menu-------------");
               Write-Host("     |                               |");
               Write-Host("     |     (B)rowse Friend Index     |");
               Write-Host("     |     (D)isplay Friends         |");
               Write-Host("     |     (L)oad Friends            |");
               Write-Host("     |     (S)ave Friends            |");
               Write-Host("     |     (F)ind a Friend           |");
               Write-Host("     |     (A)dd a Friend            |");
               Write-Host("     |     (E)dit a Friend           |");
               Write-Host("     |     (R)emove a Friend         |");
               Write-Host("     |     (Q)uit                    |");
               Write-Host("     |                               |");
               Write-Host("     ---------------------------------");

               $CHOICE = (Read-Host("`n              CHOICE? ")).ToLower();

               switch($CHOICE[0])
               {
                   'b' { Browse_Friends; }
                   'd' { Display_Friends; }
                   'l' { Load_Friends; }
                   's' { Save_Friends; }
                   'f' { Find_A_Friend; }
                   'a' { Add_Friend; }
                   'e' { Edit_Friend; }
                   'r' { Remove_Friend; }
                   'q' { Write-Host("`n  Exiting `"Friends`" 1.0..."); break; }
                   default { Write-Host("`n  Invalid option."); }

               }#close switch

         }#close while true

}#close function

<# -------------------------------------------------------------------------------- #>

function Browse_Friends
{ 
         Clear;
         Write-Host("`n                    Index of FRIENDS:`n");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              [String] $Firsty = ($global:GroupOfFriends[$x].FirstName).PadRight(10);
              [String] $Lasty = ($global:GroupOfFriends[$x].LastName).PadRight(10);
              [String] $FriendNum = ($x+1);
              $FriendNum = $FriendNum.PadLeft(5);
              
              Write-Host("------------------------------------------------------------");
              Write-Host("     " + $FriendNum + ". First: " + $Firsty + "  Last: " + $Lasty + "");
            
         }

         Write-Host("------------------------------------------------------------`n`n");

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

function Display_Friends
{
         Clear;
         Write-Host("`n                  Display FRIENDS:`n");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              Write-Host("`n-------------------------------------------");
              Write-Host("  Friend: " + ($x+1));
              $global:GroupOfFriends[$x].Display_Friend();
         }  

         Write("`n");

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

function Add_Friend
{
         Clear;
         Write-Host("`n                 Add a FRIEND:`n");

         $AFriend = New-Object FRIEND;
         $AFriend.New_Friend();
         $global:GroupOfFriends += $AFriend;    

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

function Find_A_Friend
{
         Clear;
         Write-Host("`n                 Find a FRIEND:`n");

         $FoundAFriend = $false;

         $F_Name = Read-Host("Enter FIRST Name ");
         $L_Name = Read-Host("Enter LAST Name ");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              if($F_Name -LIKE $global:GroupOfFriends[$x].FirstName -AND 
                 $L_Name -LIKE $global:GroupOfFriends[$x].LastName)
              {
                  Write-Host("`n");
                  $global:GroupOfFriends[$x].Display_Friend();
                  $FoundAFriend = $true;
              }
         } 

         if($FoundAFriend -EQ $false)
         {
              Write-Host("`n  No Friends found matching " + 
                         "`n  First Name: " + $F_Name + 
                         "`n  Last Name: " + $L_Name);
         }

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

function Edit_Friend
{
         Clear;
         Write-Host("`n                 Edit a FRIEND:`n");

         [String] $CHOICE = "*";

         while($CHOICE[0] -NE "1" -AND $CHOICE[0] -NE "2" -AND $CHOICE[0] -NE "3")
         {
             Write-Host("`n`n            Selection Options" + 
                        "`n  -------------------------------------" +
                        "`n  |                                   |" + 
                        "`n  |    1. Select by Record Number     |" +
                        "`n  |    2. Select by Name              |" +
                        "`n  |    3. Exit                        |" +
                        "`n  |                                   |" +
                        "`n  -------------------------------------`n");

                        $CHOICE = Read-Host("           Your CHOICE? ");

                        switch($CHOICE[0])
                        {
                           1 { Edit_Friend_by_Record_Number; break; }
                           2 { Edit_Friend_By_Name; break; }
                           3 { break; }
                           default { Write-Host("`nInvalid option."); break; }

                        }#close switch

         }#close while true

         Write-Host("`n");

}#close function

<# -------------------------------------------------------------------------------- #>

#Note: Uses PadRight() and PadLeft() to align output into columns

function Edit_Friend_by_Record_Number
{ 
         Clear;
         Write-Host("`n             Choose a FRIEND to Edit by Number:`n");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              [String] $Firsty = ($global:GroupOfFriends[$x].FirstName).PadRight(10);
              [String] $Lasty = ($global:GroupOfFriends[$x].LastName).PadRight(10);
              [String] $FriendNum = ($x+1);
              $FriendNum = $FriendNum.PadLeft(5);
              
              Write-Host("------------------------------------------------------------");
              Write-Host("     " + $FriendNum + ". First: " + $Firsty + "  Last: " + $Lasty + "");
            
         }

         Write-Host("------------------------------------------------------------`n");

         $CHOICE = Read-Host("        Select by number from the list above");

         #Must convert to [int] for numerical comparisons
         if(IsANumber($CHOICE) -EQ $true)
         {
             Write-Host("`n That was a legitimate number.");

             $MenuChoice = [int]::Parse($CHOICE);

             #Make sure selection is in valid range.
             if($MenuChoice -GE 1 -AND $MenuChoice -LE $global:GroupOfFriends.Count)
             {
                Write-Host("`n");
                #Subtract 1 to prevent FENCEPOST error.
                $global:GroupOfFriends[($MenuChoice-1)].Display_Friend();
                $global:GroupOfFriends[($MenuChoice-1)].Edit_Friend();
             }
             else
             {
                 Write-Host("`n  Your selection is outside the valid range.");
             }   
         }
         else
         {
             Write-Host("`n That was NOT a number. INVALID CHOICE.");
         }

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

function Edit_Friend_By_Name
{
         Clear;
         Write-Host("`n             Choose a FRIEND to Edit by Name:`n");
         
         $FoundAFriend = $false;

         $F_Name = Read-Host("Enter FIRST Name ");
         $L_Name = Read-Host("Enter LAST Name ");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              if($F_Name -LIKE $global:GroupOfFriends[$x].FirstName -AND 
                 $L_Name -LIKE $global:GroupOfFriends[$x].LastName)
              {
                  Write-Host("`n");
                  $global:GroupOfFriends[$x].Display_Friend();
                  $global:GroupOfFriends[$x].Edit_Friend();
                  $FoundAFriend = $true;
              }
         } 

         if($FoundAFriend -EQ $false)
         {
              Write-Host("`n  No Friends found matching " + 
                         "`n  First Name: " + $F_Name + 
                         "`n  Last Name: " + $L_Name);
         }

         $null = Read-Host("ENTER to continue");
}

<# -------------------------------------------------------------------------------- #>

#Arrays are of FIXED size. In order to REMOVE an object?
#We have to temporarily move everything into an ARRAYLIST object.
function Remove_Friend
{
         Clear;
         Write-Host("`n               Choose a FRIEND to Remove:`n");

         #Example of 2 Diff ways to instantiate. New-Object eats up more resources. Casting more efficient.
         #$FriendArrayList = New-Object System.Collections.ArrayList($null);
         [System.Collections.ArrayList] $FriendArrayList = @();

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
              [String] $Firsty = ($global:GroupOfFriends[$x].FirstName).PadRight(10);
              [String] $Lasty = ($global:GroupOfFriends[$x].LastName).PadRight(10);
              [String] $FriendNum = ($x+1);
              $FriendNum = $FriendNum.PadLeft(5);
              
              Write-Host("------------------------------------------------------------");
              Write-Host("     " + $FriendNum + ". First: " + $Firsty + "  Last: " + $Lasty + "");

              #Add objects from Array to ARRAYLIST. Catch return value in $null so doesn't display.
              $null = $FriendArrayList.Add($global:GroupOfFriends[$x]);
            
         }

         Write-Host("------------------------------------------------------------`n");

         $CHOICE = Read-Host("        Select by number from the list above");

         #Must convert to [int] for numerical comparisons
         if(IsANumber($CHOICE) -EQ $true)
         {
             Write-Host("`n That was a legitimate number.");

             $MenuChoice = [int]::Parse($CHOICE);

             #Make sure selection is in valid range.
             if($MenuChoice -GE 1 -AND $MenuChoice -LE $global:GroupOfFriends.Count)
             {
                Write-Host("`n");
                #Subtract 1 to prevent FENCEPOST error.
                $global:GroupOfFriends[($MenuChoice-1)].Display_Friend();
                Write-Host("`n Removeing FRIEND # " + $CHOICE + ".`n");

                $FriendArrayList.RemoveAt(($MenuChoice-1));

                $global:GroupOfFriends = @();

                for($y = 0; $y -LT $FriendArrayList.Count; $y++)
                {
                    $global:GroupOfFriends += $FriendArrayList[$y];
                }
             }
             else
             {
                 Write-Host("`n  Your selection is outside the valid range.");
             }   
         }
         else
         {
             Write-Host("`n That was NOT a number. INVALID CHOICE.");
         }    
         
         $null = Read-Host("ENTER to continue");     
}

<# -------------------------------------------------------------------------------- #>

function Load_Friends
{
         Clear;
         Write-Host("`n               Load FRIENDs:`n");

         $DataDirectory = Split-Path -Parent $PSCommandPath;
         $FriendFile = "Friends.csv";
         $FriendInput = $DataDirectory + "\" + $FriendFile;

         Write-Host("`n  Loading FRIENDs ...");

         $MyFriends = Import-CSV $FriendInput; 

         Write-Host("`n  " + $MyFriends.Count + " FRIENDS loaded from file.`n" );

         #Re-Initalize array
         $global:GroupOfFriends = @();

         for($x = 0; $x -LT $MyFriends.Count; $x++)
         {       
             $AFriend = New-Object FRIEND;  
             $AFriend.FirstName = $MyFriends[$x].FirstName;
             $AFriend.LastName = $MyFriends[$x].LastName;
             $AFriend.EmailAddress = $MyFriends[$x].EmailAddress;
             $AFriend.MobilePhone = $MyFriends[$x].MobilePhone;
             $AFriend.StreetAddress = $MyFriends[$x].StreetAddress;
             $AFriend.City = $MyFriends[$x].City;
             $AFriend.State = $MyFriends[$x].State;
             $AFriend.Country = $MyFriends[$x].Country;
             $AFriend.BirthDay = $MyFriends[$x].BirthDay;
             $AFriend.FaveColor = $MyFriends[$x].FaveColor;
             $AFriend.FaveFood = $MyFriends[$x].FaveFood;

             $global:GroupOfFriends += $AFriend;
         }

         Write-Host("`n  Finshed Loading FRIENDs ...`n`n");
         
         $null = Read-Host("ENTER to continue");        
}

<# -------------------------------------------------------------------------------- #>

function Save_Friends
{
         Clear;
         Write-Host("`n               Save FRIENDs:`n");
         
         $DataDirectory = Split-Path -Parent $PSCommandPath;
         $FriendFile = "Friends.csv";
         $FriendOutput = $DataDirectory + "\" + $FriendFile;

         Write-Host("`n  Saving FRIENDs ...");

         for($x = 0; $x -LT $global:GroupOfFriends.Count; $x++)
         {
             Write-Host("`n-------------------------------------------");
             Write-Host("  Saving Friend: " + ($x+1));

             $OUTPUT = New-Object -TypeName PSObject;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name FirstName -Value $global:GroupOfFriends[$x].FirstName;

             $OUTPUT | Add-Member -MemberType Noteproperty -Name LastName -Value $global:GroupOfFriends[$x].LastName;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name EmailAddress -Value $global:GroupOfFriends[$x].EmailAddress;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name MobilePhone -Value $global:GroupOfFriends[$x].MobilePhone;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name StreetAddress -Value $global:GroupOfFriends[$x].StreetAddress;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name City -Value $global:GroupOfFriends[$x].City;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name State -Value $global:GroupOfFriends[$x].State;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name Country -Value $global:GroupOfFriends[$x].Country;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name BirthDay -Value $global:GroupOfFriends[$x].BirthDay;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name FaveColor -Value $global:GroupOfFriends[$x].FaveColor;
             $OUTPUT | Add-Member -MemberType Noteproperty -Name FaveFood -Value $global:GroupOfFriends[$x].FaveFood;

             $OUTPUT | Export-CSV $FriendOutput -Append -NoTypeInformation;   
         }  
         
         Write-Host("`n  Finshed Saving FRIENDs ..."); 

         $null = Read-Host("ENTER to continue");      
}


<# -------------------------------------------------------------------------------- #>

function TEST
{
         Load_Friends;
         #Find_Friend_by_Record_Number;
         #Find_Friend_By_Name;
         Remove_Friend;
}

#Function Invocations
MAIN;
#TEST;



