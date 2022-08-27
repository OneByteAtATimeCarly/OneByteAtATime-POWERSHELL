#Powershell GUI Forms and Components - 03 Adding Components to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize = New-Object System.Drawing.Point(630,248);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.text = "Carkly is Sparkly Unicorn!";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$TB_Input = New-Object system.Windows.Forms.TextBox;
$TB_Input.multiline = $true;
$TB_Input.text = "INPUT";
$TB_Input.width = 392;
$TB_Input.height = 40;
$TB_Input.location = New-Object System.Drawing.Point(109,35);
$TB_Input.Font  = New-Object System.Drawing.Font('Callibri',10);

$B_ENTER = New-Object system.Windows.Forms.Button;
$B_ENTER.text = "ENTER";
$B_ENTER.width = 60;
$B_ENTER.height = 30;
$B_ENTER.location = New-Object System.Drawing.Point(273,83);
$B_ENTER.Font = New-Object System.Drawing.Font('Callibri',10);

$L_Name = New-Object system.Windows.Forms.Label;
$L_Name.text = "Name:";
$L_Name.AutoSize = $true;
$L_Name.width = 25;
$L_Name.height = 10;
$L_Name.location = New-Object System.Drawing.Point(216,153);
$L_Name.Font = New-Object System.Drawing.Font('Callibri',10);

$L_Name_Output = New-Object system.Windows.Forms.Label;
$L_Name_Output.AutoSize = $true;
$L_Name_Output.width = 75;
$L_Name_Output.height = 10;
$L_Name_Output.location = New-Object System.Drawing.Point(268,144);
$L_Name_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',16);


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.controls.AddRange(@($TB_Input,$B_ENTER,$L_Name,$L_Name_Output));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
$B_ENTER.Add_Click({ $L_Name_Output.Text = $TB_Input.text;  })


#6. Display the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;

