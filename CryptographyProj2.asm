;Project 2 - Encryption and Decryption message using encryption key and special logic.
;The line with "Add code here" need to supply the LC-3 Instruction for asm program run success. 
;Algorithm 
;
;The encryption algorithm is as follows. Each ASCII code in the message will be transformed as follows:  
;
;   1.The low order bit of the code will be toggled. That is, if it is a 1, 
;     it will be replaced by a 0, if it is a 0, it will be replaced by a 1. 
;
;   2. The key will be added to the result of step 1 above. 
;      For example, if the input (plain text) is A and the encryption key is 6, 
;      the program should take the ASCII value of A, 01000001, toggle bit [0:0], 
;      producing 01000000 and then add the encryption key, 6. 
;      The final output character would be 01000110, which is the ASCII value F.  
;
;The decryption algorithm is the reverse. That is, 
;   1.Subtract the encryption key from the ASCII code.  2. Toggle the low order bit of the result of step 1. 
;     For example, if the input (cipher text) is F, and the encryption key is 6, 
;     we first subtract the encryption key (i.e., we add -6) from the ASCII value of F, 
;     01000110 + 11111010, yielding 01000000. We then toggle bit [0:0], 
;     producing 01000001, which is the ASCII value for A.
;
;The result of the encryption/decryption algorithm should be stored in locations x3116 to x3129. 
;
;Output 
; 
;Your program should output the encrypted or decrypted message to the screen. 
;Note that the encryption/decryption algorithm stored the message to be output starting in location x3116. 
             
             .ORIG x3000
             AND R0, R0, #0		;Clear R0
	     AND R1, R1, #0		;Clear R1
	     AND R2, R2, #0		;Clear R2
	     AND R3, R3, #0		;Clear R3
	     AND R4, R4, #0		;Clear R4
	     AND R5, R5, #0		;Clear R5
	     AND R6, R6, #0		;Clear R6

	     LD R1, STORE		; Sets R1 to x3100 for memory storage and access

	     LEA R0, PROMPT1		; Load Prompt1 "(E)ncryption or (D)ecryption
	     PUTS			; Output Prompt1 same as TRAP 22. Write null-terminated string to console.
	     IN			        ; Get character input from keyboard same as TRAP 20
	     STR R0, R1, #0		; Stores/write character at memory location indicated by R1

	     LEA R0, PROMPT2		; Load Prompt2 Encryption Key "0-9"
	     PUTS			; Output Prompt2 same as TRAP 22 
	     IN			        ; Get character input from keyboard same as TRAP 20
	     ADD R1, R1, #1		; Sets R1 to x3101 (memory location to store key)
	     STR R0, R1, #0		; Stores Encryption Key (0-9) character at memory location indicated by R1
	
	     LEA R0, PROMPT3		; Load third prompt Encryption Message into R0
	     PUTS			; Output Prompt3 same as TRAP 22. Write null-terminated string to console.

;- The <ENTER> key is mapped to the line feed character on the LC-3 (ASCII x0A) 
	     ADD R1, R1, #1		; Sets R1 to x3102 for message storage
	     ADD R2, R2, #-10
	     ADD R2, R2, #-10	        ; Sets R2 to -20 for counter. Encrypt message limited to 20 characters
	     ADD R3, R3, #-10	        ; Sets R3 to -10 for comparison with "ENTER" key LC-3 (ASCII x0A)
InputLoop    GETC		        ; Begin of InputLoop, gets characterinput
	     OUT                        ; Write one character to console same as TRAP 21
	     NOT R3, R3			
	     ADD R0, R3, R0		; Compares input character in R0 with R3
	     BRz ExitInput		; Exits loop if "ENTER" key is detected
	     LD R0, R1  		; Stores input character in R0 into memory location in R1
	     ;Add code here    		; Increments R1 memory location for next character in input encrypt message
	     ;Add code here    		; Increments counter
	     BRn InputLoop		; Loops if counter is still negative
