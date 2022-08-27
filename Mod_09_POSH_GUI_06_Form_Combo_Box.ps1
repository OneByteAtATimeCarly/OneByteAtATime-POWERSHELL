#Powershell GUI Forms and Components - 06 Adding ComboBoxes to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_Main = New-Object system.Windows.Forms.Form;
$Form_Main.ClientSize = New-Object System.Drawing.Point(597,477);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_Main.text = "Carly is Unicorn";
$Form_Main.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$CB_Input = New-Object system.Windows.Forms.ComboBox;
$CB_Input.text = "The Final Five";
$CB_Input.width = 304;
$CB_Input.height = 105;
$CB_Input.location = New-Object System.Drawing.Point(141,55);
$CB_Input.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',15);
$CB_Input.Items.Add("Gaius Baltar");
$CB_Input.Items.Add("Commander Adama");
$CB_Input.Items.Add("Starbuck");
$CB_Input.Items.Add("Apollo");

$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.text = "Output Will Go HERE";
$TB_Output.width = 484;
$TB_Output.height = 256;
$TB_Output.location = New-Object System.Drawing.Point(55,189);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',25);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$TB_Output.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center;


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_Main.controls.AddRange(@($CB_Input,$TB_Output));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
function Do_Something
{
         $CHOICE = $CB_Input.GetItemText($CB_Input.SelectedItem);
         $TB_Output.Text = "`r`nThe CYLON of the Month is:`r`n" + $CHOICE;
}
#-----------------------------------------------------------------------------------------

$CB_Input.Add_SelectedIndexChanged({ Do_Something; })

#-----------------------------------------------------------------------------------------


#6. Display the Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;




