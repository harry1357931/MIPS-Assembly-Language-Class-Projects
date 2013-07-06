###################################################################
#  Date: 04-24-2012
#  Program Name:  Subtractor_MIPS_AssemblyLanguage_2.s  
#  Name: Gurpreet Singh
#  Last Modified Date: 04-23-2012
#  Description: This program will Prompt the user to enter two integers one by one and then compute their difference
#               Also, if the no. entered by the user is not in the interval [-5,10], then it will prompt the user again.
#    Pseudocode: 
#      In C++
#        
#             int n1, n2, d;     // d= difference
#    again_1: cout<<"Enter number 1 in range [-5, 10]:";
#              cin>>n1;
#              if((n1<-5)&&(n1>10))
#                goto again_1; 
#    again_2: cout<<"Enter number 2 in range [-5, 10]:";
#              cin>>n2;
#              if((n2<-5)&&(n2>10))
#                goto again_2; 
#               
#              d= n1-n2;        // Compute the difference
#              cout<<"The difference is:"<<d<<endl;
#              
#              system("pause");
#              return 0;      
#
#  Registers used:
#  $t0 - used to hold the first number.
#  $t1 - used to hold the second number.
#  $t2 - used to hold the difference of the $t1 and $t2.
#  $v0 - syscall parameter and return value.
#  $a0 - syscall parameter.
#
#####################################################################
 
 .data              #  Data declaration section
                    #  Store the following words in succesive Memory Words   
 Number_1: .asciiz  "Enter number 1 in range [-5,10]:"
 Number_2: .asciiz  "\nEnter number 2 in range [-5,10]:" 
 Difference: .asciiz  "\nThe Difference is :"

  .text
   main:         # Start of Code Section 
 
   ## Display the String "Enter number 1:"
  again_1: la $a0, Number_1     # load address of String Number_1    
          li $v0, 4            # load syscall to display String 
          syscall              # make the syscall  
 
  ## Get First number from user, put into $t0.
          li $v0, 5            # load syscall read_int into $v0.
          syscall              # make the syscall.
 
   ## Check for Number_1 b/w [-5, 10]
          slti $t3, $v0, 11
          slti $t4, $v0, -5
          beq $t3, $t4, again_1
          move $t0, $v0 # move the number read into $t0.

   ## Display the String "Enter number 2:"
 again_2: la $a0, Number_2     # load address of String Number_1
          li $v0, 4            # load syscall to display String 
          syscall              # make the syscall  
  
 
   ## Get Second number from user, put into $t1.
          li $v0, 5          # load syscall read_int into $v0.
          syscall            # make the syscall.
  
   ## Check for Number_2 b/w [-5, 10] 
          slti $t3, $v0, 11       
          slti $t4, $v0, -5
          beq $t3, $t4, again_2
          move $t1, $v0        # move the number read into $t1.

   ## Compute the difference and Store in $t2
          sub $t2, $t0, $t1       # compute the difference and stored it into t2.

          la $a0, Difference     # load address of String Difference
          li $v0, 4            # load syscall to display String 
          syscall              # make the syscall  
 
   ## Print out $t2.
          move $a0, $t2         # move the number to print into $a0.
          li $v0, 1             # load syscall print_int into $v0.
          syscall               # make the syscall. 
   
   ## Call for exit
          li $v0, 10      # syscall code 10 is for exit.
          syscall         # make the syscall.

 ## end of end of Singh_h1_2.s
