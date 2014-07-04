.section .data
.align 4

.globl KeyCount
KeyCount:
	.int	0
	
.globl ActionCount	
ActionCount:
	.int	150
	
.globl CharLocation	
CharLocation:
	.int	225

.globl InitalCharLocation	
InitalCharLocation:
	.int	225
		
.globl StartLocationDrawn
StartLocationDrawn:
	.int	0		
		
.align 4
	
.globl KeyCountString
KeyCountString:
	.asciz	"0"
	
.globl KeysString
KeysString:	
	.asciz 	"KEYS:"
	
.globl ActionCountString
ActionCountString:
	.asciz	"150"
	
.globl ActionCountStringTwo
ActionCountStringTwo:
	.asciz	"99"
	
.globl ActionCountStringOne
ActionCountStringOne:
	.asciz	"9"
	
.globl ActionString
ActionString:	
	.asciz 	"ACTIONS REMAINING:"
	
.globl YouPerish
YouPerish:
	.asciz	"YOU RAN OUT OF RATIONS AND PERISHED IN THE DUNGEON..."
	
.globl GameOver
GameOver:
	.asciz	"GAME OVER"
	
.globl YouEscaped
YouEscaped:
	.asciz	"YOU ESCAPED THE DUNGEON OF AZA NOR ANGORTH LEDUCE"
	
.globl YoureWinner
YoureWinner:
	.asciz	"YOU WIN"
	
.globl	LegendText
LegendText:
	.asciz	"LEGEND:"
	
.globl	KeyLegendText
KeyLegendText:
	.asciz	"KEY"
	
.globl	DoorLegendText
DoorLegendText:
	.asciz	"DOOR"
	
.globl	ExitLegendText
ExitLegendText:
	.asciz	"EXIT"
	
.globl	CharLegendText
CharLegendText:
	.asciz	"CHARACTER"
	
.globl originalLayoutArray	// This is the layout of the dungeon that will never change
originalLayoutArray:	// 0 = grass, 1 = wall, 2 = key, 3 = door, 4 = exitDoor, 5 = character
	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.byte	1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1
	.byte	1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1
	.byte	1, 0, 1, 2, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1
	.byte	1, 0, 1, 0, 1, 0, 1, 0, 3, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 3, 1, 0, 1, 0, 1, 1, 0, 1
	.byte	1, 2, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 3, 0, 0, 1
	.byte	1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1
	.byte	1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1
	.byte	1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1
	.byte	1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1
	.byte	1, 5, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1

.globl layoutArray		// This is the game instance that will be changed constantly
layoutArray:	// 0 = grass, 1 = wall, 2 = key, 3 = door, 4 = exitDoor, 5 = character
	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.byte	1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1
	.byte	1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1
	.byte	1, 0, 1, 2, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1
	.byte	1, 0, 1, 0, 1, 0, 1, 0, 3, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 3, 1, 0, 1, 0, 1, 1, 0, 1
	.byte	1, 2, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 3, 0, 0, 1
	.byte	1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1
	.byte	1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1
	.byte	1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1
	.byte	1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1
	.byte	1, 5, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 1, 0, 1
	.byte	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1
	
// Various constants, mostly colors, each is explained
.equ	GRID_RATIO,		0x2F	// How many pixels wide is each block
.equ	INITX,	 		0x88 	// Initial point of x (left most part of map)
.equ	INITY,			0x0		// Initial point of y (top most part of map)
.equ	ENDX,			0x378	// Final point of x (right most part of map)
.equ	ENDY,	 		0x2F0	// Final point of y (bottom most part of map)
.equ	START_COLOR,	0xFAA0	// Color of the start square (walkable)
.equ	GRASS_COLOR,	0x2B20	// Color of the grass (walkable)
.equ	WALL_COLOR,		0x4040	// Color of the wall (un-walkable)
.equ	KEY_COLOR,		0xFF40	// Color of the keys
.equ	DOOR_COLOR, 	0x0F00	// Color of the doors
.equ	CHAR_COLOR,		0xF0F0	// Color of the character
.equ	EXIT_COLOR,		0xFFF0	// Color of the exit door
.equ	LINE_COLOR,		0x1100	// Color of the lines for the grid
.equ	TEXT_COLOR,		0xDFA0  // Color of Actions Remain. and keys
.equ	NUM_COLOR,		0x0F00	// Color of the numbers fo Actions Remain. and keys
.equ	STORY_COLOR,	0x0F00	// Color of the text with story during you win/lose
.equ	DONEGAME_COLOR, 0xF000	// Color of text that says you win/lose
.equ	CELL_SIZE,		47		// Size of each cell
.globl BG_COLOR
.equ	BG_COLOR,		0x0000	// Background color the whole game

