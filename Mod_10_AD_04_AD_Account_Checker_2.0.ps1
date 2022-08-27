#Title: AD User Checker 1.0
#Author: Carly Salali Germany
#Version: 2.0 (GUI)
#Date Created : 08/07/2020
#Last Modified: 08/07/2020
#Description: Check AD User stats and alert to space in UPN or missing attributes or field data.

$Global:All_Users = $null;
$Global:User_Number = 0;

#---------------------------------------------------------------------------------------------

function RouteDisplayData
{
         $The_User = $null;

         if($T_Input_UPN.text -NE "") 
         {  
            $Criteria = $T_Input_UPN.text;
            $The_User = Get-ADUser -Filter { UserPrincipalName -like $Criteria } -Properties *; 

            for($x = 0; $x -LT $Global:All_Users.Count; $x++)
            {
                if($Global:All_Users[$x].UserPrincipalName -EQ $Criteria)
                {
                    $Global:User_Number = $x;
                    $L_Record_Number_Output.Text = ($Global:User_Number+1);
                }
            } 
         }  
         elseif($T_Input_SAM.text  -NE "") 
         { 
            $Criteria = $T_Input_SAM.text;
            $The_User = Get-ADUser -Filter { SamAccountName -like $Criteria } -Properties *;
            
            for($x = 0; $x -LT $Global:All_Users.Count; $x++)
            {
                if($Global:All_Users[$x].SamAccountName -EQ $Criteria)
                {
                    $Global:User_Number = $x;
                    $L_Record_Number_Output.Text = ($Global:User_Number+1);
                }
            }  
         }  
         elseif($T_Input_Email.text -NE "") 
         { 
             $Criteria = $T_Input_Email.text;
             $The_User = Get-ADUser -Filter { EmailAddress -like $Criteria } -Properties *;
             
             for($x = 0; $x -LT $Global:All_Users.Count; $x++)
             {
                if($Global:All_Users[$x].EmailAddress -EQ $Criteria)
                {
                    $Global:User_Number = $x;
                    $L_Record_Number_Output.Text = ($Global:User_Number+1);
                }
             }  
         } 
         elseif($T_Input_EmpID.text -NE "") 
         { 
             $Criteria = $T_Input_EmpID.text;
             $The_User = Get-ADUser -Filter { employeeID -like $Criteria } -Properties *; 

             for($x = 0; $x -LT $Global:All_Users.Count; $x++)
             {
                if($Global:All_Users[$x].employeeID -EQ $Criteria)
                {
                    $Global:User_Number = $x;
                    $L_Record_Number_Output.Text = ($Global:User_Number+1);
                }
             }
         }
         
         if($The_User -EQ $null)
         {
             $MESSAGE = "`r`nUnable to find that account.";
             $T_Group_Membership.Text = $MESSAGE;
             $T_Member_Of.Text = $MESSAGE;
         }
         else
         { Check_User -User_Object $The_User; }  

         $T_Input_SAM.Text = "";
}

#---------------------------------------------------------------------------------------------

function Check_User($User_Object)
{
         #Identity_Details
         $L_Output_UPN.Text = $User_Object.UserPrincipalName;
         $L_Output_SAM.Text = $User_Object.SamAccountName;
         $L_Output_EmpID.Text = $User_Object.EmployeeID;
         $L_Output_DisplayName.Text = $User_Object.Name;
         $L_Output_Email.Text = $User_Object.EmailAddress;
         $L_Output_Alias.Text = $User_Object.SamAccountName; #$User_Object.mailnickname;
         $L_Output_Enabled.Text = $User_Object.Enabled;
         $L_Output_First.Text = $User_Object.GivenName;
         $L_Output_Last.Text = $User_Object.Surname;
         $L_Output_GUID.Text = $User_Object.ObjectGUID;
         $L_Output_SID.Text = $User_Object.SID;

         #Account Details
         $L_Output_Account_Locked.Text = $User_Object.LockedOut;
         $L_Output_Account_Created.Text = $User_Object.whenCreated;
         $L_Output_Account_Changed.Text = $User_Object.whenChanged;

         if($User_Object.AccountExpirationDate -EQ $null)
         { $L_Output_Account_Expires.Text = "NEVER"; }
         else
         { $L_Output_Account_Expires.Text = $User_Object.AccountExpirationDate; }
         
         
         $L_Output_Password_Changed.Text = $User_Object.PasswordLastSet;
         $L_Output_Password_Expired.Text = $User_Object.PasswordExpired;
         $L_Output_Password_Not_Required.Text = $User_Object.PasswordNotRequired;
         $L_Output_Password_Never_Expires.Text = $User_Object.PasswordNeverExpires;

         #Attribute Details
         $L_Output_Attribute_1.Text = $User_Object.msTSProperty01;
         $L_Output_Attribute_5.Text = $User_Object.msTSProperty02;
         $L_Output_Attribute_6.Text = $User_Object.msTSManagingLS;
         $L_Output_Attribute_7.Text = $User_Object.msTSManagingLS2;
         $L_Output_Attribute_8.Text = $User_Object.msTSManagingLS3;
         $L_Output_Attribute_9.Text = $User_Object.msTSManagingLS4;
         $L_Output_Attribute_10.Text = "Future Use"; #$User_Object.extensionAttribute10;
         $L_Output_Attribute_11.Text = "Future Use"; #$User_Object.extensionAttribute11;
         $L_Output_Attribute_12.Text = "Future Use"; #$User_Object.extensionAttribute12;

         #Organization Details
         $L_Output_Company.Text = $User_Object.Company;
         $L_Output_Department.Text = $User_Object.Department;
         $L_Output_Job_Title.Text = $User_Object.Title;

         $Supervisor = $User_Object.Manager -split(",");
         $Supervisor = $Supervisor -replace("CN=","");
         $L_Output_Supervisor.Text = $Supervisor[0];

         #Location_Details
         $L_Output_LDAP_Location.Text = $User_Object.DistinguishedName;
         $L_Output_Home_Directory.Text = $User_Object.HomeDirectory;
         $L_Output_Mapped_To.Text = $User_Object.HomeDrive;

         #Group Membership
         $T_Group_Membership.Text = $User_Object.managedObjects;

         #Member Of
         $T_Member_Of.Text = $User_Object.MemberOf;
}

