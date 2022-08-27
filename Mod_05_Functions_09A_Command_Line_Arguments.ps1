#Title: PowerShell - Module 05 - Functions 9 - Command Line Arguments
#Author: Carly S. Germany
#Date: 06/07/2020

<# ------------------------------------------------------------------- #>

function TESTING
{

}

<# ------------------------------------------------------------------- #>


#1. 
#CD to D:\Carly_Powershell\Module_05_Functions.
#Run:   .\Script1 super cala frajal istic expi ala docious

#2. 
#CD to D:\Carly_Powershell\Module_05_Functions.
#Run: .\Script2 Create_Pokemon -Species "Mimikyu" -Name "Carly" -Gender "Female";



















function Get-NewPix
{
  $start = Get-Date -Month 1 -Day 1 -Year 2010
  $allpix = Get-ChildItem -Path $env:UserProfile\*.jpg -Recurse
  $allpix | Where-Object {$_.LastWriteTime -gt $Start}
}