.section .text


/* Creates a fresh board based on original board
 * Args:
 *  none
 * Return:
 *  none
 */
.globl NewBoard
NewBoard:
	orgBrdAdrs 	.req	r4	// Address of the original board
	newBrdAdrs 	.req	r5	// Address of the new board
	counter		.req	r6	// Counter
	push	{r4-r6, lr}
	ldr		orgBrdAdrs, =originalLayoutArray	// Load address of original array
	ldr		newBrdAdrs, =layoutArray			// Load address of new array
	
	mov		counter, #0					// Set the counter to 0
copyBoardLoop$:	
	ldrb	r0, [orgBrdAdrs, counter]	// Load value from original array
	strb	r0, [newBrdAdrs, counter]	// Store value from original array
	add		counter, #1					// Increment the counter
	
	cmp		counter, #256				// Check to see all elements were written
	blt		copyBoardLoop$				// Keep branching till all elements were iterated
	
	ldr		r0,	=StartLocationDrawn // Load address was start location drawn
	mov		r1, #0				
	str		r1, [r0]			// Reset that start wasn't drawn
	
	ldr		r0, =KeyCount		// Reset key count
	mov		r1, #0				// Default '0'
	str		r1, [r0]			
		
	ldr		r0, =ActionCount	// Reset action count
	mov		r1, #150			// Default '150'
	str		r1, [r0]			

	ldr		r0, =CharLocation	// Reset character location
	ldr		r1, =InitalCharLocation	// Load initial character location value
	ldr		r2, [r1] 			//	Load the value of initial character
	str		r2, [r0]			// Store that value in CharLocation			
	
	.unreq	counter
	.unreq	orgBrdAdrs
	.unreq	newBrdAdrs
	pop		{r4-r6, pc}
	
	
/* Draw the actual game
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawBoard
DrawBoard:
	counter .req    r4			// Used as a counter in numerous places
    gridRat .req    r5			// Grid ratio, how many pixels per block
    color	.req	r6			// Used as color in numerous places
    sqrAdrs .req	r7			// Holds address of the 2D array
    boxx	.req	r8			// x value for the 'box'
    boxy	.req	r9			// y value for the 'box'
    tmp		.req	r10			// temporary value used for checking row
	push	 {r4-r10,lr}
	
	ldr		gridRat, =GRID_RATIO	// Set the grid ratio
	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	
	ldr		boxx, =INITX			// Set initial x value
	ldr		boxy, =INITY			// Set initial y value
	mov		counter, #0				// Set the counter to 0

drawCells$:
	mov		r0,	boxx				// Move x value of top left corner
	mov		r1,	boxy				// Move y value of top left corner
	ldrb	r2,	[sqrAdrs, counter]	// Load the value stored in given spot
	
	cmp		r2, #0		// If 'grass' value is loaded branch to grass
	beq		drawGrass$
	
	cmp		r2, #1		// If 'wall' value is loaded branch to grass
	beq		drawWall$
	
	cmp		r2, #2		// If 'key' value is loaded branch to grass
	beq		drawKey$
	
	cmp		r2, #3		// If 'door' value is loaded branch to grass
	beq		drawDoor$
	
	cmp		r2, #4		// If 'exitDoor' value is loaded branch to grass
	beq		drawExit$
	
	cmp		r2, #5		// If 'character' value is loaded branch to grass
	beq		drawCharacter$

  
/* For each of these 'methods' the value of x is loaded to r0,
 * the value of y is loaded to r1. The box is then drawn with its 
 * top left corner at the coordinates given. 
 * drawGrass$ and drawWall$ also pass through r2 their colors.
 * After it is done drawing the box, they all branch down
 */ 
  drawGrass$:
	bl		DrawGrass
	b		checkRow$
 
  drawWall$:
	bl		DrawWall
	b		checkRow$
 
  drawKey$:
	bl 		DrawKey
	b		checkRow$
 
  drawDoor$:
	bl		DrawDoor
	b		checkRow$
 
  drawCharacter$:
	bl		DrawCharacter
	b		checkRow$
 
  drawExit$:
	bl		DrawExit

