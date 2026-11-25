xorCipher:
add $t0, $a0, $zero  #copy input into $t0
add $t1, $a1, $zero  #copy output into $t1
add $t2, $a2, $zero  #copy key into $t2

xor_loop:
lb $t3, 0($t0)   #load one character from the input message  
                  # 0($t0) means the character at the current address
beq $t3, $zero, xor_done # if the character is 0, message is finished 

xor $t4, $t3, $t2  #XOR the current character with the key
                  # the changed character is placed in $t4

sb $t4, 0($t1)    # store the changed character in the output buffer

addi $t0, $t0, 1  #move input pointer to the next character 
addi $t1, $t1, 1 # move output pointer to the next empty space  

j xor_loop #go back and process the next character                                                       

xor_done: 
sb $zero, 0($t1)  #put 0 at the end of the output message
jr $ra #return to the main program