#---------------------------------------------------------------------------------------------

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form_MAIN = New-Object system.Windows.Forms.Form;
$Form_MAIN.ClientSize = New-Object System.Drawing.Point(1060,775);
$Form_MAIN.text = "Active Directory Account Checker - Carly Salali Germany ©2020";
$Form_MAIN.TopMost = $false;
$Form_MAIN.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");

$L_Title = New-Object system.Windows.Forms.Label;
$L_Title.text = "Active Directory Account Checker";
$L_Title.AutoSize = $true;
$L_Title.width = 25;
$L_Title.height = 5;
$L_Title.location = New-Object System.Drawing.Point(430,12);
$L_Title.Font = New-Object System.Drawing.Font('Calibri',14);
$L_Title.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Num_AD_Accts = New-Object system.Windows.Forms.Label;
$L_Num_AD_Accts.text = "Number of Accounts in AD:";
$L_Num_AD_Accts.AutoSize = $true;
$L_Num_AD_Accts.width = 25;
$L_Num_AD_Accts.height = 5;
$L_Num_AD_Accts.location = New-Object System.Drawing.Point(770,15);
$L_Num_AD_Accts.Font = New-Object System.Drawing.Font('Calibri',12);
$L_Num_AD_Accts.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Num_AD_Accts_Output = New-Object system.Windows.Forms.Label;
$L_Num_AD_Accts_Output.text = "0000";
$L_Num_AD_Accts_Output.AutoSize = $true;
$L_Num_AD_Accts_Output.width = 25;
$L_Num_AD_Accts_Output.height = 5;
$L_Num_AD_Accts_Output.location = New-Object System.Drawing.Point(953,15);
$L_Num_AD_Accts_Output.Font = New-Object System.Drawing.Font('Calibri',12);
$L_Num_AD_Accts_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFA500");


#---------------------------------------------------------------------------------------------

$GB_Input = New-Object system.Windows.Forms.Groupbox;
$GB_Input.height = 182;
$GB_Input.width = 378;
$GB_Input.location = New-Object System.Drawing.Point(7,12);
$GB_Input.Font = New-Object System.Drawing.Font('Calibri',12);
$GB_Input.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Input = New-Object system.Windows.Forms.Label;
$L_Input.text = "Input";
$L_Input.AutoSize = $true;
$L_Input.width = 25;
$L_Input.height = 10;
$L_Input.location = New-Object System.Drawing.Point(176,14);

$L_Input_UPN = New-Object system.Windows.Forms.Label;
$L_Input_UPN.text = "UPN:";
$L_Input_UPN.AutoSize = $true;
$L_Input_UPN.width = 25;
$L_Input_UPN.height = 10;
$L_Input_UPN.location = New-Object System.Drawing.Point(18,50);

$L_Input_SAM = New-Object system.Windows.Forms.Label;
$L_Input_SAM.text = "SAM:";
$L_Input_SAM.AutoSize = $true;
$L_Input_SAM.width = 25;
$L_Input_SAM.height = 10;
$L_Input_SAM.location = New-Object System.Drawing.Point(17,81);

$L_Input_Email = New-Object system.Windows.Forms.Label;
$L_Input_Email.text = "Email:";
$L_Input_Email.AutoSize = $true;
$L_Input_Email.width = 25;
$L_Input_Email.height = 10;
$L_Input_Email.location = New-Object System.Drawing.Point(18,114);

$L_Input_EmpID = New-Object system.Windows.Forms.Label;
$L_Input_EmpID.text = "EmpID:";
$L_Input_EmpID.AutoSize = $true;
$L_Input_EmpID.width = 25;
$L_Input_EmpID.height = 10;
$L_Input_EmpID.location = New-Object System.Drawing.Point(18,149);

$T_Input_UPN = New-Object system.Windows.Forms.TextBox;
$T_Input_UPN.multiline = $false;
$T_Input_UPN.width = 279;
$T_Input_UPN.height = 20;
$T_Input_UPN.location = New-Object System.Drawing.Point(79,45);

$T_Input_SAM = New-Object system.Windows.Forms.TextBox;
$T_Input_SAM.multiline = $false;
$T_Input_SAM.width = 277;
$T_Input_SAM.height = 20;
$T_Input_SAM.location = New-Object System.Drawing.Point(80,76);

$T_Input_Email  = New-Object system.Windows.Forms.TextBox;
$T_Input_Email.multiline = $false;
$T_Input_Email.width = 276;
$T_Input_Email.height = 20;
$T_Input_Email.location = New-Object System.Drawing.Point(79,108);

$T_Input_EmpID  = New-Object system.Windows.Forms.TextBox;
$T_Input_EmpID.multiline = $false;
$T_Input_EmpID.width = 277;
$T_Input_EmpID.height = 20;
$T_Input_EmpID.location = New-Object System.Drawing.Point(79,143);

#---------------------------------------------------------------------------------------------

$GB_Identity_Details = New-Object system.Windows.Forms.Groupbox;
$GB_Identity_Details.height = 352;
$GB_Identity_Details.width = 374;
$GB_Identity_Details.location = New-Object System.Drawing.Point(8,205);
$GB_Identity_Details.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Identity_Details.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Identity_Details = New-Object system.Windows.Forms.Label;
$L_Identity_Details.text  = "Identity Details";
$L_Identity_Details.AutoSize = $true;
$L_Identity_Details.width = 25;
$L_Identity_Details.height  = 10;
$L_Identity_Details.location = New-Object System.Drawing.Point(126,17);

$L_UPN = New-Object system.Windows.Forms.Label;
$L_UPN.text = "UPN:";
$L_UPN.AutoSize = $true;
$L_UPN.width = 25;
$L_UPN.height = 10;
$L_UPN.location = New-Object System.Drawing.Point(8,55);

