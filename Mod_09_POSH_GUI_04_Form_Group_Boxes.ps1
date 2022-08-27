#Powershell GUI Forms and Components - 04 Adding Groupboxes to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize = New-Object System.Drawing.Point(593,392);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.text = "Carly is Sparkly Unicorn!";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$GB_Top = New-Object system.Windows.Forms.Groupbox;
$GB_Top.height = 148;
$GB_Top.width = 375;
$GB_Top.text = "GB Top";
$GB_Top.location = New-Object System.Drawing.Point(105,30);

$RB_Option1 = New-Object system.Windows.Forms.RadioButton;
$RB_Option1.Text = "To Be?";
$RB_Option1.AutoSize  = $true;
$RB_Option1.width = 104;
$RB_Option1.height = 10;
$RB_Option1.location = New-Object System.Drawing.Point(32,54);
$RB_Option1.Font = New-Object System.Drawing.Font('Callibri',10);

$RB_Option2 = New-Object system.Windows.Forms.RadioButton;
$RB_Option2.Text = "Or NOT To Be?";
$RB_Option2.AutoSize = $true;
$RB_Option2.width = 104;
$RB_Option2.height = 10;
$RB_Option2.location = New-Object System.Drawing.Point(32,94);
$RB_Option2.Font = New-Object System.Drawing.Font('Callibri',10);

$TB_Top_Output = New-Object system.Windows.Forms.TextBox;
$TB_Top_Output.multiline = $true;
$TB_Top_Output.width = 188;
$TB_Top_Output.height = 116;
$TB_Top_Output.location = New-Object System.Drawing.Point(167,14);
$TB_Top_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',27);

$GB_Bottom = New-Object system.Windows.Forms.Groupbox;
$GB_Bottom.height = 148;
$GB_Bottom.width = 375;
$GB_Bottom.text = "GB Bottom";
$GB_Bottom.location = New-Object System.Drawing.Point(105,216);

$L_Bottom_Output = New-Object system.Windows.Forms.Label;
$L_Bottom_Output.text = "";
$L_Bottom_Output.AutoSize  = $false;
$L_Bottom_Output.TextAlign = "MiddleCenter";
$L_Bottom_Output.width  = 300;
$L_Bottom_Output.height = 60;
$L_Bottom_Output.location = New-Object System.Drawing.Point(35,20);
$L_Bottom_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',30);
$L_Bottom_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#bd10e0");

$B_Enter = New-Object system.Windows.Forms.Button;
$B_Enter.text = "ENTER";
$B_Enter.width = 120;
$B_Enter.height = 42;
$B_Enter.location = New-Object System.Drawing.Point(130,90);
$B_Enter.Font = New-Object System.Drawing.Font('Callibri',15);
$B_Enter.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Enter.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");


#4. Add the Components to the Group Boxes
#-----------------------------------------------------------------------------------------
$GB_Top.controls.AddRange(@($RB_Option1,$RB_Option2,$TB_Top_Output));
$GB_Bottom.controls.AddRange(@($L_Bottom_Output,$B_Enter));


#5. Add the Group Boxes to the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.controls.AddRange(@($GB_Top,$GB_Bottom));


#6. Code the Event Handlers
#-----------------------------------------------------------------------------------------
$RB_Option1.Add_Click({ $TB_Top_Output.Text = "To BE?"; })
$RB_Option2.Add_Click({ $TB_Top_Output.Text = "Or NOT`r`nto be?"; })
$B_Enter.Add_Click({ $L_Bottom_Output.Text = "Hello World!"; })


#7. Display the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