ExitInput 		                ;

	     AND R3, R3, #0		; Clears R3 for later use
	     AND R4, R4, #0		; Clears R4 for later use

	     ;These lines prepare for encryption/decryption
	     LD R1, STORE		; Stores x3100 in R1
	     ;Add code here    		; Stores encryption key (ASCII) in R2 from memory address in R1
	     ADD R2, R2, #-16   	; These three lines convert R2 from ASCII to Decimal. "0-9" are "48-57" ASCII code
	     ADD R2, R2, #-16   	; ^											;Line 50
	     ADD R2, R2, #-16	        ; ^^
	     ;Add code here    		; Makes R3 point to first char in input messge for encryption from the memory location in R1
	     LD R5, NEW		        ; Loads memory location NEW to store encrypted message

	     LDI R1, STORE 		; Reloads R1 with x3100
	     LD R6, N68		        ; Loads R6 with -68 to check for D input 
	     ;Add code here    		; Adds R1 and R6 to check if D was first input
	     ;BRz DECRYPT		; Goes to DECRYPT if D was first input, else it runs encyption in next instruction
;
;Encryption algorithm:
;The encryption algorithm is as follows. Each ASCII code in the message will be transformed as follows:  
;
;   1.The low order bit of the code will be toggled. That is, if it is a 1, 
;     it will be replaced by a 0, if it is a 0, it will be replaced by a 1. 
;
;   2. The key will be added to the result of step 1 above. 
;      For example, if the input (plain text) is A and the encryption key is 6, 
;      the program should take the ASCII value of A, 01000001, toggle bit [0:0], 
;      producing 01000000 and then add the encryption key, 6. 
;      The final output character would be 01000110, which is the ASCII value F.  
;                                        ;
EncryptLoop 
	     LDR R0, R3, #0    		; Load the value in the memory location pointed by R3 with 0 Offeset into R0
	     BRz SKIP		        ; Ends Encryption when all characters are read
	     ;Add code here		; Determines last bit in R0. Use AND with decimal number #1
	     BRp One_1		        ; 
	     ;Add code here		; If last bit in R0 is zero, adds 1 to toggle bit, stores in R4
	     BRnzp E_Store
One_1        ADD R4, R0, #-1    	; If last bit is one, subtracts 1 to toggle bit, stores in R4
	  
E_Store     
	     ;Add code here		; Adds encyption key to R4 (char w/ toggled bit)
	     ;Add code here		; Stores/write encrypyed char into its memory location "NEW'
	     ;Add code here		; Increments character pointer to next memory address for loop "EncryptLoop"
	     ;Add code here		; Increments memory pointer to next memory address for storing "NEW"
	     BRnzp EncryptLoop


;DECRYPT
;Decryption algorithm:
;Decryption code here follow the logic rule for decryption logic
;
;The decryption algorithm is the reverse. That is, 
;   1.Subtract the encryption key from the ASCII code.  2. Toggle the low order bit of the result of step 1. 
;     For example, if the input (cipher text) is F, and the encryption key is 6, 
;     we first subtract the encryption key (i.e., we add -6) from the ASCII value of F, 
;     01000110 + 11111010, yielding 01000000. We then toggle bit [0:0], 
;     producing 01000001, which is the ASCII value for A.
;
;Data Structures lay out:
;- The starting location is to be x3000 
; 
;- The buffers have been expanded to 21 memory locations each so that you may store <ENTER> 
; 
;        x3100 <- E/D        
;        x3101 <- Encryption key        
;
;        x3102 through x3116 <- input buffer        
;
;        x3117 through x312A <- output buffer 
; 
;
;Output 
; 
;Your program should output the encrypted or decrypted message to the screen. 
;Note that the encryption/decryption algorithm stored the message to be output starting in location x3116. 
;The result of the encryption/decryption algorithm should be stored in locations x3116 to x3129. 
;Display the encryption or decryption message from the saved in NEW memory address location
SKIP

	    LEA R0, SCRIPT		; Loads new message script into R0
	    PUTS			; Outputs encrypt or decrypt script						;Line 100
	    LD R0, NEW	        	; Loads new message into R0
	    PUTS		 	; Outputs message


	    HALT                        ;STOP
;
;- The starting location is to be x3000 
; 
;- The buffers have been expanded to 21 memory locations each so that you may store <ENTER> 
; 
;***        x3100 <- E/D                           ***     
;***        x3101 <- Encryption key                ***
;***                                               ***
;***        x3102 through x3116 <- input buffer    ***     
;***                                               ***
;***        x3117 through x312A <- output buffer   ***
;***                                               ***

STORE .FILL x3100

PROMPT1 .STRINGZ "(E)ncrypt/(D)ecrypt:\n"

PROMPT2 .STRINGZ "\nEncryption Key:\n"

PROMPT3 .STRINGZ "\nInput Message:\n\n"

N68 .FILL #-68

SCRIPT .STRINGZ "\nNew message:\n\n"

NEW .FILL x3117

            .END