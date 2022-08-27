#Title: PowerShell - Module 01 - Data Types and Variables
#Author: Carly S. Germany
#Date: 04/23/2020

#Note: Variables are NOT case-sensitive in PowerShell. However, my background is in C++ and Java,
#which are case sensitive languages, I try to keep my POSH code case-sensitive too. Also, if you
#want to script in Linux? It's a case sensitive environment. So it's just good practice to 
#discipline yourself to code in a tightly case sensitive manner. 

#Note: PowerShell is not strongly data-typed like C++ or Java. In those languages, you need to
#declare the type and size of data when you create variables, and you can only store data of
#the correct type inside the correct type and size variable. This gives C++ and Java tight 
#control over memory management and provides indirect access to objects stored in memory
#on the free store or the heap. This makes C++ and Java powerful and efficient, but complicates
#their usage. PowerShell on the other hand makes declaring variables easy. It is NOT strongly
#data-typed and you can create a generic variable in PowerShell and store just about any data
#type inside it. This decreases efficiency, but increases ease of use.

<# ----------------------------------------------------------------------------------- #>

#1. Declaring a variable
$MyVariable;

<# ----------------------------------------------------------------------------------- #>

#2. Declaring and Initializing a variable
$MyVariable = $null;
$MyStringVariable = "";
$MyNumberVariable = 0;

<# ----------------------------------------------------------------------------------- #>

#3. Assigning a value to a variable
$MyVariable = "Fluttershy";
$MyStringVariable = "Friendship is Magic";
$MyNumberVariable = 5 + 5;

<# ----------------------------------------------------------------------------------- #>

#4. Variable Scope - Global vs. Local

#Global (Single instance accessible to all functions in a program)
$global:MyVariable = $null;
$global:MyVariable = "Twilight Sparkle";

#Local (Multiple instance inside each function, accessible only to that function)
$MyVariable = $null;
$MyVariable = "Rainbow Dash";

<# ----------------------------------------------------------------------------------- #>

#Global Namespace = "The Infinite Multiverse"
$global:Einstein_Rosen_Bridge_WormHole;

function Universe_01
{
         #Local NameSpace
         Einstein_Rosen_Bridge_WormHole = "Rarity"; #only accessible in Universe 1

         $global:Einstein_Rosen_Bridge_WormHole = "Twilight1"; #accessible in any universe
}

function Universe_02
{
         #Local NameSpace
         Einstein_Rosen_Bridge_WormHole = "Rarity"; #only accessible in Universe 2
         
         $global:Einstein_Rosen_Bridge_WormHole = "Twilight2"; #accessible in any universe
}

<# ----------------------------------------------------------------------------------- #>

#5. The ASSIGNMENT Operator

#Note: A common misconeption people frequently make in programming language is confusing the meaning "=".
#In math, the "=" means "equals. So if I write the expression "a = 7", I am saying "a equals 7". However,
#this is NOT that case in programming. The "=" does not mean "equals" in programming, but rather "assign".
#So if I write the expression "a = 7" in code? What I am saying is "assign the value of 7 to variable a",
#or "store the value of 7 inside container a". The assignment operator always says "take what is on the 
#left and store it in the object on the right". Changning the way you think about "=" will help you avoid
#many logic and syntax errors in the future.  

$a = 444;  #assigns value of 444 to variable a, takes 444 on left and stores it in a on the right

<# ----------------------------------------------------------------------------------- #>

#6. Explicitly typing/casting a PowerShell Variable

#Note: Powershell tries to simplify variable declaration and usage by not forcing strong data typing. 
#To achieve this? It treats most data as string data by default. String data is a collection of chars.
#Unfortunately, this can create unexpected outcomes and create errors in calculations. For example:

#A. This calculates correctly, PowerShell auto-chooses the correct data types
$ANumber = 222;
$MyNumber = $ANumber * 2;
Write("MyNumber is now: " + $MyNumber);  

#Above, eeverything calculates correctly and MyNumber displays as 444.

#B. This calculates incorrectly, PowerShell choses wrong data type since input is a string
$MyNumber = Read-Host("Please enter a number");
$MyNumber = $MyNumber * $MyNumber;
Write("MyNumber squared is: " + $MyNumber);

#If I enter "4"? I should get the square of 4. But because Powershell treats it as a string data type instead
#of an integer data type? It displays the incorrect value of "4444" instead of "16". Powershell is treating
#the data type as string, so it displays the char "4" 4 times. It's not treating it as integer data.

#C. We can help powershell as programmers by explicitly declaring the data type of the input variable. The syntax
#for this is very simliar to type-casting in C++ and Java, where you convert one data type to another. In 
#Powershell, to explicitly declare the data type of a variable use [] and insert the explicit data type in between.

[Int]$MyNumber = Read-Host("Please enter a number");
$MyNumber = $MyNumber * $MyNumber;
Write("MyNumber squared is: " + $MyNumber);
 
#Notice when I enter the exact same value "4" above? It now calcualtes the square correctly as "16".

#Another example:
[DateTime]$FooledMe = "April 1, 2020"; 
$CurrentDate = Get-Date; 
$Days = ($CurrentDate - $FooledMe).Days; 
Write-Host "Worst prank ever $Days day(s) ago.";

#Example above explicitly forces the string data "April 1, 2020" into a [DataTime] class oject in PowerShell.
#Now that it is the right data type? It can be used for calculations.

<#
    Here are some values you can EXPLICITLY convert/cast to in PowerShell:

    [Int] = 32-bit integers
    [Int32] = 32-bit integers
    [Float] = floating point, for large numbers or extra decimal precision
    [Single] = floating point, for large numbers or extra decimal precision
    [Bool] = boolean values, either $true or $false
    [String] = a string of text
    [Array]	= an array, a collection of variable objects
    [DateTime] = date and time object
    [TimeSpan]= a time interval
    [Guid] = GUID 32-byte identifier
    [HashTable]	= hash table with key-value pairs
    [ScriptBlock] = powerShell script block
    [PsObject] = a powerShell object
    [XmlDocument] = an XML document
    [Regex]	= a regular expression
#>

#Note: You can use the methods "GetType()" to get a variable's data type if you aren't sure. 	
$b = 444;
$b.GetType().Name

<# ----------------------------------------------------------------------------------- #>
#More Examples:

#----Example 1: Reading string data and storing it in variables--------

function Pony_Database
{
         $UserName = Read-Host("Please enter your NAME");
         $UserAge = Read-Host("Please enter your AGE");
         $UserSpecies = Read-Host("Please enter your SPECIES");
         $UserGender = Read-Host("Please enter your GENDER");

         Write("`nStats:`n");
         Write("Name: " + $UserName);
         Write("Age: " + $UserAge);
         Write("Species: " + $UserSpecies);
         Write("Gender: " + $UserGender);
}


#----------------------------------------------------------------------


#----Example 2: Reading string data and storing it in variables--------

function Guess_My_Number
{
         $MyNumber = 444;

         $BestGuess = Read-Host("What is MyNumber?");

         if($BestGuess -EQ $MyNumber)
         { Write("What luck! You guessed my number!"); }
         else
         { Write("Sorry. That was NOT my number."); }

}

#----------------------------------------------------------------------