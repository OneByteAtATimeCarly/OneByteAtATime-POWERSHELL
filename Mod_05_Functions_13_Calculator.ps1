#Title: PowerShell - Module 05 - Functions 10 - Other Things
#Author: Carly S. Germany
#Date: 06/07/2020

<# --------------------------------------------------------------------------------------------- #>

function Main_Menu
{
         $Menu = "LOOP";

         Clear;
         Write("`nCalculator 1.0`n");

         while($Menu -EQ "LOOP")
         {
              Clear;
              Write("`n                Main Menu");
              Write("-----------------------------------------");
              Write("|                                       |");
              Write("|     (B)asic Caclculations             |");
              Write("|     (S)quare a Number                 |");
              Write("|     (C)ube a Number                   |");
              Write("|     (F)arenheit Ceclius Conversion    |");
              Write("|     (M)iles Kilometers Conversion     |");
              Write("|     (Q)uit                            |");
              Write("|                                       |");
              Write("-----------------------------------------`n");

              $CHOICE = (Read-Host("CHOICE?")).ToLower();

              switch($CHOICE[0])
              {
                 'b' { Basic_Calculations; }
                 's' { Square_Number; }
                 'c' { Cube_Number; }
                 'f' { Farenheit_Celcius_Conversion; }
                 'm' { Miles_Kilometers_Conversion; }
                 'q' { Write("`n Exiting Calculator ..."); $Menu = "EXIT"; }
                 default 
                 {  
                     Write("`nInvalid CHOICE. Choose again.");
                     Read-Host("Press ENTER to continue."); 
                     Clear;
                 }
              }
         }         
}

<# --------------------------------------------------------------------------------------------- #>

function Basic_Calculations
{
         [double] $FirstNum = 0;
         [double] $SecondNum = 0;
         [double] $Answer = 0;
         $OpSign = "NULL";
         $CHOICE = "NULL";

         Clear;

         while($CHOICE[0] -NE 'q')
         {
              Clear;
              Write("`nBasic Calculations");
              Write("----------------------");
              Write("|                    |");
              Write("|     (A)dd          |");
              Write("|     (S)ubtract     |");
              Write("|     (M)ultiply     |");
              Write("|     (D)ivide       |");
              Write("|     (Q)uit         |");
              Write("|                    |");
              Write("----------------------`n");

              $CHOICE = (Read-Host("CHOICE?")).ToLower();

              if($CHOICE[0] -NE 'q')
              {
                  [double] $FirstNum = Read-Host("`n1st Number?"); 
                  [double] $SecondNum = Read-Host("2nd Number?");

                  switch($CHOICE[0])
                  {
                     'a' { $Answer = $FirstNum + $SecondNum; $OpSign = "+"; break; }
                     's' { $Answer = $FirstNum - $SecondNum; $OpSign = "-"; break; }
                     'm' { $Answer = $FirstNum * $SecondNum; $OpSign = "*"; break; }
                     'd' { $Answer = $FirstNum / $SecondNum; $OpSign = "/"; break; }
                     'q' { Write("`n Exiting Calculations ..."); break; }
                     default 
                     {  
                         Write("`nInvalid CHOICE. Choose again.");
                         Read-Host("Press ENTER to continue."); 
                         Clear;
                     }
                  }

                  Write("`nRESULT: " + $FirstNum + " " + $OpSign + " " + $SecondNum + " = " + $Answer);
                  Read-Host("`nPress ENTER to continue.");
              }
         }        
}

<# --------------------------------------------------------------------------------------------- #>

function Square_Number
{
         [double] $Num = 0;
         [double] $Answer = 0;

         Clear;
         Write("`nSquare Number");
         
         [double] $Num = Read-Host("`nEnter Number?");
         $Answer = $Num * $Num;
          
         Write("`nRESULT: " + $Num + " * " + $Num + " = " + $Answer);
         Read-Host("`nPress ENTER to continue.");
}

<# --------------------------------------------------------------------------------------------- #>

