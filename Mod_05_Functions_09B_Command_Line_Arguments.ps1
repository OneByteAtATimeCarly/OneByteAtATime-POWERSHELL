#Demonstratingbuilt-in argument array $args

Write("`nInside script 1.");

Write("`nA total of " + $($args.count) + " arguments were passed to this function.`n");

for($x = 0; $x -LT $args.count; $x++ ) 
{
    Write("Argument " + $x + " is " + $($args[$x]) + "");
}


#EXAMPLE 1 
#CD to D:\Carly_Powershell\Module_05_Functions.
#Run: .\Script1 super cala frajal istic expi ala docious

 