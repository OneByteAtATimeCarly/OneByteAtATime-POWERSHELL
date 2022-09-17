#File Sharing Agenda 2 - Complex Share With TRAVERSE Folder and LIST Folder

<# ----------------------------------------------------- #>

function Connect
{
    #Set Execution Policy
    #Get-ExecutionPolicy;
    #Set-ExecutionPolicy Unrestricted -Force;

    #Remoting into Mail2019CORE-01
    Enter-PSSession Mail2019CORE-01
    #Exit-PSSession
    #$S = New-PSSession -ComputerName Mail2019CORE-01;
}

<# ----------------------------------------------------- #>

<# ------------------------------------------------------------------------------------------- #>
<# ------------------------------------------------------------------------------------------- #>

function 01_Create_Global_Security_Groups
{
         #Exit REMOTE POSH and Do this part on the CLIENT with AD access:  Exit-PSSession .
         New-ADOrganizationalUnit -Name "SHARE_GSGs_2" -Path "DC=BattleStars,DC=fleet";

         #----------------------------------------------------------------------------------------------

         New-ADGroup -Name "SHARE Research_and_Development RW" -SamAccountName SHARE_Research_and_Development_RW `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Research_and_Development RW" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Research and Development Data - Full Write and Modify Access";

         New-ADGroup -Name "SHARE Accounting RW" -SamAccountName SHARE_Accounting_RW `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Accounting RW" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Accounting Records - Full Write and Modify Access";

         Add-ADGroupMember "CN=SHARE Research_and_Development RW,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "SparkT","DashRa","ShyFlu";

         Add-ADGroupMember "CN=SHARE Accounting RW,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "SparkT","DashRa","ShyFlu";

         #----------------------------------------------------------------------------------------------

         New-ADGroup -Name "SHARE Research_and_Development RO" -SamAccountName SHARE_Research_and_Development_RO `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Research_and_Development RO" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Research and Development Data - Read-Only Access";

         New-ADGroup -Name "SHARE Accounting RO" -SamAccountName SHARE_Accounting_RO `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Accounting RO" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Accounting Records - Read-Only Access";

         Add-ADGroupMember "CN=SHARE Research_and_Development RO,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "Luffy","Zoro","Sanji";

         Add-ADGroupMember "CN=SHARE Accounting RO,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "Luffy","Zoro","Sanji";

         #----------------------------------------------------------------------------------------------

         New-ADGroup -Name "SHARE Research_and_Development ROOTONLY" -SamAccountName SHARE_Research_and_Development_ROOTONLY `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Research_and_Development ROOTONLY" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Research and Development Data - ROOT Parent Folder Only";

         New-ADGroup -Name "SHARE Accounting ROOTONLY" -SamAccountName SHARE_Accounting_ROOTONLY `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE Accounting ROOTONLY" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Accounting Records - ROOT Parent Folder Only";

         Add-ADGroupMember "CN=SHARE Research_and_Development ROOTONLY,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "Sasuke","Sakura","Naruto";

         Add-ADGroupMember "CN=SHARE Accounting ROOTONLY,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "Sasuke","Sakura","Naruto";
}

<# ------------------------------------------------------------------------------------------- #>
<# ------------------------------------------------------------------------------------------- #>

function 02_Create_Folders
{
         #Do this part in REMOTE POSH on the File Server
         New-Item -ItemType "directory" -Path "C:\Accounting" -Force;
         New-Item -ItemType "directory" -Path "C:\Accounting\Receivable" -Force;
         New-Item -ItemType "directory" -Path "C:\Accounting\Payable" -Force;

         New-Item -Path "C:\Accounting\Receivable\Payees.txt" -ItemType "File" -Force;
         Set-Content -Path "C:\Accounting\Receivable\Payees.txt" -Value "Payee budget information.";

         New-Item -ItemType "directory" -Path "C:\Research_and_Development" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\Top_Secret" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\R_And_D_DATA" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\High_Risk_High_Yield" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\Obscure_Projects" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\Interns" -Force;
         New-Item -ItemType "directory" -Path "C:\Research_and_Development\Trainees" -Force;

         New-Item -Path "C:\Research_and_Development\Top_Secret\Secret_Projects.txt" -ItemType "File" -Force;
         Set-Content -Path "C:\Research_and_Development\Top_Secret\Secret_Projects.txt" -Value "Secret project data.";

         New-Item -Path "C:\Research_and_Development\Trainees\Newbie_Manual.txt" -ItemType "File" -Force;
         Set-Content -Path "C:\Research_and_Development\Trainees\Newbie_Manual.txt" -Value "Newbie Manual.";
}

