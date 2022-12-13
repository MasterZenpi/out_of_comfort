PEEK
    LD R0, STACK_POINTER    ; Load the stack pointer into R0
    ADD R0, R0, #-1         ; Decrement the stack pointer to point to the top of the stack
    LD R1, STACK(R0)        ; Load the value at the top of the stack into R1
    BRnzp PEEK_UNDERFLOW    ; If the stack pointer is 0, go to the underflow error handling routine
    LD R0, STACK_POINTER    ; Load the stack pointer back into R0
    ADD R0, R0, #1          ; Increment the stack pointer to restore its original value
    RET                     ; Return the value in R1

PEEK_UNDERFLOW
    ; Handle the underflow error by printing an error message and halting the program
    LEA R0, STACK_UNDERFLOW_MESSAGE
    PUTS
    HALT

; Define the STACK_POINTER and STACK symbols for use in the PEEK function
STACK_POINTER .FILL #0
STACK .FILL x3000