$L_SAM = New-Object system.Windows.Forms.Label;
$L_SAM.text = "SAM:";
$L_SAM.AutoSize = $true;
$L_SAM.width  = 25;
$L_SAM.height = 10;
$L_SAM.location = New-Object System.Drawing.Point(8,84);

$L_EmpID = New-Object system.Windows.Forms.Label;
$L_EmpID.text = "EmpID:";
$L_EmpID.AutoSize = $true;
$L_EmpID.width = 25;
$L_EmpID.height = 10;
$L_EmpID.location = New-Object System.Drawing.Point(8,111);

$L_DisplayName = New-Object system.Windows.Forms.Label;
$L_DisplayName.text = "Name:";
$L_DisplayName.AutoSize = $true;
$L_DisplayName.width = 25;
$L_DisplayName.height = 10;
$L_DisplayName.location = New-Object System.Drawing.Point(8,137);

$L_Email = New-Object system.Windows.Forms.Label;
$L_Email.text = "Email:";
$L_Email.AutoSize = $true;
$L_Email.width = 25;
$L_Email.height = 10;
$L_Email.location = New-Object System.Drawing.Point(8,163);

$L_Alias = New-Object system.Windows.Forms.Label;
$L_Alias.text = "Alias:";
$L_Alias.AutoSize = $true;
$L_Alias.width = 25;
$L_Alias.height = 10;
$L_Alias.location = New-Object System.Drawing.Point(8,190);

$L_Enabled = New-Object system.Windows.Forms.Label;
$L_Enabled.text = "Enabled:";
$L_Enabled.AutoSize = $true;
$L_Enabled.width = 25;
$L_Enabled.height = 10;
$L_Enabled.location = New-Object System.Drawing.Point(8,217);

$L_First = New-Object system.Windows.Forms.Label;
$L_First.text = "First:";
$L_First.AutoSize = $true;
$L_First.width = 25;
$L_First.height = 10;
$L_First.location = New-Object System.Drawing.Point(8,243);

$L_Last = New-Object system.Windows.Forms.Label;
$L_Last.text = "Last:";
$L_Last.AutoSize = $true;
$L_Last.width = 25;
$L_Last.height = 10;
$L_Last.location = New-Object System.Drawing.Point(8,270);

$L_GUID = New-Object system.Windows.Forms.Label;
$L_GUID.text = "GUID:";
$L_GUID.AutoSize = $true;
$L_GUID.width = 25;
$L_GUID.height = 10;
$L_GUID.location = New-Object System.Drawing.Point(8,298);

$L_SID = New-Object system.Windows.Forms.Label;
$L_SID.text = "SID:";
$L_SID.AutoSize = $true;
$L_SID.width = 25;
$L_SID.height = 10;
$L_SID.location = New-Object System.Drawing.Point(8,325);

$L_Output_UPN = New-Object system.Windows.Forms.Label;
$L_Output_UPN.text = "";
$L_Output_UPN.AutoSize = $true;
$L_Output_UPN.width = 25;
$L_Output_UPN.height = 10;
$L_Output_UPN.location = New-Object System.Drawing.Point(70,55);
$L_Output_UPN.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_SAM = New-Object system.Windows.Forms.Label
$L_Output_SAM.text = ""
$L_Output_SAM.AutoSize = $true
$L_Output_SAM.width = 25
$L_Output_SAM.height = 10
$L_Output_SAM.location = New-Object System.Drawing.Point(70,84)
$L_Output_SAM.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_EmpID = New-Object system.Windows.Forms.Label;
$L_Output_EmpID.text = "";
$L_Output_EmpID.AutoSize = $true;
$L_Output_EmpID.width = 25;
$L_Output_EmpID.height = 10;
$L_Output_EmpID.location = New-Object System.Drawing.Point(70,111);
$L_Output_EmpID.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_DisplayName = New-Object system.Windows.Forms.Label;
$L_Output_DisplayName.text = "";
$L_Output_DisplayName.AutoSize = $true;
$L_Output_DisplayName.width = 25;
$L_Output_DisplayName.height = 10;
$L_Output_DisplayName.location = New-Object System.Drawing.Point(70,137);
$L_Output_DisplayName.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Email = New-Object system.Windows.Forms.Label
$L_Output_Email.text  = ""
$L_Output_Email.AutoSize  = $true
$L_Output_Email.width = 25
$L_Output_Email.height = 10
$L_Output_Email.location = New-Object System.Drawing.Point(70,163)
$L_Output_Email.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2")

$L_Output_Alias = New-Object system.Windows.Forms.Label;
$L_Output_Alias.text = "";
$L_Output_Alias.AutoSize = $true;
$L_Output_Alias.width = 25;
$L_Output_Alias.height = 10;
$L_Output_Alias.location = New-Object System.Drawing.Point(70,190);
$L_Output_Alias.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Enabled = New-Object system.Windows.Forms.Label;
$L_Output_Enabled.text = "";
$L_Output_Enabled.AutoSize = $true;
$L_Output_Enabled.width = 25;
$L_Output_Enabled.height = 10;
$L_Output_Enabled.location = New-Object System.Drawing.Point(70,217);
$L_Output_Enabled.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_First = New-Object system.Windows.Forms.Label;
$L_Output_First.text = "";
$L_Output_First.AutoSize = $true;
$L_Output_First.width = 25;
$L_Output_First.height = 10;
$L_Output_First.location = New-Object System.Drawing.Point(70,243);
$L_Output_First.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Last = New-Object system.Windows.Forms.Label;
$L_Output_Last.text = "";
$L_Output_Last.AutoSize = $true;
$L_Output_Last.width = 25;
$L_Output_Last.height = 10;
$L_Output_Last.location = New-Object System.Drawing.Point(70,270);
$L_Output_Last.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2")

