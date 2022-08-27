#Title: PowerShell - Module 05 - Functions - MegaPet
#Author: Carly S. Germany
#Date: 06/10/2020

<# ------------------------------------------------------------------- #>




















<#

//MegaPet 1.0, Java version, C. Germany - June 27, 2006

import javax.swing.*;
import java.util.Random;
import java.io.*;

public class MegaPet
{
       //Initializaions and Instantiations - Stuff to Happen Once in Main
       static Random rand = new Random(); 
       static LineNumberReader cin = new LineNumberReader(new InputStreamReader(System.in));
       static int Continue = 500;
       static String choice;
       static String PetName = "";            
       static char WhatToDo = '#';
       static int life = 50;
       static int EmotiveState = 5;

//----------------------------------------------------------------------------------------

       public static void main(String[] args)
       {
              PetName = Introduction();
              
              while(Continue != 0 && life != 0)
              {   
                  View(PetName);
                  Menu(PetName);
                  
                 switch(WhatToDo)
                 {
                       case 'q' : Continue = 0; break;
                       case 'f' : Feed(); break;
                       case 'c' : Communicate(); break;
                       case 'p' : Pet(); break;
                       case 's' : Sleep(); break;
                       case 'k' : Kick(); break;
                       case 'v' : View(PetName); break;    
                       default : System.out.println("Invalid input."); break;
                 }

                 life = life - 1; //1 life subtracted for each turn, feed pet to increase
             } //close while true loop                  
              
              Ending();
              System.exit(0); 
 
       }//close main() function

//----------------------------------------------------------------------------------------

       public static String Introduction()
       {
              System.out.println("------------------------------" + 
                                "--------------------------------");
              
              System.out.println("MegaPet 1.0, Java Version - C. "
                                 + "Germany, June 27, 2006");  
              System.out.println("\nWhat will you name your MegaPet?");
 
              try { PetName = cin.readLine(); }
              catch (IOException e) { System.err.println("Error."); }

              System.out.println("\nCongratulations, you are now the the "
                                 + "proud owner of " + PetName + "!");

              System.out.println("Taking on a MegaPet is a big responsibility."
                                 + " Are you up to ");

              System.out.println("the challenge? As " + PetName + "'s owner,"
                                 + " you will enjoy the\nprivledges and bear"
                                 + " the burdens of caring for a MegaPet."
                                 + "\nGood luck!"); 

              System.out.println("\n");
             
              return PetName;
             
       }//close Introduction() function
       
//----------------------------------------------------------------------------------------      
       
       public static void Ending()
       {
              System.out.println("\n");
              
              if(life <= 0)
              {
                   System.out.println("Your pet has died of starvation and lack of\n" +
                                      " sleep due to your careless neglect!\n");    
              }

              System.out.println("Now exiting MegaPet 1.0 for Java ...");

              System.out.println("------------------------------" + 
                                 "--------------------------------");

              System.out.println("\n\n");
              
       }//close Ending() function
       
//----------------------------------------------------------------------------------------      
       
       public static void Menu(String PetName)
       {
              System.out.println("\nMegaPet 1.0 for Java Menu\n\n" + 
                                 "(q)uit \n" +
                                 "(f)eed " + PetName + ".\n" +
                                 "(c)ommunicate with " + PetName + ".\n" +
                                 "(p)et " + PetName + ".\n" +
                                 "(k)ick " + PetName + ".\n" +
                                 "(s)end " + PetName + " to bed.\n" +
                                 "(v)iew " + PetName + "'s statistics.\n");
              
              try { choice = cin.readLine(); }
              catch (IOException e) { System.err.println("Error."); }
              
              WhatToDo = choice.charAt(0); //Copy 1st character of string to char
              
       }//close Menu() function
       
//----------------------------------------------------------------------------------------
      
       public static void View(String PetName)
       {       
               String Feeling = "nothing";
               
               switch(EmotiveState)
               {
                      case 1 : Feeling = "Depressed and Suicidal"; break;
                      case 2 : Feeling = "Down and Out"; break;  
                      case 3 : Feeling = "Melancholy"; break;  
                      case 4 : Feeling = "Fairly Happy"; break;  
                      case 5 : Feeling = "Ecstatic with Joy"; break;  
                      default : System.out.println("Should never be."); break;
               } 
               
               System.out.println("------------------------------" + 
                                  "--------------------------------");
               
               System.out.println("\t\t" + PetName + "'s Statistics:\n" +
                                  "\t\tLife = " + life + "\n" +
                                  "\t\tEmotive State = " + Feeling);

               System.out.println("------------------------------" + 
                                  "--------------------------------");

       }//close View() function
       
//----------------------------------------------------------------------------------------
       
       public static void Feed()
       {       
              if(life < 50)
              {
                  System.out.println("\nYou feed your pet. This brings it happy "
                                     + "contentment\n and adds 3 points to its life.\n");
                  life = life + 3;;
              }
 
              else
              {
                  System.out.println("\nYour feed your pet, but it is just not hungry."
                                     + "\nAs a result, it gets sick and vomits on your "
                                     + "new carpet.\n This causes you to scold it. It "
                                     + "looses 1 life point.\n");
                  life = life - 1;
              }
       }//close Feed() function
       
//----------------------------------------------------------------------------------------
       
