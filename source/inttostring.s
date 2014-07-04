.section .text

/* Converts given integer to ascii
 * BASED ON CODE FROM POST #3 ON:
 *    http://www.microchip.com/forums/m453018.aspx
 * Args:
 *  r0 - Number to be converted 
 *	r1 - Where it will be stored
 * Return:
 *  none
 */
.globl IntToString
IntToString:
	counter	.req	r4		// Counter
	integer	.req	r5		// Interger to be converted
	string	.req	r6		// String that is being written to
	tmp		.req	r7		// Temp value used to store char '0'
	push	{r4-r7, lr}
	
	mov		integer, r0		// Store the integer
	mov		string,	r1		// Store location for the string
		
	mov		counter, #0		// Set counter
		
toStringLoop$:
	mov		r0, integer			// Move value of integer to be divided
	mov		r1, #10				// Modular division by 10
	bl		ModularDivision		// Do the modular division by 10
	ldr		tmp, ='0'			// Load the value of '0'
	add		r0, tmp				// Add the ASCII value of 0 to the result
	
	strb	r0, [string, counter] // Store the result to the string
		
	add		counter, #1			// Increment the counter
	
	mov		r0, integer			// Move value of integer to be divided
	mov		r1, #10				// Integer division by 10
	bl		DivideTwoNum		// Do integer division by 10
	
	mov		integer, r0			// Store new value for the integer
	
	cmp		integer, #1			// While => 1 stay in the loop
	bge		toStringLoop$

	cmp		counter, #1			// If string is only 1 character long
	beq		toStringDone$ 		// ... don't bother flipping

	mov		r0, string			// Move string to be flipped
	bl		FlipString			// Flip it
toStringDone$:
	
	.unreq	string
	.unreq	integer
	.unreq	counter
	pop		{r4-r7, pc}


/* Divides two numbers
 * TAKEN FROM TEXTBOOK PAGE 110
 * Args:
 *  r0 - dividend
 *	r1 - divisor
 * Return:
 *  r0 - result
 */
.globl DivideTwoNum
DivideTwoNum:
	Rcnt	.req	r4		// Counter
	Ra		.req	r5		// Dividend
	Rb		.req	r6		// Divisor
	Rc		.req	r7		// Will be result
	push	{r4-r7, lr}
	
	mov		Ra, r0			// Store dividend in Ra
	mov		Rb, r1			// Store divisor in Rb
	
	mov		Rcnt, #1		// Bit control the division
	
Div1:
	cmp		Rb, #0x80000000 // Move Rb until greater than Ra
	
	cmpcc	Rb, Ra
	movcc	Rb, Rb, LSL #1
	movcc	Rcnt, Rcnt, LSL #1
	bcc 	Div1
	
	mov		Rc, #0
	
Div2:
	cmp		Ra, Rb			// Test for possible subtraction
	subcs	Ra, Ra, Rb		// Subtract if OK
	addcs	Rc, Rc, Rcnt	// Put relevant bit into result
	
	movs	Rcnt, Rcnt, LSR #1	// Shift control bit
	movne	Rb, Rb, LSR #1			// Halve unless finished
	
	bne		Div2			// Divide result in Rc remainder in Ra
	
done:
	mov		r0, Rc			// Return result
	
	.unreq	Rcnt
	.unreq	Ra
	.unreq	Rb
	.unreq	Rc
	pop		{r4-r7, pc}
	

/* Modular division
 * Args:
 *  r0 - dividend
 *	r1 - divisor
 * Return:
 *  r0 - result
 */
.globl ModularDivision
ModularDivision:
	dividend	.req	r4	// Dividend
	divisor		.req	r5	// Divisor
	divResult	.req	r6	// This is the result of the division
	result		.req	r7	// Result of modular division
	push	{r4-r7, lr}
	
	mov		dividend, r0	// Store dividend in Ra
	mov		divisor, r1		// Store divisor in Rb
	
	mov		r0, dividend	// Store dividend in Ra
	mov		r1, divisor		// Store divisor in Rb
	bl		DivideTwoNum	// Find the result of the division
	
	mov		divResult, r0	// Result of division
	mul		r0,	divResult, divisor	// Result of division * divisor 

	sub		result, dividend, r0	// Finding the result of our modular division

	mov		r0, result			// Return result
	
	.unreq	dividend
	.unreq	divisor
	.unreq	divResult
	.unreq	result
	pop		{r4-r7, pc}	


/* Flips the string
 * BASED ON CODE FROM POST #3 ON:
 *    http://www.microchip.com/forums/m453018.aspx
 * Args:
 *  r0 - Location of string to be flipped
 * Return:
 *  none
 */
.globl FlipString
FlipString:
	counter	.req	r4		// Counter
	string	.req	r5		// String to be flipped
	tmpChr	.req	r6		// Temp value used to store character being replaced
	length	.req	r7		// Length of string
	push	{r4-r7, lr}

	mov		counter, #0		// Set counter to 0

	mov		string, r0		// Store location of the string

	mov		r0, string		// Make sure r0 has address of the string
	bl		StringLength	// Check length of the string
	mov		length, r0		// Store length of string
	
	sub		length, #1		// Subtract length by 1
flipLoop$:	
	ldrb	tmpChr, [string, counter] 	// Load the character that will be replaced
	ldrb	r0,	[string, length] 		// Load character that will be replacing
	
	strb	r0, [string, counter] 		// Store the replacement character
	strb	tmpChr, [string, length]	// Store the replaced character
	
	add		counter, #1		// Increment counter
	sub		length, #1		// Subtract length by 1
	
	cmp		counter, length	// Compare the counter to the current length
	blo		flipLoop$

	.unreq	counter
	.unreq	string
	.unreq	tmpChr
	pop		{r4-r7, pc}	
	

/* Finds length of string
 * Args:
 *  r0 - Location of string
 * Return:
 *  r0 - Length of string
 */
.globl StringLength
StringLength:
	counter	.req	r4		// Counter
	string	.req	r5		// String to be counted
	tmpChr	.req	r6		// Temp value used to store a character
	push	{r4-r6, lr}

	ldrb	tmpChr, [string]	// Load the first character to be counted
lengthLoop$:	
	add		counter, #1		// Increment to next character
	
	ldrb	tmpChr, [string, counter]	// Load the next character to be counted
	cmp		tmpChr, #0		// Check if end of string
	bne		lengthLoop$

	mov		r0, counter		// Return the counter
	
	.unreq	counter
	.unreq	string
	.unreq	tmpChr
	pop		{r4-r6, pc}	
