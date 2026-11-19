# $a0 = string
# $a1 = key

encrypt:
    move $t0,$a0

encLoop:
 lb $t1,0($t0)
    beq $t1,$zero,encDone

    # uppercase
 li $t2,65
 blt $t1,$t2,encNext
    li $t2,90
 ble $t1,$t2,encUpper

    # lowercase
 li $t2,97
    blt $t1,$t2,encNext
 li $t2,122
 ble $t1,$t2,encLower

encNext:
    addi $t0,$t0,1
 j encLoop


encUpper:
    add $t1,$t1,$a1

    li $t2,90
 ble $t1,$t2,encStoreUpper

    addi $t1,$t1,-26

encStoreUpper:
 sb $t1,0($t0)
    addi $t0,$t0,1
 j encLoop


encLower:
 add $t1,$t1,$a1

 li $t2,122
    ble $t1,$t2,encStoreLower

 addi $t1,$t1,-26

encStoreLower:
    sb $t1,0($t0)
 addi $t0,$t0,1
    j encLoop


encDone:
 jr $ra




# $a0 = string
# $a1 = key

decrypt:
 move $t0,$a0

decLoop:
    lb $t1,0($t0)
 beq $t1,$zero,decDone

 li $t2,65
    blt $t1,$t2,decNext
 li $t2,90
 ble $t1,$t2,decUpper

 li $t2,97
 blt $t1,$t2,decNext
    li $t2,122
 ble $t1,$t2,decLower


decNext:
 addi $t0,$t0,1
    j decLoop


decUpper:
 sub $t1,$t1,$a1

 li $t2,65
    bge $t1,$t2,decStoreUpper

 addi $t1,$t1,26

decStoreUpper:
 sb $t1,0($t0)
 addi $t0,$t0,1
    j decLoop


decLower:
    sub $t1,$t1,$a1

 li $t2,97
 bge $t1,$t2,decStoreLower

    addi $t1,$t1,26

decStoreLower:
 sb $t1,0($t0)
    addi $t0,$t0,1
 j decLoop


decDone:
    jr $ra