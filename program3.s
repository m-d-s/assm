	.file	"program3.s"
        .text
	.globl	f
f:

### This is where your code begins ...

    
    movl    (%rdi), %eax         # Move the length of the first array into %eax
    movq     %rdi,  %rcx         # Copy the pointer to the first array into %rcx
    movq     %rdi,  %rdx         # Copy the pointer to the first array into %rdx

    cmpl     $0,    %eax         # Compare the length of the first array to zero
    jle     done                 # If length is zero, jump to done 
    movslq   %eax,  %rax         # Sign extend the 32 bit value to 64 bits
    addq     $4,    %rdx         # Move the pointer in %rdx ahead one position past the length
    imulq    $4,    %rax         # Multiply the value in %rax by four
    addq     %rax,  %rdx         # Jump the %rdx pointer to the end of the array
    

swap: 
    cmpq     %rdx,  %rcx         # Compare the pointers in %rdx and %rcx
    jge     done                 # Jump to done if %rcx is greater than or equal to %rdx
    movl    (%rdx), %r8d         # Copy the greater indexed value 
    movl    (%rcx), %r9d         # Copy the lesser indexed value
    movl     %r8d, (%rcx)        # Swap the greater indexed value into the lesser  
    movl     %r9d, (%rdx)        # Swap the lesser indexed value into the greater
    addq     $4,    %rcx         # Increment the lesser indexed value
    subq     $4,    %rdx         # Decrement the greater indexed value
    jmp     swap                 # loop back
### This is where your code ends ...
done:
    movl     $1, %eax             # return 
	ret
