#Powershell GUI Forms and Components - 10 Adding Checkboxes to a Form Handling the Selected Event
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(390,425);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$GB_Top = New-Object system.Windows.Forms.Groupbox;
$GB_Top.Height = 102;
$GB_Top.Width = 351;
$GB_Top.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$GB_Top.Font = New-Object System.Drawing.Font('Callibri',10);
$GB_Top.Text  = "GB Best Starship Captains of All Time";
$GB_Top.Location = New-Object System.Drawing.Point(20,15);

$CheckB_Kirk = New-Object system.Windows.Forms.CheckBox;
$CheckB_Kirk.text = "James T. Kirk";
$CheckB_Kirk.AutoSize = $false;
$CheckB_Kirk.width = 121;
$CheckB_Kirk.height = 16;
$CheckB_Kirk.location = New-Object System.Drawing.Point(24,37);

$CheckB_Janeway = New-Object system.Windows.Forms.CheckBox;
$CheckB_Janeway.text = "Kathryn Janeway";
$CheckB_Janeway.AutoSize = $false;
$CheckB_Janeway.width  = 132;
$CheckB_Janeway.height = 17;
$CheckB_Janeway.location = New-Object System.Drawing.Point(24,64);

$CheckB_Sisko = New-Object system.Windows.Forms.CheckBox;
$CheckB_Sisko.text = "Benjamin L. Sisko";
$CheckB_Sisko.AutoSize = $false;
$CheckB_Sisko.width = 136;
$CheckB_Sisko.height = 17;
$CheckB_Sisko.location = New-Object System.Drawing.Point(202,36);

$CheckB_Picard = New-Object system.Windows.Forms.CheckBox;
$CheckB_Picard.text = "Jean Luc Picard";
$CheckB_Picard.AutoSize = $false;
$CheckB_Picard.width = 127;
$CheckB_Picard.height = 17;
$CheckB_Picard.location = New-Object System.Drawing.Point(202,64);

$B_Who = New-Object system.Windows.Forms.Button;
$B_Who.text = "WHO Is Your Captain?";
$B_Who.width = 330;
$B_Who.height = 55;
$B_Who.location = New-Object System.Drawing.Point(30,125);
$B_Who.Font = New-Object System.Drawing.Font('Calibri',25);
$B_Who.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Who.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#bd10e0");

$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.width = 339;
$TB_Output.height = 216;
$TB_Output.location = New-Object System.Drawing.Point(25,190);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',16);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$GB_Top.controls.AddRange(@($CheckB_Kirk,$CheckB_Janeway,$CheckB_Picard,$CheckB_Sisko));
$Form_MAIN.controls.AddRange(@($GB_Top,$B_Who,$TB_Output));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
function Do_Something
{
         $TB_Output.Text = "";

         if($CheckB_Kirk.Checked)
         { $TB_Output.Text += "`r`nBest captain is " + $CheckB_Kirk.Text; }

         if($CheckB_Janeway.Checked)
         { $TB_Output.Text += "`r`nBest captain is " + $CheckB_Janeway.Text; }

         if($CheckB_Sisko.Checked)
         { $TB_Output.Text += "`r`nBest captain is " + $CheckB_Sisko.Text; }

         if($CheckB_Picard.Checked)
         { $TB_Output.Text += "`r`nBest captain is " + $CheckB_Picard.Text; }

}
#-----------------------------------------------------------------------------------------

$B_Who.Add_Click({ Do_Something; })

#-----------------------------------------------------------------------------------------


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
