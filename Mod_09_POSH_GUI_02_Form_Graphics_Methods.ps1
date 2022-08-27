#Powershell GUI Forms and Components - 02 Drawing Directly Onto a Form
#Author: Carly Salali Germany
#Date: 08/04/2020

#-----------------------------------------------------------------------------------------

#GDI Graphics Mehods You Can Use to Draw Directly Onto a Form

<#
Note: To draw directly on a FORM with Graphics methods, you must:

1. Call the CreateGraphics() on the form itself:

        $GRAPH = $Form_MAIN.CreateGraphics();

2. Override your own version of the EVENT HANDLER add_paint:

            $Form_MAIN.add_paint(
            {
                 $A_Brush = New-Object Drawing.SolidBrush("PINK");
                 $GRAPH.FillEllipse($A_Brush,150,150,180,180);
            })

The vector graphics functions below must be called from insde the 
event handler when a Window Form is painted/refreshed. 
#>

#-----------------------------------------------------------------------------------------


#1. Add the Required C#, .Net, Namespace and Classes 
#-----------------------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#2. Instantiate a Form Object
#-----------------------------------------------------------------------------------------
$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize = New-Object System.Drawing.Point(350,365);
$Form_MAIN.StartPosition = "manual"; #or "CenterScreen"
$Form_MAIN.Location = New-Object System.Drawing.Size(800,300);
$Form_MAIN.text = "Carkly the Sparkly Unicorn";
$Form_MAIN.TopMost = $false;
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#bd10e0");


#3. Get a Pointer to the Form Background to Draw Graphics On 
#-----------------------------------------------------------------------------------------
$GRAPH = $Form_MAIN.CreateGraphics();


#4. OVERRIDE the Form add_paint() Event Handler
#-----------------------------------------------------------------------------------------
$Form_MAIN.add_paint(
{
           #Draw_Filled_Rectangles;
           #Draw_Empty_Rectangles;
           #Draw_Lines;
           #Draw_A_Bezier_Curve;
           #Draw_Ellipses;
           Draw_String_Message;
})




#5. Draw Some Things Directly Onto the Form
#-----------------------------------------------------------------------------------------

function Draw_A_Bezier_Curve
{
         $A_Pen = New-Object Drawing.Pen("BLACK");
         $A_Pen.Color = "RED";
         $A_Pen.Width = 10;
         $p1 = New-Object Drawing.Point(10,100);
         $p2 = New-Object Drawing.Point(100,10);
         $p3 = New-Object Drawing.Point(170,170);
         $p4 = New-Object Drawing.Point(200,100);
         $GRAPH.DrawBezier($A_Pen,$p1,$p2,$p3,$p4);
}

#-----------------------------------------------------------------------------------------

function Draw_Lines
{
         $A_Pen = New-Object Drawing.Pen("BLACK");
         $A_Pen.Color = "BLUE";
         $A_Pen.Width = 10;
         $GRAPH.DrawLine($A_Pen,50,50,300,300);
         $GRAPH.DrawLine($A_Pen,300,50,50,300);
}

#-----------------------------------------------------------------------------------------

function Draw_Ellipses
{
         $A_Brush = New-Object Drawing.SolidBrush("PINK");
         #Two Different Ways
         $RECTANGLE = New-Object Drawing.Rectangle(10,10,180,180);
         $GRAPH.FillEllipse($A_Brush, $RECTANGLE);
         $GRAPH.FillEllipse($A_Brush,150,150,180,180);
}

#-----------------------------------------------------------------------------------------

function Draw_Filled_Rectangles
{
         $A_Brush = New-Object Drawing.SolidBrush("BLACK");
         $GRAPH.FillRectangle($A_Brush,75,75,100,100);
         $GRAPH.FillRectangle($A_Brush,200,200,100,100);
}

#-----------------------------------------------------------------------------------------

function Draw_Empty_Rectangles
{
         $A_Pen = New-Object Drawing.Pen("BLACK");
         $A_Pen.Width = 10;
         $GRAPH.DrawRectangle($A_Pen,75,75,100,100);
         $GRAPH.DrawRectangle($A_Pen,200,200,100,100);
}

#-----------------------------------------------------------------------------------------

function Draw_String_Message
{
         [String] $Message = "A long, LONG time ago ... `r`n" + 
                             "In a galaxy far, FAR away ... `r`n" +
                             "It was a DARK and STORMY night ...`r`n`r`n" + 
                             "And once upon a time?`r`n" +
                             "There was a magical UNICORN!`r`n" +
                             "And she was so totally SPARKLY!`r`n`r`n" + 
                             "And all her reindeer pals?`r`n" + 
                             "They did NOT want to play with her.`r`n" +
                             "Cause she was just WAAAYYYYY `r`n" + 
                             "too sparkly for them.`r`n`r`n" + 
                             "THE END";

         $A_Font = New-Object System.Drawing.Font("Comic Sans MS", 12);
         $A_Brush = New-Object Drawing.SolidBrush("BLACK");
         $RECTANGLE = New-Object Drawing.RectangleF(40,20,300,325);
         $GRAPH.DrawString($Message,$A_Font,$A_Brush,$RECTANGLE);
}

#-----------------------------------------------------------------------------------------



#6. Display the Form
#-----------------------------------------------------------------------------------------
#Note: Using ShowDialog() locks up ISE after form closes sometimes. So trying an alternative:
# [system.windows.forms.application]::run($form)

#$Form_MAIN.ShowDialog();
[system.windows.forms.application]::run($Form_MAIN);


#$Form_MAIN.ShowDialog() | Out-Null;