       public static void Communicate()
       {       
         
              int PetState = rand.nextInt(10) + 1;
              System.out.println("");
              
              if(EmotiveState > 3)
              {
                   switch(PetState)
                   {
                        case 1 : System.out.println("Purr! I love you master!"
                                                    + " My life for you!"); 
                                 break;      
                        case 2 : System.out.println("I am happy and content."
                                                    + " Life is good.");
                                 break;          
                        case 3 : System.out.println("I am fairly content with things.");
                                 break;          
                        case 4 : System.out.println("I am o.k. Are you o.k.?");
                                 break;           
                        case 5 : System.out.println("I am surviving, getting by..."); 
                                 break;           
                        case 6 : System.out.println("It's all good, baby."); 
                                 break;          
                        case 7 : System.out.println("That's life I guess."); 
                                 break;           
                        case 8 : System.out.println("I am so happy it is hard not to "
                                                    + "wet myself."); 
                                 break;           
                        case 9 : System.out.println("I must be in heaven!"); 
                                 break;           
                        case 10 : System.out.println("When I'm with you, everything"
                                                     + " is o.k.");
                                 break;                  
                        default : System.out.println("This should never happen!"
                                                     + "Only values 1-10."); 
                                  break;
                   } //close switch
              } // close if  
     
              else if(EmotiveState <= 3 && EmotiveState > 1)
              {
                   switch(PetState)
                   {
                        case 1 : System.out.println("I feel really sad. So sad..."); 
                                 break;      
                        case 2 : System.out.println("I am so lonely. Please pet me"
                                                     + " master.");
                                 break;          
                        case 3 : System.out.println("Sigh, if only..."); 
                                 break;          
                        case 4 : System.out.println("Have I displeased you master?"); 
                                 break;           
                        case 5 : System.out.println("Don't you love me any more?"); 
                                 break;           
                        case 6 : System.out.println("I crave your love and affection...");
                                 break;          
                        case 7 : System.out.println("Why me?"); 
                                 break;           
                        case 8 : System.out.println("Feelin' mighty low..."); 
                                 break;           
                        case 9 : System.out.println("My life is a living hell."); 
                                 break;           
                        case 10 : System.out.println("I'm thinking about ways to kill"
                                  + "myself.");
                                 break;                  
                        default : System.out.println("I don't want to go on living."); 
                                 break;
                   } //close switch     
              }
              
              else
              {  
                  System.out.println("I hate you. I want to bite your freakin' arm off"
                                     + " master.\nWhen you sleep at night I will lift my"
                                     + " leg and pee in your shoes!\nI will shred your "
                                     + "favorite pillow, I will devour your homework!\n");
              }
     
              //While first statement is based on EmotiveSrate, second is based on life  
              if(life > 40 && life <= 50)
              { System.out.println( "I'm not really hungry or sleepy."); }
              
              if(life > 30 && life <= 40)
              { System.out.println( "I feel a little hungry"); }
              
              if(life > 20 && life <= 30)
              { System.out.println( "I feel really hungry and sleepy"); }
              
              if(life > 10 && life <= 20)
              { System.out.println( "I am starving to death"); }
              
              if(life > 0 && life <= 10)
              {System.out.println("I am so weak. I don't think I will last much longer.");}
              
       }//close Communicate() function
       
//----------------------------------------------------------------------------------------
      
       public static void Pet()
       {       
              if(EmotiveState < 5)
              {
                    System.out.println("\nYou pet your pet. This affection raises its "
                                       + "spirits,\n improving its outlook on life.\n");
                    EmotiveState = EmotiveState + 1;
              }

              else
              {
                    System.out.println("\nYour pet does not require petting. It feels"
                                       + " loved and content.\n");
              }

       }//close Pet() function
       
//----------------------------------------------------------------------------------------
       
       public static void Sleep()
       {       
              if(life < 50)
              {
                    System.out.println("\nYour pet could use some sleep."
                                       + "It gains 1 life point!\n");
                    life = life + 2;
              }
              
              else
              {
                   System.out.println("\nYour pet does not need any sleep. You put"
                                      + " it to bed any way,\ncausing it undue "
                                      + "anxiety and it looses 1 life point.\n");
                   life = life - 1;
           
               }
          
       }//close Sleep() function
       
       public static void Kick()
       {       
              System.out.println("\n\nYou kick your pet. You are a real jerk!\n\n");

              if(EmotiveState > 1)
              { 
                   EmotiveState = EmotiveState - 1;
              }
    
              else
              {
                   System.out.println("You are not worthy of being a pet owner.\n"
                                      + "Kick 'em when they're down?");
                   EmotiveState = 1;
              }

       }//close Kick() function
       
//----------------------------------------------------------------------------------------
      
}//close MegaPet class

#>