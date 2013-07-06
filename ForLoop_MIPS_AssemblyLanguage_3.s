###################################################################
#  Date: 04-24-2012
#  Program Name:  ForLoop_MIPS_AssemblyLanguage_3.s  
#  Name: Gurpreet Singh
#  Last Modified Date: 04-23-2012
#  
#  Description: This program implements the for loop in assembly language and print no. from 0 to 35 in reverse order
#    
#  Pseudocode: 
#      In C language
#           int x; 
#           for(x=35; x>=0; x--)
#           { printf("x=%d", x); 
#           }       
#      
# Registers used:
#  $v0: syscall parameter and return value.
#  $a0: syscall parameter-- Store the address of String to print.
#  $s0: Permanent or save register-- Stores 35 initially, then reduce by 1 
#  $t0: Temporary register-- in this program, to store 0 or 1 using slti
#  $0 : Contains integer Zero
#
####################################################################
# this program implements the for loop and print no. from 0 to 35 in reverse order
.data
 NextlineCharacter: .asciiz  "\n"

.text
 main:    # Start of Code Section 
 
      li $s0, 35                     # x=35  or $s0=35
 FOR: slti $t0, $s0, 0          # x=$s0,    if $s0 >=0 , then this will set $t0 = 0  else $t0= 1
      beq $t0, $0, PRINT        # $t0= $0, then print  
      j EXIT
 
  ## Print out x or $s0
PRINT: move $a0, $s0 # move the number to print into $a0.
       li $v0, 1 # load syscall print_int into $v0.
       syscall # make the syscall. 
       
    ## To go to nextline  
      la $a0, NextlineCharacter     # load address of Nextline
      li $v0, 4            # load syscall to next line
      syscall              # make the syscall   
    ## Reduce x by 
       add $s0, $s0, -1            # reduce x by 1 everytime
       j FOR

 EXIT: li $v0, 10 # syscall code 10 is for exit.
       syscall # make the syscall.

 ## end of Singh_h1_3.s
 
