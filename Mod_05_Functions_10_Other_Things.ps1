#Title: PowerShell - Module 05 - Functions 10 - Other Things
#Author: Carly S. Germany
#Date: 06/07/2020

<# ------------------------------------------------------------------- #>

#1. Default Arguments

function Grand_Gala($Name = "Celestia", $Age = 100)
{
         Write("`nWelcome to the Grand Gala!");
         Write("Name: " + $Name );
         Write("Age: " + $Age );
}

<# ------------------------------------------------------------------- #>

#2. Positional parameters. Parameter passed in without a name using built-in args array.

function Positional_Parameters
{
         Write("`nInside Positional_Parameters function.");

         Write("`nA total of " + $($args.count) + " arguments were passed to this function.`n");

         for($x = 0; $x -LT $args.count; $x++ ) 
         {
             Write("Array ELEMENT " + $x + " is " + $($args[$x]) + "");
         }

         Write("`nName: " + $args[0]);
         Write("Species: " + $args[1]);
         Write("Age: " + $args[2]);
}

<# ------------------------------------------------------------------- #>

#3. Switch Parameters. Use simple switch statements as parameters.

function Galactica_FTL_Drive_State 
{
         param([switch]$FTL_Drive_Activated);

         Write("Reading Galactica's FTL drive state.");

         if($FTL_Drive_Activated) 
         { "Galactica Jumps!" }
         else 
         { "Galactica remains stationary." }
}

<# ------------------------------------------------------------------- #>

#4. Filters. Type of function that runs on each object in pipeline.

filter Get-ErrorLog ([switch]$message)
{
       if ($MESSAGE) { Out-Host -InputObject $_.MESSAGE }
       else { $_ }

       #MORE ON THESE LATER.
}

<# ------------------------------------------------------------------- #>



#------ Invocations ------------------------
Clear;

#EXAMPLE 1
Write("`nEXAMPLE 1: Calling function with no arguments so triggers defaults.");
Grand_Gala;

#EXAMPLE 2
Write("`nEXAMPLE 2: Calling function WITH arguments. Will NOT trigger defaults.");
Grand_Gala -Name "Twilight Sparkle" -Age 50;


#EXAMPLE 3
Write("`nEXAMPLE 3: Calling function with positional parameters.");
Positional_Parameters Celestia Alicorn 100;


#EXAMPLE 4
Write("`nEXAMPLE 4: Calling function with switch parameter.`n");
Galactica_FTL_Drive_State -FTL_Drive_Activated;
Write("`n");
Galactica_FTL_Drive_State;




Write("`n");