checkRow$:	
	ldr		tmp, =ENDX			// Move value of edge to tmp
	sub		tmp, gridRat		// Subtract gridRat
	cmp		boxx, tmp			// Compare to see are we at the end
	bne		incrementXCoord$	// If not continue on
	ldr		boxx, =INITX		// If yes start at initial x value
	add		boxy, gridRat		// and move down one row
	b		icrementDraw$		// Branch to continue the counter
	
incrementXCoord$:
	add		boxx, gridRat		// Move to next box to the right
icrementDraw$:
	add 	counter, #1			// Increment counter
	cmp		counter, #256		// Check to see are all tiles drawn
	blt		drawCells$			// Otherwise branch up

	bl		DrawStart			// Draw the start cell
	bl		DrawGrid			// Draw the grid
	bl		DrawKeys			// Draw the number of keys
	bl		DrawActions			// Draw the number of actions
	
	.unreq	counter
	.unreq	gridRat
	.unreq	color
	.unreq	sqrAdrs
	.unreq	boxx
	.unreq	boxy
	.unreq  tmp
	pop		{r4-r10,pc}
	
	
/* Draw a box of grass
 * Args:
 *  r0 - x coord of top left corner of box
 *	r1 - y coord of top left corner of box
 * Return:
 *  none
 */	
.globl DrawGrass
DrawGrass:
	push {lr}
	ldr		r2,	=GRASS_COLOR
	bl		DrawSquare
	pop	{pc}


/* Draw a box of wall
 * Args:
 *  r0 - x coord of top left corner of box
 *	r1 - y coord of top left corner of box
 * Return:
 *  none
 */	
.globl DrawWall
DrawWall:
	push {lr}
	ldr		r2,	=WALL_COLOR
	bl		DrawSquare
	pop	{pc}


/* Draw the key
 * Args:
 *  r0 - x coord of top left corner of box that includes a key
 *	r1 - y coord of top left corner of box that includes a key
 * Return:
 *  none
 */	
.globl DrawKey
DrawKey:
	push {lr}
	ldr		r2,	=KEY_COLOR
	bl		DrawSquare
	pop	{pc}
	
/* Draw a door
 * Args:
 *  r0 - x coord of top left corner of door
 *	r1 - y coord of top left corner of door
 * Return:
 *  none
 */	
.globl DrawDoor
DrawDoor:
	push {lr}
	ldr		r2,	=DOOR_COLOR
	bl		DrawSquare
	pop	{pc}
	
	
/* Draw the character
 * Args:
 *  r0 - x coord of top left corner of the character's box
 *	r1 - y coord of top left corner of the character's box
 * Return:
 *  none
 */	
.globl DrawCharacter
DrawCharacter:
	push {lr}
	ldr		r2,	=CHAR_COLOR
	bl		DrawSquare
	pop	{pc}


/* Draw the exit
 * Args:
 *  r0 - x coord of top left corner of the exit
 *	r1 - y coord of top left corner of the exit
 * Return:
 *  none
 */	
.globl DrawExit
DrawExit:
	push {lr}
	ldr		r2,	=EXIT_COLOR
	bl		DrawSquare
	pop	{pc}
	
	
/* Draw the exit
 * Args:
 *  r0 - cell number
 * Return:
 *  r0 - x coord of top left corner of the exit
 *	r1 - y coord of top left corner of the exit
 */	
