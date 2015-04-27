# Michael Simpson
# CS322
# Assignment 2
# 04-24-15

	.file	"program1.s"
    .text
	.globl	f
f:

### This is where your code begins ...
    movq %rdi, %rdx            # Copy the pointer to the first image into %rbx
    movl (%rdx), %ecx          # Retrieve the length of the first image and store in %ecx
    movl  $0,  %eax            # Initialize eax to zero, this will contain the total  
first:
    cmpl  $1, %ecx             # Compare the length of the fist image to one
    jl    phase2               # If the length is less than one, jump to phase2
    addq  $4, %rdx             # Move pointer to first image ahead 32 bits
    addl  (%rdx), %eax         # Add the integer value at that position to the total
    decl  %ecx                 # Decrement the length of the image
    jmp   first                # Loop back to repeat the comparison

phase2:
    movq %rsi, %rdx            # Copy the pointer to the second image into %rbx
    movl (%rdx), %ecx          # Retrieve the length of the second image and store into %ecx

second: 
    cmpl  $1, %ecx             # Compare the length of the second image to one
    jl   done                  # If the length is less than one jump to done
    addq  $4, %rdx             # Move pointer to second image ahead 32 bits
    addl  (%rdx), %eax         # Add the value in that position to the total
    decl  %ecx                 # Decrement the length of the image
    jmp   second               # Loop back to repeat the comparison
    
### This is where your code ends ...
done:
	ret
