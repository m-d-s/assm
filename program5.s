    .file	"program5.s"
        .text
	.globl	f
f:

### This is where your code begins ...

    movl  (%rdi),  %ecx           # Copy the length of the first array
    movl  (%rsi),  %r10d           # Copy the length of the second array
    
    cmpl   %ecx,   %r10d           # Compare the two lengths
    je     equal                  # Jump if lengths are the same
    addl   %ecx,   %r10d
    movl   %r10d,  %eax
    jmp done
    
### This is where your code ends ...

equal:
    movq   %rdi,   %rcx           # Copy the pointer to the first array
    movq   %rsi,   %rdx           # Copy the pointer to the second array
    movl   $0,     %eax
loop:
    cmpl   $0,     %r10d           # Compare the length to zero
    je    done                    # If equal to zero jump to done
    addq   $4,     %rcx           # Move first pointer ahead one position
    addq   $4,     %rdx           # Move second pointer ahead one postion
    movl  (%rcx),  %r8d           # Copy element in first array
    movl  (%rdx),  %r9d           # Copy element in second array
    cmpl   %r8d,   %r9d
    jg    skip
    movl   %r8d,  (%rdx)          # Swap elements
    movl   %r9d,  (%rcx)          # Swap elements
skip:    
    imull  %r8d,   %r9d
    addl   %r9d,   %eax
    decl   %r10d                   # Decrement the length
    jmp   loop                    # Repeat the loop
done:
    ret