.globl CellPixels
CellPixels:
	cell 	.req    r4			// The cell number
    gridRat .req    r5			// Grid ratio, how many pixels per block
    posit	.req	r6			// Position, used for relative positions
    boxx	.req	r7			// x value for the 'box'
    boxy	.req	r8			// y value for the 'box'
	push	 {r4-r8,lr}
	
	mov		cell, r0			// Move the cell number over
	ldr		gridRat, =GRID_RATIO	// Load the grid ratio
	
	mov		posit, cell			// Copy leftCell number over to posit
	lsr		posit, posit, #4	// Move right by 4 bits to get the row number
	
	mul		boxy, posit, gridRat // Multiply row # by gridRat which is number of pixels per row
	ldr		posit, =INITY		// Load inital y pixel value into posit
	add		boxy, posit			// Add the inital y pixel value to calculated value
	

	mov		posit, cell			// Copy cell number over to posit
	and		posit, posit, #0xF	// Get only the first 4 bits to get the column number
	
	mul		boxx, posit, gridRat // Multiply column # by gridRat which is number of pixels per column
	ldr		posit, =INITX		// Load inital x pixel value into posit
	add		boxx, posit			// Add the inital x pixel value to calculated value
	
	mov		r0, boxx			// Move value of boxx to be returned
	mov		r1, boxy			// Move value of boxy to be returned
	
	.unreq	cell
	.unreq	gridRat
	.unreq	posit
	.unreq	boxx
	.unreq	boxy
	pop		{r4-r8,pc}


