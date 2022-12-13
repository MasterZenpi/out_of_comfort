.peek
LD R0, 0(R6) ; load first element on stack into R0
BRnzp UNDERFLOW ; check for underflow
LD R5, 0 ; set R5 to 0 to indicate no underflow
RTI ; return from function

UNDERFLOW
LD R5, 1 ; set R5 to 1 to indicate underflow
RTI ; return from function


;next