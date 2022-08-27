#Title: PowerShell - Module 08 - File Access 1
#Author: Carly S. Germany
#Date: 06/25/2020

<# ------------------------------------------------------------------- #>

function Write_To_CSV_1
{
         #Using Add-Content using an array of Strings

         $DataFile = "C:\DATA\MLP_Main_Characters_1_Strings.csv";

         $Ponies = @("Twilight Sparkle",
                     "Fluttershy",
                     "Rainbow Dash",
                     "Rarity",
                     "AppleJack",
                     "Pinkie Pie");

         #Write field/column name to file
         Add-Content -Path  $DataFile -Value Name;

         Write-Host("`nNumber of ponies to write to file = " + $Ponies.Count);

         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("Writing pony " + ($x+1) + " = " + $Ponies[$x]);
             Add-Content -Path  $DataFile -Value $Ponies[$x];
         }
}

<# ------------------------------------------------------------------- #>

function Write_To_CSV_2
{
         #Using Add-Content using a 2-dimensional array

         $DataFile = "C:\DATA\MLP_Main_Characters_2_2D_Array.csv";

         $Ponies = @('"Twilight Sparkle","Alicorn Magic","9000"',
                     '"Fluttershy","Animal Friendship","4500"',
                     '"Rainbow Dash","Sonic Rainboom","6500"',
                     '"Rarity","Unicorn magic","3000"',
                     '"AppleJack","Cowgirl Skillz","1500"',
                     '"Pinkie Pie","Party Tricks","1500"');

         Write-Host("`nNumber of ponies to write to file = " + $Ponies.Count);

         #Write Field/column names to the file
         Add-Content -Path  $DataFile -Value '"Pony Name","Ability","Magic Strength"';

         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("Writing pony " + ($x+1) + " = " + $Ponies[$x]);
             Add-Content -Path  $DataFile -Value $Ponies[$x];
         }
}

<# ------------------------------------------------------------------- #>

function Write_To_CSV_3
{
         #Using Export-CSV using an array of pscustomobjects

         $DataFile1 = "C:\DATA\MLP_Main_Characters_3_All_At_Once.csv";
         $DataFile2 = "C:\DATA\MLP_Main_Characters_3_1_at_A_Time.csv";

         $Ponies = @( [pscustomobject]@{ PonyName = 'Twilight Sparkle';
                                         Ability='Alicorn Magic';
                                         MagicStrength='9000'},  
                      [pscustomobject]@{ PonyName = 'Fluttershy';
                                         Ability='Animal Friendship';
                                         MagicStrength='4500'}, 
                      [pscustomobject]@{ PonyName = 'Rainbow Dash';
                                         Ability='Sonic Rainboom';
                                         MagicStrength='6500'},
                      [pscustomobject]@{ PonyName = 'Rarity';
                                         Ability='Unicorn magic';
                                         MagicStrength='3000'},
                      [pscustomobject]@{ PonyName = 'AppleJack';
                                         Ability='Cowgirl Skillz';
                                         MagicStrength='1500'},
                      [pscustomobject]@{ PonyName = 'Pinkie Pie';
                                         Ability='Party Tricks';
                                         MagicStrength='1500'} );

         Write-Host("`nNumber of pony objects to write to file = " + $Ponies.Count);

         #1. Write entire array at once
         Write-Host("`n1. Writing entire pony array to file all at once ...");
         $Ponies | Export-CSV $DataFile1 -Append -NoTypeInformation;

         #2. Write each element in array 1 line at a time
         Write-Host("`n2. Writing each pony array to file one element at a time ...`n");
         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("Writing pony " + ($x+1) + " = " + $Ponies[$x]);
             $Ponies[$x] | Export-CSV $DataFile2 -Append -NoTypeInformation;
         }
}

<# ------------------------------------------------------------------- #>

function Write_To_CSV_4
{
         #Using Export-CSV and instances of PSObject class

         $DataFile = "C:\DATA\MLP_Main_Characters_4_PSObjects.csv";
         $Ponies = @();

         $Pony1 = New-Object -TypeName PSObject;
         $Pony1 | Add-Member -MemberType Noteproperty -Name Name -Value "Twilight Sparkle";
         $Pony1 | Add-Member -MemberType Noteproperty -Name Ability -Value "Alicorn Magic";
         $Pony1 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 9000;
         $Ponies += $Pony1;

         $Pony2 = New-Object -TypeName PSObject;
         $Pony2 | Add-Member -MemberType Noteproperty -Name Name -Value "Fluttershy";
         $Pony2 | Add-Member -MemberType Noteproperty -Name Ability -Value "Animal Friendship";
         $Pony2 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 4500;
         $Ponies += $Pony2;

         $Pony3 = New-Object -TypeName PSObject;
         $Pony3 | Add-Member -MemberType Noteproperty -Name Name -Value "Rainbow Dash";
         $Pony3 | Add-Member -MemberType Noteproperty -Name Ability -Value "Sonic Rainboom";
         $Pony3 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 6500;
         $Ponies += $Pony3;

         $Pony4 = New-Object -TypeName PSObject;
         $Pony4 | Add-Member -MemberType Noteproperty -Name Name -Value "Rarity";
         $Pony4 | Add-Member -MemberType Noteproperty -Name Ability -Value "Unicorn magic";
         $Pony4 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 3000;
         $Ponies += $Pony4;

         $Pony5 = New-Object -TypeName PSObject;
         $Pony5 | Add-Member -MemberType Noteproperty -Name Name -Value "AppleJack";
         $Pony5 | Add-Member -MemberType Noteproperty -Name Ability -Value "Cowgirl Skillz";
         $Pony5 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 1500;
         $Ponies += $Pony5;

         $Pony6 = New-Object -TypeName PSObject;
         $Pony6 | Add-Member -MemberType Noteproperty -Name Name -Value "Pinkie Pie";
         $Pony6 | Add-Member -MemberType Noteproperty -Name Ability -Value "Party Tricks";
         $Pony6 | Add-Member -MemberType Noteproperty -Name MagicStrength -Value 1500;
         $Ponies += $Pony6;

         Write-Host("`nNumber of pony objects to write to file = " + $Ponies.Count + "`n");

         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("Writing pony " + ($x+1) + " = " + $Ponies[$x].Name);
             $Ponies[$x] | Export-CSV $DataFile -Append -NoTypeInformation;
         }
}

