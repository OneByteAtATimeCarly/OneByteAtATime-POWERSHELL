#Powershell GUI Forms and Components - 14 Adding Menus to a Form
#Author: Carly Salali Germany
#Date: 08/04/2020


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(390,400);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$MainMenu = New-Object System.Windows.Forms.MenuStrip;

$Menu_File = New-Object System.Windows.Forms.ToolStripMenuItem("File");
$SubMenu_Open = New-Object System.Windows.Forms.ToolStripMenuItem("Open");
$SubMenu_Save = New-Object System.Windows.Forms.ToolStripMenuItem("Save");
$SubMenu_Exit = New-Object System.Windows.Forms.ToolStripMenuItem("Exit");

$Menu_Options = New-Object System.Windows.Forms.ToolStripMenuItem("Options");
$Menu_View = New-Object System.Windows.Forms.ToolStripMenuItem("View");
$Menu_Help = New-Object System.Windows.Forms.ToolStripMenuItem("Help");
$Menu_About = New-Object System.Windows.Forms.ToolStripMenuItem("About");

$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.width = 339;
$TB_Output.height = 216;
$TB_Output.location = New-Object System.Drawing.Point(25,100);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',20);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Menu_File.DropDownItems.Add($SubMenu_Open);
$Menu_File.DropDownItems.Add($SubMenu_Save);
$Menu_File.DropDownItems.Add($SubMenu_Exit);

$MainMenu.Items.Add($Menu_File);
$MainMenu.Items.Add($Menu_Options);
$MainMenu.Items.Add($Menu_View);
$MainMenu.Items.Add($Menu_Help);
$MainMenu.Items.Add($Menu_About);

$Form_MAIN.controls.AddRange(@($MainMenu,$TB_Output));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------
$SubMenu_Open.Add_Click({ $TB_Output.Text = "`r`n  Open File."; })
$SubMenu_Save.Add_Click({ $TB_Output.Text = "`r`n  Save File."; })
$SubMenu_Exit.Add_Click({ $TB_Output.Text = "`r`n  Exit Program."; })
$Menu_Options.Add_Click({ $TB_Output.Text = "`r`n  Options!"; })
$Menu_View.Add_Click({ $TB_Output.Text = "`r`n  Changing VIEW."; })
$Menu_Help.Add_Click({ $TB_Output.Text = "`r`n  Help me!"; })
$Menu_About.Add_Click({ $TB_Output.Text = "`r`n  All about ME."; })


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;