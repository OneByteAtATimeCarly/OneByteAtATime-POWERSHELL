clear;

Write("`n`n`n");


         $a = 444;
         $b = 3.145678;
         $c = "Carly";

         $a.GetType();
         $b.GetType();
         $c.GetType();

         $TESTER = 444;
         Write("`n------------------------------------------------");
         Write("Setting value of TESTER to: `"" + $TESTER + "`".")
         Write("------------------------------------------------");

         if($TESTER -is [int])
         { Write("`nYes, TESTER is data type INT."); }
         else
         { Write("`nNo, TESTER is not an integer."); }

         if($TESTER -is [double])
         { Write("`nYes, TESTER is data type DOUBLE."); }
         else
         { Write("`nNo, TESTER is not a double."); }

         if($TESTER -is [string])
         { Write("`nYes, TESTER is data type STRING."); }
         else
         { Write("`nNo, TESTER is not a string."); }

         $TESTER = 3.145678;
         Write("`n------------------------------------------------");
         Write("Setting value of TESTER to: `"" + $TESTER + "`".")
         Write("------------------------------------------------");

         if($TESTER -is [int])
         { Write("`nYes, TESTER is data type INT."); }
         else
         { Write("`nNo, TESTER is not an integer."); }

         if($TESTER -is [double])
         { Write("`nYes, TESTER is data type DOUBLE."); }
         else
         { Write("`nNo, TESTER is not a double."); }

         if($TESTER -is [string])
         { Write("`nYes, TESTER is data type STRING."); }
         else
         { Write("`nNo, TESTER is not a string."); }

         $TESTER = "Carly";
         Write("`n------------------------------------------------");
         Write("Setting value of TESTER to: `"" + $TESTER + "`".")
         Write("------------------------------------------------");

         if($TESTER -is [int])
         { Write("`nYes, TESTER is data type INT."); }
         else
         { Write("`nNo, TESTER is not an integer."); }

         if($TESTER -is [double])
         { Write("`nYes, TESTER is data type DOUBLE."); }
         else
         { Write("`nNo, TESTER is not a double."); }

         if($TESTER -is [string])
         { Write("`nYes, TESTER is data type STRING."); }
         else
         { Write("`nNo, TESTER is not a string."); }


Write("`n`n");