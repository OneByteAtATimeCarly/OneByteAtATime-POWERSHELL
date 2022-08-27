#Title: PowerShell - Module 07 - Classes 01 - Defining, Instantiating, Using
#Author: Carly S. Germany
#Date: 06/14/2020

#Classes offer a way to further encapsulate code. Being able to implement
#a class structure allows a programmer to take advantage of true object-oriented
#features like an inheritance hierarchy and polymorphism to devlop code that
#can more closely model real-world structures and processes. This enables the
#development of more sophisticated code structures with less code and enables a
#programmer to re-use more of their code in a project without re-inventing the wheel.

#Classes are like next-level functions. In the way functions allow a programmer
#to create modular, re-usable and easy to edit code? Classes extend this functionality
#to encapsulate both functions/methods and data members within themselves.
#Therefore, like an object in the real world? Classes encapsulate both what an
#object IS and what it DOES.

 
 <# --------------------------------------------------------------------------------- #>

 #1. Defining a Class
 
 Class Monster
 {
       [String]$Name = "Generic Monster";
       [int]$Health = 100;
       [int]$Attack = 7;
       [int]$Defense = 12;
 }

  <# --------------------------------------------------------------------------------- #>

  #2. Creating an Instance of a Class once you have defined it

  function Create_Monster1
  {
           Clear;
           Write("`nInstantiating a Monster object using New-Object.");

           $MONSTER1 = New-Object Monster;

           Write("`n");
           Write("Name: " + $MONSTER1.Name);
           Write("Health: " + $MONSTER1.Health);
           Write("Attack: " + $MONSTER1.Attack);
           Write("Defense: " + $MONSTER1.Defense);
           Write("`n");
  }

  <# --------------------------------------------------------------------------------- #>

  function Create_Monster2
  {
           Write("`nInstantiating a Monster object using ::new.");

           $MONSTER2 = [Monster]::new();

           Write("`n");
           Write("Name: " + $MONSTER2.Name);
           Write("Health: " + $MONSTER2.Health);
           Write("Attack: " + $MONSTER2.Attack);
           Write("Defense: " + $MONSTER2.Defense);
           Write("`n");
  }

  
#------- Invocations -------
  Create_Monster1;
  Create_Monster2;