$L_Output_GUID = New-Object system.Windows.Forms.Label;
$L_Output_GUID.text = "";
$L_Output_GUID.AutoSize = $true;
$L_Output_GUID.width = 25;
$L_Output_GUID.height = 10;
$L_Output_GUID.location = New-Object System.Drawing.Point(70,298);
$L_Output_GUID.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_SID = New-Object system.Windows.Forms.Label;
$L_Output_SID.text = "";
$L_Output_SID.AutoSize = $false;
$L_Output_SID.width = 336;
$L_Output_SID.height = 15;
$L_Output_SID.location = New-Object System.Drawing.Point(36,325);
$L_Output_SID.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

#---------------------------------------------------------------------------------------------

$GB_Attribute_Details = New-Object system.Windows.Forms.Groupbox;
$GB_Attribute_Details.height = 300;
$GB_Attribute_Details.width = 324;
$GB_Attribute_Details.location = New-Object System.Drawing.Point(398,204);
$GB_Attribute_Details.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Attribute_Details.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Attribute_Details = New-Object system.Windows.Forms.Label;
$L_Attribute_Details.text = "Attribute Details";
$L_Attribute_Details.AutoSize = $true;
$L_Attribute_Details.width = 25;
$L_Attribute_Details.height = 10;
$L_Attribute_Details.location = New-Object System.Drawing.Point(112,13);

$L_Attribute_1 = New-Object system.Windows.Forms.Label;
$L_Attribute_1.text = "Attribute 1:";
$L_Attribute_1.AutoSize = $true;
$L_Attribute_1.width = 25;
$L_Attribute_1.height = 10;
$L_Attribute_1.location = New-Object System.Drawing.Point(14,47);

$L_Attribute_5 = New-Object system.Windows.Forms.Label
$L_Attribute_5.text = "Attribute 5:";
$L_Attribute_5.AutoSize = $true;
$L_Attribute_5.width = 25;
$L_Attribute_5.height = 10;
$L_Attribute_5.location = New-Object System.Drawing.Point(14,72);

$L_Attribute_6 = New-Object system.Windows.Forms.Label;
$L_Attribute_6.text = "Attribute 6:";
$L_Attribute_6.AutoSize = $true;
$L_Attribute_6.width = 25;
$L_Attribute_6.height = 10;
$L_Attribute_6.location = New-Object System.Drawing.Point(14,96);

$L_Attribute_7 = New-Object system.Windows.Forms.Label;
$L_Attribute_7.text = "Attribute 7:";
$L_Attribute_7.AutoSize = $true;
$L_Attribute_7.width = 25;
$L_Attribute_7.height = 10;
$L_Attribute_7.location = New-Object System.Drawing.Point(14,122);

$L_Attribute_8  = New-Object system.Windows.Forms.Label;
$L_Attribute_8.text = "Attribute 8:";
$L_Attribute_8.AutoSize = $true;
$L_Attribute_8.width = 25;
$L_Attribute_8.height = 10;
$L_Attribute_8.location = New-Object System.Drawing.Point(14,147);

$L_Attribute_9 = New-Object system.Windows.Forms.Label;
$L_Attribute_9.text = "Attribute 9:";
$L_Attribute_9.AutoSize = $true;
$L_Attribute_9.width = 25;
$L_Attribute_9.height = 10;
$L_Attribute_9.location = New-Object System.Drawing.Point(14,170);

$L_Attribute_10 = New-Object system.Windows.Forms.Label;
$L_Attribute_10.text = "Attribute 10:";
$L_Attribute_10.AutoSize = $true;
$L_Attribute_10.width = 25;
$L_Attribute_10.height = 10;
$L_Attribute_10.location = New-Object System.Drawing.Point(14,195);

$L_Attribute_11 = New-Object system.Windows.Forms.Label;
$L_Attribute_11.text = "Attribute 11:";
$L_Attribute_11.AutoSize = $true;
$L_Attribute_11.width = 25;
$L_Attribute_11.height = 10;
$L_Attribute_11.location = New-Object System.Drawing.Point(14,219);

$L_Attribute_12 = New-Object system.Windows.Forms.Label;
$L_Attribute_12.text = "Attribute 12:";
$L_Attribute_12.AutoSize = $true;
$L_Attribute_12.width = 25;
$L_Attribute_12.height = 10;
$L_Attribute_12.location = New-Object System.Drawing.Point(14,242);

$L_Output_Attribute_1 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_1.text = "";
$L_Output_Attribute_1.AutoSize = $true;
$L_Output_Attribute_1.width = 25;
$L_Output_Attribute_1.height = 10;
$L_Output_Attribute_1.location = New-Object System.Drawing.Point(104,47);
$L_Output_Attribute_1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_5 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_5.text = "";
$L_Output_Attribute_5.AutoSize = $true;
$L_Output_Attribute_5.width = 25;
$L_Output_Attribute_5.height = 10;
$L_Output_Attribute_5.location = New-Object System.Drawing.Point(104,72);
$L_Output_Attribute_5.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_6 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_6.text = "";
$L_Output_Attribute_6.AutoSize = $true;
$L_Output_Attribute_6.width = 25;
$L_Output_Attribute_6.height = 10;
$L_Output_Attribute_6.location = New-Object System.Drawing.Point(104,96);
$L_Output_Attribute_6.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_7 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_7.text = "";
$L_Output_Attribute_7.AutoSize = $true;
$L_Output_Attribute_7.width = 25;
$L_Output_Attribute_7.height = 10;
$L_Output_Attribute_7.location = New-Object System.Drawing.Point(104,122);
$L_Output_Attribute_7.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_8 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_8.text = "";
$L_Output_Attribute_8.AutoSize = $true;
$L_Output_Attribute_8.width = 25;
$L_Output_Attribute_8.height = 10;
$L_Output_Attribute_8.location = New-Object System.Drawing.Point(104,147);
$L_Output_Attribute_8.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_9 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_9.text = "";
$L_Output_Attribute_9.AutoSize = $true;
$L_Output_Attribute_9.width = 25;
$L_Output_Attribute_9.height = 10;
$L_Output_Attribute_9.location = New-Object System.Drawing.Point(105,170);
$L_Output_Attribute_9.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_10 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_10.text = "";
$L_Output_Attribute_10.AutoSize = $true;
$L_Output_Attribute_10.width = 25;
$L_Output_Attribute_10.height = 10;
$L_Output_Attribute_10.location = New-Object System.Drawing.Point(105,195);
$L_Output_Attribute_10.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_11 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_11.text  = "";
$L_Output_Attribute_11.AutoSize = $true;
$L_Output_Attribute_11.width = 25;
$L_Output_Attribute_11.height = 10;
$L_Output_Attribute_11.location = New-Object System.Drawing.Point(105,218);
$L_Output_Attribute_11.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Attribute_12 = New-Object system.Windows.Forms.Label;
$L_Output_Attribute_12.text = "";
$L_Output_Attribute_12.AutoSize = $true;
$L_Output_Attribute_12.width = 25;
$L_Output_Attribute_12.height = 10;
$L_Output_Attribute_12.location = New-Object System.Drawing.Point(105,242);
$L_Output_Attribute_12.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

