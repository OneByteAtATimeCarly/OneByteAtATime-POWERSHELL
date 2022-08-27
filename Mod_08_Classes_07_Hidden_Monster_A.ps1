
<# --------------------------------------------------------------------------------- #>

Class HiddenMonster
{
      #Constructor
      HiddenMonster()
      { 
          Write-Host("`nInstantiating a HiddenMonster object.");
      }

      #Hidden Private Protected Data Members
      hidden [String]$Name = "Static Generic Monster";
      hidden [Int]$Health = 150;
      hidden [Int]$Attack = 10;

      #Member Methods
      DisplayMonster()
      {
           Write-Host("Name: " + $this.Name);
           Write-Host("Health: " + $this.Health);
           Write-Host("ATK: " + $this.Attack);
      }

      #Public Accessor Methods to Access HIDDEN Data Members

      [String] Get_Name() { return $this.Name; }
      Set_Name([String]$x) { $this.Name = $x; }

      [Int] Get_Health() { return $this.Health; }
      Set_Health([Int]$x) { $this.Health = $x; }

      [Int] Get_Attack() { return $this.Attack; }
      Set_Attack([Int]$x) { $this.Attack = $x; }
 }

<# --------------------------------------------------------------------------------- #>

#2. Creating an Instance of a Class once you have defined it

function Create_Monster
{
         Clear;

         Write-Host("`nLet's BUILD a Monster.") -ForegroundColor Cyan;
         Write-Host("We'll access it's data members using ACCESSOR methods.") -ForegroundColor Green;
         Write-Host("This is how data members are accessed in C++ and Java.") -ForegroundColor Yellow;
         Write-Host("The member data is always PRIVATE, PROTECTED or HIDDEN.") -ForegroundColor Red;
         Write-Host("Then you code PUBLIC ACCESSOR methods to access the PRIVATE/HIDDEN data.");
         Write-Host("You can see this same GET- and SET- structure in PowerShell commandletts.") -ForegroundColor Cyan;

         $Monster = New-Object HiddenMonster;

         Write-Host("`nCalling pubic SET Accessor methods to SET private/hidden data.");
         
         $Monster.Set_Name("Bubba");
         $Monster.Set_Health(9000);
         $Monster.Set_Attack(444);

         Write-Host("`nCalling pubic GET Accessor methods to GET private/hidden data.`n");
         
         Write-Host("Name: " + $Monster.Get_Name());
         Write-Host("Health: " + $Monster.Get_Health());
         Write-Host("Attack: " + $Monster.Get_Attack());

       
         Write-Host("`n`n");
}

<# --------------------------------------------------------------------------------- #>

  
#------- Invocations -------
Create_Monster;