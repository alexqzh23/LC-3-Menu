	.ORIG	x3000						;place to start the lc-3 program
	BRnzp	START						;jump to welcome directly in the first time
MENU	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	OUT							;go to next line
START	LEA 	R0, Welcome					;load the welcome string to R0
	PUTS  							;output welcome string
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	LEA 	R0, MENU_1					;load option a
	PUTS							;put option a
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	LEA 	R0, MENU_2					;load option b
	PUTS							;put option b
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	LEA 	R0, MENU_3					;load option c
	PUTS							;put option c
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	LEA 	R0, MENU_4					;load option e
	PUTS							;put option c
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
GET	GETC							;get a character
	OUT							;output the character user just input
	ADD	R1, R0, #0					;copy the character into R1 from R0
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	ADD	R0, R1, #0					;load back the character value to R0
TEST_1	LD	R2, TERM_1					;load #-97 to R2, #97 in ASCII means 'a'
	ADD	R1, R2, R0					;use the ASCII of input to minus #-97
	BRz	SUB_A						;if the input is 'a', jump to SUB_A
TEST_2	LD	R2, TERM_2					;load #-98 to R2, #97 in ASCII means 'b'
	ADD	R1, R2, R0					;use the ASCII of input to minus #-98
	BRz	SUB_B						;if the input is 'b', jump to SUB_B
TEST_3	LD	R2, TERM_3					;load #-99 to R2, #97 in ASCII means 'c'
	ADD	R1, R2, R0					;use the ASCII of input to minus #-99
	BRz	SUB_C						;if the input is 'b', jump to SUB_C
TEST_4	LD	R2, TERM_4					;load #-101 to R2, #101 in ASCII means 'e'
	ADD	R1, R2, R0					;use the ASCII of input to minus #-101
	BRnp	ERROR						;if the input is not 'e', jump to ERROR
	LEA	R0, BYE						;if the input is 'e', load "goodbye" to R0
	PUTS							;output "goodbye"
	BRnzp	EXIT						;jump to EXIT, and halt the program
ERROR	LEA	R0, ILLEGAL 					;load "Please input a legal letter to continue: "
	PUTS							;output the string
	BRnzp	GET						;jump to START
SUB_A	LEA	R0, HELLO					;load "Hello, world!"
	PUTS							;output the string
	BRnzp	MENU						;jump to START
SUB_B	LD	R1, TEN						;load #10 to R1, R1 is the counter of the loop
	LD	R2, FIRST					;load #0 to R2, R2 is the varied summand
	AND	R0, R0, #0					;clear R0
AGAIN	ADD	R2, R2, #1					;R2 start to add 1 as a summand
	ADD	R0, R0, R2					;add R2 to the total R0
	ADD	R1, R1, #-1					;R1 as the counter minus 1
	BRp	AGAIN						;if R1 is not zero, loop continue
	BRnzp	DG_1						;if R1 becomes zero, loop stop, jump to DG_1
SUB_C	LEA	R0, TIP						;load "Please input an integer number: "
	PUTS							;output the string
	GETC							;get a single-bit number from the keyboard
	OUT							;output the input number
	ADD	R4, R0, #0					;copy the input number to R4
	LD	R0, TEN						;load a newline value
	OUT							;go to next line
	ADD	R0, R4, #0					;copy R4(INPUT) back to R0
	BRnz	MENU						;if R4(INPUT) is zero or negative, back to MENU
SUM	LD	R3, NUMBERS					;load #-48 to R3
	ADD	R1, R0, R3					;trans string to number, then store it to R1 as a counter
	ADD	R3, R1, #0					;copy input number to R3
	BRz	OUT_2						;if input is zero, jump to OUT_2 directly
	LD	R2, FIRST					;load #0 to R2
	AND	R0, R0, #0					;clear R0
	BRnzp	AGAIN						;jump to again
DG_1	AND	R1, R1, #0					;clear R1	
	LD	R2, NUM_1					;load #-10 to R2
LOOP_1	ADD	R0, R0, R2					;add R2 to R0, to decrease the total by 10
	BRn	DG_2						;if R2 is negative, jump to DG_2(if the number is already one-bit, R1 will equals to 0)
	ADD	R1, R1, #1					;else R1 add 1(Record the tenth bit)
	BRnzp	LOOP_1						;jump to LOOP_1
DG_2	LD	R2, NUM_3					;load #10 to R2
	ADD	R0, R0, R2					;add #10 to total to back to its one-bit original number
	ADD	R3, R0, #0					;copy R0(single-bit TOTAL) to R3
	ADD	R1, R1, #0					;check if R1 is 0
	BRz	OUT_2						;if R1 is 0, the number is single-bit, jump to OUT_2
	BRnzp	OUT_1						;else jump to OUT_1
OUT_1	ADD	R0, R1, #0					;copy R1 to R0
	LD	R2, OFFSET					;copy #48 to R2
	ADD	R0, R0, R2					;trans tenth bit's number to string
	OUT							;output the tenth bit string
OUT_2	ADD	R0, R3, #0					;copy R3(single-bit) to R0 
	LD	R2, OFFSET					;copy #48 to R2
	ADD	R0, R0, R2					;trans single-bit's number to string
	OUT							;output the single-bit
	BRnzp	MENU						;jump to START
EXIT	HALT							;stop the program
NUM_1	.FILL xFFF6						;number #-10
NUM_2	.FILL xFFFF						;number #-1
NUM_3	.FILL x000A						;number #10
OFFSET	.FILL x0030						;number #48, to trans number into string
TERM_1	.FILL xFF9F						;number #-97(a)
TERM_2	.FILL xFF9E						;number #-98(b)
TERM_3	.FILL xFF9D						;number #-99(c)
TERM_4	.FILL xFF9B						;number #-101(e)
TEN	.FILL x000A						;number to start a new line and it is also #10
FIRST	.FILL x0000						;number #0
NUMBERS .FILL xFFD0						;number #-48, to trans string into number
Welcome .stringz "Welcome to LC-3!"				;words to welcome
;ASK	.stringz "What else do you want LC-3 do?"		;words to continue
MENU_1	.stringz "a. print Hello, world!"			;words of option a
MENU_2	.stringz "b. output the sum 1+2+бн+10"			;words of option b
MENU_3	.stringz "c. output the sum 1+2+бн+n"			;words of option c
MENU_4	.stringz "e. exit the program"				;words of option e
HELLO 	.stringz "Hello, world!"				;content of option a
TIP	.stringz "Please input an integer number: "		;ask user to input an integer
BYE 	.stringz "Goodbye!"					;content of option e
ILLEGAL .stringz "Please input a legal letter to continue: "	;ask user to input a valid letter
	.END