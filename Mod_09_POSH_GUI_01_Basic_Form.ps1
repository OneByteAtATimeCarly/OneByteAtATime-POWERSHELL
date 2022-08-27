#Powershell GUI Forms and Components - 01 A Basic Windows Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;


#3. Set Size of Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.ClientSize = New-Object System.Drawing.Point(350,350);


#4. Set Position of Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.StartPosition = "manual"; #or "CenterScreen"
$Form_MAIN.Location = New-Object System.Drawing.Size(800,300);


#5. Set Title Text for Top Label of Form
#-----------------------------------------------------------------------------------------
$Form_MAIN.text = "Carly the Sparkly Unicorn";
$Form_MAIN.TopMost = $false;


#6. Set Form Background Color
#-----------------------------------------------------------------------------------------
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");


#7. Display the Form
#-----------------------------------------------------------------------------------------

#Note: Using ShowDialog() locks up ISE after form closes sometimes. So trying an alternative:
# [system.windows.forms.application]::run($form)

#$Form_MAIN.ShowDialog();
[system.windows.forms.application]::run($Form_MAIN);