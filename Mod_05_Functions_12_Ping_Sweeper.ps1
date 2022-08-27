#Title: PowerShell - Module 07 - Classes - Adventure Game 2
#Author: Carly S. Germany
#Date: 06/10/2020

<# ------------------------------------------------------------------- #>

function Ping_Sweeper
{
         param($Network,$NumHostsPerSubnet);

         Clear;

         for($x = 1; $x -LT $NumHostsPerSubnet; $x++)
         {
             $HostAddress = $Network + ($x);

             Write("`n-------------------------------------------");
             Write("Host Address = " + $HostAddress);
             ping $HostAddress;
         }
}

<# ------------------------------------------------------------------- #>

#---------- Invocations ----------

#Remember: 0 = network and 255 = broadcast
Ping_Sweeper -Network "10.54.2." -NumHostsPerSubnet 255