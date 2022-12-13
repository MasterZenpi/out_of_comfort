  ; Check if value in x4000 is a valid ASCII code
    LD R0, x4000 ; load value from x4000 into R0
    AND R0, R0, #0x7F ; mask off the top bit to check if it's a valid ASCII code
    BRz skip ; if the value is 0, skip the print
    ; Print the character
    LD R1, ASCII ; load the ASCII character table into R1
    ADD R1, R1, R0 ; add the ASCII code to the table address to get the character
    LD R0, (R1) ; load the character from the table
    TRAP x22 ; print the character
    skip, HALT ; halt the program

ASCII, .FILL xFF00 ; ASCII character table