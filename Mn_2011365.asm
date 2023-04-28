# random number generator
# it will generate 3 random float number in range (0,1000)

.data

endl: .asciiz "\n"

twoDec: .float 100
threeDec: .float 1000
fourDec: .float 10000

file: .asciiz "SOLE.TXT"
sole2text: .asciiz "2 so le: "
sole3text: .asciiz "3 so le: "
sole4text: .asciiz "4 so le: "

#Float string to print
sole2: .asciiz "000.00" 
sole3: .asciiz "000.000"
sole4: .asciiz "000.0000"

#char to convert float to string. Just in order to write to file
num0: .byte'0'
num1: .byte'1'
num2: .byte'2'
num3: .byte'3'
num4: .byte'4'
num5: .byte'5'
num6: .byte'6'
num7: .byte'7'
num8: .byte'8'
num9: .byte'9'



.text
##############################################################################
# seed the random number generator
##############################################################################

# get the time
li	$v0, 30		# get time in milliseconds (as a 64-bit value)
syscall

move	$t0, $a0	# save the lower 32-bits of time

# seed the random generator (just once)
li	$a0, 1		# random generator id (will be used later)
move 	$a1, $t0	# seed from time
li	$v0, 40		# seed random number generator syscall
syscall

##############################################################################
# seeding done
##############################################################################
jal RANDOMINT
add $t1, $zero,$v1 
jal RANDOMINT
add $t2, $zero, $v1
jal RANDOMINT
add $t3, $zero, $v1


jal RANDOMFLOAT
mov.s $f2, $f0
jal RANDOMFLOAT
mov.s $f4, $f0
jal RANDOMFLOAT
mov.s $f6, $f0


#CONVERT RANDOM INT TO FLOAT
mtc1 $t1, $f1
cvt.s.w $f1, $f1

mtc1 $t2, $f3
cvt.s.w $f3, $f3

mtc1 $t3, $f5
cvt.s.w $f5, $f5

add.s $f7,$f1,$f2 #First Float is stored at $f1
add.s $f8,$f3,$f4 #Second Float is stored at $f2
add.s $f9,$f5,$f6 #Third Float is stored at $f3

#ROUND UP FLOAT 
#First Float
lwc1 $f10, twoDec
mul.s $f7,$f7,$f10
round.w.s $f7,$f7
cvt.s.w $f7,$f7

cvt.w.s $f7, $f7
mfc1 $t0,$f7

addi $t9,$zero,100
div $t0,$t9
mflo $t0 #integral part
mfhi $t1 #decimal part

#Deal with integral part first
addi $t9,$zero,10
div $t0,$t9

mflo $t0 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,2
la $a2,sole2 #$a2 hold address of sole2, sole2 is string needed to be print

jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,1
la $a2,sole2
jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,0
la $a2,sole2
jal ADDNUMTOSTRING

#Deal with decimal part second
div $t1,$t9

mflo $t1 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,5
la $a2,sole2 #$a2 hold address of sole2, sole2 is string needed to be print
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,4
la $a2,sole2
jal ADDNUMTOSTRING

#PRINT TO CHECK
la $a0, sole2text
li $v0,4
syscall

la $a0, sole2
li $v0,4
syscall
##########

#Second Float
lwc1 $f10, threeDec
mul.s $f8,$f8,$f10
round.w.s $f8,$f8
cvt.s.w $f8,$f8

cvt.w.s $f8, $f8
mfc1 $t0,$f8

addi $t9,$zero,1000
div $t0,$t9
mflo $t0 #integral part
mfhi $t1 #decimal part

#Deal with integral part first
addi $t9,$zero,10
div $t0,$t9

mflo $t0 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,2
la $a2,sole3 #$a2 hold address of sole2, sole2 is string needed to be print

jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,1
la $a2,sole3
jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,0
la $a2,sole3
jal ADDNUMTOSTRING

#Deal with decimal part second
div $t1,$t9

mflo $t1 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,6
la $a2,sole3 #$a2 hold address of sole2, sole2 is string needed to be print
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,5
la $a2,sole3
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,4
la $a2,sole3
jal ADDNUMTOSTRING

#PRINT TO CHECK
la $a0, endl
li $v0,4
syscall

la $a0, sole3text
li $v0,4
syscall

la $a0, sole3
li $v0,4
syscall
##########

#Third Float
lwc1 $f10, fourDec
mul.s $f9,$f9,$f10
round.w.s $f9,$f9
cvt.s.w $f9,$f9

