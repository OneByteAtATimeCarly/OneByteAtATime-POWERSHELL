







function Test_Code
{

         New-ADOrganizationalUnit -Name "BSG Crew" -Path "DC=SkiNet,DC=ai" -ProtectedFromAccidentalDeletion $true;
         #New-ADOrganizationalUnit -Name "MLP Crew" -Path "DC=SkiNet,DC=ai" -OtherAttributes @{seeAlso="CN=MLP-Admins,OU=Groups,OU=Managed,DC=Fabrikam,DC=com";managedBy="CN=TomC,DC=FABRIKAM,DC=COM"}



         New-ADOrganizationalUnit -Name "Test OU" -Path "DC=daytonastate,DC=edu" -ProtectedFromAccidentalDeletion $true;

}


<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_MLP
{
         $OU_Name = "MLP_Main_Chars";
         $Group_Name = "MLP-FIM-Admins";
         $DomainPath = "DC=SkyNet,DC=edu";
         $DomainName = "SkyNet.ai";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

          $City = "Equestria";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Twilight Sparkle","twilight_sparkle","SparkT","Twilight.Sparkle","Chief Magician","Unicorns","Understudy to Princess C.","10000444"),
                         ("Rainbow Dash","rainbow_dash","DashRa","Rainbow.Dash","Weather Manager","Ponies","Outgoing overachiever.","10000777"),
                         ("Fluttershy","flutter_shy","ShyFlu","Flutter.Shy","Animal Caregiver","Ponies","Kind animal lover","10000777"), 
                         ("Apple Jack","apple_jack","AppleJ","Apple.Jack","Argiculture Engineer","Ponies","Texas cowgirl","10000777"), 
                         ("Pinkie Pie","pinkie_pie","PiePin","Pinkie.Pie","Festivities Planner","Ponies","Party animal.","10000333"), 
                         ("Rarity","rarity","Rarity","Rarity","Chief Set Designer","Ponies","Fashionista.","10000222")
                       );
         
         Write-Host("`n3. Creating Users inside OU `"" + $OU_Name + "`". Also adding them to GSG `"" + $Group_Name + "`".");
         for($x = 0; $x -LT $The_Users.Count; $x++)
         {        
              Write-Host("`n----------------------------------------------------");
              Write-Host("Creating USER " + ($x+1) + ". " + $The_Users[$x][0] + ""); 
              
              New-ADUser -Path $LOCATION -City $City `
                         -Name ($The_Users[$x][0]) `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -OtherAttributes @{'extensionAttribute1'="Staff";
                                            'extensionAttribute2'="P@wny";
                                            'extensionAttribute3'="Alicorns";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_BSG
{
         $OU_Name = "BSG_Cylon_Hybrids";
         $Group_Name = "BSG-Cylon-Hybrids";
         $DomainPath = "DC=SkyNet,DC=edu";
         $DomainName = "SkyNet.ai";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "Galactica";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Starbuck Kara Thrace","Kara_Thrace","Starbuck","Kara.Thrace","Main protagonist","Viper Pilot","The Harbinger of Death.","10000000"),
                         ("Gaius Baltar","Gaius_Baltar","Baltar","Gaius.Baltar","Scientest","Guru","Chaotic neutral.","20000111"),
                         ("William Adama","William_Adama","Adama","William.Adama","Commander","Captains","The leader of the pack.","20000222"), 
                         ("Lee Adama","Lee_Adama","Lee","Lee.Adama","Captain of Pegasus","Commander","Adama's wayward son Apollo.","20000333"), 
                         ("Boomer Sharon Valerii","Sharon_Valerii","Boomer","Sharon.Valerii","Viper Pilot","Cylons","Mother of Hybrids.","20000444"), 
                         ("Laura Roslin","Laura_Roslin","Roslin","Laura.Roslin","President","Humans","Adama's soulmate.","20000555"),
                         ("Number Six","Number_Six","Six","Number.Six","Leader of rebel Cylons","Cylons","A lover, not a fighter.","20000666"),
                         ("Saul Tigh","Saul_Tigh","Tigh","Saul.Tigh","Adama's Number Two","Final Five","Self-hating cylon.","20000777"),
                         ("Samuel Anders","Samuel_Anders","Sam","Samuel.Anders","Hybrid Warrior Poet","Final Five","Too good for this universe.","20000888"),
                         ("Tory Foster","Tory_Foster","Tory","Tory.Foster","Cheater and Liar","Final Five","Stabber of backs.","200001002"),
                         ("Galen Tyrol","Galen_Tyrol","Galen","Galen.Tyrol","Mechanical Engineer","Final Five","You break it? He'll fix it","200001003"),
                         ("Ellen Tigh","Ellen_Tigh","Ellen","Ellen.Tigh","Wife of Saul Tigh","Final Five","Raging alcoholic lush.","200001004"),
                         ("Leoben Conoy","Leoben_Conoy","Leoben","Leoben.Conoy","Cylon Mind Bender","Ponies","Tormenter of Starbucks.","20000999"),
                         ("John Cavil","John_Cavil","Cavil","John.Cavil","Villian in chief","EVIL Cylons","The most EVIL model of cylon ever devised.","200001001")
                       );
         
         Write-Host("`n3. Creating Users inside OU `"" + $OU_Name + "`". Also adding them to GSG `"" + $Group_Name + "`".");
         for($x = 0; $x -LT $The_Users.Count; $x++)
         {        
              Write-Host("`n----------------------------------------------------");
              Write-Host("Creating USER " + ($x+1) + ". " + $The_Users[$x][0] + ""); 
              
              New-ADUser -Path $LOCATION -City $City `
                         -Name ($The_Users[$x][0]) `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -OtherAttributes @{'extensionAttribute1'="Hybrids";
                                            'extensionAttribute2'="Cylons";
                                            'extensionAttribute3'="Simulations";
                                            'extensionAttribute4'="Humans";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_Naruto
{
         $OU_Name = "Hidden_Leaf_Village";
         $Group_Name = "Hidden_Leaf_Shinobi";
         $DomainPath = "DC=SkyNet,DC=edu";
         $DomainName = "SkyNet.ai";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(".") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "Hidden Leaf Village";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Naruto Uzumaki","Naruto_Uzumaki","Naruto","Naruto.Uzumaki","Jinchuriki","Shinobi","It's my ninja way.","30000111"),
                         ("Sakura Haruno","Sakura_Haruno","Sakura","Sakura.Haruno","Shinobi","Healing Ninjitsu","Naruto's lifelong crush and unrequitted love.","30000222"), 
                         ("Sasuke Uchiha","Sasuke_Uchiha","Sasuke","Sasuke.Uchiha","Shinobi","Sharingan Caster","The most EMO ninja ever devised.","30000333"), 
                         ("Kakashi Hatake","Kakashi_Hatake","Kakashi","Kakashi.Hatake","Sinsei","Sharingan Caster","The Copy Ninja.","30000444"), 
                         ("Jiraiya Legendary Sannin","Jiraiya_Legendary_Sannin","Jiraiya","Jiraiya.Legendary.Sannin","Ultimate Sage","Sage Warrior","Pervy Sage.","30000555"),
                         ("Lady Tsunade","Lady_Tsunade","Tsunade","Lady.Tsunade","Hokage","Master Healer","Uses the chakra fountain of youth.","30000666"),
                         ("Hinata Hyuga","Hinata_Hyuga","Hinata","Hinata.Hyuga","Shinobi","Byakugan Caster","Hopelessy in love with Naruto.","30000777"),
                         ("Gaara","Gaara","Gaara","Gaara","Jinchuriki","Shukaku One-Tailed Vessel","I feel nothing. I'm dead inside.","30000888"),
                         ("Rock Lee","Rock_Lee","Lee","Rock.Lee","Taijutsu User","Shinboi","The one and only Bushy Brow.","300001002"),
                         ("Shikamaru Nara","Shikamaru_Nara","Shikamaru","Shikamaru.Nara","Shadow Jitsu Caster","Shinobi","Under-confidant.","300001003"),
                         ("Kurama Nine Tails","Kurama_Nine_Tails","Kuruma","Kurama.Nine.Tails","Fox Demon","The Nine-tailed Fox","Needs SERIOUS anger management.","300001004"),
                         ("Kabuto Yakushi","Kabuto_Yakushi","Kabuto","Kabuto.Yakushi","Orochimaru Henchman","Minion","So in love with Orochimaru.","30000999"),
                         ("Orochimaru Sannin","Orochimaru_Sannin","Orochimaru","Orochimaru.Sannin","Villian in chief","EVIL Anti-Hokage","A snake in the grass.","300001001")
                       );
         
         Write-Host("`n3. Creating Users inside OU `"" + $OU_Name + "`". Also adding them to GSG `"" + $Group_Name + "`".");
         for($x = 0; $x -LT $The_Users.Count; $x++)
         {        
              Write-Host("`n----------------------------------------------------");
              Write-Host("Creating USER " + ($x+1) + ". " + $The_Users[$x][0] + ""); 
              
              New-ADUser -Path $LOCATION -City $City `
                         -Name ($The_Users[$x][0]) `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -OtherAttributes @{'extensionAttribute1'="Hybrids";
                                            'extensionAttribute2'="Cylons";
                                            'extensionAttribute3'="Simulations";
                                            'extensionAttribute4'="Humans";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>


#Batch_MLP;
#Batch_BSG;
#Batch_Naruto;
Batch_Star_Trek;
Batch_One_Piece;
Batch_Star_Wars;