#Powershell GUI Forms and Components - 13 Adding Panels to a Form
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
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$Form_MAIN.text = "Carly is Unicorn";
$Form_MAIN.TopMost = $false;


#3. Build the Form Components
#-----------------------------------------------------------------------------------------
$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 150
$Panel1.width                    = 300
$Panel1.location                 = New-Object System.Drawing.Point(42,25)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 150
$Panel2.width                    = 300
$Panel2.location                 = New-Object System.Drawing.Point(42,213)

$CheckBox1                       = New-Object system.Windows.Forms.CheckBox
$CheckBox1.text                  = "checkBox"
$CheckBox1.AutoSize              = $false
$CheckBox1.width                 = 95
$CheckBox1.height                = 20
$CheckBox1.location              = New-Object System.Drawing.Point(25,24)
$CheckBox1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$CheckBox2                       = New-Object system.Windows.Forms.CheckBox
$CheckBox2.text                  = "checkBox"
$CheckBox2.AutoSize              = $false
$CheckBox2.width                 = 95
$CheckBox2.height                = 20
$CheckBox2.location              = New-Object System.Drawing.Point(25,55)
$CheckBox2.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RadioButton1                    = New-Object system.Windows.Forms.RadioButton
$RadioButton1.text               = "radioButton"
$RadioButton1.AutoSize           = $true
$RadioButton1.width              = 104
$RadioButton1.height             = 20
$RadioButton1.location           = New-Object System.Drawing.Point(25,84)
$RadioButton1.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RadioButton2                    = New-Object system.Windows.Forms.RadioButton
$RadioButton2.text               = "radioButton"
$RadioButton2.AutoSize           = $true
$RadioButton2.width              = 104
$RadioButton2.height             = 20
$RadioButton2.location           = New-Object System.Drawing.Point(25,114)
$RadioButton2.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "button"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(195,20)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $true
$TextBox1.width                  = 114
$TextBox1.height                 = 64
$TextBox1.location               = New-Object System.Drawing.Point(161,68)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ComboBox1                       = New-Object system.Windows.Forms.ComboBox
$ComboBox1.text                  = "comboBox"
$ComboBox1.width                 = 241
$ComboBox1.height                = 47
$ComboBox1.location              = New-Object System.Drawing.Point(33,14)
$ComboBox1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $true
$TextBox2.width                  = 234
$TextBox2.height                 = 63
$TextBox2.location               = New-Object System.Drawing.Point(30,66)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


#4. Add the Components to the Form
#-----------------------------------------------------------------------------------------
$Panel1.controls.AddRange(@($ComboBox1,$TextBox2));
$Panel2.controls.AddRange(@($CheckBox1,$CheckBox2,$RadioButton1,$RadioButton2,$Button1,$TextBox1));
$Form_MAIN.controls.AddRange(@($Panel1,$Panel2));


#5. Code the Event Handlers
#-----------------------------------------------------------------------------------------


#6. Display Form
#-----------------------------------------------------------------------------------------
$Form_Main.ShowDialog();
#$Form_MAIN.ShowDialog() | Out-Null;