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
    je    fEmpty                  # First array is empty
    jmp   rest                    # Array length unequal and both arrays non empty
### This is where your code ends ...

equal:
    cmpl   $0,     %eax           # If one array is empty
    je    done                    # Then both arrays are empty
    jmp   rest                    # Arrays are not empty
fEmpty:
    leaq 4(%rsi), %rdx
    jmp split

rest:
    leaq 4(%rdi),  %rdx            # Copy a pointer to the first element of the first array 
    cmp   $0,      %eax
    je   rot
split:
    movslq %eax,   %r9           # Sign extend the length of the second array for indexed access
    leaq  (%rsi,   %r9, 4), %r10 # Copy a pointer to the last element of the second array
    #movl  (%r9),   %edx           # Copy the value in the first element of the first array
    movl  (%r10),  %ecx           # Copy the value of the last element of the second array
    movl   %edx,  (%r10)          # Move the first element of the first array to the last element of the second 
loop:
    cmpl   $1,     %eax           # Compare the remaining length to one
    jng   rot                     # Jump to next phase in rotation if length is less than or equal to one
    subq   $4,     %r10           # Move the index of the second array back one
    decl   %eax                   # Decrement the length of the second array
    movl  (%r10),  %edx           # Copy the current indexed value
    movl   %ecx,  (%r10)          # Replace the currrent indexed value with the value previously at "[i+1]"
    movl   %edx,   %ecx           # Copy the old current to be placed in a new index
    jmp   loop                    # Loop back to check the length
    
rot:
    movl  (%rdi),  %eax           # Copy the length of the first array
    cmpl   $0,     %eax           # Check if the length is zero
    je    houseKeep               # If length was zero skip this array
    movslq %eax,   %r9           # Sign extend the length of the array for indexed access
    leaq  (%rdi,   %r9, 4), %r10 # Point to the last index in the first array 
    cmpl   $0,     (%rsi)
    jne   skip
    xchgl  %ecx,   %edx
skip:
    movl  (%r10),  %edx           # Copy the value at that index
    movl   %ecx,  (%r10)          # Replace the value at that index with the rotated value
otLoop: 
    cmpl   $1,     %eax           # Compare the length of the first array to one
    jng   houseKeep               # If the length is less than or equal to one
    subq   $4,     %r10           # Move the index of the first array back one
    decl   %eax                   # Decrement the length of the first array
    movl  (%r10),  %ecx           # Copy the current indexed value
    movl   %edx,  (%r10)          # Replace the current indexed value with the value previously at "[i+1]"
    movl   %ecx,   %edx           # Copy the old current to be placed in a new index
    jmp   otLoop                  # Loop back to check the length

houseKeep:
    movl  (%rdi),  %eax
    movl  (%rsi),  %ecx
    addl   %ecx,   %eax
done:
    ret
