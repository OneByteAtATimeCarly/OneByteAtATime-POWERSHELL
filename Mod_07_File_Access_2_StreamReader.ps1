         
         
         #Using "StreamReader" to read specific line # from a plain text file

         $LogFile = "C:\DATA\Galactica_LOG_1.txt";

         $TheStreamReader = New-Object System.IO.StreamReader($LogFile);
         #$TheStreamReader.ReadLine();
         
         $LineNumber = 0;

         Write("`nLooking for a specific line:`n");

         $TargetLine = 3;

         while(($CurrentLine = $TheStreamReader.ReadLine()) -ne $null)
         {
             $LineNumber++;

             if($LineNumber -EQ $TargetLine) 
             {
                Write-Host("Line " + $LineNumber + " = " + $CurrentLine);
             }
             
         }

         $TheStreamReader.Dispose();