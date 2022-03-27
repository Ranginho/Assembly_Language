print all prime numbers from 1 to N using the Sieve of Eratosthenes algorithm.
input: integer N  (3<=N<=100000).
output: prime numbers from 1 to N.

.data
primes1:     .asciiz    "\nPrime numbers between 2 and 100000: "
newLine:     .asciiz     "\n"
space:       .asciiz     " "

.text
main:
    li $s0, 100000

    mul     $a0     $s0     4
    li      $v0     9
    syscall
    move    $s1     $v0
    
    li      $s2     0

    bool_loop:
    sb      $zero,    0($s1)
    beq     $s0     $s2     endbool
    addi    $s1     $s1     1
    addi    $s2     $s2     1
    j       bool_loop
    endbool:
    li      $s2     1

    outer_loop:
    addi    $s2     $s2     1
    mult    $s2     $s2 
    mflo    $s3
    bgt     $s3     $s0     exit

    lb      $s4     0($s1)
    bnez    $s4     outer_loop
    mul     $s5     $s2     $s2

    inner_loop:
    bgt     $s5     $s0     outer_loop
    add     $s6     $s5     $s1
    sb      $s2     0($s6)
    add     $s5     $s5     $s2 
    j       inner_loop


    j       outer_loop
    exit:
    li      $v0     4
    la      $a0     primes1
    syscall

    li      $s2     1
    print:
    addi    $s2     $s2     1
    bgt     $s2     $s0     done
    add     $s3     $s1     $s2
    lb      $s4     0($s3)


    bnez    $s4     print
    li      $v0     1
    move    $a0     $s2
    syscall

    li      $v0     4
    la      $a0     space
    syscall

    j print

    done:

    li      $v0     4
    la      $a0     newLine
    syscall

    li      $v0     10
    syscall