/* Draw the game's grid
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawGrid
DrawGrid:
	counter .req    r4			// Used as a counter in numerous places
    gridRat .req    r5			// Grid ratio, how many pixels per block
    color	.req	r6			// Used as color in numerous places
	push	 {r4-r6,lr}
	
	ldr		gridRat, =GRID_RATIO	// Set the grid ratio
	
	ldr		counter, =INITX		 // Load inital value for x
	ldr		color,   =LINE_COLOR // Load the color the lines should be
drawGridY$:	
	mov		r0,	counter		// Move value of x to r0 so it can be passed
	ldr		r1,	=INITY		// Move value of y to r1 so it can be passed
	mov		r2,	color		// Move value of color to r2 so it can be passed
	ldr		r3,	=ENDY		// Move final value of y to r3 so it can be passed
	bl 		DrawLineY		// Draw the line!
	
	add		counter, gridRat	// Incrmenet the counter by the size of the grid
	ldr		r3,	=ENDX			// Load how far the grid should go
	cmp		counter, r3			// Compare it to our counter
	ble		drawGridY$			// If not at the end branch up
	
	ldr		counter, =INITY		// Load initial value for y
	
drawGridX$:	
	ldr		r0,	=INITX		// Move value of x to r0 so it can be passed
	mov		r1,	counter		// Move value of y to r1 so it can be passed
	mov		r2,	color		// Move value of color to r2 so it can be passed
	ldr		r3,	=ENDX		// Move final value of x to r3 so it can be passed
	bl 		DrawLineX		
	
	add		counter, gridRat	// Incrmenet the counter by the size of the grid
	ldr		r3,	=ENDY			// Load how far the grid should go
	cmp		counter, r3			// Compare it to our counter
	ble		drawGridX$			// If not at the end branch up
	
	.unreq	counter
	.unreq	gridRat
	.unreq	color
	pop		{r4-r6,pc}


/* Draw's the text that tells you amount of keys
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawKeys
DrawKeys:
	keyAdrs	.req	r4	// Address of key integer
	tmp		.req	r5	// Used to temporary store larger numbers
	push	{r4-r5, lr}
	
	mov		r0, #14			// Move the value of the cell that will overwrite
	bl		CellPixels		// Get the x and y value for the cell
	bl		DrawWall		// Draw wall block where value of key was
	
	bl		DrawGrid		// Redraw the grid
	
	ldr		r0,	=INITX		// Set the value of x to inital x value of game
	ldr		tmp, =612		// Load 612 into register (to large to mov and use add)
	add		r0, tmp			// Add 612 to x value
	ldr		r1,	=INITY		// Set the value of y to initial y value of game
	add		r1, #15			// Add 15 to y value
	ldr		r2,	=TEXT_COLOR	// Set the color of the text
	ldr		r3,	=KeysString	// Load address of the string "KEYS"
	bl		DrawSentance	// Draw the string
	
	ldr		keyAdrs, =KeyCount	// Load address of the key count
	ldr     r0,  [keyAdrs, #0]	// Load how many keys are present
	ldr		r1, =KeyCountString	// Load address of the key string
	bl		IntToString			// Turn the int to string
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	ldr		tmp, =662			// Load 662 into register (to large to mov and use add)
	add		r0, tmp				// Add 662 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #15				// Add 15 to y value
	ldr		r2,	=NUM_COLOR		// Set the color of the text
	ldr		r3,	=KeyCountString	// Load address of how many keys there are
	bl		DrawSentance		// Draw the string
	
	.unreq	tmp
	.unreq	keyAdrs
	pop		{r4-r5, pc}


/* Draw's the amount of actions left
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawActions
DrawActions:
	actAdrs	.req	r4	// Address of action integer
	push	{r4, lr}

	mov		r0, #5			// Move the value of the cell that will overwrite
	bl		CellPixels		// Get the x and y value for the cell
	bl		DrawWall		// Draw wall block where value of actions was

	bl		DrawGrid		// Redraw the grid
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	add		r0, #55				// Add 55 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #15				// Add 15 to y value
	ldr		r2,	=TEXT_COLOR		// Set the color of the text
	ldr		r3,	=ActionString	// Load address of the string "ACTIONS REMAINING"
	bl		DrawSentance		// Draw the string

    ldr		actAdrs, =ActionCount	// Load address for action counter	
	ldr     r0,  [actAdrs]			// Load number of actions left into r0
	
	cmp		r0, #9					// See if int is 1 number big
	bls		oneLong$				// If so branch to oneLong$
	
	cmp		r0, #99					// See if int is 2 numbers big
	bls		twoLong$				// If so branch to twoLong$
	
threeLong$:	// Otherwise fall through to threeLong$
	ldr		r1, =ActionCountString	// Load address where int will be stored as string
	bl		IntToString				// Convert to string
	ldr		r3,	=ActionCountString	// Load address of the new string
	b		drawActionNumber$
	
twoLong$:	// Branch here to avoid having '099', instead only have '99'
	ldr		r1, =ActionCountStringTwo	// Load address where int will be stored as string
	bl		IntToString					// Convert to string
	ldr		r3,	=ActionCountStringTwo	// Load address of the new string
	b		drawActionNumber$
	
oneLong$: // Branch here to avoid having '009', instead only have '9'
	ldr		r1, =ActionCountStringOne	// Load address where int will be stored as string
	bl		IntToString					// Convert to string
	ldr		r3,	=ActionCountStringOne	// Load address of the new string
	
drawActionNumber$:
	ldr		r0,	=INITX		// Set the value of x to inital x value of game
	add		r0, #235		// Add 235 to x value
	ldr		r1,	=INITY		// Set the value of y to initial y value of game
	add		r1, #15			// Add 15 to y value
	ldr		r2,	=NUM_COLOR	// Set the color of the text
	bl		DrawSentance	// Draw the string

	.unreq	actAdrs
	pop		{r4, pc}
	
	
/* Tells user he loses
 * Args:
 *  none
 * Return:
 *  none
 */
.globl YouLose
YouLose:
	push	{lr}
	
	bl		ClearScreen		// Clear the screen
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	add		r0, #100			// Add 100 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #300			// Add 300 to y value
	ldr		r2,	=STORY_COLOR	// Load color of text
	ldr		r3, =YouPerish		// Load story text to be written
	bl		DrawSentance		// Draw it
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	add		r0, #235			// Add 235 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #400			// Add 400 to y value
	ldr		r2,	=DONEGAME_COLOR	// Load color of text
	ldr		r3, =GameOver		// Load text to tell player they lose
	bl		DrawSentance		// Draw it
	
