#Title: PowerShell - Module 09 - RPG Game
#Author: Carly S. Germany
#Date: 08/03/2020 

#GitHub Source Note: 08/27/2022 This POSH RPG game project is still in progress. Totally HALF-BAKED!
# I plan to come back and finish it soon. As soon as I finish the Python section I just started for this YT Channel :-)
# You can run it and navigate through the 1st ring of cardinal N,S,E,W. But if you try to go beyond it, the game will
# CRASH as nothing has been coded to exist yet beyond that 1st ring of reality. Ended up doigng this project in Python
# and going WAY farther with it. And it's a lot of fun. And I plan to come back here and finish coding this POSH version.
# But I will upload the source at least as an example of navigation code until I get a chance to come back after Python
# and finnish some POSH things. Thanks for your patience. - C.S.G.

#Globals
[Int] $Global:QUIT = 0;
[Int] $INTRO = 1;
[Int] $C1 = 2;
[Int] $N1 = 3;
[Int] $S1 = 4;
[Int] $E1 = 5;
[Int] $W1 = 6;
[Int] $N2 = 7;

[String] $Global:CHOICE = "";
[Int] $Global:LOCATION = $INTRO;

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function Go_Action
{
         $Global:CHOICE = $TB_Main_Input.Text;
         if($Global:CHOICE -EQ "") { $Global:CHOICE = "#"; }

         SwitchBoard;

         $TB_Main_Input.Text = "";
         $Global:CHOICE = "#";
         #$TB_Main_Input.SelectedText = 0;
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function Navigate_Action
{
         SwitchBoard;
         $TB_Main_Input.Text = "";
         $Global:CHOICE = "#";
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function SwitchBoard
{
         switch($Global:LOCATION)
         {
             $INTRO { Introduction; }
             $C1 { CENTER1; }
             $N1 { NORTH1; }
             $S1 { SOUTH1; }
             $E1 { EAST1; }
             $W1 { WEST1; }
             $N2 { NORTH2; }
             default { $TB_Main_Input.Text = "`r`nERROR! Inavlid value for location."; }
        }    
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function Introduction
{
         [String] $MESSAGE = "`r`n                                           " + 
                             "A Knight in the Darkness 3.0`r`n";

         $MESSAGE += "`r`n  You awake from what appears to be a disturbing dream, knowing neither where" +
                     "`r`n  you've been? Nor how you got where you are now. You slowly rise to your" +
                     "`r`n  feet, bewildered and almost oblivious to the throbbing ache pulsating" +
                     "`r`n  between your ringing ears.`r`n" +

                     "`r`n  The air surrounding you feels cold and damp. As you open your eyes and they" +
                     "`r`n  grow accustomed to the darkness? ou find yourself standing on a flowing" +
                     "`r`n  grassy knoll amidst dark green hills, towering stone fortresses and distant" +
                     "`r`n  villages that somewhat resemble the feudal townships and castles of medieval" + 
                     "`r`n  Scotland.`r`n" +

                     "`r`n  In the skies above? Dark gray clouds are passing in billowing, whispy tendrils." +
                     "`r`n  They randomly shape-shift into obscure patterns. As you gaze towards the" +
                     "`r`n  horizon to the north? You see a storm approaching from the east.`r`n" + 

                     "`r`n  A few black ravens fly over your head towards some unknown destination," +
                     "`r`n  their cries echoing softly against the creeping shadows.`r`n";

        $TB_Main_Output.Text = $MESSAGE;

        $PB_Current_View_PictureFile = (Split-Path -Parent $PSCommandPath) + "\Images\Classes_RPG_A _Knight_in_the_Darkness_MAP.jpg";
        $PB_Current_View.imageLocation = $PB_Current_View_PictureFile;

        $IntroSound = New-Object System.Media.SoundPlayer; 
        $IntroSound.SoundLocation = (Split-Path -Parent $PSCommandPath) + "\Sounds\WolfHowl.wav";
        $IntroSound.play();

        $Global:LOCATION = $C1;
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function CENTER1
{
        switch($Global:CHOICE[0])
        {
            'n' { $Global:LOCATION = $N1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            's' { $Global:LOCATION = $S1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'e' { $Global:LOCATION = $E1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'w' { $Global:LOCATION = $W1; 
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            default { $TB_Main_Output.Text = 
                      "`r`n You find yourself in: CENTER1" +
                      "`r`n Describe scenery and environment...";     
                      break; }
        }                           
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function NORTH1
{
        switch($Global:CHOICE[0])
        {
            'n' { $Global:LOCATION = $N2;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            's' { $Global:LOCATION = $C1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'e' { $TB_Main_Output.Text = 
                  "`r`n You see a wall.";
                  break; }
            'w' { $TB_Main_Output.Text = 
                  "`r`n You see trees."; 
                  break; }
            default { $TB_Main_Output.Text = 
                      "`r`n You find yourself in: NORTH1" +
                      "`r`n Describe scenery and environment...";      
                      break; }
        }                           
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function SOUTH1
{
        switch($Global:CHOICE[0])
        {
            'n' { $Global:LOCATION = $C1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            's' { $Global:LOCATION = $S2;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'e' { $TB_Main_Output.Text = 
                  "`r`n You see rocks.";
                  $Global:CHOICE = "#";
                  break; }
            'w' { $TB_Main_Output.Text = 
                  "`r`n You see dirt.";
                  $Global:CHOICE = "#";
                  break; }
            default { $TB_Main_Output.Text = 
                      "`r`n You find yourself in: SOUTH1" +
                      "`r`n Describe scenery and environment...";      
                      break; }
        }                           
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function EAST1
{
        switch($Global:CHOICE[0])
        {
            'n' { $TB_Main_Output.Text = 
                  "`r`n You see a small pond.";
                  $Global:CHOICE = "#";
                  break; }
            's' { $TB_Main_Output.Text = 
                  "`r`n You see tall grass.";
                  $Global:CHOICE = "#";
                  break; }
            'e' { $Global:LOCATION = $E2;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'w' { $Global:LOCATION = $C1; 
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            default { $TB_Main_Output.Text = 
                      "`r`n You find yourself in: EAST1" +
                      "`r`n Describe scenery and environment...";      
                      break; }
        }                           
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>

function WEST1
{
        switch($Global:CHOICE[0])
        {
            'n' { $TB_Main_Output.Text = 
                  "`r`n You see a village.";
                  $Global:CHOICE = "#";
                  break; }
            's' { $TB_Main_Output.Text = 
                  "`r`n You see smoking ruins.";
                  $Global:CHOICE = "#";
                  break; }
            'e' { $Global:LOCATION = $C1;
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            'w' { $Global:LOCATION = $W2; 
                  $Global:CHOICE = "#";
                  SwitchBoard;
                  break; }
            default { $TB_Main_Output.Text = 
                      "`r`n You find yourself in: WEST1" +
                      "`r`n Describe scenery and environment...";      
                      break; }
        }                           
}

<# ------------------------------------------------------------------------------------------------------------------------------------ #>


#GUI
<# ------------------------------------------------------------------------------------------------------------------------------------ #>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Main_Form = New-Object system.Windows.Forms.Form;
$Main_Form.ClientSize = New-Object System.Drawing.Point(1262,797);
$Main_Form.text = "A Knight in the Darkness 3.0 - Carly Salali Germany ©2020";
$Main_Form.TopMost = $false;
$Main_Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$Main_Form.Font  = New-Object System.Drawing.Font('Comic Sans MS',12);
$Main_Form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Title = New-Object system.Windows.Forms.Label;
$L_Title.text = "A Knight in the Darkness 3.0";
$L_Title.AutoSize = $true;
$L_Title.width = 25;
$L_Title.height = 8;
$L_Title.location = New-Object System.Drawing.Point(450,08);

$L_Main_Output = New-Object system.Windows.Forms.Label;
$L_Main_Output.text = "Main Output";
$L_Main_Output.AutoSize = $true;
$L_Main_Output.width = 25;
$L_Main_Output.height = 8;
$L_Main_Output.location = New-Object System.Drawing.Point(14,10);

$L_Current_View = New-Object system.Windows.Forms.Label;
$L_Current_View.text = "Current View";
$L_Current_View.AutoSize = $true;
$L_Current_View.width = 25;
$L_Current_View.height = 8;
$L_Current_View.location = New-Object System.Drawing.Point(935,10);


$GB_Main_Output = New-Object system.Windows.Forms.Groupbox;
$GB_Main_Output.height = 546;
$GB_Main_Output.width = 710;
$GB_Main_Output.location = New-Object System.Drawing.Point(15,36);


$Message = "`r`n`  Main Output text will display HERE." + 
           "`r`n`r`n  A LONG, LONG time ago?" +
           "`r`n`r`n  In a galaxy FAR, FAR away ..." +
           "`r`n`r`n  It was a DARK and STORMY night ...";

$TB_Main_Output = New-Object system.Windows.Forms.TextBox;
$TB_Main_Output.multiline = $true;
$TB_Main_Output.WordWrap = $true;
$TB_Main_Output.BorderStyle = 0;
$TB_Main_Output.ScrollBars = 2;
$TB_Main_Output.TabStop = $false;
$TB_Main_Output.AcceptsTab = $false;
$TB_Main_Output.ReadOnly = $true;
$TB_Main_Output.text = $Message;
$TB_Main_Output.width = 688;
$TB_Main_Output.height = 441;
$TB_Main_Output.location = New-Object System.Drawing.Point(8,16);
$TB_Main_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',13);
$TB_Main_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Main_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a4a4a");

$TB_Main_Input = New-Object system.Windows.Forms.TextBox;
$TB_Main_Input.multiline = $false;
$TB_Main_Input.WordWrap = $true;
$TB_Main_Input.BorderStyle = 0;
$TB_Main_Input.ScrollBars = 0;
$TB_Main_Input.TabStop = $true;
$TB_Main_Input.text = "Input goes HERE";
$TB_Main_Input.width = 688;
$TB_Main_Input.height = 15;
$TB_Main_Input.location = New-Object System.Drawing.Point(8,470);
$TB_Main_Input.Font = New-Object System.Drawing.Font('Comic Sans MS',13);
$TB_Main_Input.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Main_Input.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a4a4a");


$B_Look                          = New-Object system.Windows.Forms.Button
$B_Look.text                     = "LOOK"
$B_Look.width                    = 115
$B_Look.height                   = 35
$B_Look.location                 = New-Object System.Drawing.Point(384,500)
$B_Look.Font                     = New-Object System.Drawing.Font('Calibri',18,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$B_Look.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$B_Look.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$B_Go                            = New-Object system.Windows.Forms.Button
$B_Go.text                       = "GO"
$B_Go.width                      = 181
$B_Go.height                     = 35
$B_Go.location                   = New-Object System.Drawing.Point(512,500)
$B_Go.Font                       = New-Object System.Drawing.Font('Calibri',18,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$B_Go.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$B_Go.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$B_Defend                        = New-Object system.Windows.Forms.Button
$B_Defend.text                   = "DEFEND"
$B_Defend.width                  = 115
$B_Defend.height                 = 35
$B_Defend.location               = New-Object System.Drawing.Point(257,500)
$B_Defend.Font                   = New-Object System.Drawing.Font('Calibri',18,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$B_Defend.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$B_Defend.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$B_Attack                        = New-Object system.Windows.Forms.Button
$B_Attack.text                   = "ATTACK"
$B_Attack.width                  = 115
$B_Attack.height                 = 35
$B_Attack.location               = New-Object System.Drawing.Point(130,500)
$B_Attack.Font                   = New-Object System.Drawing.Font('Calibri',18,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$B_Attack.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$B_Attack.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$B_Use                           = New-Object system.Windows.Forms.Button
$B_Use.text                      = "USE"
$B_Use.width                     = 115
$B_Use.height                    = 35
$B_Use.location                  = New-Object System.Drawing.Point(4,500)
$B_Use.Font                      = New-Object System.Drawing.Font('Calibri',18,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$B_Use.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$B_Use.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$GB_Current_View                 = New-Object system.Windows.Forms.Groupbox
$GB_Current_View.height          = 432
$GB_Current_View.width           = 514
$GB_Current_View.location        = New-Object System.Drawing.Point(731,37)


$PB_Current_View_PictureFile = (Split-Path -Parent $PSCommandPath) + "\Images\Wolf.jpg";
$PB_Current_View                     = New-Object system.Windows.Forms.PictureBox;
$PB_Current_View.width               = 500;
$PB_Current_View.height              = 405;
$PB_Current_View.location            = New-Object System.Drawing.Point(5,15)
$PB_Current_View.imageLocation       = $PB_Current_View_PictureFile;
$PB_Current_View.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom;


$GB_Inventory                    = New-Object system.Windows.Forms.Groupbox
$GB_Inventory.height             = 196
$GB_Inventory.width              = 381
$GB_Inventory.location           = New-Object System.Drawing.Point(15,587)

$LV_Inventory                    = New-Object system.Windows.Forms.ListBox;
$LV_Inventory.Visible = $true;
$LV_Inventory.Font                = New-Object System.Drawing.Font('Comic Sans MS',11)
$LV_Inventory.width              = 359;
$LV_Inventory.height             = 148;
$LV_Inventory.location           = New-Object System.Drawing.Point(12,38);
$LV_Inventory.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$LV_Inventory.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#4a4a4a");
$LV_Inventory.Items.Add("Broad Sword");
$LV_Inventory.Items.Add("Dagger");
$LV_Inventory.Items.Add("Bo Staff");
$LV_Inventory.Items.Add("CrossBow");
$LV_Inventory.Items.Add("LongBow");
$LV_Inventory.Items.Add("Arrows: 34");
$LV_Inventory.Items.Add("Whip");
$LV_Inventory.Items.Add("PlateArmor");
$LV_Inventory.Items.Add("ChainMail");
$LV_Inventory.Items.Add("FishKey");
$LV_Inventory.Items.Add("Healing Potion");

$L_Inventory                     = New-Object system.Windows.Forms.Label
$L_Inventory.text                = "Inventory"
$L_Inventory.AutoSize            = $true
$L_Inventory.width               = 25
$L_Inventory.height              = 8
$L_Inventory.location            = New-Object System.Drawing.Point(153,13)
$L_Inventory.Font                = New-Object System.Drawing.Font('Callibri',13)
$L_Inventory.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$GB_Magic                        = New-Object system.Windows.Forms.Groupbox
$GB_Magic.height                 = 195
$GB_Magic.width                  = 320
$GB_Magic.location               = New-Object System.Drawing.Point(406,588)

$LV_Magic                        = New-Object system.Windows.Forms.ListBox;
$LV_Magic.Visible = $true;
$LV_Magic.Font                = New-Object System.Drawing.Font('Comic Sans MS',11)
$LV_Magic.width                  = 304;
$LV_Magic.height                 = 149;
$LV_Magic.location               = New-Object System.Drawing.Point(7,38);
$LV_Magic.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$LV_Magic.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#4a4a4a");
$LV_Magic.Items.Add("Shape Shift");
$LV_Magic.Items.Add("Fire Ball");
$LV_Magic.Items.Add("Ice Blast");
$LV_Magic.Items.Add("Lightning");
$LV_Magic.Items.Add("Telekinetic Force");
$LV_Magic.Items.Add("Invisibility");
$LV_Magic.Items.Add("Teleport");
$LV_Magic.Items.Add("Illuminate");
$LV_Magic.Items.Add("Levitate");
$LV_Magic.Items.Add("Slow Time");
$LV_Magic.Items.Add("Healing");

$L_Magic_Abilities               = New-Object system.Windows.Forms.Label
$L_Magic_Abilities.text          = "Magic Abilities"
$L_Magic_Abilities.AutoSize      = $true
$L_Magic_Abilities.width         = 25
$L_Magic_Abilities.height        = 8
$L_Magic_Abilities.location      = New-Object System.Drawing.Point(102,13)
$L_Magic_Abilities.Font          = New-Object System.Drawing.Font('Callibri',13)
$L_Magic_Abilities.ForeColor     = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$GB_Player_Stats                 = New-Object system.Windows.Forms.Groupbox
$GB_Player_Stats.height          = 196
$GB_Player_Stats.width           = 503
$GB_Player_Stats.location        = New-Object System.Drawing.Point(740,589)

$L_Character_Stats               = New-Object system.Windows.Forms.Label
$L_Character_Stats.text          = "Character Stats"
$L_Character_Stats.AutoSize      = $true
$L_Character_Stats.width         = 25
$L_Character_Stats.height        = 8
$L_Character_Stats.location      = New-Object System.Drawing.Point(194,20)
$L_Character_Stats.Font          = New-Object System.Drawing.Font('Callibri',12)
$L_Character_Stats.ForeColor     = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Name                          = New-Object system.Windows.Forms.Label
$L_Name.text                     = "Name:"
$L_Name.AutoSize                 = $true
$L_Name.width                    = 25
$L_Name.height                   = 8
$L_Name.location                 = New-Object System.Drawing.Point(15,51)
$L_Name.Font                     = New-Object System.Drawing.Font('Callibri',11)
$L_Name.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Name_Output                   = New-Object system.Windows.Forms.Label
$L_Name_Output.text              = "Carly Salali"
$L_Name_Output.AutoSize          = $true
$L_Name_Output.width             = 25
$L_Name_Output.height            = 8
$L_Name_Output.location          = New-Object System.Drawing.Point(70,52)
$L_Name_Output.Font              = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Name_Output.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Gender                        = New-Object system.Windows.Forms.Label
$L_Gender.text                   = "Gender:"
$L_Gender.AutoSize               = $true
$L_Gender.width                  = 25
$L_Gender.height                 = 8
$L_Gender.location               = New-Object System.Drawing.Point(15,77)
$L_Gender.Font                   = New-Object System.Drawing.Font('Callibri',11)
$L_Gender.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Gender_Output                 = New-Object system.Windows.Forms.Label
$L_Gender_Output.text            = "Female"
$L_Gender_Output.AutoSize        = $true
$L_Gender_Output.width           = 25
$L_Gender_Output.height          = 8
$L_Gender_Output.location        = New-Object System.Drawing.Point(79,78)
$L_Gender_Output.Font            = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Gender_Output.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Species                       = New-Object system.Windows.Forms.Label
$L_Species.text                  = "Species:"
$L_Species.AutoSize              = $true
$L_Species.width                 = 25
$L_Species.height                = 8
$L_Species.location              = New-Object System.Drawing.Point(16,106)
$L_Species.Font                  = New-Object System.Drawing.Font('Callibri',11)
$L_Species.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Species_Output                = New-Object system.Windows.Forms.Label
$L_Species_Output.text           = "Elven Hybrid"
$L_Species_Output.AutoSize       = $true
$L_Species_Output.width          = 25
$L_Species_Output.height         = 8
$L_Species_Output.location       = New-Object System.Drawing.Point(83,106)
$L_Species_Output.Font           = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Species_Output.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Health                        = New-Object system.Windows.Forms.Label
$L_Health.text                   = "Health:"
$L_Health.AutoSize               = $true
$L_Health.width                  = 25
$L_Health.height                 = 8
$L_Health.location               = New-Object System.Drawing.Point(16,135)
$L_Health.Font                   = New-Object System.Drawing.Font('Callibri',11)
$L_Health.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Health_Output                 = New-Object system.Windows.Forms.Label
$L_Health_Output.text            = "100"
$L_Health_Output.AutoSize        = $true
$L_Health_Output.width           = 25
$L_Health_Output.height          = 8
$L_Health_Output.location        = New-Object System.Drawing.Point(72,135)
$L_Health_Output.Font            = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Health_Output.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Magic_Energy                  = New-Object system.Windows.Forms.Label
$L_Magic_Energy.text             = "Magic Eng:"
$L_Magic_Energy.AutoSize         = $true
$L_Magic_Energy.width            = 25
$L_Magic_Energy.height           = 8
$L_Magic_Energy.location         = New-Object System.Drawing.Point(16,162)
$L_Magic_Energy.Font             = New-Object System.Drawing.Font('Callibri',11)
$L_Magic_Energy.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Magic_Energy_Output           = New-Object system.Windows.Forms.Label
$L_Magic_Energy_Output.text      = "9000"
$L_Magic_Energy_Output.AutoSize  = $true
$L_Magic_Energy_Output.width     = 25
$L_Magic_Energy_Output.height    = 8
$L_Magic_Energy_Output.location  = New-Object System.Drawing.Point(99,164)
$L_Magic_Energy_Output.Font      = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Magic_Energy_Output.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Attack                        = New-Object system.Windows.Forms.Label
$L_Attack.text                   = "Attack:"
$L_Attack.AutoSize               = $true
$L_Attack.width                  = 25
$L_Attack.height                 = 8
$L_Attack.location               = New-Object System.Drawing.Point(198,51)
$L_Attack.Font                   = New-Object System.Drawing.Font('Callibri',11)
$L_Attack.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Attack_Output                 = New-Object system.Windows.Forms.Label
$L_Attack_Output.text            = "15"
$L_Attack_Output.AutoSize        = $true
$L_Attack_Output.width           = 25
$L_Attack_Output.height          = 8
$L_Attack_Output.location        = New-Object System.Drawing.Point(251,51)
$L_Attack_Output.Font            = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Attack_Output.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Defense                       = New-Object system.Windows.Forms.Label
$L_Defense.text                  = "Defense:"
$L_Defense.AutoSize              = $true
$L_Defense.width                 = 25
$L_Defense.height                = 8
$L_Defense.location              = New-Object System.Drawing.Point(198,78)
$L_Defense.Font                  = New-Object System.Drawing.Font('Callibri',11)
$L_Defense.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Defense_Output                = New-Object system.Windows.Forms.Label
$L_Defense_Output.text           = "23"
$L_Defense_Output.AutoSize       = $true
$L_Defense_Output.width          = 25
$L_Defense_Output.height         = 8
$L_Defense_Output.location       = New-Object System.Drawing.Point(267,78)
$L_Defense_Output.Font           = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Defense_Output.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Charisma                      = New-Object system.Windows.Forms.Label
$L_Charisma.text                 = "Charisma:"
$L_Charisma.AutoSize             = $true
$L_Charisma.width                = 25
$L_Charisma.height               = 8
$L_Charisma.location             = New-Object System.Drawing.Point(198,106)
$L_Charisma.Font                 = New-Object System.Drawing.Font('Callibri',11)
$L_Charisma.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Charisma_Output               = New-Object system.Windows.Forms.Label
$L_Charisma_Output.text          = "9000"
$L_Charisma_Output.AutoSize      = $true
$L_Charisma_Output.width         = 25
$L_Charisma_Output.height        = 8
$L_Charisma_Output.location      = New-Object System.Drawing.Point(276,107)
$L_Charisma_Output.Font          = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Charisma_Output.ForeColor     = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Combat_Exp                    = New-Object system.Windows.Forms.Label
$L_Combat_Exp.text               = "Combat Exp:"
$L_Combat_Exp.AutoSize           = $true
$L_Combat_Exp.width              = 25
$L_Combat_Exp.height             = 8
$L_Combat_Exp.location           = New-Object System.Drawing.Point(198,135)
$L_Combat_Exp.Font               = New-Object System.Drawing.Font('Callibri',11)
$L_Combat_Exp.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Combat_Exp_Output             = New-Object system.Windows.Forms.Label
$L_Combat_Exp_Output.text        = "153"
$L_Combat_Exp_Output.AutoSize    = $true
$L_Combat_Exp_Output.width       = 25
$L_Combat_Exp_Output.height      = 8
$L_Combat_Exp_Output.location    = New-Object System.Drawing.Point(292,135)
$L_Combat_Exp_Output.Font        = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Combat_Exp_Output.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Level                         = New-Object system.Windows.Forms.Label
$L_Level.text                    = "Level:"
$L_Level.AutoSize                = $true
$L_Level.width                   = 25
$L_Level.height                  = 8
$L_Level.location                = New-Object System.Drawing.Point(198,162)
$L_Level.Font                    = New-Object System.Drawing.Font('Callibri',11)
$L_Level.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Level_Output                  = New-Object system.Windows.Forms.Label
$L_Level_Output.text             = "18"
$L_Level_Output.AutoSize         = $true
$L_Level_Output.width            = 25
$L_Level_Output.height           = 8
$L_Level_Output.location         = New-Object System.Drawing.Point(249,163)
$L_Level_Output.Font             = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Level_Output.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Armor                         = New-Object system.Windows.Forms.Label
$L_Armor.text                    = "Armor:"
$L_Armor.AutoSize                = $true
$L_Armor.width                   = 25
$L_Armor.height                  = 8
$L_Armor.location                = New-Object System.Drawing.Point(343,50)
$L_Armor.Font                    = New-Object System.Drawing.Font('Callibri',11)
$L_Armor.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Armor_Output                  = New-Object system.Windows.Forms.Label
$L_Armor_Output.text             = "Plate Mail"
$L_Armor_Output.AutoSize         = $true
$L_Armor_Output.width            = 25
$L_Armor_Output.height           = 8
$L_Armor_Output.location         = New-Object System.Drawing.Point(396,51)
$L_Armor_Output.Font             = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Armor_Output.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Weapon                        = New-Object system.Windows.Forms.Label
$L_Weapon.text                   = "Weapon:"
$L_Weapon.AutoSize               = $true
$L_Weapon.width                  = 25
$L_Weapon.height                 = 8
$L_Weapon.location               = New-Object System.Drawing.Point(343,78)
$L_Weapon.Font                   = New-Object System.Drawing.Font('Callibri',11)
$L_Weapon.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Weapon_Output                 = New-Object system.Windows.Forms.Label
$L_Weapon_Output.text            = "Long Bow"
$L_Weapon_Output.AutoSize        = $true
$L_Weapon_Output.width           = 25
$L_Weapon_Output.height          = 8
$L_Weapon_Output.location        = New-Object System.Drawing.Point(410,78)
$L_Weapon_Output.Font            = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Weapon_Output.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Magic                         = New-Object system.Windows.Forms.Label
$L_Magic.text                    = "Magic:"
$L_Magic.AutoSize                = $true
$L_Magic.width                   = 25
$L_Magic.height                  = 8
$L_Magic.location                = New-Object System.Drawing.Point(343,106)
$L_Magic.Font                    = New-Object System.Drawing.Font('Callibri',11)
$L_Magic.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Magic_Output                  = New-Object system.Windows.Forms.Label
$L_Magic_Output.text             = "Fire Ball"
$L_Magic_Output.AutoSize         = $true
$L_Magic_Output.width            = 25
$L_Magic_Output.height           = 8
$L_Magic_Output.location         = New-Object System.Drawing.Point(396,106)
$L_Magic_Output.Font             = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Magic_Output.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Dexterity                     = New-Object system.Windows.Forms.Label
$L_Dexterity.text                = "Dexterity:"
$L_Dexterity.AutoSize            = $true
$L_Dexterity.width               = 25
$L_Dexterity.height              = 8
$L_Dexterity.location            = New-Object System.Drawing.Point(343,135)
$L_Dexterity.Font                = New-Object System.Drawing.Font('Callibri',11)
$L_Dexterity.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Dexterity_Output              = New-Object system.Windows.Forms.Label
$L_Dexterity_Output.text         = "5"
$L_Dexterity_Output.AutoSize     = $true
$L_Dexterity_Output.width        = 25
$L_Dexterity_Output.height       = 8
$L_Dexterity_Output.location     = New-Object System.Drawing.Point(413,135)
$L_Dexterity_Output.Font         = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Dexterity_Output.ForeColor    = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$L_Constitution                  = New-Object system.Windows.Forms.Label
$L_Constitution.text             = "Constitution:"
$L_Constitution.AutoSize         = $true
$L_Constitution.width            = 25
$L_Constitution.height           = 8
$L_Constitution.location         = New-Object System.Drawing.Point(342,163)
$L_Constitution.Font             = New-Object System.Drawing.Font('Callibri',11)
$L_Constitution.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$L_Constitution_Output           = New-Object system.Windows.Forms.Label
$L_Constitution_Output.text      = "55"
$L_Constitution_Output.AutoSize  = $true
$L_Constitution_Output.width     = 25
$L_Constitution_Output.height    = 8
$L_Constitution_Output.location  = New-Object System.Drawing.Point(431,164)
$L_Constitution_Output.Font      = New-Object System.Drawing.Font('Comic Sans MS',11)
$L_Constitution_Output.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

#--------------------------------------------------------------------------------------------------------------------

$GB_Navigation = New-Object system.Windows.Forms.Groupbox;
$GB_Navigation.height = 110;
$GB_Navigation.width = 209;
$GB_Navigation.location = New-Object System.Drawing.Point(740,480);

$L_Navigation = New-Object system.Windows.Forms.Label;
$L_Navigation.text = "Navigation";
$L_Navigation.AutoSize = $true;
$L_Navigation.width = 25;
$L_Navigation.height = 8;
$L_Navigation.location = New-Object System.Drawing.Point(69,13);
$L_Navigation.Font = New-Object System.Drawing.Font('Callibri',11);
$L_Navigation.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$B_North = New-Object system.Windows.Forms.Button;
$B_North.text = "North";
$B_North.width  = 60;
$B_North.height = 30;
$B_North.location = New-Object System.Drawing.Point(75,40);
$B_North.Font = New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_North.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_North.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

$B_South = New-Object system.Windows.Forms.Button;
$B_South.text = "South";
$B_South.width = 60;
$B_South.height = 30;
$B_South.location = New-Object System.Drawing.Point(75,70);
$B_South.Font = New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_South.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_South.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

$B_East = New-Object system.Windows.Forms.Button;
$B_East.text = "East";
$B_East.width = 60;
$B_East.height = 30;
$B_East.location = New-Object System.Drawing.Point(135,55);
$B_East.Font = New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_East.ForeColor= [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_East.BackColor= [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

$B_West = New-Object system.Windows.Forms.Button;
$B_West.text = "West";
$B_West.width = 60;
$B_West.height = 30;
$B_West.location = New-Object System.Drawing.Point(15,55);
$B_West.Font = New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_West.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_West.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

#--------------------------------------------------------------------------------------------------------------------

$GB_Load_Save = New-Object system.Windows.Forms.Groupbox
$GB_Load_Save.height = 110
$GB_Load_Save.width = 105
$GB_Load_Save.location = New-Object System.Drawing.Point(1138,480)

$B_Load = New-Object system.Windows.Forms.Button;
$B_Load.text  = "LOAD";
$B_Load.width = 80;
$B_Load.height = 35;
$B_Load.location = New-Object System.Drawing.Point(13,65);
$B_Load.Font = New-Object System.Drawing.Font('Calibri',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_Load.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Load.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

$B_Save = New-Object system.Windows.Forms.Button
$B_Save.text = "SAVE"
$B_Save.width = 80
$B_Save.height = 35
$B_Save.location = New-Object System.Drawing.Point(13,25);
$B_Save.Font = New-Object System.Drawing.Font('Calibri',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold));
$B_Save.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Save.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");

#--------------------------------------------------------------------------------------------------------------------

$GB_Main_Output.controls.AddRange(@($TB_Main_Output,$TB_Main_Input,$B_Look,$B_Go,$B_Defend,$B_Attack,$B_Use))
$GB_Current_View.controls.AddRange(@($PB_Current_View))
$GB_Inventory.controls.AddRange(@($LV_Inventory,$L_Inventory))
$GB_Magic.controls.AddRange(@($LV_Magic,$L_Magic_Abilities))
$GB_Player_Stats.controls.AddRange(@($L_Name,$L_Character_Stats,$L_Gender,$L_Gender_Output,$L_Species,$L_Species_Output,$L_Health,$L_Health_Output,$L_Magic_Energy,$L_Magic_Energy_Output,$L_Attack,$L_Name_Output,$L_Attack_Output,$L_Defense,$L_Defense_Output,$L_Charisma,$L_Charisma_Output,$L_Combat_Exp,$L_Combat_Exp_Output,$L_Level,$L_Level_Output,$L_Armor,$L_Armor_Output,$L_Weapon,$L_Weapon_Output,$L_Magic,$L_Magic_Output,$L_Dexterity,$L_Dexterity_Output,$L_Constitution,$L_Constitution_Output))
$GB_Navigation.controls.AddRange(@($L_Navigation,$B_North,$B_South,$B_East,$B_West))
$GB_Load_Save.controls.AddRange(@($B_Load,$B_Save));

$Main_Form.controls.AddRange(@($L_Title,$L_Main_Output,$L_Current_View,$GB_Main_Output,$GB_Current_View,$GB_Inventory,$GB_Magic,$GB_Player_Stats,$GB_Navigation,$GB_Load_Save))

<# --------------------------------------------------------------------------------------------------- #>

$B_Go.Add_Click({ Go_Action; })
$B_Look.Add_Click({  })
$B_Defend.Add_Click({  })
$B_Attack.Add_Click({  })
$B_Use.Add_Click({  })

$B_North.Add_Click({ $Global:CHOICE = "n"; Navigate_Action; })
$B_South.Add_Click({ $Global:CHOICE = "s"; Navigate_Action; })
$B_East.Add_Click({ $Global:CHOICE = "e"; Navigate_Action; })
$B_West.Add_Click({ $Global:CHOICE = "w"; Navigate_Action; })

$LV_Inventory.Add_Click({  })
$LV_Magic.Add_Click({  })
$LV_Inventory.Add_SelectedIndexChanged({  })
$LV_Magic.Add_SelectedIndexChanged({  })

<# --------------------------------------------------------------------------------------------------- #>

$LoadSound = New-Object System.Media.SoundPlayer; 
$LoadSound.SoundLocation = (Split-Path -Parent $PSCommandPath) + "\Sounds\Thunder1.wav";
$LoadSound.Load();
$LoadSound.play();

#Note: Using ShowDialog() locks up ISE after form closes sometimes. So trying an alternative:
# [system.windows.forms.application]::run($form)

#$Main_Form.ShowDialog();
[system.windows.forms.application]::run($Main_Form);



