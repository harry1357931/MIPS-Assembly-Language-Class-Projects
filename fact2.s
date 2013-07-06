
 
 .data              #  Data declaration section
                    #  Store the following words in succesive Memory Words   
 Number_1: .asciiz  "Enter number 1 in range [1,10]:"
 result_message: .asciiz "The result of F(n) for user input n is: "

 .text   
         
   ## Recursion Starts  
   ####################################
      addi $a0, $0, 4
      # F -- Recursive Function
      jal F                          # Call to Recursive Function F from main function
      
      move $t3, $v0 
      
      la $a0, result_message         # Load address of String result_message in $a0   
      li $v0, 4                      # To Print String
      syscall

      move $a0, $t3
      li $v0, 1                      # To print an integer
      syscall  
      
      j Done
   ##################################
     F:  addi $sp, $sp, -8       # allocating space for two variables n = $t0 and return address $ra
         sw $a0, 0($sp)          # Store variable n on Stack  
         sw $ra, 4($sp)          # Store return address on Stack
             
    ## If (n==1 or n==2) then goto base_case; else goto continue;
        li $t1, 1                     
        beq $a0, $t1, base_case            # Checking if n==1
        li $t2, 2
        beq  $a0, $t2, base_case           # Checking if n==2
        j Continue                         # else goto continue
    ##
  base_case:    addi $v0, $0, 10               # base case for n=1 or n=2 , F(n)=10, return variable $v0 = 10
                  addi $sp, $sp, 8             # De-allocating space after base case
                  jr $ra                       # Jump to address contained in register $ra
    ##
  Continue:  addi $a0, $a0, -1                 # Continue: for Recursive call, and also decreasing n= n-1
               jal F                           # Recursive Call to function F
    ##  After returning back from prev. call, loading variables again
       lw $a0, 0($sp)                         
       lw $ra, 4($sp)
       addi $sp, $sp, 8
   ##
     sll $a0, $a0, 1            #  Multiplying by 2 or 2*n   
     mul $v0, $a0, $v0          #  2n*f(n-1) 
   ##
     jr $ra                     #  Jump to address in Register $ra
   
    Done:                                       
         
   ######################################      
