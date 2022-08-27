#Powershell GUI Forms and Components - 11 Adding a ProgressBar to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(390,275);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$L_Title = New-Object system.Windows.Forms.Label;
$L_Title.text = "Power Level";
$L_Title.AutoSize = $true;
$L_Title.width = 25;
$L_Title.height = 10;
$L_Title.location = New-Object System.Drawing.Point(145,10);
$L_Title.Font = New-Object System.Drawing.Font('Callibri',12);
$L_Title.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$L_Title.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");

$ProgressBar1 = New-Object system.Windows.Forms.ProgressBar;
$ProgressBar1.width = 329;
$ProgressBar1.height = 40;
$ProgressBar1.location = New-Object System.Drawing.Point(30,45);

$GB_Amount = New-Object system.Windows.Forms.Groupbox;
$GB_Amount.height = 117;
$GB_Amount.width = 258;
$GB_Amount.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$GB_Amount.Font = New-Object System.Drawing.Font('Courier New',10);
$GB_Amount.text = "Power Amount";
$GB_Amount.location = New-Object System.Drawing.Point(62,110);

$RB_25 = New-Object system.Windows.Forms.RadioButton;
$RB_25.text = "25% Power";
$RB_25.AutoSize = $true;
$RB_25.width = 104;
$RB_25.height = 10;
$RB_25.location = New-Object System.Drawing.Point(21,45);

$RB_50 = New-Object system.Windows.Forms.RadioButton;
$RB_50.text = "50% Power";
$RB_50.AutoSize = $true;
$RB_50.width = 104;
$RB_50.height = 10;
$RB_50.location = New-Object System.Drawing.Point(19,85);

$RB_75 = New-Object system.Windows.Forms.RadioButton;
$RB_75.text = "75% Power";
$RB_75.AutoSize = $true;
$RB_75.width = 104;
$RB_75.height = 10;
$RB_75.location = New-Object System.Drawing.Point(146,45);

$RB_100 = New-Object system.Windows.Forms.RadioButton;
$RB_100.text = "100% Power";
$RB_100.AutoSize = $true;
$RB_100.width = 104;
$RB_100.height = 10;
$RB_100.location = New-Object System.Drawing.Point(146,85);


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$GB_Amount.controls.AddRange(@($RB_25,$RB_50,$RB_75,$RB_100));
$Form_MAIN.controls.AddRange(@($L_Title,$ProgressBar1,$GB_Amount));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
$RB_25.Add_Click({ $ProgressBar1.Value = 25; })
$RB_50.Add_Click({ $ProgressBar1.Value = 50; })
$RB_75.Add_Click({ $ProgressBar1.Value = 75; })
$RB_100.Add_Click({ $ProgressBar1.Value = 100; })


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
