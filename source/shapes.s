.section .text

/* Drawing a 47x47 box
 * Args:
 *  r0 - inital x coord
 *	r1 - inital y coord
 *	r2 - color of line
 * Return:
 *  none
 */
.globl DrawSquare
DrawSquare:
    boxx    .req    r4		// Left most part of the box
    boxy    .req    r5		// Top of the box
    color	.req	r6		// Color of the box
    px		.req	r7		// x coordinate of the pixel (relative to inside the box)
    py		.req	r8		// y coordinate of the pixel (relative to inside the box)
	
	push {r4-r8, lr}
	
	mov		boxx,	r0		// Save left corner of box
	mov		boxy,	r1		// Save top of box
	mov		color,	r2		// Save the color
	
	mov		px,		#0		// Set x coord of pixel to 0
	mov		py,		#0		// Set y coord of pixel to 0 
squareLoop$:
	mov		r0,		px		// Move the pixel value of x (relative to the box)
	add		r0, 	boxx	// Add the x value relative to the screen 
	mov		r1,		py		// Move the pixel value of y (relative to the box)
	add		r1,		boxy	// Add the y value relative to the screen 
	mov		r2,		color	// Set the color
	bl		DrawPixel		// Draw pixel at (px, py)
	add 	px, #1			// Increment the pixel on the x axis
	cmp		px, #47			// Draw up to 47th pixel on x axis
	ble		squareLoop$
	mov		px, #0			// Reset the x coord of the pixel
	add 	py, #1			// Increment the pixel on the y axis
	cmp		py, #47			// Draw up to 47th pixel on y axis
	ble		squareLoop$
	
	.unreq	boxx
	.unreq	boxy
	.unreq	color
	.unreq	px
	.unreq	py
		
	pop {r4-r8, pc}


/* Drawing a vertical line
 * FINAL Y MUST BE > INITAL Y
 * Args:
 *  r0 - x coord
 *	r1 - inital y coord
 *	r2 - final y coord
 *	r3 - color of line
 * Return:
 *  none
 */
.globl DrawLineY
DrawLineY:
    px		.req	r4			// x coordinate of pixel
    py  	.req    r5			// y coordinate of pixel
    endpy	.req	r6			// final y coordinate of pixel
    color	.req	r7			// color of pixel

    
	push {r4-r7, lr}
	
	// move values that were given into respective variables 
	mov		px,		r0
	mov		py,		r1
	mov		color,	r2
	mov		endpy,  r3
lineYLoop$:	
	// move values into appropriate reigsters so they can be passed properly
	mov		r0,		px
	mov		r1,		py
	mov		r2,		color
	bl		DrawPixel			// draw pixel at (px, py)
	
	add		py,		#1			// increment the pixel by one pixel
	
	cmp		py,		endpy		// make sure it draws the right amount
	bne		lineYLoop$

	.unreq	px	
	.unreq	py
	.unreq	endpy
	.unreq	color
	pop  {r4-r7, pc}



/* Drawing a horizontal line
 * FINAL X MUST BE > INITAL X
 * Args:
 *  r0 - inital x coord
 *	r1 - y coord
 *	r2 - final x coord
 *	r3 - color of line
 * Return:
 *  none
 */
.globl DrawLineX
DrawLineX:
    px		.req	r4			// x coordinate of pixel
    py  	.req    r5			// y coordinate of pixel
    endpx	.req	r6			// final x coordinate of pixel
    color	.req	r7			// color of pixel

    
	push {r4-r7, lr}
	
	// move values that were given into respective variables 
	mov		px,		r0
	mov		py,		r1
	mov		color,	r2
	mov		endpx,  r3
lineXLoop$:	
	// move values into appropriate reigsters so they can be passed properly
	mov		r0,		px
	mov		r1,		py
	mov		r2,		color
	bl		DrawPixel			// draw pixel at (px, py)
	
	add		px,		#1			// increment the pixel by one pixel
	
	cmp		px,		endpx		// make sure it draws the right amount
	bne		lineXLoop$

	.unreq	px	
	.unreq	py
	.unreq	endpx
	.unreq	color
	pop  {r4-r7, pc}
