#Powershell GUI Forms and Components - 08 Adding a PictureBox to a Form
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
$PB_View = New-Object system.Windows.Forms.PictureBox;
$PB_View.width = 337;
$PB_View.height = 263;
$PB_View.location = New-Object System.Drawing.Point(28,127);
$PB_View_File = (Split-Path -Parent $PSCommandPath) + "\Images\Alice.jpg";
$PB_View.imageLocation = $PB_View_File;
$PB_View.BorderStyle = 1;
$PB_View.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::zoom;

$B_View = New-Object system.Windows.Forms.Button;
$B_View.text = "VIEW";
$B_View.width = 179;
$B_View.height = 55;
$B_View.location = New-Object System.Drawing.Point(110,38);
$B_View.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',25);
$B_View.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_View.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#bd10e0");


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.controls.AddRange(@($PB_View,$B_View))


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
function Reveal_the_View
{
        $PB_View_File = (Split-Path -Parent $PSCommandPath) + "\Images\Wolf.jpg";
        $PB_View.imageLocation = $PB_View_File; 
}

#-----------------------------------------------------------------------------------------

$B_View.Add_Click({ Reveal_the_View; })

#-----------------------------------------------------------------------------------------


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
