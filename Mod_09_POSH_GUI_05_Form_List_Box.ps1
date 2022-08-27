#Powershell GUI Forms and Components - 05 Adding a ListBox to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_Main = New-Object system.Windows.Forms.Form;
$Form_Main.ClientSize = New-Object System.Drawing.Point(758,580);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_Main.text = "Form";
$Form_Main.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$LB_Input = New-Object system.Windows.Forms.ListBox;
$LB_Input.text = "listBox";
$LB_Input.width = 367;
$LB_Input.height = 180;
$LB_Input.location = New-Object System.Drawing.Point(203,60);
$LB_Input.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$LB_Input.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a4a4a");
$LB_Input.Font = New-Object System.Drawing.Font('Comic Sans MS',16);
$LB_Input.Items.Add("Twilight Sparkle");
$LB_Input.Items.Add("Fluttershy");
$LB_Input.Items.Add("Rainbow Dash");
$LB_Input.Items.Add("Apple Jack");
$LB_Input.Items.Add("Pinkie Pie");
$LB_Input.Items.Add("Rarity");

$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.text = "Output Goes HERE!";
$TB_Output.width  = 567;
$TB_Output.height = 224;
$TB_Output.location = New-Object System.Drawing.Point(102,320);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',30);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#9013fe");
$TB_Output.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center;


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_Main.controls.AddRange(@($LB_Input,$TB_Output))


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
function Do_Something
{
         $CHOICE = $LB_Input.GetItemText($LB_Input.SelectedItem);
         $TB_Output.Text = "`r`nPony of the Month is:`r`n" + $CHOICE;
}
#-----------------------------------------------------------------------------------------

$LB_Input.Add_Click({ Do_Something; })

#-----------------------------------------------------------------------------------------


#6. Display the Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;