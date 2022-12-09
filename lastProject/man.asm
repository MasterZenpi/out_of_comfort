; Bubble Sort Program:
; This program will print a list of positive or negative single-digit numbers
; stored starting at location x4000. It well then run a bubble sorting algorithm
; to change the order they are stored into ascending order. It will then print
; the new sorted list of numbers.

	.ORIG x3000
	
	LEA R0, NoSort		; Loads string location into R0
	PUTS			; Outputs "Unsorted" string
	JSR OutputData          ; display the unsorted digits list to monitor

	LEA R1, FILE		; Set R1 as the pointer to the memory address of the digits list FILE
	AND R2, R2, #0		; Clear R2 prepare for storing first digit 1 read from the FILES
	AND R3, R3, #0		; Clear R3 prepare for storing second digit 2 read from the FILE
	AND R4, R4, #0		; Clear R4 prepare for Comparing the value of first and second digit
	ADD R5, R5, #-1		; R5 is the digits counter. Brings amount of data (n) from unsorted list output data, and puts into R5 as "n-1"

Sort	
	LDR R2, R1, #0		; Loads first digit value 1 from the memory address where R1 pointed to into R2
	LDR R3, R1, #1		; Loads second digit value 2 from the memory address where R1 pointed to into R3
	BRz EndPass             ; If no more data goto EndPass
	NOT R4, R3              ; NOT and ADD 1 operation make the 2's compliment negative number into R4 from R3
	ADD R4, R4, #1 
	ADD R3, R3, #-1		; Makes R3 negative of itself for subtraction
	ADD R4, R4, R2		; Subtracts second digit value 2 from first digit value 1
	BRp Swap                ; If first digit value bigger than the second digit value then swap it
	ADD R1, R1, #1		; If difference is negative, no swap needed, increment pointer (R1) to next digit memory address in the FILE
	BRnzp Sort		; Repeat the process until no more digit

Swap	STR R3, R1, #0		; Write the swaped digits in R3 and R2 to the memory address which R1 point to
	STR R2, R1, #1		; If difference is positive, swaps values
	ADD R1, R1, #1		; Increments pointer
	BRnzp Sort              ; Contine to the sort process

EndPass	LD R1, FILE		; Re-initializes pointer (R1) for next pass of bubble sort process
	ADD R5, R5, #-1		; De-increments R5 (pass counter)
	BRp Sort		; If pass counter still positive, sort again.

	LEA R0, Sorted		; Loads string location into R0
	PUTS			; Outputs "Sorted" string
	JSR OutputData          ; Show the sorted list
	

	HALT                    ; STOP
		
FILE	.FILL x4000


OutputData			; Subroutine 1: Outputs data starting at x4000
	AND R3, R3, #0		; Clears R3 for return address
	;STR R3, R7, #0 		; Saves return address to R3
	;LD R1, FILE		; Loads R1 with x4000 to act as pointer to data
	AND R5, R5, #0		; Clears R5 to act as counter for amount of data (n)

DataLoop	
	LDR R0, R1, #0		; Loads R0 with data pointed to the memory address by R1 with offset #0
	BRz EndLoop		; If pointer doesn't point to value, data has ended, stops loop
	ADD R5, R5, #1		; Increments R5 for every piece of data - Counter of the digits in the list
	JSR Bin_to_ASCII	; Converts number in R0  to string of ASCII chars stored at x4500
	LD R0, ASCIIString	; Loads pointer to ASCII string (x4500)
	PUTS			; Outputs data as string
	ADD R1, R1, #1		; Increments pointer
	BRnzp DataLoop		; Loops
EndLoop	LD R0, newline
	OUT			; Ends with newline
	AND R7, R7, #0		; Clears R7
	ADD R7, R3, #0		; Restores R7 to value before subroutine
	BR DataLoop		; Returns to main program when loop ends


		
Bin_to_ASCII			; Subroutine 2: Converts binary num to a string placed at x4500
	ST R0, SR0		; Saves R0 registor values to memory address SR0
	ST R1, SR1    	        ; Saves R1 registor values to memory address SR1
	ST R2, SR2              ; Saves R2 registor values to memory address SR2
	ST R3, SR3              ; Saves R3 registor values to memory address SR3
	LEA R1, ASCIIString     ; Set R1 point to memory address ASCIIString will be used saved the output (usorted or sorted) string.

	ADD R0, R0, #0		; Checks for positive or negative digit +/-
	BRn NegSign             ; if negative digit go to negative
	LD R2, ASCIIPlus	; Store '+'
	BRnzp Begin1            ; if positive go to Begin1 write out the sign and the digit
NegSign	LD R2, ASCIINeg		; Store '-'
	NOT R0, R0              ; 
	ADD R0, R0, #1		; absolute value

Begin1	STR R1, R2, #0          ; Write the '+' in R2 to memory address R1 pointed to with offset #0
	LD R2, ASCIIoffset	; R2 <= character '0' (for ones digit)
	AND R4, R0, #15		; Convert the binary digit in R0 to char into R4
	STR R4, R1, #1		; Stores or write the digit char int R4 to the next byte of memory address R1 pointed to
	
	LD R0, space            ; R0 <-- ' '
	STR R0, R1, #2		; Stores a space after number

	;ADD CODE HERE          ; Restore R0's data from save address memory before return to caller.
	;ADD CODE HERE          ; Restore R1's data from save address memory before return to caller.
	;ADD CODE HERE          ; Restore R2's data from save address memory before return to caller.
	;ADD CODE HERE          ; Restore R3's data from save address memory before return to caller.

	RET          ;Return to caller


ASCIIPlus	.FILL #43	; ASCII value for '+'
ASCIINeg	.FILL #45	; ASCII value for '-'
ASCIIoffset	.FILL #48	; ASCII value for '0'
SR0	.BLKW 1
SR1	.BLKW 1
SR2	.BLKW 1
SR3	.BLKW 1
ASCIIString	.FILL x4500	; Address where string will be stored
comma		.FILL #44
space		.FILL #32
newline 	.FILL #13	
NoSort	.STRINGZ "Unsorted digits list: "
Sorted	.STRINGZ "Sorted digits list: "

	.END
