

Class HiddenMonster
 {
       #Constructor
       HiddenMonster()
       { 
           Write-Host("`nInstantiating a HiddenMonster object.");
       }

       #Data Members
       hidden [String]$Name = "Static Generic Monster";
       hidden [int]$Health = 150;
       hidden [int]$Attack = 10;

       #Member Methods
       DisplayMonster()
       {
            Write-Host("Name: " + $this.Name);
            Write-Host("Health: " + $this.Health);
            Write-Host("ATK: " + $this.Attack);
       }
 }

  <# --------------------------------------------------------------------------------- #>

  #2. Creating an Instance of a Class once you have defined it

  function Create_Monster2
  {
           Clear;

           Write("`nNote we can still SET and GET values of instantiated object when it IS HIDDEN.");

           $Monster = New-Object HiddenMonster;
           $Monster.Name = "Bubba";
           $Monster.Health = 9000;
           $Monster.Attack = 100;
           $Monster.DisplayMonster(); 
         
           Write("`n`nIf we call Get-Member, all hidden data members are INVISIBLE:")
           Write("Calling: Get-Member -MemberType Properties");

           $Monster | Get-Member -MemberType Properties;

           Write("`n`nBut if we use the -Force parameter with Get-Member? HIDDEN data members display:")
           Write("Calling: Get-Member -MemberType Properties -Force`n")

           $Monster | Get-Member -MemberType Properties -Force;

           Write("`nBut notice that we can SET and GET the values of an instantiated object, even when they are HIDDEN.");
  }


  Create_Monster2;

