     .file	"program5.s"
        .text
    .globl	f
f:

### This is where your code begins ...

    movl  (%rdi),  %ecx           # Copy the length of the first array
    movl  (%rsi),  %eax           # Copy the length of the second array

    cmpl   %ecx,   %eax           # Compare the two lengths
    je    equal                   # Jump past singularly empty comparison if equal
    cmpl   $0,     %ecx           # See if the first array is empty
    je    fEmpty                  # Go to special case handler
    cmpl   $0,     %eax           # See if the second array is empty
    je    sEmpty                  # Go to special case handler
    jmp   rest
### This is where your code ends ...

equal:
    cmpl   $0,     %eax
    je    done

fEmpty:

    jmp done

sEmpty:

    jmp done

rest:
    leaq 4(%rdi),  %r9            # Copy a pointer to the first element of the first array 
    movslq %eax,   %rdx           # Sign extend the length of the second array for indexed access
    leaq  (%rsi,   %rdx, 4), %r10 # Copy a pointer to the last element of the second array
#    movl  (%r9),   %edx           # Copy the value in the first element of the first array
#    movl  (%r10),  %ecx           # Copy the value of the last element of the second array
#    movl   %edx,  (%r10)          # Move the first element of the first array to the last element of the second 
#loop:
#    cmpl   $1,     %eax
#    jng   rot
#    subq   $4,     %r10
#    decl   %eax
#    movl  (%r10),  %edx
#    movl   %ecx,   (%r10)
#    jmp   loop
    
rot:
   # movl   %edx , (%r10)
    #movl   %edx,  %eax
done:
    ret
