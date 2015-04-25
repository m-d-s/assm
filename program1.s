# Michael Simpson
# CS322
# Assignment 2
# 04-24-15

	.file	"program1.s"
    .text
	.globl	f
f:

### This is where your code begins ...
    movq %rdi, %rbx
    movl (%rbx), %ecx            
    movl  $0,  %eax            # Initialize eax to zero, this will contain the total
    movl  $0, %ecx    
first:
    cmpl  $0, %ecx               # Compare the length of the fist image to one
    jng   setUp                # If ebx equal to zero jump to next routine
    addq  $4, %rbx               # Move pointer to first image ahead 32 bits
    addl  (%rbx), %eax
    decl  %ecx                   # Decrement the length of the image
    jmp   first                  # Loop back to repeat the comparison

setUp:
    movq %rsi, %rbx
    movl (%rbx), %ecx    

second: 
    cmpl  $0, %ecx               # Compare the length of the second image to one
    jng   done                  # If ecx equal to zero jump to next routine
    addq  $4, %rbx              # Move pointer to second image ahead 32 bits
    addl  (%rbx), %eax           # Add the value in that position to the total
    decl  %ecx                   # Decrement the length of the image
    jmp   second                 # Loop back to repeat the comparison
    
### This is where your code ends ...
done:
    
	ret
