    .file	"program4.s"
        .text
	.globl	f
f:

### This is where your code begins ...

    movl  (%rdi),  %ecx           # Copy the length of the first array
    movl  (%rsi),  %eax           # Copy the length of the second array
    
    cmpl   %ecx,   %eax           # Compare the two lengths
    je     equal                  # Jump if lengths are the same
    subl   %eax,   %ecx           # Subtract the two lengths
    movl   %ecx,   %eax           # Copy the difference
    sar    $31,    %ecx           # Generate bit mask by extending the sign field
    xorl   %ecx,   %eax           # Xor the mask with the copied difference
    subl   %ecx,   %eax           # Subract the Xor from the mask to get absolute value 
    jmp done
    
### This is where your code ends ...

equal:
    movq   %rdi,   %rcx           # Copy the pointer to the first array
    movq   %rsi,   %rdx           # Copy the pointer to the second array
loop:
    cmpl   $0,     %eax           # Compare the length to zero
    je    done                    # If equal to zero jump to done
    addq   $4,     %rcx           # Move first pointer ahead one position
    addq   $4,     %rdx           # Move second pointer ahead one postion
    movl  (%rcx),  %r8d           # Copy element in first array
    movl  (%rdx),  %r9d           # Copy element in second array
    movl   %r8d,  (%rdx)          # Swap elements
    movl   %r9d,  (%rcx)          # Swap elements
    decl   %eax                   # Decrement the length
    jmp   loop                    # Repeat the loop
done:
    ret