#---------------------------------------------------------------------------------------------

$GB_Organization_Details = New-Object system.Windows.Forms.Groupbox;
$GB_Organization_Details.height = 186;
$GB_Organization_Details.width = 375;
$GB_Organization_Details.location  = New-Object System.Drawing.Point(9,565);
$GB_Organization_Details.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Organization_Details.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Organization_Details = New-Object system.Windows.Forms.Label;
$L_Organization_Details.text = "Organization Details";
$L_Organization_Details.AutoSize = $true;
$L_Organization_Details.width = 25;
$L_Organization_Details.height = 10;
$L_Organization_Details.location = New-Object System.Drawing.Point(110,13);

$L_Company = New-Object system.Windows.Forms.Label;
$L_Company.text = "Company:";
$L_Company.AutoSize = $true;
$L_Company.width = 25;
$L_Company.height = 10;
$L_Company.location = New-Object System.Drawing.Point(12,45);

$L_Department = New-Object system.Windows.Forms.Label;
$L_Department.text = "Department:";
$L_Department.AutoSize = $true;
$L_Department.width = 25;
$L_Department.height = 10;
$L_Department.location = New-Object System.Drawing.Point(12,72);

$L_Job_Title = New-Object system.Windows.Forms.Label;
$L_Job_Title.text = "Job Title:";
$L_Job_Title.AutoSize = $true;
$L_Job_Title.width = 25;
$L_Job_Title.height = 10;
$L_Job_Title.location = New-Object System.Drawing.Point(12,103);

$L_Supervisor = New-Object system.Windows.Forms.Label;
$L_Supervisor.text  = "Supervisor:";
$L_Supervisor.AutoSize = $true;
$L_Supervisor.width = 25;
$L_Supervisor.height = 10;
$L_Supervisor.location = New-Object System.Drawing.Point(12,133);

$L_Output_Company = New-Object system.Windows.Forms.Label;
$L_Output_Company.text = "";
$L_Output_Company.AutoSize = $true;
$L_Output_Company.width = 25;
$L_Output_Company.height = 10;
$L_Output_Company.location = New-Object System.Drawing.Point(100,45);
$L_Output_Company.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Department = New-Object system.Windows.Forms.Label;
$L_Output_Department.text = "";
$L_Output_Department.AutoSize = $true;
$L_Output_Department.width = 25;
$L_Output_Department.height = 10;
$L_Output_Department.location = New-Object System.Drawing.Point(101,72);
$L_Output_Department.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Job_Title = New-Object system.Windows.Forms.Label;
$L_Output_Job_Title.text = "";
$L_Output_Job_Title.AutoSize = $true;
$L_Output_Job_Title.width = 25;
$L_Output_Job_Title.height = 10;
$L_Output_Job_Title.location = New-Object System.Drawing.Point(100,103);
$L_Output_Job_Title.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Supervisor = New-Object system.Windows.Forms.Label;
$L_Output_Supervisor.text = "";
$L_Output_Supervisor.AutoSize = $true;
$L_Output_Supervisor.width = 25;
$L_Output_Supervisor.height = 10;
$L_Output_Supervisor.location = New-Object System.Drawing.Point(101,133);
$L_Output_Supervisor.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

#---------------------------------------------------------------------------------------------

$GB_Account_Details = New-Object system.Windows.Forms.Groupbox;
$GB_Account_Details.height = 236;
$GB_Account_Details.width = 325;
$GB_Account_Details.location = New-Object System.Drawing.Point(398,516);
$GB_Account_Details.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Account_Details.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Account_Details = New-Object system.Windows.Forms.Label;
$L_Account_Details.text = "Account Details";
$L_Account_Details.AutoSize = $true;
$L_Account_Details.width = 25;
$L_Account_Details.height = 10;
$L_Account_Details.location = New-Object System.Drawing.Point(101,12);

$L_Account_Locked = New-Object system.Windows.Forms.Label;
$L_Account_Locked.text = "Account Locked:";
$L_Account_Locked.AutoSize = $true;
$L_Account_Locked.width = 25;
$L_Account_Locked.height  = 10;
$L_Account_Locked.location  = New-Object System.Drawing.Point(12,39);

$L_Account_Created = New-Object system.Windows.Forms.Label;
$L_Account_Created.text = "Account Created:";
$L_Account_Created.AutoSize = $true;
$L_Account_Created.width = 25;
$L_Account_Created.height = 10;
$L_Account_Created.location = New-Object System.Drawing.Point(12,64);

$L_Account_Changed = New-Object system.Windows.Forms.Label;
$L_Account_Changed.text = "Account Changed:";
$L_Account_Changed.AutoSize = $true;
$L_Account_Changed.width  = 25;
$L_Account_Changed.height = 10;
$L_Account_Changed.location = New-Object System.Drawing.Point(12,88);

$L_Account_Expires = New-Object system.Windows.Forms.Label;
$L_Account_Expires.text = "Account Expires:";
$L_Account_Expires.AutoSize = $true;
$L_Account_Expires.width = 25;
$L_Account_Expires.height = 10;
$L_Account_Expires.location = New-Object System.Drawing.Point(12,111);