<# ------------------------------------------------------------------- #>

function Write_To_CSV_5
{
         #Using "Export-CSV", writing jagged/uneven # field elements to a column

         $DataFile = "C:\DATA\Jedis_And_Sith_Lords.csv";

         $Jedi_Abilities = @("Telekinesis",
                             "Telepathy",
                             "Clairvoyance",
                             "ClairAudience",
                             "Premonitions",
                             "Regeneration",
                             "Healing",
                             "Animal FriendShip",
                             "Mind Tricks",
                             "Spirit Talking",
                             "Spirit Walking");

         $Sith_Lord_Abiliites = @("Telekinesis",
                                  "Telepathy",
                                  "Clairvoyance",
                                  "ClairAudience",
                                  "Premonitions",
                                  "Force Lightning",
                                  "Resurrection");

         Write-Host("`nNumber of Jedi Abilities = " + $Jedi_Abilities.Count);
         Write-Host("Number of Sith Lord Abilities = " + $Sith_Lord_Abiliites.Count);
         Write-Host("`nNotice that the arrays above are of different sizes?");

         #Save ForceUser1 = Jedi
         $ForceUser1 = New-Object -TypeName PSObject;
         $ForceUser1 | Add-Member -MemberType Noteproperty -Name Name -Value "Jedi";
         $ForceUser1 | Add-Member -MemberType Noteproperty -Name Age -Value "25";
         $ForceUser1 | Add-Member -MemberType Noteproperty -Name ForceStrength -Value 4500;
         
         $Accumulator = "";

         for($x = 0; $x -LT $Jedi_Abilities.Count; $x++)
         {
             $Accumulator += $Jedi_Abilities[$x] + ",";
         }

         $ForceUser1 | Add-Member -MemberType Noteproperty -Name Abilities -Value $Accumulator;

         Write-Host("`nWriting ForceUser1 to file (Jedi) ...");
         $ForceUser1 | Export-CSV $DataFile -Append -NoTypeInformation;

         #Save ForceUser2 = Sith Lord
         $ForceUser2 = New-Object -TypeName PSObject;
         $ForceUser2 | Add-Member -MemberType Noteproperty -Name Name -Value "Sith Lord";
         $ForceUser2 | Add-Member -MemberType Noteproperty -Name Age -Value "75";
         $ForceUser2 | Add-Member -MemberType Noteproperty -Name ForceStrength -Value 9000;
         
         $Accumulator = "";

         for($x = 0; $x -LT $Sith_Lord_Abiliites.Count; $x++)
         {
             $Accumulator += $Sith_Lord_Abiliites[$x] + ",";
         }

         $ForceUser2 | Add-Member -MemberType Noteproperty -Name Abilities -Value $Accumulator;

         Write-Host("`nWriting ForceUser2 to file (Sith Lord) ...");
         $ForceUser2 | Export-CSV $DataFile -Append -NoTypeInformation;
}

<# ------------------------------------------------------------------- #>

function Read_From_CSV_1
{
         #Reading entire row/element vs. specific attribute and value from CSV

         $DataFile = "C:\DATA\MLP_Main_Characters_1_Strings.csv";

         $Ponies = Import-CSV $DataFile;
         $PonyCounter = 0;

         Write-Host("`nPonies loaded from file = " + $Ponies.Count);

         Write-Host("`n1. Display entire array elements from row ...`n");

         ForEach($Pony in $Ponies)
         {
             $PonyCounter++; 
             Write-Host("Pony element" + $PonyCounter + " = " + $Pony);
         }

         Write-Host("`n2. Display value of Name only from row ...`n");
         $PonyCounter = 0;

         ForEach($Pony in $Ponies)
         {
             $PonyCounter++; 
             Write-Host("Pony element" + $PonyCounter + " = " + $Pony.Name);
         }
}

