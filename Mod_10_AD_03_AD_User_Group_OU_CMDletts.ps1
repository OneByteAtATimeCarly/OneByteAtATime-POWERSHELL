#Active Directory User, Group and OU Commandletts

function Connect_To_AD
{
         #1. On Each Domain Controller
         winrm quickconfig
         Enable-PSRemoting


         #2. On each Client You Will REMOTE POSH From
         Set-ExecutionPolicy Unrestricted

         $AD_Session = New-PSSession -ComputerName "Galactica" -Credential (Get-Credential)
         Invoke-Command $AD_Session -Scriptblock { Import-Module ActiveDirectory }
         Import-PSSession -Session $AD_Session -module ActiveDirectory

         #To Test Connectivity
         Get-ADDomainController -Filter * | Select-Object name;
         Get-ADUser -Filter *
}


<# ************************************************************************************************** #>
<# ************************************************************************************************** #>

#A. OUs

#1. Create OUs
#New-ADOrganizationalUnit -Name "Rebel_Forces_Parent" -Path "DC=BattleStars,DC=fleet";
#New-ADOrganizationalUnit -Name "Rebel_Forces_Child" -Path "OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet";
#New-ADOrganizationalUnit -Name "Empire_Forces_Parent" -Path "DC=BattleStars,DC=fleet";
#New-ADOrganizationalUnit -Name "Empire_Forces_Child" -Path "OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet";
#New-ADOrganizationalUnit -Name "Sith_Lords" -Path "DC=BattleStars,DC=fleet";
#New-ADOrganizationalUnit -Name "DELETE THIS OU" -Path "DC=BattleStars,DC=fleet";


#2. SET OUs
#Set-ADOrganizationalUnit -Identity "OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet" -Description "Contains members of Rebel force against Emperor Palpatine's evil empire." 
#Set-ADOrganizationalUnit -Identity "OU=Rebel_Forces_Child,OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet" -Description "Contains members of Rebel force against Emperor Palpatine's evil empire." 
#Set-ADOrganizationalUnit -Identity "OU=Sith_LOrds,DC=BattleStars,DC=fleet" -Description "Dark Sith Lords";

#3. GET OUs
#Get-ADOrganizationalUnit -Filter * | select Name;
#Get-ADOrganizationalUnit -Identity "OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet";

#4. Move OUs (Note: 1st you must REMOVE ProtectedFromAccidentalDeletion on OU to move it)
#Set-ADOrganizationalUnit -Identity "OU=Sith_LOrds,DC=BattleStars,DC=fleet" -ProtectedFromAccidentalDeletion:$false;
#Move-ADObject -Identity "OU=Sith_Lords,DC=BattleStars,DC=fleet" -targetpath "OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet";

#5. Delete an OU (Note: 1st you must REMOVE ProtectedFromAccidentalDeletion on OU to move it)
Set-ADOrganizationalUnit -Identity "OU=DELETE THIS OU,DC=BattleStars,DC=fleet" -ProtectedFromAccidentalDeletion:$false;
Remove-ADOrganizationalUnit "OU=DELETE THIS OU,DC=BattleStars,DC=fleet" -Confirm:$false;

<# -------------------------------------------------------------------------------------------------- #>

function Get_OUs_By_CN
{
         
         Get-ADOrganizationalUnit  -Properties CanonicalName -Filter *| 
         Sort-Object CanonicalName | 
         Format-Table CanonicalName, DistinguishedName         
}

<# -------------------------------------------------------------------------------------------------- #>

function Get_OUs_With_User_Count
{
         Get-ADOrganizationalUnit  -Properties CanonicalName -Filter *| 
         Sort-Object CanonicalName |
         ForEach-Object `
         {
            [pscustomobject]`
            @{
                Name = Split-Path $_.CanonicalName -Leaf;
                CanonicalName = $_.CanonicalName;
                UserCount = (Get-AdUser -Filter * -SearchBase $_.DistinguishedName -SearchScope OneLevel).Count;
             }
         }
}

<# -------------------------------------------------------------------------------------------------- #>

#Invocations
#Get_OUs_By_CN;
#Get_OUs_With_User_Count;

<# ************************************************************************************************** #>
<# ************************************************************************************************** #>

#B. GROUPs

#1. Create GROUPs
#New-ADGroup -Name "DELETE ME" -SamAccountName DELETEME -GroupCategory Security -GroupScope Global -DisplayName "DELETE ME" -Path "CN=Users,DC=BattleStars,DC=fleet" -Description "DELETE Me.";
#New-ADGroup -Name "Test GSG" -SamAccountName TestGSG -GroupCategory Security -GroupScope Global -DisplayName "Test GSG" -Path "CN=Users,DC=BattleStars,DC=fleet" -Description "GSG for Testing";
#New-ADGroup -Name "Evil Empire Admins" -SamAccountName EvilEmpireAdmins -GroupCategory Security -GroupScope Global -DisplayName "Evil Empire Administrators" -Path "OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -Description "Emperor Palpatine's Evil Administrators";

#2. SET GROUPs
#Set-ADGroup -Identity "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet" -Description "Testing 1... 2... 3...";
#Set-ADGroup -Identity "CN=Evil Empire Admins,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -DisplayName "Emperor's Evil Administrators";
#Set-ADGroup -Identity "CN=Evil Empire Admins,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -ManagedBy "Luffy";
#Set-ADGroup -Identity "CN=Evil Empire Admins,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -Description "Emperor Palpatine's Evil Admins";