$L_Password_Changed = New-Object system.Windows.Forms.Label;
$L_Password_Changed.text = "Password Changed:";
$L_Password_Changed.AutoSize = $true;
$L_Password_Changed.width = 25;
$L_Password_Changed.height = 10;
$L_Password_Changed.location = New-Object System.Drawing.Point(12,135);

$L_Password_Expired = New-Object system.Windows.Forms.Label;
$L_Password_Expired.text = "Password Expired:";
$L_Password_Expired.AutoSize = $true;
$L_Password_Expired.width = 25;
$L_Password_Expired.height = 10;
$L_Password_Expired.location = New-Object System.Drawing.Point(12,160);

$L_Password_Not_Required = New-Object system.Windows.Forms.Label;
$L_Password_Not_Required.text = "Password Not Required:";
$L_Password_Not_Required.AutoSize = $true;
$L_Password_Not_Required.width = 25;
$L_Password_Not_Required.height = 10;
$L_Password_Not_Required.location = New-Object System.Drawing.Point(12,184);

$L_Password_Never_Expires = New-Object system.Windows.Forms.Label;
$L_Password_Never_Expires.text = "Password Never Expires:";
$L_Password_Never_Expires.AutoSize = $true;
$L_Password_Never_Expires.width = 25;
$L_Password_Never_Expires.height = 10;
$L_Password_Never_Expires.location = New-Object System.Drawing.Point(12,209);

$L_Output_Account_Locked = New-Object system.Windows.Forms.Label;
$L_Output_Account_Locked.text = "";
$L_Output_Account_Locked.AutoSize = $true;
$L_Output_Account_Locked.width = 25;
$L_Output_Account_Locked.height = 10;
$L_Output_Account_Locked.location = New-Object System.Drawing.Point(149,39);
$L_Output_Account_Locked.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Account_Created        = New-Object system.Windows.Forms.Label;
$L_Output_Account_Created.text   = "";
$L_Output_Account_Created.AutoSize  = $true;
$L_Output_Account_Created.width  = 25;
$L_Output_Account_Created.height  = 10;
$L_Output_Account_Created.location  = New-Object System.Drawing.Point(149,64);
$L_Output_Account_Created.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Account_Changed = New-Object system.Windows.Forms.Label;
$L_Output_Account_Changed.text = "";
$L_Output_Account_Changed.AutoSize  = $true;
$L_Output_Account_Changed.width = 25;
$L_Output_Account_Changed.height = 10;
$L_Output_Account_Changed.location = New-Object System.Drawing.Point(149,90);
$L_Output_Account_Changed.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Account_Expires = New-Object system.Windows.Forms.Label;
$L_Output_Account_Expires.text = "";
$L_Output_Account_Expires.AutoSize = $true;
$L_Output_Account_Expires.width = 25;
$L_Output_Account_Expires.height = 10;
$L_Output_Account_Expires.location = New-Object System.Drawing.Point(149,111);
$L_Output_Account_Expires.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Password_Changed = New-Object system.Windows.Forms.Label;
$L_Output_Password_Changed.text = "";
$L_Output_Password_Changed.AutoSize = $true;
$L_Output_Password_Changed.width = 25;
$L_Output_Password_Changed.height = 10;
$L_Output_Password_Changed.location = New-Object System.Drawing.Point(150,135);
$L_Output_Password_Changed.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Password_Expired = New-Object system.Windows.Forms.Label;
$L_Output_Password_Expired.text = "";
$L_Output_Password_Expired.AutoSize = $true;
$L_Output_Password_Expired.width = 25;
$L_Output_Password_Expired.height = 10;
$L_Output_Password_Expired.location = New-Object System.Drawing.Point(150,160);
$L_Output_Password_Expired.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Password_Not_Required  = New-Object system.Windows.Forms.Label;
$L_Output_Password_Not_Required.text = "";
$L_Output_Password_Not_Required.AutoSize = $true;
$L_Output_Password_Not_Required.width = 25;
$L_Output_Password_Not_Required.height = 10;
$L_Output_Password_Not_Required.location = New-Object System.Drawing.Point(179,184);
$L_Output_Password_Not_Required.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Password_Never_Expires = New-Object system.Windows.Forms.Label;
$L_Output_Password_Never_Expires.text = "";
$L_Output_Password_Never_Expires.AutoSize = $true;
$L_Output_Password_Never_Expires.width = 25;
$L_Output_Password_Never_Expires.height = 10;
$L_Output_Password_Never_Expires.location = New-Object System.Drawing.Point(179,209);
$L_Output_Password_Never_Expires.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

#---------------------------------------------------------------------------------------------

$GB_Location_Details = New-Object system.Windows.Forms.Groupbox;
$GB_Location_Details.height  = 156;
$GB_Location_Details.width = 640;
$GB_Location_Details.location = New-Object System.Drawing.Point(396,40);
$GB_Location_Details.Font = New-Object System.Drawing.Font('Calibri',12);
$GB_Location_Details.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Location_Details = New-Object system.Windows.Forms.Label;
$L_Location_Details.text = "Location Details";
$L_Location_Details.AutoSize = $true;
$L_Location_Details.width = 25;
$L_Location_Details.height = 10;
$L_Location_Details.location = New-Object System.Drawing.Point(252,15);

$L_LDAP_Location = New-Object system.Windows.Forms.Label;
$L_LDAP_Location.text = "LDAP Location:";
$L_LDAP_Location.AutoSize = $true;
$L_LDAP_Location.width = 25;
$L_LDAP_Location.height = 10;
$L_LDAP_Location.location = New-Object System.Drawing.Point(12,48);

$L_Home_Directory = New-Object system.Windows.Forms.Label;
$L_Home_Directory.text = "Home Directory:";
$L_Home_Directory.AutoSize = $true;
$L_Home_Directory.width = 25;
$L_Home_Directory.height = 10;
$L_Home_Directory.location = New-Object System.Drawing.Point(12,69);