cvt.w.s $f9, $f9
mfc1 $t0,$f9

addi $t9,$zero,10000
div $t0,$t9
mflo $t0 #integral part
mfhi $t1 #decimal part

#Deal with integral part first
addi $t9,$zero,10
div $t0,$t9

mflo $t0 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,2
la $a2,sole4 #$a2 hold address of sole2, sole2 is string needed to be print

jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,1
la $a2,sole4
jal ADDNUMTOSTRING

div $t0,$t9
mflo $t0 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,0
la $a2,sole4
jal ADDNUMTOSTRING

#Deal with decimal part second
div $t1,$t9

mflo $t1 #Quotient
mfhi $t2 #Remainder

#$a0 stored position
addi $a0,$zero,7
la $a2,sole4 #$a2 hold address of sole2, sole2 is string needed to be print
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,6
la $a2,sole4
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,5
la $a2,sole4
jal ADDNUMTOSTRING

div $t1,$t9
mflo $t1 #Quotient
mfhi $t2 #Remainder
addi $a0,$zero,4
la $a2,sole4
jal ADDNUMTOSTRING

#PRINT TO CHECK
la $a0, endl
li $v0,4
syscall

la $a0, sole4text
li $v0,4
syscall

la $a0, sole4
li $v0,4
syscall
##########

####### WRITE TO FILE ######

li $v0, 13
la $a0, file
li $a1,1
syscall

move $s0,$v0
#PRINT 2 SO LE
li $v0, 15
move $a0,$s0
la $a1,sole2text
la $a2, 9
syscall

li $v0, 15
move $a0,$s0
la $a1,sole2
la $a2, 6
syscall

#PRINT 3 SO LE
li $v0, 15
move $a0,$s0
la $a1,endl
la $a2, 1
syscall

li $v0, 15
move $a0,$s0
la $a1,sole3text
la $a2, 9
syscall

li $v0, 15
move $a0,$s0
la $a1,sole3
la $a2, 7
syscall

#PRINT 4 SO LE
li $v0, 15
move $a0,$s0
la $a1,endl
la $a2, 1
syscall

li $v0, 15
move $a0,$s0
la $a1,sole4text
la $a2, 9
syscall

li $v0, 15
move $a0,$s0
la $a1,sole4
la $a2, 8
syscall


li $v0,16
move $a0,$s0
syscall

###### CLOSE FILE ##########



li $v0,10
syscall

#FUNCTION TO ADD CHAR TO FLOAT STRING. ARGUMENTS ARE $a0. $a0 hold the position where a char should be stored
#For example we have string "000.00". $a0 hold 2 and we want to store '5' in that position.
#Therefore the result string will be 005.00.
ADDNUMTOSTRING:
beq $t2,0, add_0
beq $t2,1, add_1
beq $t2,2, add_2
beq $t2,3, add_3
beq $t2,4, add_4
beq $t2,5, add_5
beq $t2,6, add_6
beq $t2,7, add_7
beq $t2,8, add_8
beq $t2,9, add_9

add_0:
lb $a1,num0
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_1:
lb $a1,num1
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_2:
lb $a1,num2
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_3:
lb $a1,num3
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_4:
lb $a1,num4
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_5:
lb $a1,num5
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_6:
lb $a1,num6
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_7:
lb $a1,num7
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_8:
lb $a1,num8
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

add_9:
lb $a1,num9
beq $a0,0,place0
beq $a0,1,place1
beq $a0,2,place2
beq $a0,4,place4
beq $a0,5,place5
beq $a0,6,place6
beq $a0,7,place7

place0:
sb $a1,0($a2)
jr $ra
place1:
sb $a1,1($a2)
jr $ra
place2:
sb $a1,2($a2)
jr $ra
place4:
sb $a1,4($a2)
jr $ra
place5:
sb $a1,5($a2)
jr $ra
place6:
sb $a1,6($a2)
jr $ra
place7:
sb $a1,7($a2)
jr $ra
  





#li $v0, 10
#syscall



#RANDOMINT funtion will randomly generate an integer from (0 to 999).
#Return value will be stored at register $v1
RANDOMINT:
li	$a0, 1		# as said, this id is the same as random generator id
li	$a1, 999	# upper bound of the range
li	$v0, 42		# random int range
syscall

add $v1,$zero,$a0
jr $ra

RANDOMFLOAT:
li	$a0,1
li	$v0,43
syscall

jr $ra