#3. GET GROUPs (Uses LDAP locations)
#Get-ADGroup -Identity "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet";
#Get-ADGroup -Identity "CN=Evil Empire Admins,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -Properties * | FL;

#4. Move GROUPs (Note: 1st you must REMOVE ProtectedFromAccidentalDeletion on OU to move it)
#Move-ADObject -Identity "CN=Evil Empire Admins,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -targetpath "OU=Empire_Forces_Child,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet";

#5. Add Members to a group
#Add-ADGroupMember "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet" -Members "AppleJ";
#Add-ADGroupMember "CN=Evil Empire Admins,OU=Empire_Forces_Child,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -Members "PiePin";
#Add-ADGroupMember "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet" -Members ( Get-ADUser -Filter { UserPrincipalName -like "rainbow_dash@battlestars.fleet" } );

#6. Remove Members from GROUP
#Remove-ADGroupMember "CN=Evil Empire Admins,OU=Empire_Forces_Child,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -Members "PiePin" -Confirm:$false
#Remove-ADGroupMember "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet" -Members "AppleJ" -Confirm:$false
#Remove-ADGroupMember "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet" -Members "DashRa" -Confirm:$false

#7. Delete a GROUP
#Remove-ADGroup "CN=DELETE ME,CN=Users,DC=BattleStars,DC=fleet" -Confirm:$false;

#Get Members of a Group
Get-ADGroupMember -Identity "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet"

<# -------------------------------------------------------------------------------------------------- #>

function Get_Group_Members
{         $The_Group = "CN=Test GSG,CN=Users,DC=BattleStars,DC=fleet";         Write-Host("`n-----------------------------------------------------------`n");         Write-Host("Group name: " + $The_Group + ".");         $GRP = Get-ADGroup $The_Group -Properties ManagedBy;         $MANAGER = $GRP.ManagedBy;         if($MANAGER -EQ "") { $MANAGER = "NoBody"; }         Write-Host("Group managed by: " + $MANAGER);                  $MEMBERS = Get-ADGroupMember $The_Group;         Write-Host("`nMembers:");         for($z = 0; $z -LT $MEMBERS.Count; $z++)         {             Write-Host("" + ($z+1) + ". " + $MEMBERS[$z].Name);         }         Write-Host("`n-----------------------------------------------------------`n");
}

<# -------------------------------------------------------------------------------------------------- #>

#Get_Group_Members;

<# ************************************************************************************************** #>
<# ************************************************************************************************** #>
#C. USERs


#1. Create USERs
#New-ADUser -Name "Emperor Palpatine" -Path "OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet";
#New-ADUser -Name "Luke Skywalker" -Path "OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet";

<#
New-ADUser -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
           -Path "OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" `
           -City "The Death Star" `
           -Office "Vader's Quarters" `
           -Company "The Empire" `
           -HomePage "http://www.PowerOfTheDarkSide.evil" `
           -OfficePhone "666-666-6660" `
           -ProfilePath ("\\Galactica\PROFILES\" + "Anakin_Skywalker\Profile") `
           -HomeDirectory ("\\Galactica\PROFILES\" + "Anakin_Skywalker\Home") `
           -HomeDrive "Z:" `
           -GivenName "Anakin" `
           -Surname "Skywalker" `
           -Name "Darth_Vader" `
           -DisplayName "Anakin Skywalker" `
           -UserPrincipalName "anakin_skywalker@battlestars.fleet" `
           -SamAccountName "Darth_Vader" `
           -EmailAddress "Anakin.Skywalker.Vader@battlestars.fleet" `
           -Title "Sith Apprentice" `
           -Department "Sith Lords" `
           -Description "Primary understudy to Emperor Palpatine." `
           -Manager "AppleJ" `
           -OtherAttributes @{'msTSProperty01'="SithLord";
                              'msTSProperty02'="ForceUser";
                              'msTSManagingLS'="EmpireCitizen";
                              'msTSManagingLS2'="Commander";
                              'msTSManagingLS3'="TieFighterPilot";
                              'msTSManagingLS4'="TraitorToJedis";
                              'employeeID'="666"};
#>

#2. SET USERs
#Set-ADUser -Identity "Darth_Vader" -Description "New Sith Master (killed Emperor Palpatine)";
#Set-ADUser -Identity "SparkT" -Title "Alicorn Princess";
#Set-ADUser -Identity "SparkT" -Description "Celestia's right-hand woman.";
#Set-ADUser -Identity "SparkT" -HomePage "http://www.UnicornSparkles.good"

#3. GET USERs
#Get-ADUser Darth_Vader;
#Get-ADUser Darth_Vader -Properties *;
#Get-ADUser -Filter { UserPrincipalName -LIKE "rainbow_dash@battlestars.fleet" };
#Get-ADUser -Filter { EmployeeID -LIKE "10000444" };
#Get-ADUser -Filter { Name -LIKE "Twilight Sparkle" };

#4. Move USERs
#Move-ADObject -Identity "CN=Darth_Vader,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet" -targetpath "OU=Empire_Forces_Child,OU=Empire_Forces_Parent,DC=BattleStars,DC=fleet";

#5. Delete USERs 
#Remove-ADUser "CN=Luke Skywalker,OU=Rebel_Forces_Parent,DC=BattleStars,DC=fleet" -Confirm:$false;

#6. Change USER's Password
#Set-ADAccountPassword -Identity "SparkT";
#Set-ADAccountPassword -Identity "SparkT"  -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Sup3rC@l@Fr@j@l1st1c" -Force);
#Set-ADAccountPassword -Identity "SparkT"  -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd" -Force);