function Cube_Number
{
         [double] $Num = 0;
         [double] $Answer = 0;

         Clear;
         Write("`nCube Number");
         
         [double] $Num = Read-Host("`nEnter Number?");
         $Answer = $Num * $Num * $Num;
          
         Write("`nRESULT: " + $Num + " * " + $Num + " * " + $Num + " = " + $Answer);
         Read-Host("`nPress ENTER to continue.");
}

<# --------------------------------------------------------------------------------------------- #>

function Farenheit_Celcius_Conversion
{
         [double] $Temperature = 0;
         [double] $TempFarenheit = 0;
         [double] $TempCelcius = 0;
         $CHOICE = "NULL";

         Clear;

         while($CHOICE[0] -NE 'q')
         {
              Clear;
              Write("`nFarenheit Celcius Conversion");
              Write("------------------------------");
              Write("|                            |");
              Write("|   (F)arenheit to Celcius   |");
              Write("|   (C)elcius to Farenheit   |");
              Write("|   (Q)uit                   |");
              Write("|                            |");
              Write("------------------------------`n");

              $CHOICE = (Read-Host("CHOICE?")).ToLower();

              if($CHOICE[0] -NE 'q')
              {
                  [double] $Temperature = Read-Host("`nTemperature?"); 

                  switch($CHOICE[0])
                  {
                     'f' { $TempCelcius = ($Temperature - 32) * 5/9;   break; }
                     'c' { $TempFarenheit = ($Temperature * 9/5) + 32;  break; }
                     'q' { Write("`n Exiting Conversion ..."); break; }
                     default 
                     {  
                         Write("`nInvalid CHOICE. Choose again.");
                         Read-Host("Press ENTER to continue."); 
                         Clear;
                     }
                  }

                  Write("`n");
                  
                  if($CHOICE[0] -EQ 'f')
                  { 
                       Write($Temperature.ToString() + " degrees Farenheit = " +
                       $TempCelcius.ToString() + " degrees Celcius."); 
                  } 
                  else
                  { 
                       Write($Temperature.ToString() + " degrees Celcius = " + 
                       $TempFarenheit.ToString() + " degrees Farenheit."); 
                  } 
                  
                  Read-Host("`nPress ENTER to continue.");
              }
         }        
}

<# --------------------------------------------------------------------------------------------- #>

function Miles_Kilometers_Conversion
{
         [double] $Kilometers = 0;
         [double] $Miles = 0;
         [double] $Distance = 0;
         $CHOICE = "NULL";

         Clear;

         while($CHOICE[0] -NE 'q')
         {
              Clear;
              Write("`n Kilometers Miles Conversion");
              Write("------------------------------");
              Write("|                            |");
              Write("|   (M)iles to Kilometers    |");
              Write("|   (K)ilometers to Miles    |");
              Write("|   (Q)uit                   |");
              Write("|                            |");
              Write("------------------------------`n");

              $CHOICE = (Read-Host("CHOICE?")).ToLower();

              if($CHOICE[0] -NE 'q')
              {
                  [double] $Distance = Read-Host("`nDistance?"); 

                  switch($CHOICE[0])
                  {
                     'm' { $Kilometers = ($Distance * 1.609);  break; }
                     'k' { $Miles =  ($Distance / 1.609);  break; }
                     'q' { Write("`n Exiting Conversion ..."); break; }
                     default 
                     {  
                         Write("`nInvalid CHOICE. Choose again.");
                         Read-Host("Press ENTER to continue."); 
                         Clear;
                     }
                  }

                  Write("`n");
                  
                  if($CHOICE[0] -EQ 'm')
                  { 
                       Write($Distance.ToString() + " miles = " +
                       $Kilometers.ToString() + " kilometers."); 
                  } 
                  else
                  { 
                       Write($Distance.ToString() + " kilometers = " + 
                       $Miles.ToString() + " miles."); 
                  } 
                  
                  Read-Host("`nPress ENTER to continue.");
              }
         }  
}

<# --------------------------------------------------------------------------------------------- #>


#------- Invocations -------
Main_Menu;