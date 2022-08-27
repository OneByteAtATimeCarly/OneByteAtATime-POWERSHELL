#Title: PowerShell - Module 05 - Functions 8 - Returning Values
#Author: Carly S. Germany
#Date: 06/07/2020

<# ------------------------------------------------------------------- #>

function Calculate_1
{
         $A = 100;
         $B = 7;
         $C = $A * $B;

         return $C
}

<# ------------------------------------------------------------------- #>

function TEST_1
{
         $MESSAGE = "Hello, Celestia.";
         
         $MESSAGE = $MESSAGE + " I'm having a really nice time."

         return $MESSAGE;
}

<# ------------------------------------------------------------------- #>


#The return statement in PowerShell doesn't work like the return statement in C++ or Java.
#Any string output within the function is assigned to the return value, along with any values/calculations.
#To get text to display within a functin with a return value, you can use the Write-Information function:

#Write-Information "Please wait. Working on calculation..." -InformationAction Continue
#EXAMPLE: Write-Information "Wait for it ..." -InformationAction Continue;
#You can also use Write-Host() in place of Write()

<# ------------------------------------------------------------------- #>

function Get_Pony_Age_1
{
         Write("INSIDE Get_Pony_Age_1 function.");

         $Age = 14;
         Write("How old is my pony?");

         return $Age;
}

<# ------------------------------------------------------------------- #>

function Get_Pony_Age_2
{
         Write-Host("INSIDE Get_Pony_Age_2 function.");

         $Age = 14;
         Write-Host("How old is my pony?");

         return $Age;
}

<# ------------------------------------------------------------------- #>

function Get_Pony_Age_3
{
         Write-Information("INSIDE Get_Pony_Age_3 function.") -InformationAction Continue;

         $Age = 14;
         Write-Information("How old is my pony?") -InformationAction Continue;

         return $Age;
}

<# ------------------------------------------------------------------- #>


#------- INVOCATIONS -------
Clear;
Write("`n");

#1
Write("`nExample 1");
$RESULT = Calculate_1;
Write($RESULT);
Write("`n");

#2
Write("`nExample 2");
$RESULT = TEST_1;
Write($RESULT);
Write("`n");

#3
Write("`nExample 3");
$RESULT = Get_Pony_Age_1;
Write("Outside now.");
Write("`n");

#4
Write("`nExample 4");
$RESULT = Get_Pony_Age_1;
Write("Outside now.");
Write($RESULT);
Write("`n");

#5
Write("`nExample 5");
$RESULT = Get_Pony_Age_2;
Write("Outside now.");
Write($RESULT);
Write("`n");

#6
Write("`nExample 6");
$RESULT = Get_Pony_Age_3;
Write("Outside now.");
Write($RESULT);
Write("`n");