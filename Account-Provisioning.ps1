#Title: Account-Provisioning 
#Description: Populates AD with Global Security Groups, OUs and User Accounts.
#             For 2019 CORE Server DC + Exchange Test Environment.
#Date: 08/25/2020
#Revision: 1.0
#Author: Carly S. Germany

function Batch_MLP
{
         $OU_Name = "1_MLP_Main_Chars";
         $Group_Name = "MLP-FIM-Admins";
         $DomainPath = "DC=Pegasi,DC=pony";
         $DomainName = "Pegasi.pony";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 
         
         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "Equestria";
         $Office = "Building 444";
         $Web = "http://everypony.com";
         $Company = "Ponies R US";
         
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
              
              $FirstName = ($The_Users[$x][0].Split(" "))[0];
              $LastName = ($The_Users[$x][0].Split(" "))[1];
         
              New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
                         -Path $LOCATION -City $City -Office $Office -Company $Company `
                         -HomePage $Web -OfficePhone $The_Users[$x][7] `
                         -ProfilePath ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDirectory ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDrive "Z:" `
                         -GivenName $FirstName `
                         -Surname $LastName `
                         -Name $The_Users[$x][0] `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -Enabled $true `
                         -OtherAttributes @{'msTSProperty01'="Staff";
                                            'msTSProperty02'="P@wny";
                                            'msTSManagingLS'="Alicorns";
                                            'msTSManagingLS2'="Unicorns";
                                            'msTSManagingLS3'="Pegasuses";
                                            'msTSManagingLS4'="Ponies";
                                            'employeeID'=$The_Users[$x][7]};
             
             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
         
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_BSG
{
         $OU_Name = "2_BSG_Cylon_Hybrids";
         $Group_Name = "BSG-Cylon-Human-Hybrid-Crew";
         $DomainPath = "DC=Pegasi,DC=pony";
         $DomainName = "Pegasi.pony";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "Equestria";
         $Office = "Resurrection Ship";
         $Web = "http://EveryoneIsACYLON.com";
         $Company = "The Final Five";

         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Starbuck - Kara Thrace","Kara_Thrace","Thrace","Kara.Thrace","Main protagonist","Viper Pilot","The Harbinger of Death.","10000000"),
                         ("Gaius Baltar","Gaius_Baltar","Baltar","Gaius.Baltar","Scientest","Guru","Chaotic neutral.","20000111"),
                         ("William Adama","William_Adama","CommanderAdama","William.Adama","Commander","Captains","The leader of the pack.","20000222"), 
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
              
              $FirstName = ($The_Users[$x][0].Split(" "))[0];
              $LastName = ($The_Users[$x][0].Split(" "))[1];
         
              New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
                         -Path $LOCATION -City $City -Office $Office -Company $Company `
                         -HomePage $Web -OfficePhone $The_Users[$x][7] `
                         -ProfilePath ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDirectory ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDrive "Z:" `
                         -GivenName $FirstName `
                         -Surname $LastName `
                         -Name $The_Users[$x][0] `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -Enabled $true `
                         -OtherAttributes @{'msTSProperty01'="Hybrids";
                                            'msTSProperty02'="Cylons";
                                            'msTSManagingLS'="Humans";
                                            'msTSManagingLS2'="Simulations";
                                            'msTSManagingLS3'="Rebel Factions";
                                            'msTSManagingLS4'="Colonials";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_Naruto
{
         $OU_Name = "3_Hidden_Leaf_Village";
         $Group_Name = "Hidden_Leaf_Shinobi_Ninjas";
         $DomainPath = "DC=Pegasi,DC=pony";
         $DomainName = "Pegasi.pony";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "Hidden Leaf Village";
         $Office = "S-Class Ninja Squad";
         $Web = "http://ItsMyNijaWay.com";
         $Company = "I WILL Become HoKage";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Naruto Uzumaki","Naruto_Uzumaki","Naruto","Naruto.Uzumaki","Jinchuriki","Shinobi","It's my ninja way.","30000111"),
                         ("Sakura Haruno","Sakura_Haruno","Sakura","Sakura.Haruno","Shinobi","Healing Ninjitsu","Naruto's lifelong crush and unrequitted love.","30000222"), 
                         ("Sasuke Uchiha","Sasuke_Uchiha","Sasuke","Sasuke.Uchiha","Shinobi","Sharingan Caster","The most EMO ninja ever devised.","30000333"), 
                         ("Kakashi Hatake","Kakashi_Hatake","Kakashi","Kakashi.Hatake","Sinsei","Sharingan Caster","The Copy Ninja.","30000444"), 
                         ("Jiraiya Legendary Sannin","Jiraiya_Legendary_Sannin","Jiraiya","Jiraiya.Legendary.Sannin","Ultimate Sage","Sage Warrior","Pervy Sage.","30000555"),
                         ("Lady Tsunade","Lady_Tsunade","Tsunade","Lady.Tsunade","Hokage","Master Healer","Uses the chakra fountain of youth.","30000666"),
                         ("Hinata Hyuga","Hinata_Hyuga","Hinata","Hinata.Hyuga","Shinobi","Byakugan Caster","Hopelessy in love with Naruto.","30000777"),
                         ("Gaara","Gaara","Gaara","Gaara","Jinchuriki","Shukaku One-Tailed Vessel","I feel nothing. I'm dead inside.","30000888"),
                         ("Rock Lee","Rock_Lee","Rock","Rock.Lee","Taijutsu User","Shinboi","The one and only Bushy Brow.","300001002"),
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
              
              $FirstName = ($The_Users[$x][0].Split(" "))[0];
              $LastName = ($The_Users[$x][0].Split(" "))[1];
         
              New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
                         -Path $LOCATION -City $City -Office $Office -Company $Company `
                         -HomePage $Web -OfficePhone $The_Users[$x][7] `
                         -ProfilePath ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDirectory ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDrive "Z:" `
                         -GivenName $FirstName `
                         -Surname $LastName `
                         -Name $The_Users[$x][0] `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -Enabled $true `
                         -OtherAttributes @{'msTSProperty01'="Genin";
                                            'msTSProperty02'="Chuunin";
                                            'msTSManagingLS'="Jounin";
                                            'msTSManagingLS2'="Shinobi";
                                            'msTSManagingLS3'="HoKage";
                                            'msTSManagingLS4'="S-Class";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_One_Piece
{
         $OU_Name = "4_One_Piece";
         $Group_Name = "The_Going_Merry_Crew";
         $DomainPath = "DC=Pegasi,DC=pony";
         $DomainName = "Pegasi.pony";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "The Grand Line";
         $Office = "The Going Merry";
         $Web = "http://www.StrawHatPirates.com";
         $Company = "King of the Pirates!";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Luffy MonkeyD","Luffy_MonkeyD","Luffy","Luffy.MonkeyD","Captain","PIRATE","Gum Gum fruit powers.","50000111"),
                         ("Zoro Roronoa","Zoro_Roronoa","Zoro","Zoro.Roronoa","Swordsman","PIRATE","Master bushido swordsman.","50000222"), 
                         ("Nami Akemi","Nami_Akemi","Nami","Nami.Akemi","Navigator","PIRATE","Smart navigator and GREEDY pirate.","50000333"), 
                         ("Sanji Vinsmoke","Sanji_Vinsmoke","Sanji","Sanji.Vinsmoke","Cook","PIRATE","Great cook and LEGGS.","50000444"), 
                         ("Robin Nico","Robin_Nico","Robin","Robin.Nico","Assassin","PIRATE","Death blossoms.","50000555"),
                         ("Chopper Tony","Chopper_Tony","Chopper","Chopper.Tony","Doctor","PIRATE","Reindeer CAN be docotors.","50000666"),
                         ("Usopp Yamaguchi","Usopp_Yamaguch","Usopp","Usopp.Yamaguch","Engineer","PIRATE","Liar liar pants on fire.","50000777")
                       );
         
         Write-Host("`n3. Creating Users inside OU `"" + $OU_Name + "`". Also adding them to GSG `"" + $Group_Name + "`".");
         for($x = 0; $x -LT $The_Users.Count; $x++)
         {        
              Write-Host("`n----------------------------------------------------");
              Write-Host("Creating USER " + ($x+1) + ". " + $The_Users[$x][0] + ""); 
              
              $FirstName = ($The_Users[$x][0].Split(" "))[0];
              $LastName = ($The_Users[$x][0].Split(" "))[1];
         
              New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
                         -Path $LOCATION -City $City -Office $Office -Company $Company `
                         -HomePage $Web -OfficePhone $The_Users[$x][7] `
                         -ProfilePath ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDirectory ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDrive "Z:" `
                         -GivenName $FirstName `
                         -Surname $LastName `
                         -Name $The_Users[$x][0] `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -Enabled $true `
                         -OtherAttributes @{'msTSProperty01'="Genin";
                                            'msTSProperty02'="Chuunin";
                                            'msTSManagingLS'="Jounin";
                                            'msTSManagingLS2'="Shinobi";
                                            'msTSManagingLS3'="HoKage";
                                            'msTSManagingLS4'="S-Class";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Batch_Star_Trek_TNG
{
         $OU_Name = "5_Star_Trek_TNG";
         $Group_Name = "The_Enterprise_D_Crew";
         $DomainPath = "DC=Pegasi,DC=pony";
         $DomainName = "Pegasi.pony";
         $LOCATION = "OU=" + $OU_Name + "," + $DomainPath;

         Write-Host("`n1. Creating OU `"" + $OU_Name + "`". Location = `"" + $LOCATION + "`".");
         New-ADOrganizationalUnit -Name $OU_Name -Path $DomainPath; 

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         Write-Host("`n2. Creating Global Security Group " + $OU_Name + ". Location = `"" + $LOCATION + "`".");
         New-ADGroup -Name $Group_Name -SamAccountName $Group_Name -GroupCategory Security -GroupScope Global `
                     -Path $LOCATION -DisplayName $Group_Name -Description ("Administrators for OU `"" + $OU_Name + "`".");

         Write-Host("`nWaiting 5 seconds for replication.");
         for($z = 0; $z -LT 5; $z++)
         { 
             Write-Host(" .") -NoNewline;
             Start-Sleep -s 1; 
         }

         $City = "The Alpha Quadrant";
         $Office = "The Enterprise D";
         $Web = "http://www.FederationOfPlanets.com";
         $Company = "Make It SO Number One!";
         
         $The_Users = @( #Name-DisplayName,UPN,SamAcct,Email,Title,Department,Description
                         ("Jean-Luc Picard","Jean-Luc_Picard","Picard","Jean-Luc.Picard","Starship Captain","Enterprise","Cerebral leader.","90000111"),
                         ("William T Riker","William_T_Riker","Riker","William.T.Riker","Number One","Enterprise","Delightful opportunist.","90000222"), 
                         ("Beverly Crusher","Beverly_Crusher","Crusher","Beverly.Crusher","The Doctor","Enterprise","Compassionate physician.","90000333"), 
                         ("Worf Mogh","Worf_Mogh","Worf","Worf.Mogh","Klingon Warrior","Enterprise","The bonding!","90000444"), 
                         ("DATA Soong","DATA_Soong","DATA","DATA.Soong","Artificial Life","Enterprise","Results inconcusive.","90000555"),
                         ("Deanna Troi","Deanna_Troi","Troi","Deanna.Troi","Betazoid Counselor","Enterprise","How do you FEEL?","90000666"),
                         ("Geordi LaForge","Geordi_LaForge","LaForge","Geordi.LaForge","Engineer","Enterprise","Warp core breach.","90000777")
                       );
         
         Write-Host("`n3. Creating Users inside OU `"" + $OU_Name + "`". Also adding them to GSG `"" + $Group_Name + "`".");
         for($x = 0; $x -LT $The_Users.Count; $x++)
         {        
              Write-Host("`n----------------------------------------------------");
              Write-Host("Creating USER " + ($x+1) + ". " + $The_Users[$x][0] + ""); 
              
              $FirstName = ($The_Users[$x][0].Split(" "))[0];
              $LastName = ($The_Users[$x][0].Split(" "))[1];
         
              New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
                         -Path $LOCATION -City $City -Office $Office -Company $Company `
                         -HomePage $Web -OfficePhone $The_Users[$x][7] `
                         -ProfilePath ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDirectory ("\\Pegasi-DC1\PROFILES\" + $The_Users[$x][1]) `
                         -HomeDrive "Z:" `
                         -GivenName $FirstName `
                         -Surname $LastName `
                         -Name $The_Users[$x][0] `
                         -DisplayName $The_Users[$x][0] `
                         -UserPrincipalName ($The_Users[$x][1] + "@" + $DomainName) `
                         -SamAccountName $The_Users[$x][2] `
                         -EmailAddress ($The_Users[$x][3] + "@" + $DomainName) `
                         -Title $The_Users[$x][4] `
                         -Department $The_Users[$x][5] `
                         -Description $The_Users[$x][6] `
                         -Enabled $true `
                         -OtherAttributes @{'msTSProperty01'="Genin";
                                            'msTSProperty02'="Chuunin";
                                            'msTSManagingLS'="Jounin";
                                            'msTSManagingLS2'="Shinobi";
                                            'msTSManagingLS3'="HoKage";
                                            'msTSManagingLS4'="S-Class";
                                            'employeeID'=$The_Users[$x][7]};

             Add-ADGroupMember $Group_Name -Members ( $The_Users[$x][2]);
         }
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

Batch_MLP;
Batch_BSG;
Batch_Naruto;
Batch_One_Piece;
Batch_Star_Trek_TNG;





<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

function Test_Code_for_Exchange_Schema_Additions
{
<#
Note: For user AFTER Schema extended for Exchange

                         -OtherAttributes @{'extensionAttribute1'="Staff";
                                            'extensionAttribute2'="P@wny";
                                            'extensionAttribute3'="Alicorns";
                                            'employeeID'=$The_Users[$x][7]};
#>
}

<# ------------------------------------------------------------------------------------------------------------------------------------------------------ #>