$L_Mapped_To  = New-Object system.Windows.Forms.Label;
$L_Mapped_To.text = "Mapped To:";
$L_Mapped_To.AutoSize = $true;
$L_Mapped_To.width = 25;
$L_Mapped_To.height = 10;
$L_Mapped_To.location = New-Object System.Drawing.Point(12,90);

$L_Output_LDAP_Location = New-Object system.Windows.Forms.Label;
$L_Output_LDAP_Location.text = "";
$L_Output_LDAP_Location.AutoSize = $true;
$L_Output_LDAP_Location.width = 25;
$L_Output_LDAP_Location.height = 10;
$L_Output_LDAP_Location.location = New-Object System.Drawing.Point(127,48);
$L_Output_LDAP_Location.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Home_Directory = New-Object system.Windows.Forms.Label;
$L_Output_Home_Directory.text = "";
$L_Output_Home_Directory.AutoSize = $true;
$L_Output_Home_Directory.width = 25;
$L_Output_Home_Directory.height = 10;
$L_Output_Home_Directory.location = New-Object System.Drawing.Point(127,69);
$L_Output_Home_Directory.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Output_Mapped_To = New-Object system.Windows.Forms.Label
$L_Output_Mapped_To.text = ""
$L_Output_Mapped_To.AutoSize = $true
$L_Output_Mapped_To.width = 25
$L_Output_Mapped_To.height = 10
$L_Output_Mapped_To.location = New-Object System.Drawing.Point(127,90)
$L_Output_Mapped_To.Font = New-Object System.Drawing.Font('Calibri',12)
$L_Output_Mapped_To.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$B_Search = New-Object system.Windows.Forms.Button;
$B_Search.text = "SEARCH";
$B_Search.width = 160;
$B_Search.height = 32;
$B_Search.location = New-Object System.Drawing.Point(10,113);
$B_Search.Font = New-Object System.Drawing.Font('Calibri',20);
$B_Search.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Search.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2");

$B_Previous = New-Object system.Windows.Forms.Button;
$B_Previous.text = "PREVIOUS";
$B_Previous.width = 160;
$B_Previous.height = 32;
$B_Previous.location = New-Object System.Drawing.Point(170,113);
$B_Previous.Font = New-Object System.Drawing.Font('Calibri',20);
$B_Previous.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Previous.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2");

$B_Next = New-Object system.Windows.Forms.Button;
$B_Next.text = "NEXT";
$B_Next.width = 160;
$B_Next.height = 32;
$B_Next.location = New-Object System.Drawing.Point(330,113);
$B_Next.Font = New-Object System.Drawing.Font('Calibri',20);
$B_Next.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");
$B_Next.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2");

$L_Record_Number = New-Object system.Windows.Forms.Label;
$L_Record_Number.text = "Account:";
$L_Record_Number.AutoSize = $false;
$L_Record_Number.width = 65;
$L_Record_Number.height = 22;
$L_Record_Number.location = New-Object System.Drawing.Point(505,118);
$L_Record_Number.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");

$L_Record_Number_Output = New-Object system.Windows.Forms.Label;
$L_Record_Number_Output.text = "0000000";
$L_Record_Number_Output.AutoSize = $false;
$L_Record_Number_Output.width = 55;
$L_Record_Number_Output.height = 22;
$L_Record_Number_Output.location = New-Object System.Drawing.Point(568,118);
$L_Record_Number_Output.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFA500");

#---------------------------------------------------------------------------------------------

$GB_Group_Membership = New-Object system.Windows.Forms.Groupbox;
$GB_Group_Membership.height  = 298;
$GB_Group_Membership.width = 296;
$GB_Group_Membership.location = New-Object System.Drawing.Point(738,207);
$GB_Group_Membership.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Group_Membership.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Group_Membership = New-Object system.Windows.Forms.Label;
$L_Group_Membership.text = "Group Membership (Managed)";
$L_Group_Membership.AutoSize = $true;
$L_Group_Membership.width = 25;
$L_Group_Membership.height = 8;
$L_Group_Membership.location = New-Object System.Drawing.Point(53,15);

#---------------------------------------------------------------------------------------------

$GB_Member_Of = New-Object system.Windows.Forms.Groupbox;
$GB_Member_Of.height = 232;
$GB_Member_Of.width  = 298;
$GB_Member_Of.location = New-Object System.Drawing.Point(738,518);
$GB_Member_Of.Font = New-Object System.Drawing.Font('Calibri',11);
$GB_Member_Of.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff");

$L_Member_Of = New-Object system.Windows.Forms.Label;
$L_Member_Of.text = "Member Of";
$L_Member_Of.AutoSize  = $true;
$L_Member_Of.width = 25;
$L_Member_Of.height = 8;
$L_Member_Of.location = New-Object System.Drawing.Point(109,8);

<# --------------------------------------------------------------------------------------------------------------------------- #>

$T_Group_Membership = New-Object system.Windows.Forms.TextBox;
$T_Group_Membership.multiline = $true;
$T_Group_Membership.WordWrap = $true;
$T_Group_Membership.BorderStyle = 0;
$T_Group_Membership.ScrollBars = 2;
$T_Group_Membership.text = "";
$T_Group_Membership.width = 262;
$T_Group_Membership.height = 236;
$T_Group_Membership.location = New-Object System.Drawing.Point(19,41);
$T_Group_Membership.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");
$T_Group_Membership.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");

<# --------------------------------------------------------------------------------------------------------------------------- #>

$T_Member_Of = New-Object system.Windows.Forms.TextBox;
$T_Member_Of.multiline = $true;
$T_Member_Of.WordWrap = $true;
$T_Member_Of.BorderStyle = 0;
$T_Member_Of.ScrollBars = 2;
$T_Member_Of.text = "";
$T_Member_Of.width = 278;
$T_Member_Of.height = 191;
$T_Member_Of.location = New-Object System.Drawing.Point(10,31);
$T_Member_Of.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2");
$T_Member_Of.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#000000");