<# ------------------------------------------------------------------- #>

function Read_From_CSV_2
{
         #Shorthand method of reading from CSV using $_.

         $DataFile = "C:\DATA\MLP_Main_Characters_1_Strings.csv";

         Import-CSV $DataFile | ForEach { Write-Host("Name = " + $_.Name) }
}

<# ------------------------------------------------------------------- #>

function Read_From_CSV_3
{
         #Reading entire object from CSV and displaying individual attributes

         $DataFile = "C:\DATA\MLP_Main_Characters_4_PSObjects.csv";
         $Ponies = Import-CSV $DataFile;

         Write-Host("`nPony objects loaded from file = " + $Ponies.Count);

         Write-Host("`n1. Display entire object in element/row ...`n");

         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("Pony " + ($x+1) + " = " + $Ponies[$x]);
         }

         Write("`n2. Display each object's separate attributes ...`n");

         for($x = 0; $x -LT $Ponies.Count; $x++)
         {
             Write-Host("`n----------------------------------------");
             Write-Host("Pony # " + ($x+1));
             Write-Host("Name: " + $Ponies[$x].Name);
             Write-Host("Ability: " + $Ponies[$x].Ability);
             Write-Host("MagicStrength: " + $Ponies[$x].MagicStrength);
         }
}

<# ------------------------------------------------------------------- #>

function Write_To_Text_File_1
{
         #Using "Out-File" to write to a plain text file

         $LogFile = "C:\DATA\Galactica_LOG_1.txt";

         $MESSAGE = "Galactica actual to Pegasus.`r`n" + 
                    "Verify colonial authentication codes.`r`n" +
                    "Spin up FTL drives and prepare to JUMP.`r`n" +
                    "A Cylon base star has been detected`r`n" +
                    "just outside our defense perimeter.`r`n";

         Write-Host("`nThe MESSAGE is:`n`n" + $MESSAGE);

         Write-Host("`nWriting message to log file ...");
         $MESSAGE | Out-File $LogFile;
}

<# ------------------------------------------------------------------- #>

function Write_To_Text_File_2
{
         #Using "Set-Content" to write to a plain text file

         $LogFile = "C:\DATA\I_Robot_Behavior_Directives_1.txt";

         $MESSAGE = "`r`n`"Three Laws Safe`" Prime Directives:`r`n`r`n" +
                    "1. Robot may not by action harm a human.`r`n" + 
                    "2. Robot may not by omission of action harm a human.`r`n" +
                    "3. Robot must protect itself if it does not conflict with first 2 laws.";

         Write-Host("`nThe MESSAGE is:`n`n" + $MESSAGE);

         Write-Host("`nWriting message to log file ...");
         $MESSAGE | Set-Content $LogFile;
}

<# ------------------------------------------------------------------- #>

function Read_From_Text_File_1
{
         #Using "Get-Content" to read from a plain text file

         $LogFile = "C:\DATA\Galactica_LOG_1.txt";

         Write-Host("`nWriting message to log file ...`n");
         $MESSAGE = Get-Content $LogFile;

         Write-Host("`nThe MESSAGE is:`n`n" + $MESSAGE);
}

<# ------------------------------------------------------------------- #>

function Read_From_Text_File_2
{
         #Using "StreamReader" to read from a plain text file

         $LogFile = "C:\DATA\Galactica_LOG_1.txt";

         $TheStreamReader = New-Object System.IO.StreamReader($LogFile);
         #$TheStreamReader.ReadLine();
         
         $LineNumber = 0;

         Write("`nReading one line at a time:`n");

         while(($CurrentLine = $TheStreamReader.ReadLine()) -ne $null)
         {
             $LineNumber++;
             Write-Host("Line " + $LineNumber + " = " + $CurrentLine);
         }

         $TheStreamReader.Dispose();
}

<# ------------------------------------------------------------------- #>
function Read_From_Text_File_3
{
         #Using "StreamReader" to read specific line # from a plain text file

         $LogFile = "C:\DATA\Galactica_LOG_1.txt";

         $TheStreamReader = New-Object System.IO.StreamReader($LogFile);
         #$TheStreamReader.ReadLine();
         
         $LineNumber = 0;

         Write("`nLooking for a specific line:`n");

         $TargetLine = 3;

         while(($CurrentLine = $TheStreamReader.ReadLine()) -ne $null)
         {
             $LineNumber++;

             if($LineNumber -EQ $TargetLine) 
             {
                Write-Host("Line " + $LineNumber + " = " + $CurrentLine);
             }
             
         }

         $TheStreamReader.Dispose();
}

<# ------------------------------------------------------------------- #>

#------- Invocations -------

#-CSV-------------------
#Write_To_CSV_1;
#Write_To_CSV_2;
#Write_To_CSV_3;
#Write_To_CSV_4;
#Write_To_CSV_5;
#Read_From_CSV_1;
#Read_From_CSV_2;
#Read_From_CSV_3;

#-TEXT------------------
#Write_To_Text_File_1;
#Write_To_Text_File_2;
#Read_From_Text_File_1;
#Read_From_Text_File_2;
#Read_From_Text_File_3;



