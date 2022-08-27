#Powershell GUI Forms and Components - 07 Adding Masked TextBoxes to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(597,477);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.text = "`r`nENTER 20-digit into the`r`nMASKED textbox above.`r`n" +
                  "Note that because it is masked?`r`nIt will only take numbers.";
$TB_Output.TabStop = $false;
$TB_Output.width = 484;
$TB_Output.height = 256;
$TB_Output.location = New-Object System.Drawing.Point(55,189);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',20);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$TB_Output.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center;

#Note: A MaskedTextBox allows you to set the Mask attribute and control input
$MTB_Password = New-Object system.Windows.Forms.MaskedTextBox;
$MTB_Password.multiline = $false;
$MTB_Password.Mask = "00000000000000000000";
$MTB_Password.PasswordChar = "*";
$MTB_Password.TabStop = $true;
$MTB_Password.TabIndex = 0;
$MTB_Password.SelectionStart = 0;
$MTB_Password.SelectionLength = $MTB_Password.Text.Length;
$MTB_Password.width = 421;
$MTB_Password.height = 68;
$MTB_Password.location = New-Object System.Drawing.Point(79,32);
$MTB_Password.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',20);

$B_ENTER = New-Object system.Windows.Forms.Button;
$B_ENTER.text = "ENTER";
$B_ENTER.width = 386;
$B_ENTER.height = 67;
$B_ENTER.location = New-Object System.Drawing.Point(97,97);
$B_ENTER.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',20);
$B_ENTER.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_ENTER.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#d0021b");


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.controls.AddRange(@($TB_Output,$MTB_Password,$B_ENTER))


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
$B_ENTER.Add_Click({ $TB_Output.Text = $MTB_Password.Text; })


#6. Display the Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