<# --------------------------------------------------------------------------------------------------------------------------- #>

$Form_MAIN.controls.AddRange(@($L_Title,$L_Num_AD_Accts,$L_Num_AD_Accts_Output,$GB_Input,$GB_Identity_Details,$GB_Attribute_Details,$GB_Organization_Details,$GB_Account_Details,$GB_Location_Details,$GB_Group_Membership,$GB_Member_Of))
$GB_Identity_Details.controls.AddRange(@($L_UPN,$L_SAM,$L_Output_UPN,$L_Output_SAM,$L_EmpID,$L_Output_EmpID,$L_DisplayName,$L_Output_DisplayName,$L_Email,$L_Output_Email,$L_Enabled,$L_Output_Enabled,$L_Alias,$L_Output_Alias,$L_First,$L_Last,$L_Output_First,$L_Output_Last,$L_Identity_Details,$L_GUID,$L_Output_GUID,$L_SID,$L_Output_SID))
$GB_Input.controls.AddRange(@($L_Input,$L_Input_UPN,$L_Input_SAM,$L_Input_Email,$L_Input_EmpID,$T_Input_UPN,$T_Input_SAM,$T_Input_Email,$T_Input_EmpID))
$GB_Location_Details.controls.AddRange(@($B_Search,$B_Previous,$B_Next,$L_Record_Number,$L_Record_Number_Output,$L_Location_Details,$L_LDAP_Location,$L_Output_LDAP_Location,$L_Home_Directory,$L_Output_Home_Directory,$L_Mapped_To,$L_Output_Mapped_To))
$GB_Attribute_Details.controls.AddRange(@($L_Attribute_1,$L_Attribute_Details,$L_Attribute_5,$L_Attribute_6,$L_Attribute_7,$L_Attribute_8,$L_Attribute_9,$L_Attribute_10,$L_Attribute_11,$L_Attribute_12,$L_Output_Attribute_12,$L_Output_Attribute_11,$L_Output_Attribute_10,$L_Output_Attribute_9,$L_Output_Attribute_8,$L_Output_Attribute_7,$L_Output_Attribute_6,$L_Output_Attribute_5,$L_Output_Attribute_1))
$GB_Organization_Details.controls.AddRange(@($L_Organization_Details,$L_Supervisor,$L_Output_Supervisor,$L_Company,$L_Department,$L_Job_Title,$L_Output_Job_Title,$L_Output_Department,$L_Output_Company))
$GB_Account_Details.controls.AddRange(@($L_Account_Details,$L_Account_Locked,$L_Password_Expired,$L_Password_Changed,$L_Account_Created,$L_Account_Changed,$L_Account_Expires,$L_Password_Not_Required,$L_Password_Never_Expires,$L_Output_Account_Locked,$L_Output_Account_Created,$L_Output_Account_Changed,$L_Output_Account_Expires,$L_Output_Password_Changed,$L_Output_Password_Expired,$L_Output_Password_Not_Required,$L_Output_Password_Never_Expires))
$GB_Group_Membership.controls.AddRange(@($L_Group_Membership,$T_Group_Membership))
$GB_Member_Of.controls.AddRange(@($L_Member_Of,$T_Member_Of))

#---------------------------------------------------------------------------------------------

$T_Input_UPN.Add_Click({ $T_Input_SAM.text =""; $T_Input_Email.text =""; $T_Input_EmpID.text =""; })
$T_Input_SAM.Add_Click({ $T_Input_UPN.text =""; $T_Input_Email.text =""; $T_Input_EmpID.text =""; })
$T_Input_Email.Add_Click({ $T_Input_SAM.text =""; $T_Input_UPN.text =""; $T_Input_EmpID.text =""; })
$T_Input_EmpID.Add_Click({ $T_Input_SAM.text =""; $T_Input_UPN.text =""; $T_Input_Email.text =""; })

$B_Search.Add_Click({ RouteDisplayData; })
$B_Previous.Add_Click({ PREVIOUS; })
$B_Next.Add_Click({ NEXT; })

#Add Event Listener and Handler for Key Presses
$KEYS_Listener = [System.Windows.Forms.KeyEventHandler]{
    if ($_.KeyCode -eq 'Enter')
    {
        $B_Search.PerformClick();
    }
}

$T_Input_UPN.Add_KeyDown($KEYS_Listener);
$T_Input_SAM.Add_KeyDown($KEYS_Listener);
$T_Input_Email.Add_KeyDown($KEYS_Listener);
$T_Input_EmpID.Add_KeyDown($KEYS_Listener);

#---------------------------------------------------------------------------------------------

function Initialize
{
         $Global:All_Users = Get-ADUser -Filter * -Properties *;
         #$MESSAGE = $Global:All_Users.Count;

         $L_Num_AD_Accts_Output.Text = $Global:All_Users.Count;
         $T_Input_SAM.Text = $Global:All_Users[$Global:User_Number].SamAccountName;
         $L_Record_Number_Output.Text = ($Global:User_Number+1);
         RouteDisplayData;
}

#---------------------------------------------------------------------------------------------
function PREVIOUS
{
         if(($Global:User_Number-1) -GE 0)
         { 
             $Global:User_Number--;
             $T_Input_SAM.Text = $Global:All_Users[$Global:User_Number].SamAccountName;
             $L_Record_Number_Output.Text = ($Global:User_Number+1);
             RouteDisplayData; 
         }     
}
#---------------------------------------------------------------------------------------------
function NEXT
{
         if(($Global:User_Number+1) -LE ($Global:All_Users.Count))
         { 
             $Global:User_Number++;
             $T_Input_SAM.Text = $Global:All_Users[$Global:User_Number].SamAccountName;
             $L_Record_Number_Output.Text = ($Global:User_Number+1);
             RouteDisplayData; 
         } 
}
#---------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------


Initialize;
[system.windows.forms.application]::run($Form_MAIN);




#Message Box for testing
#[System.Windows.MessageBox]::Show('Hello');
#$T_Input_UPN.Remove_KeyDown($KEYS_Listener);