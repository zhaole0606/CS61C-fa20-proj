.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================

argmax:
    # Prologue
    li t0, 1
    ble t0, a1, init_param
    li a1, 77
    j exit2
 
init_param:
    addi sp,sp,-8
    sw s0,0(sp)
    sw s1,4(sp)
    
    lw s0,0(a0) # max_val=a[0]
    mv s1,x0 # max_idx=0
    # t0 作为index，当前t0已经从1开始
    # 所以a1也从下标为1开始，a[1]
    addi a0,a0,4
loop_start:
    bge t0,a1,loop_end
 	
    
    lw t1,0(a0)
    
    bge s0,t1,loop_continue
    mv s0,t1
    mv s1,t0
loop_continue:
    addi a0,a0,4
    addi t0,t0,1
    j loop_start
loop_end:
    mv a0,s1
    lw s0,0(sp)
    lw s1,4(sp)
    addi sp,sp,8
    ret

 