<# ------------------------------------------------------------------------------------------- #>
<# ------------------------------------------------------------------------------------------- #>

<# ------------------------------------------------------------------------------------------- #>
<# ------------------------------------------------------------------------------------------- #>

function 03_Set_NTFS_Permissions
{
         #Do this part in REMOTE POSH on the File Server :  Enter-PSSession Mail2019CORE-01  .
         #----------------------------------------------------------------------------------------------
         #Set Owner to Starbuck
         $OWNER = New-Object System.Security.Principal.NTAccount("BattleStars\Starbuck");
         $ACL1 = Get-Acl "C:\Accounting";
         $ACL2 = Get-Acl "C:\Research_and_Development";
         $ACL1.SetOwner($OWNER);
         $ACL2.SetOwner($OWNER);
         $ACL1 | Set-Acl "C:\Accounting";
         $ACL2 | Set-Acl "C:\Research_and_Development";

         (Get-Acl "C:\Accounting").Owner;
         (Get-Acl "C:\Research_and_Development").Owner;

         
   #MODIFY Access RW (Modify,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------

         #Setting WITH Inheritance
         $ACL1 = Get-Acl "C:\Accounting";
         $Permissions = 'BattleStars\SHARE_Accounting_RW','Modify,Synchronize','ContainerInherit,ObjectInherit','None','Allow';
         $AccessRule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Permissions;
         $ACL1.SetAccessRule($AccessRule1);
         $ACL1 | Set-Acl "C:\Accounting";

         $ACL2 = Get-Acl "C:\Research_and_Development";
         $Permissions = 'BattleStars\SHARE_Research_and_Development_RW','Modify,Synchronize','ContainerInherit,ObjectInherit','None','Allow';
         $AccessRule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Permissions;
         $ACL2.SetAccessRule($AccessRule1);
         $ACL2 | Set-Acl "C:\Research_and_Development";


   #Read Only RO Access (ReadAndExecute,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------

         #Setting WITH Inheritance
         $ACL1 = Get-Acl "C:\Accounting";
         $Permissions = 'BattleStars\SHARE_Accounting_RO','ReadAndExecute,Synchronize','ContainerInherit,ObjectInherit','None','Allow';
         $AccessRule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Permissions;
         $ACL1.SetAccessRule($AccessRule1);
         $ACL1 | Set-Acl "C:\Accounting";

         $ACL2 = Get-Acl "C:\Research_and_Development";
         $Permissions = 'BattleStars\SHARE_Research_and_Development_RO','ReadAndExecute,Synchronize','ContainerInherit,ObjectInherit','None','Allow';
         $AccessRule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Permissions;
         $ACL2.SetAccessRule($AccessRule1);
         $ACL2 | Set-Acl "C:\Research_and_Development";


   #Parent Folder Only Access = TRAVERSE Folder and LIST Folder (ReadData,ExecuteFile,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------

         #Setting WITHOUT Inheritance
         $ACL1 = Get-Acl "C:\Accounting";
         $AccessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule("BattleStars\SHARE_Accounting_ROOTONLY","ReadData,ExecuteFile,Synchronize","Allow");
         $ACL1.SetAccessRule($AccessRule1);
         $ACL1 | Set-Acl "C:\Accounting";

         $ACL2 = Get-Acl "C:\Research_and_Development";
         $AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("BattleStars\SHARE_Research_and_Development_ROOTONLY","ReadData,ExecuteFile,Synchronize","Allow");
         $ACL2.SetAccessRule($AccessRule2);
         $ACL2 | Set-Acl "C:\Research_and_Development";


   # Add RO Access to SUB Dirs for Parent Only Users (CreateFiles,AppendData,ReadAndExecute,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------

         #Setting WITHOUT Inheritance
         $ACL1 = Get-Acl "C:\Accounting\Receivable";
         $AccessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule("BattleStars\SHARE_Accounting_ROOTONLY","ReadAndExecute,Synchronize","Allow");
         $ACL1.SetAccessRule($AccessRule1);
         $ACL1 | Set-Acl "C:\Accounting\Receivable";

         $ACL2 = Get-Acl "C:\Research_and_Development\Interns";
         $AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("BattleStars\SHARE_Research_and_Development_ROOTONLY","ReadAndExecute,Synchronize","Allow");
         $ACL2.SetAccessRule($AccessRule2);
         $ACL2 | Set-Acl "C:\Research_and_Development\Interns";

   # Add RW Access to SUB Dirs for Parent Only Users (CreateFiles,AppendData,ReadAndExecute,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------

         #Setting WITH Inheritance
         $ACL1 = Get-Acl "C:\Research_and_Development\Trainees";
         $Permissions = 'BattleStars\SHARE_Research_and_Development_ROOTONLY','Modify,Synchronize','ContainerInherit,ObjectInherit','None','Allow';
         $AccessRule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Permissions;
         $ACL1.SetAccessRule($AccessRule1);
         $ACL1 | Set-Acl "C:\Research_and_Development\Trainees";


   # REMOVE "BUILTIN\Users" Local Group from child (CreateFiles,AppendData,ReadAndExecute,Synchronize)
   #-------------------------------------------------------------------------------------------------------------------------


         #1. Remove Inheritance
         $ACL1 = Get-Acl "C:\Accounting";
         $ACL1.SetAccessRuleProtection($true,$false);
         $ACL1 | Set-Acl "C:\Accounting";

         $ACL2 = Get-Acl "C:\Research_and_Development";
         $ACL2.SetAccessRuleProtection($true,$false);
         $ACL2 | Set-Acl "C:\Research_and_Development";

         #2. Add sub-directory permissions




   #Verify Permission ACEs on DACL
   #-------------------------------------------------------------------------------------------------------------------------

         Clear;
         Write-Host("`n--------------------------------------------------------------------------------------------");
         $Target = "C:\Accounting";
         Write-Host("Permissions for " + $Target + ":`n");
         $MESSAGE = (Get-Acl $Target).Access | select IdentityReference,FileSystemRights;

         For($x=0; $x -LT $MESSAGE.Count; $x++)
         {
              [String] $ID = ($MESSAGE[$x].IdentityReference).ToString().PadRight(45);
              [String] $RIGHTS = ($MESSAGE[$x].FileSystemRights).ToString().PadRight(45);
              [String] $ACENUM = ($x+1);
              $ACENUM = $ACENUM.PadLeft(5);
              Write-Host("    " + $ACENUM + ". ID: " + $ID + "  Rights: " + $RIGHTS + "");
         }

         Write-Host("`n--------------------------------------------------------------------------------------------");
         $Target = "C:\Research_and_Development";
         Write-Host("Permissions for " + $Target + ":`n");
         $MESSAGE = (Get-Acl $Target).Access | select IdentityReference,FileSystemRights;

         For($x=0; $x -LT $MESSAGE.Count; $x++)
         {
              [String] $ID = ($MESSAGE[$x].IdentityReference).ToString().PadRight(45);
              [String] $RIGHTS = ($MESSAGE[$x].FileSystemRights).ToString().PadRight(45);
              [String] $ACENUM = ($x+1);
              $ACENUM = $ACENUM.PadLeft(5);
              Write-Host("    " + $ACENUM + ". ID: " + $ID + "  Rights: " + $RIGHTS + "");
         }


   #Additional Access for Sub-Directory Exception Users
   #Must exit remote POSH session once again to create groups:  Exit-PSSession .
   #-------------------------------------------------------------------------------------------------------------------------

         New-ADGroup -Name "SHARE SUB R_and_D_Interns RW" -SamAccountName SHARE_R_and_D_Interns_RW `
                     -GroupCategory Security -GroupScope Global -DisplayName "SHARE SUB R&D Interns RW" `
                     -Path "OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                     -Description "Research and Development SUB Interns Folder";

         Add-ADGroupMember "CN=SHARE Research_and_Development ROOTONLY,OU=SHARE_GSGs_2,DC=BattleStars,DC=fleet" `
                            -Members "Sasuke","Sakura","Naruto";

         #Go back to REMOTE POSH now :  Enter-PSSession Mail2019CORE-01  .
         $ACL3 = Get-Acl "C:\Research_and_Development\Interns";
         $AccessRule3 = New-Object System.Security.AccessControl.FileSystemAccessRule("BattleStars\SHARE_R_and_D_Interns_RW","FullControl","Allow");
         $ACL3.SetAccessRule($AccessRule3);
         $ACL3 | Set-Acl "C:\Research_and_Development\Interns";
                
}

<# ------------------------------------------------------------------------------------------- #>
<# ------------------------------------------------------------------------------------------- #>

function 04_Set_SHAREs
{
         #-----Easiest Way Using INheritance and Combinging NTFS and SHARE Permissions-----
         New-SmbShare -Name "Accounting" -Path "C:\Accounting" -FullAccess "BattleStars\Domain Users";
         New-SmbShare -Name "Research_and_Development" -Path "C:\Research_and_Development" -FullAccess "BattleStars\Domain Users";


         #-----More Secure But More Tedious and Explicit Way-----
         New-SmbShare -Name "Accounting" -Path "C:\Accounting" -FullAccess "BattleStars\SHARE Accounting RW";
         Grant-SmbShareAccess -Name "Accounting" -AccountName "BattleStars\SHARE Accounting RO" -AccessRight Read -Force;
         Grant-SmbShareAccess -Name "Accounting" -AccountName "BattleStars\SHARE Accounting ROOTONLY" -AccessRight Read -Force;
         New-SmbShare -Name "Research_and_Development" -Path "C:\Research_and_Development" -FullAccess "BattleStars\SHARE Research_and_Development RW";
         Grant-SmbShareAccess -Name "Research_and_Development" -AccountName "BattleStars\SHARE Research_and_Development RO" -AccessRight Read -Force;
         Grant-SmbShareAccess -Name "Research_and_Development" -AccountName "BattleStars\SHARE Research_and_DevelopmentROOTONLY" -AccessRight Read -Force;
}

#Remove-SmbShare -Name "Accounting";
#Remove-SmbShare -Name "Research_and_Development";

<# ------------------------------------------------------------------------------------------- #>

function View_Permissions
{
         Clear;
         Write-Host("`n--------------------------------------------------------------------------------------------");
         $Target = "C:\Research_and_Development\Trainees";
         Write-Host("Permissions for " + $Target + ":`n");
         $MESSAGE = (Get-Acl $Target).Access | select IdentityReference,FileSystemRights;

         For($x=0; $x -LT $MESSAGE.Count; $x++)
         {
              [String] $ID = ($MESSAGE[$x].IdentityReference).ToString().PadRight(45);
              [String] $RIGHTS = ($MESSAGE[$x].FileSystemRights).ToString().PadRight(45);
              [String] $ACENUM = ($x+1);
              $ACENUM = $ACENUM.PadLeft(2);
              Write-Host("  " + $ACENUM + ". ID: " + $ID + "  Rights: " + $RIGHTS + "");
         }
}

<# ------------------------------------------------------------------------------------------- #>



#------------Invocations------------
#01_Create_Folders;
#02_Create_Global_Security_Groups;
#03_Set_NTFS_Permissions;
#04_Set_SHAREs;

#NOTE: Had to temporaryily make users memeber of "Domain Admins" to give them local sign-in privileges to sign into Win 10 WS.
