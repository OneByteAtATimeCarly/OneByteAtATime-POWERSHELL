Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

<# --------------------------------------------------------------------------------------------------- #>
#2. Create Form 

$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize  = New-Object System.Drawing.Point(390,400);
$Form_MAIN.StartPosition = "manual";
$Form_MAIN.Location = New-Object System.Drawing.Size(600,300);
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;

<# --------------------------------------------------------------------------------------------------- #>
#3. Create Form Components


$TB_Output = New-Object system.Windows.Forms.TextBox;
$TB_Output.multiline = $true;
$TB_Output.width = 339;
$TB_Output.height = 216;
$TB_Output.location = New-Object System.Drawing.Point(25,100);
$TB_Output.Font = New-Object System.Drawing.Font('Comic Sans MS',20);
$TB_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$TB_Output.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");


$MainToolStrip = New-Object System.Windows.Forms.ToolStrip;

$ToolStrip_File = New-Object System.Windows.Forms.ToolStripButton("File");

$ToolStrip_Open = New-Object System.Windows.Forms.ToolStripButton("Open");
$ToolStrip_Open.ToolTipText  = "Open this please";
#$ToolStrip_Open.Image = "";

$ToolStrip_Save = New-Object System.Windows.Forms.ToolStripButton("Save");
$ToolStrip_Options = New-Object System.Windows.Forms.ToolStripButton("Options");
$ToolStrip_Help = New-Object System.Windows.Forms.ToolStripButton("Help");
$ToolStrip_Exit = New-Object System.Windows.Forms.ToolStripButton("Exit");

$StatusStrip = New-Object System.Windows.Forms.StatusStrip;
$StatusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel;


<# --------------------------------------------------------------------------------------------------- #>
#4. Add Components to Form

$MainToolStrip.Items.Add($ToolStrip_File);
$MainToolStrip.Items.Add($ToolStrip_Open);
$MainToolStrip.Items.Add($ToolStrip_Save);
$MainToolStrip.Items.Add($ToolStrip_Options);
$MainToolStrip.Items.Add($ToolStrip_Help);
$MainToolStrip.Items.Add($ToolStrip_Exit);

$Form_MAIN.controls.AddRange(@($MainToolStrip,$TB_Output));

<# --------------------------------------------------------------------------------------------------- #>
#5. Code Event Handlers

$ToolStrip_Open.Add_Click({ $TB_Output.Text = "`r`n  Open File."; })

<# --------------------------------------------------------------------------------------------------- #>
#6. Display Form

$Form_Main.ShowDialog();

#$The_File = New-Object System.Windows.Forms.OpenFileDialog;