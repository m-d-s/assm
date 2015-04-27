# Michael Simpson
# CS322
# Assignment 2
# 04-24-15

	.file	"program2.s"
    .text
	.globl	f
f:

### This is where your code begins ...
    movq %rdi, %rdx            # Copy the pointer to the first array into %rdx
    movl (%rdx), %ecx          # Retrieve the length of the first array and store in %ecx
    movl  $0,  %eax            # Initialize eax to zero, this will contain the total  
first:
    cmpl  $1, %ecx             # Compare the length of the fist array to one
    jl    phase2               # If the length is less than one, jump to phase2
    addq  $4, %rdx             # Move pointer to first array ahead 32 bits
    cmpl  $0, (%rdx)           # Compare the value at that position to zero
    jne   notEq                # If the value was not equal to zero jump to notEq
    incl  %eax                 # Increment the value in %eax
notEq:    
    decl  %ecx                 # Decrement the length of the array
    jmp   first                # Loop back to repeat the comparison

phase2:
    movq %rsi, %rdx            # Copy the pointer to the second array into %rbx
    movl (%rdx), %ecx          # Retrieve the length of the second array and store into %ecx

second: 
    cmpl  $1, %ecx             # Compare the length of the second array to one
    jl    done                 # If the length is less than one, jump to done
    addq  $4, %rdx             # Move pointer to second array ahead 32 bits
    cmpl  $1, (%rdx)           # Compare the value at that position to zero
    jl    notGt                # If the value was not greater than zero jump to notGt
    incl  %eax                 # Increment the value in %eax
notGt:    
    decl  %ecx                 # Decrement the length of the array
    jmp   second                # Loop back to repeat the comparison
   
### This is where your code ends ...
done:
	ret
