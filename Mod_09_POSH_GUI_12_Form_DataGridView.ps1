#Powershell GUI Forms and Components - 12 Adding a DataGridView to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(390,400);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$DataGridView1 = New-Object system.Windows.Forms.DataGridView;
$DataGridView1.width = 300;
$DataGridView1.height = 250;
$DataGridView1.location = New-Object System.Drawing.Point(51,116);


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.controls.AddRange(@($DataGridView1));

#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;
