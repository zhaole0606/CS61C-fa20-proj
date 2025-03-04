.globl dot

# .data
# array1:
#     .word   1
#     .word   2
#     .word   3
#     .word   4
#     .word   5
#     .word   6
#     .word   7
#     .word   8
#     .word   9
# array2:
#     .word   1
#     .word   2
#     .word   3
#     .word   4
#     .word   5
#     .word   6
#     .word   7
#     .word   8
#     .word   9
# len:
#     .word 9
# step1:
#     .word 1
# step2:
#     .word 1
.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    ###初始化测试数据开始###
#     la a0, array1    
#     la a1, array2
    
#     la a2, len
#     lw a2, 0(a2)
    
#     la a3, step1
#     lw a3,0(a3)
    
#     la a4, step2
#     lw a4,0(a4)
    
    ###初始化测试数据结束###
    ble a2,x0, err_75
    ble a3,x0 , err_76
    ble a4,x0, err_76
    # Prologue
    addi sp,sp, -12
    sw s0,0(sp) #用来记录a0中的值
    sw s1,4(sp) #用来记录a1中的值
    sw s2,12(sp) #用来记录sum
    
    mv s2,x0 
    
    li t0,4
    li t1,0 # 循环次数i =0
    
    #判断那个哪个step更长
    mv t4,a3
    bge t4,a4,loop_start
    mv t4,a4
loop_start:

    beq t1, a2, loop_end
    lw s0,0(a0)
    lw s1,0(a1)
 
    #求和
    mul s0,s0,s1
    add s2,s2,s0
   
    #t2=i* step 每次循环移动固定长度
    mul t2,t0,a3
    mul t3,t0,a4
    #数组a0,a1的next step  
    add a0,a0,t2
    add a1,a1,t3
    
    #i自增到下一个step
    addi t1,t1,1
     # 判断是否越界
    j loop_start
loop_end:
    mv a0,s2
    lw s0,0(sp) 
    lw s1,4(sp)  
    lw s2,12(sp)  
    addi sp,sp, 12
    # Epilogue
    ret
    
err_75:
	li a1, 75
    j exit2
   
err_76:
    li a1, 76
    j exit2