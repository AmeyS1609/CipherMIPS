# CipherMIPS - main.asm
# Menu, input, and integration for the Caesar and XOR ciphers
# In MARS, open and assemble this file only, the includes at the bottom pull in the cipher code

.data
menu:		.asciiz "\n========== CipherMIPS ==========\n1. Caesar Cipher - Encrypt\n2. Caesar Cipher - Decrypt\n3. XOR Cipher\n4. Exit\nSelect an option: "
msgPrompt:	.asciiz "Enter a message: "
keyPrompt:	.asciiz "Enter a key: "
encLabel:	.asciiz "Encrypted: "
decLabel:	.asciiz "Decrypted: "
xorLabel:	.asciiz "XOR result (byte values): "
xorBackLabel:	.asciiz "\nXOR again with same key: "
badChoice:	.asciiz "Invalid choice, enter 1 to 4.\n"
badKey:		.asciiz "Key must be 1-25 for Caesar or 1-255 for XOR.\n"
goodbye:	.asciiz "Goodbye!\n"
newline:	.asciiz "\n"
space:		.asciiz " "
messageBuffer:	.space 256		# the message the user types in
outputBuffer:	.space 256		# where xorCipher writes its result

.text
.globl main
main:
	li	$v0, 4			# 4 = print string
	la	$a0, menu		# print the menu
	syscall
	li	$v0, 5			# 5 = read integer
	syscall
	move	$s1, $v0		# $s1 = choice

	li	$t0, 4			# option 4 is exit
	beq	$s1, $t0, exit		# leave the program
	blt	$s1, 1, invalid		# below 1 is not an option
	bgt	$s1, 4, invalid		# above 4 is not an option

	jal	readMessage		# message goes into messageBuffer
	jal	readKey			# key goes into $s0

	beq	$s1, 1, doEncrypt	# option 1 = Caesar encrypt
	beq	$s1, 2, doDecrypt	# option 2 = Caesar decrypt
	j	doXor			# option 3 is the only one left

doEncrypt:
	la	$a0, messageBuffer	# $a0 = address of the message
	move	$a1, $s0		# $a1 = key
	jal	encrypt			# shift the message forward in place
	la	$a0, encLabel		# print "Encrypted: "
	j	printResult		# then print the message

doDecrypt:
	la	$a0, messageBuffer	# $a0 = address of the message
	move	$a1, $s0		# $a1 = key
	jal	decrypt			# shift the message backward in place
	la	$a0, decLabel		# print "Decrypted: "
	j	printResult		# then print the message

doXor:
	la	$a0, messageBuffer	# $a0 = input message
	la	$a1, outputBuffer	# $a1 = where the result goes
	move	$a2, $s0		# $a2 = key
	jal	xorCipher		# XOR every byte with the key

	li	$v0, 4			# 4 = print string
	la	$a0, xorLabel		# print "XOR result (byte values): "
	syscall
	la	$t0, outputBuffer	# XOR output can be unprintable so print each byte as a number
printBytes:
	lbu	$a0, 0($t0)		# load the byte unsigned so values over 127 stay positive
	beq	$a0, $zero, xorAgain	# 0 means the end of the output
	li	$v0, 1			# 1 = print integer
	syscall
	li	$v0, 4			# 4 = print string
	la	$a0, space		# space between the numbers
	syscall
	addi	$t0, $t0, 1		# next byte
	j	printBytes

xorAgain:
	la	$a0, outputBuffer	# XOR the result again with the same key
	la	$a1, messageBuffer	# put it back in messageBuffer
	move	$a2, $s0		# same key
	jal	xorCipher		# this should give back the original message
	la	$a0, xorBackLabel	# print "XOR again with same key: "
	j	printResult		# then print the message

printResult:
	li	$v0, 4			# 4 = print string, $a0 has the label
	syscall
	li	$v0, 4			# 4 = print string
	la	$a0, messageBuffer	# print the message
	syscall
	li	$v0, 4			# 4 = print string
	la	$a0, newline		# end the line
	syscall
	j	main			# back to the menu

invalid:
	li	$v0, 4			# 4 = print string
	la	$a0, badChoice		# tell the user the choice was wrong
	syscall
	j	main			# show the menu again

exit:
	li	$v0, 4			# 4 = print string
	la	$a0, goodbye		# print goodbye
	syscall
	li	$v0, 10			# 10 = exit
	syscall


# readMessage: reads the message into messageBuffer and removes the newline at the end
readMessage:
	li	$v0, 4			# 4 = print string
	la	$a0, msgPrompt		# ask for the message
	syscall
	li	$v0, 8			# 8 = read string
	la	$a0, messageBuffer	# store it in messageBuffer
	li	$a1, 256		# max size of the buffer
	syscall
	la	$t0, messageBuffer	# $t0 walks through the message
findNewline:
	lb	$t1, 0($t0)		# load the current character
	beq	$t1, $zero, readDone	# end of the string
	beq	$t1, 10, removeNewline	# 10 = newline
	addi	$t0, $t0, 1		# next character
	j	findNewline
removeNewline:
	sb	$zero, 0($t0)		# replace the newline with 0 so the string ends there
readDone:
	jr	$ra			# return to main


# readKey: reads the key into $s0, 1-25 for Caesar and 1-255 for XOR, asks again if it's out of range
readKey:
	li	$v0, 4			# 4 = print string
	la	$a0, keyPrompt		# ask for the key
	syscall
	li	$v0, 5			# 5 = read integer
	syscall
	move	$s0, $v0		# $s0 = key
	li	$t0, 25			# max key for Caesar
	bne	$s1, 3, checkKey	# Caesar options keep 25
	li	$t0, 255		# max key for XOR since the key is one byte
checkKey:
	blt	$s0, 1, keyError	# key has to be at least 1
	bgt	$s0, $t0, keyError	# and not more than the max
	jr	$ra			# return to main
keyError:
	li	$v0, 4			# 4 = print string
	la	$a0, badKey		# key out of range
	syscall
	j	readKey			# ask again


# Caesar procedures (encrypt, decrypt) and the XOR procedure (xorCipher) from the other branches
.include "caesar_cipher.asm"
.include "xorCipher.asm"