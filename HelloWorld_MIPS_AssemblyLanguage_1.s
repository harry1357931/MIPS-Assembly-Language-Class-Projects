#################################################################################
#  Date: 04-24-2012
#  Program Name:  HelloWorld_MIPS_AssemblyLanguage_1.s  ,A "Hello World" program.
#  Name: Gurpreet Singh
#  Last Modified Date: 04-23-2012
#  Description: This program will print a String: "Hello World !!!!" 
#  
#    Pseudocode: 
#      In C++
#       cout<<"Hello World !!!!";
#      In C
#       printf("Hello World !!!!");
#
#  Registers used:
#  $v0: syscall parameter and return value.
#  $a0: syscall parameter--  Store the address of String to print.
#
#################################################################################
 .text
 main:            # Start of Code Section
 # rough work --ori $s2, $0, 50
      # load the addr of hello_msg into $a0.
 li $v0, 2              # 4 is the print_string syscall.
 syscall    
 move $f12, $f0          # do the syscall.
li $v0,6
syscall

 li $v0, 10              # 10 is the exit syscall.
 syscall                 # do the syscall.

 ## Data for the program:
 .data              #  Data declaration section
                    #  Store the following words in succesive Memory Words 
 hello_msg: .asciiz "Hello World !!!!\n"

 ## end of Singh_Gurpreet_h1_1.s --- "Hello World Program"