loseReadLoop$:
	bl	ReadFromCont		// read SNES
		ldr	r1, =0xFFFF		// full mask
		teq	r0, r1			// test if no buttons are pressed
		beq loseReadLoop$	// branch up till something is pressed
		
		bl	ClearScreen		// Clear the screen
		b	mainMenu$		// branch to start game when something is pressed
	
	pop		{pc}

/* Tells user he wins
 * Args:
 *  none
 * Return:
 *  none
 */
.globl YouWin
YouWin:
	push	{lr}
	
	bl		ClearScreen		// Clear the screen
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	add		r0, #100			// Add 100 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #300			// Add 300 to y value
	ldr		r2,	=STORY_COLOR	// Load color of text
	ldr		r3, =YouEscaped		// Load story text to be written
	bl		DrawSentance		// Draw it
	
	ldr		r0,	=INITX			// Set the value of x to inital x value of game
	add		r0, #235			// Add 235 to x value
	ldr		r1,	=INITY			// Set the value of y to initial y value of game
	add		r1, #400			// Add 400 to y value
	ldr		r2,	=DONEGAME_COLOR	// Load color of text
	ldr		r3, =YoureWinner	// Load text to tell player they win
	bl		DrawSentance		// Draw it
	
winReadLoop$:
	bl	ReadFromCont		// read SNES
		ldr	r1, =0xFFFF		// full mask
		teq	r0, r1			// test if no buttons are pressed
		beq loseReadLoop$	// branch up till something is pressed
		
		bl	ClearScreen		// Clear the screen
		b	mainMenu$		// branch to start game when something is pressed
	
	pop		{pc}
	
/* Draws the start square
 * Args:
 *  none
 * Return:
 *  none
 */
.globl DrawStart
DrawStart:
	charLoc			.req	r4
	initCharLoc		.req	r5
	push	{r4-r7, lr}
	
	ldr		r0, =CharLocation
	ldr		charLoc, [r0]		// Load value where character currently is
	
	ldr		r0, =InitalCharLocation
	ldr		initCharLoc, [r0]	// Load value of start

	cmp		charLoc, initCharLoc	// If they are the same
	beq		dontDrawStart$			// Don't draw anything
	
	ldr		r0,	=StartLocationDrawn // Load address was start location drawn
	ldr		r1, [r0]			// Load was the start location was drawn
	cmp		r1, #1				// If already drawn...
	beq		drawStartDone$		// ... don't draw anything
	
drawStartSquare$:
	ldr		r0,	=StartLocationDrawn // Load address was start location drawn
	mov		r1, #1
	str		r1, [r0]			// Store that the start location was drawn
	mov		r0, initCharLoc		// Move the value of the old cell to be passed
	bl		CellPixels			// Get the x and y value of cell to be drawn
	ldr		r2,	=START_COLOR	// Set color for start block
	bl		DrawSquare			// Draw start cell

	b		drawStartDone$		// Branch to end

dontDrawStart$:
	ldr		r0,	=StartLocationDrawn // Load address was start location drawn
	mov		r1, #0				
	str		r1, [r0]			// Store that the start location wasn't drawn

drawStartDone$:
	
	pop		{r4-r7,pc}
	
	
/* Draws a row of color BG_COLOR to/from specified cells
 * Args:
 *  r0 - First cell in row
 *  r1 - Final cell in row
 *	r2 - Color of row
 * Return:
 *  none
 */
.globl DrawCellRow
DrawCellRow:
	cellInt	.req	r4		// Initial/counter cell of the row
    cellFin .req	r5		// Final cell in the row
	push	 {r4-r5,lr}
	
	mov		cellInt, r0		// Store first cell in row
	mov		cellFin, r1		// Store final cell in row
	
drawRow$:	
	mov		r0, cellInt		// Move the value of the old cell to be passed
	bl		CellPixels		// Get the x and y value of cell to be drawn
	bl		DrawSquare		// Draw background cell
	
	add		cellInt, #1		// Increment the cell number
	
	cmp		cellInt, cellFin // Check are we at the last cell
	bls		drawRow$
	
	.unreq	cellInt
	.unreq	cellFin
	pop		{r4-r5,pc}
	
