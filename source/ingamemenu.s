.section .data
.align 4

.globl inGameSelected 
inGameSelected:
	.int		0
	
.equ	BORDER_COLOR,		0xF222 // Color of the border
.equ	TEXT_COLOR,			0xF000 // Color for text
.equ	SELECTOR_COLOR,		0xF000 // Color of the selector

.globl GameMenu
GameMenu:	
	.asciz 	"GAME MENU"

.globl RestartGame
RestartGame:	
	.asciz 	"Restart Game"
	
.globl Quit
Quit:	
	.asciz 	"Quit"

.section .text

/* Draws the in game menu
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawInGameMenu
DrawInGameMenu:
	cellInt	.req	r4		// Initial/counter cell of the row
    cellFin .req	r5		// Final cell in the row
    increm	.req	r6		// Amount to increment to get next row
    rowNum	.req	r7		// Counter for row number
	push	 {r4-r7,lr}
	

	
	mov		cellInt, #85	// Store first cell we are writing to
	mov		cellFin, #90	// Store last cell in that row we are writing to
	mov		increm, #16		// Incrementation = # of cells per row
	mov		rowNum, #1		// Start the row number at 1
	
	// Draws a 6x6 background 
drawBackground$:
	mov		r0, cellInt		// Load the first cell in row
	mov		r1, cellFin		// Load the last cell in row
	ldr		r2,	=BG_COLOR 	// Set color for background
	bl		DrawCellRow		// Draw the row	
	
	add		cellInt, increm	// Increment to first cell to the next row
	add		cellFin, increm	// Increment to last cell to the next row
	
	add		rowNum, #1		// Increment the row number
	
	cmp		rowNum, #6		// Draw up to row 6	
	bls		drawBackground$
	
	
	
drawBorder$:
	mov		cellInt, #68	// Store first cell of the border
	mov		cellFin, #75	// Store last cell in current row of border
	mov		rowNum, #1		// Start the row number at 1

	mov		r0, cellInt	// Store first cell we are writing to
	mov		r1, cellFin	// Store last cell in that row we are writing to
	ldr		r2,	=BORDER_COLOR	// Set color for border
	bl		DrawCellRow		// Draw the row	

borderLoop$:	
	ldr		r2,	=BORDER_COLOR	// Set color for border
	mov		r0, cellInt		// Move the value of the old cell to be passed
	bl		CellPixels		// Get the x and y value of cell to be drawn
	bl		DrawSquare		// Draw border cell
	
	mov		r0, cellFin		// Move the value of the old cell to be passed
	bl		CellPixels		// Get the x and y value of cell to be drawn
	bl		DrawSquare		// Draw border cell
	
	add		cellInt, increm	// Increment to first cell to the next row
	add		cellFin, increm	// Increment to last cell to the next row
	
	add		rowNum, #1		// Increment the row number
	
	cmp		rowNum, #7		// Draw up to row 8
	bls		borderLoop$		
	
	mov		r0, cellInt	// Store first cell we are writing to
	mov		r1, cellFin	// Store last cell in that row we are writing to
	ldr		r2,	=BORDER_COLOR	// Set color for border
	bl		DrawCellRow		// Draw the row	
	
drawMenuItems$:
/* Each of the following 'groups' of code loads the x value to r0
 * the x value to r1, the color to r2, which string will be drawn 
 * to r3 and finally calls DrawSentance. The values of x and y are 
 * not relative to anything, so cannot be made variables as that 
 * would only take up more space.
 */
 
	// Draw the string "Game Menu"
	ldr		r0, =475
	ldr		r1, =275
	ldr		r2, =0xF0F0		// Pink color
	ldr		r3,	=GameMenu
	bl		DrawSentance

	// Draw the string "Restart Game"
	ldr		r0, =410
	ldr		r1, =360
	ldr		r2, =0x0FF0		// Teal color
	ldr		r3,	=RestartGame
	bl		DrawSentance

	// Draw the string "Quit Game"
	ldr		r0, =410
	ldr		r1, =415
	ldr		r2, =0x0FF0		// Teal color
	ldr		r3,	=Quit
	bl		DrawSentance
	
	// Set the selector on "Restart Game"
	ldr		r0, =inGameSelected	// Load address for the game menu selection
	mov		r1, #1
	str		r1, [r0]			// Reset the menu selection
	bl		MoveGameMenuSelect	// Draw the selector
	
	// Have to reset was the start location drawn since we will be redrawing it
	ldr		r0,	=StartLocationDrawn // Load address was start location drawn
	mov		r1, #0				
	str		r1, [r0]			// Store that the start location wasn't drawn
	
	.unreq	cellInt
	.unreq	cellFin
	.unreq	increm
	.unreq	rowNum
	pop		{r4-r7,pc}


/* Moves the game menu selector
 * Args:
 *  none
 * Return:
 *  none
 */
.globl MoveGameMenuSelect
MoveGameMenuSelect:
	selection	.req	r4	// What menu item is selected
	selectAdrs	.req	r5	// Address of selector integer
	push	{r4-r5, lr}
	
	ldr		selectAdrs, =inGameSelected	// Load address of selection
	ldr		selection, [selectAdrs]	// Load the selection
	
	cmp		selection, #0	// Test to see is StartGame selected
	beq		quitSelect$ // if it is branch to change the selection
	
startGameSelect$:
	ldr		r0,	=390		// Move the x coordinate in
	ldr		r1,	=360		// Move the y coordinate in
	ldr		r2, =0xF000		// Move the color in
	ldr		r3, =150		// Move width of the text
	bl		DrawSelector	// Draw the selector
	
	ldr		r0,	=390		// Move the x coordinate in
	ldr		r1,	=415		// Move the y coordinate in
	ldr		r2, =0x0000		// Move the color in
	ldr		r3, =70		// Move width of the text
	bl		DrawSelector	// Erase old selector
	
	mov		r0,	#0
	str		r0, [selectAdrs]	// Store the selection
	
	b		doneSelect$		// Done!
	
quitSelect$:
	ldr		r0,	=390		// Move the x coordinate in
	ldr		r1,	=415		// Move the y coordinate in
	ldr		r2, =0xF000		// Move the color in
	ldr		r3, =70		// Move width of the text
	bl		DrawSelector	// Draw the selector
	
	ldr		r0,	=390		// Move the x coordinate in
	ldr		r1,	=360		// Move the y coordinate in
	ldr		r2, =0x0000		// Move the color in
	ldr		r3, =150		// Move width of the text
	bl		DrawSelector	// Erase old selector
	
	mov		r0, #1
	str		r0, [selectAdrs]	// Store the selection
	
doneSelect$:	
	
	.unreq	selectAdrs
	.unreq	selection
	pop		{r4-r5, pc}
