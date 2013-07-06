###################################################################
#  Date: 05-11-2012
#  Program Name:  Singh_Gurpreet_H2.s  
#  Name: Gurpreet Singh
#  Last Modified Date: 05-16-2012
#  Description:      
#           The program will prompt the user to enter an Integer between 1 and 10. Then, depending on value of n
#           implement 3 cases: 
#           1) for   1<=n<=6 , it will implement a Recursive Procedure F and then print out the final value.
#           2) for   7<=n<10 , it will declare an array, then read and display each character, and then
#                              print the character array in reverse order.
#           3) for    n=10,  it will display a Joke.                    
#  Pseudocode:
#         In C++
#          #include<iostream>
#          int F(int n){             // Recursive Procedure
#            if(n==1 || n== 2)
#                return 10;
#            else
#             return (2*n*F(n-1));    
#          }
#          int main() {
#            int n;
#     again: cout<<"Enter number b/w [1,10]: ";
#            cin>>n;
#            
#            if(n>10 && n<1 )           // Prompting the user again
#               goto again;
#            
#            // Checking for Cases
#            if(n>=1 && n<=6)                              // Case 1
#            {
#               cout<<"The F(n) for n is :"<<F(n)<<endl;
#            }
#            
#            else if(n>=7 && n< 10){                       // Case 2
#             
#                char chararray[10];
#                for(int i=0; i< 10; i++){
#                  cin>>chararray[i];
#                  cout<<"\n The character you entered is: "<<array[i] <<endl;
#                }
#                for(int i=9; i>=0; i--) {
#                  cout<<chararray[i]<<endl;
#                 } 
#             } // case for n 7 to 9 ends here 
#            
#              else if (n==10)                             // Case 3
#                cout<<"Display a Joke";
#          
#           system("pause");
#           return 0;
#          
#        }            
#         
#   # Pseudo Code ends here         
#
#  Registers used:
#
#    $t0 - used to hold the Input number, n.
#    $t1 - For Temporary values, hold temporary values on many places
#    $t2 - For Temporary values, hold temporary values on many places
#    $t3 - For Temporary values, hold temporary values on many places
#    $v0 - syscall parameter and return value.
#    $a0 - syscall parameter, Multiple uses- To hold the addresses, values, System call parameter.
#    $a3 - I used it to hold some temporary stuff
#    $sp - Stack Pointer, used in lw, sw instructions and allocating and deallocating space 
#    $ra - Contains the address of Instruction, Used in Conjunction with jal usually
#
#####################################################################
 
 .data              #  Data declaration section
                    #  Store the following words in succesive Memory Words   
   
   Number_by_User: .asciiz  "Hello Miss Fluture...\n Enter a number in range [1,10]:"
   
   result_message: .asciiz "The result of F(n) for the number you entered is: "
   
   Joke: .asciiz  "The Joke is:\n Two bytes meet.  The first byte asks, \n 'Are you ill?' The second byte replies, 'No, just feeling a bit off.'"
   
   Array: .byte  0:10
   
   typedchar: .asciiz "\nThe character you typed is: " 
   
   rev_order: .asciiz "\nThe characters in reverse order are: " 
   
   nextline: .asciiz "\n"
   
   Enter_Char_String: .asciiz "Enter Ten Characters to fill an Char array without Pressing the button 'Enter'\n: "    
 
  # Text Segment or Main function
  .text
  
    main:         # Start of Code Section 
 
  ## Display the String "Enter number :"
  again_1: la $a0, Number_by_User           # load address of String Number_1    
          li $v0, 4                   # load syscall to display String 
          syscall                     # make the syscall  
 
  ## Get First number from user
          li $v0, 5                   # load syscall read_int into $v0.
          syscall                     # make the syscall.
 
   ## Check for Number_1 b/w [1, 10] and put into $t0 if valid.
          slti $t3, $v0, 11
          slti $t4, $v0, 1
          beq $t3, $t4, again_1
          move $t0, $v0               # move the number read into $t0.
 
 ##Case1
  ## Check for Number_1 b/w [1, 6] 
  L1:     slti $t3, $t0, 7
          slti $t4, $t0, 1
          beq $t3, $t4, L2               # if number is not b/w 1 to 6 then jump to another case
          ## above means if(n<1&&n>6) then go to L2--second case    
          ## else compute the stuff F(n)
          
      ## Recursion Starts  
   
      move $a0, $t0
      # F -- Recursive Function
      jal F                          # Call to Recursive Function F from main function
      
      move $t3, $v0 
      
      la $a0, result_message         # Load address of String result_message in $a0   
      li $v0, 4                      # To Print String
      syscall

      move $a0, $t3
      li $v0, 1                      # To print an integer
      syscall  
      
      j Exit
   ## Recursive Procedure Starts
     F:  addi $sp, $sp, -8             # allocating space for two variables n = $t0 and return address $ra
         sw $a0, 0($sp)                # Store variable n on Stack  
         sw $ra, 4($sp)                # Store return address on Stack
             
    ## If (n==1 or n==2) then goto base_case; else goto continue;
        li $t1, 1                     
        beq $a0, $t1, base_case            # Checking if n==1
        li $t2, 2
        beq  $a0, $t2, base_case           # Checking if n==2
        j Else                         # else goto continue
    
  base_case:    addi $v0, $0, 10               # base case for n=1 or n=2 , F(n)=10, return variable $v0 = 10
                  addi $sp, $sp, 8             # De-allocating space after base case
                  jr $ra                       # Jump to address contained in register $ra
    
  Else:  addi $a0, $a0, -1                 # Continue: for Recursive call, and also decreasing n= n-1
               jal F                           # Recursive Call to function F
     ##  After returning back from prev. call, loading variables again
       lw $a0, 0($sp)                         
       lw $ra, 4($sp)
       addi $sp, $sp, 8
   
       sll $a0, $a0, 1            #  Multiplying by 2 or 2*n   
       mul $v0, $a0, $v0          #  2n*f(n-1) 
  
       jr $ra                     #  Jump to address in Register $ra
   ## Recursive Procedure ends                                       
 
  ## Case 1 Over                
   
  ##Case2
  ##Check for Number b/w [7, 10)       
  L2:     slti $t3, $t0, 10
          slti $t4, $t0, 7
          beq $t3, $t4, L3               ## if number is not b/w [7 to 9] then jump to case 3
         ## above means if(n>=7&&n<=9) then go to L3--Third case    
         ## Enter all array stuff
               
       # To Print the instructions before reading characters         
        la $a0, Enter_Char_String
        li $v0, 4
        syscall        
               
         la $a3, Array               # Address of base of Array in $a3
         move $t0, $a3                # Moving address to $t0
         addi $t1, $t0, 10            # Address of Last element of Array in $t1
       # Now $t0 contains the address of base of array 
   again_C:  beq $t0, $t1, Rev_String
           
            la $a0, nextline
           li $v0, 4
           syscall
           
           
           li $v0, 12                # Read Char and value returned in $v0
           syscall
           
           sb $v0, 0($t0)                # Store a byte or store a character
            
           la $a0, typedchar
           li $v0, 4
           syscall
            
            
           lb $a0, 0($t0)                  # loading character from Memory to Register
           li $v0, 11                     # Print the value Stored in $a0 
           syscall
           addi $t0, $t0, 1 
           
           j again_C                      # Jump to again_C, To read and print the next Character
   
 Rev_String:  la $a0, rev_order           # Just to Print Info String, before reversing the actual array
              li $v0, 4
              syscall   
                  
 Rev:   beq $t1, $a3, Exit         # I used the old $t1 value, before again_C one...here, breaker for loop
              
                      
           
           lb $a0, 0($t1)                  # loading character from Memory to Register
           li $v0, 11                     # Print the value Stored in $a0 
           syscall
           addi $t1, $t1, -1
           
           la $a0, nextline              # T go to next line
           li $v0, 4
           syscall

           
          j Rev                                                                               
         
    ## Case 2 Over
  
##Case3
  ## for Number n=10       
  L3:     la $a0, Joke         # load address of String Difference
          li $v0, 4            # load syscall to display String 
          syscall   
          ## Display a Joke-- Define Joke above in data segment
    ## Case 3 Over
   
 
## Call for exit
Exit:     li $v0, 10      # syscall code 10 is for exit.
          syscall         # make the syscall.

 ## end of Singh_Gurpreet_H2.s


 
