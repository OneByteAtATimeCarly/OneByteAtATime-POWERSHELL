#Title: PowerShell - Module 06 - Arrays - Paralell Arrays - MAD LIB 1.0
#Author: Carly S. Germany
#Date: 06/14/2020

#Globals
$global:The_Story;

<# ---------------------------------------------------------------------------------------------- #>

function MAIN
{
         Clear;
         Write("`n`nMADLIB 1.0 - Using Paralell Arrays`n`n");
         $null = Read-Host("Press ENTER to continue.");

         $choice = "";

         while($choice[0] -NE 'q')
         {
             Clear;

             Write("`nChoose an example to run:`n`n" +
                   "-----------------------`n" +
                   "|                     |`n" +
                   "|   (C)reate Story    |`n" +
                   "|   (R)ead Story      |`n" +
                   "|   (S)ave Story      |`n" +
                   "|   (L)oad Story      |`n" +
                   "|   (Q)uit            |`n" +
                   "|                     |`n" + 
                   "-----------------------" );

             $choice = (Read-Host("`nCHOICE?")).ToLower();

             switch($choice[0])
             {
                 'c' { Create_Story; }
                 'r' { Read_Story; }
                 's' { Save_Story; }
                 'l' { Load_Story; }
                 'q' { break; }
                 default { $null = Read-Host("`nInvalid choice. Press ENTER to continue."); }
             }           
         }         

        Write("`nExiting Array QUIZ 1.0 ...");
}

<# ---------------------------------------------------------------------------------------------- #>

#Example of PARALLEL ARRAYS
function Create_Story
{
         $MESSAGE = "";

         $PlayerSays = @("***","***","***","***","***","***","***");

         $Criteria = @("Female person's name",
		    	       "An object",
			           "An infinitive verb",
    				   "An object or animal",
	    			   "An object",
		    		   "An object",
			    	   "Male person's name");

         $ComputerSays = @("One day, ", 
                           " was tip-toing through the tulips`nwhen she saw a ",
                           ".  This was because the folks`nat Microsoft were ",
                           " into the sky again and`nagain. Her ",
                           " jumped off of a cliff because`nthe ",
                           " could not pat its head and rub its`ntummy at the same time. The ",
                           " ran off`nholding hands with ");

         Clear;
         Write("`nLet's create the story.`n");
     
         #Get player's thoughts 
         for($x = 0; $x -LT $Criteria.Count; $x++)
         {
              $PlayerSays[$x] = Read-Host($Criteria[$x]);
         }

         #Concatenate everything together into a story String
         for($x = 0; $x -LT $ComputerSays.Count; $x++)
         {
             $MESSAGE = $MESSAGE + $ComputerSays[$x] + $PlayerSays[$x];        
         }

         $MESSAGE = $MESSAGE + ".`n`n`n            The End";

         #Store result in global to be accessed by other functions
         $global:The_Story = $MESSAGE;

         $null = Read-Host -Prompt "`nPress ENTER to continue.";
}

<# ---------------------------------------------------------------------------------------------- #>

function Read_Story
{
         Clear;
         Write("`n`nThe story so far:`n`n");
         Write($global:The_Story);
         $null = Read-Host("`n`nPress ENTER to continue.");
}

<# ---------------------------------------------------------------------------------------------- #>

function Save_Story
{
         Clear;
         Write("`nSAVE story to file.`n`n");

         $CurrentDIRLocation = Split-Path $script:MyInvocation.MyCommand.Path;
         $TextFileName = "\My_Story.txt";
         $TextOutput = $CurrentDIRLocation + $TextFileName;

         Write-Host("Saving story to: " + $TextOutput);
         $global:The_Story | Out-File $TextOutput;

         $null = Read-Host("`n`nPress ENTER to continue.");
}

<# ---------------------------------------------------------------------------------------------- #>

function Load_Story
{
         Clear;
         Write("`nREAD story from file.`n`n");

         $CurrentDIRLocation = Split-Path $script:MyInvocation.MyCommand.Path;
         $TextFileName = "\My_Story.txt";
         $TextInput = $CurrentDIRLocation + $TextFileName;

         Write-Host("Loading story from: " + $TextInput);
         #$global:The_Story | Out-File $TextOutput;

         $global:The_Story = Get-Content $TextInput;

         $null = Read-Host("`n`nPress ENTER to continue.");
}

<# ---------------------------------------------------------------------------------------------- #>


#------- Invocations -------
MAIN;

