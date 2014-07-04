
.section .text

/* Checks is there a door to unlock with your key, and unlocks it
 * Args:
 *  none
 * Return:
 *  none
 */
.globl ActionKey
ActionKey:
	oldCell	.req	r4			// The cell number you are moving from
	newCell .req    r5			// The cell number the door might be
    cell	.req	r6			// What is in the cell (ex. wall)
    sqrAdrs .req	r7			// Holds address of the 2D array
    looking .req	r8			// What we are looking for (door or exit)
	push	 {r4-r8,lr}
	
	ldr		r0,	=KeyCount	// Load address for key count
	ldr		r1, [r0]		// Load value of key count
	cmp		r1, #0			// If no keys branch to done
	beq		keyDone$

	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	
	ldr		r0,	=CharLocation	// Load address for location of character
	ldr		oldCell, [r0]		// Load location of character
	
	mov		looking, #3			// Store what are we looking for (door first time)
lookLoop$:	
	sub		newCell, oldCell, #1	// Find value of cell to the left
	ldrb	cell, [sqrAdrs, newCell]	// Load the value stored to left of player
	cmp		cell, looking			// See if cell is a door
	beq		keyUnlock$				// If it is, unlock it

	add		newCell, oldCell, #1	// Find value of cell to the right
	ldrb	cell, [sqrAdrs, newCell]	// Load the value stored to left of player
	cmp		cell, looking			// See if cell is a door
	beq		keyUnlock$				// If it is, unlock it

	sub		newCell, oldCell, #16	// Find value of cell above
	ldrb	cell, [sqrAdrs, newCell]	// Load the value stored to left of player
	cmp		cell,looking			// See if cell is a door
	beq		keyUnlock$				// If it is, unlock it

	add		newCell, oldCell, #16	// Find value of cell below
	ldrb	cell, [sqrAdrs, newCell]	// Load the value stored to left of player
	cmp		cell, looking			// See if cell is a door
	beq		keyUnlock$				// If it is, unlock it
	
	add		looking, #1				// Next time look for exit door
	cmp		looking, #4				// Branch back up to look for exit door
	bls		lookLoop$		
	
	b keyDone$

keyUnlock$:
	cmp		looking, #4		// If you unlock the exit door
	beq		exitUnlock$		// branch to exitUnlock
	
	mov		r0, #0			// Store 0 in register
	strb	r0, [sqrAdrs, newCell]	// Save that it is now grass in the array
	mov		r0, newCell		// Move the value of the new cell to be passed
	bl		CellPixels		// Get the x and y value for the door
	bl		DrawGrass		// Draw grass where door was
	b		countersUnlock$	// Branch subtract # of keys and actions
	
exitUnlock$:
	mov		r0, newCell		// Move the value of the new cell to be passed
	bl		CellPixels		// Get the x and y value for the door
	bl		DrawGrass		// Draw grass where door was
	bl		YouWin			// You win!

	
countersUnlock$:
	ldr		r0,	=KeyCount	// Load address for key count
	ldr		r1, [r0]		// Load value of key count
	sub		r1, #1			// Subtract 1 (because you used a key)
	str		r1, [r0]		// Store the new value of the key
	
	bl		DrawKeys		// Draw new number of keys
	bl		ActionSubtract	// Draw new number of actions
	
keyDone$:
	
	.unreq  looking
	.unreq	oldCell
	.unreq	newCell
	.unreq	sqrAdrs
	.unreq	cell
	pop		{r4-r8,pc}


/* Checks can you move left, and moves you if you can
 * Args:
 *  none
 * Return:
 *  none
 */
.globl MoveLeft
MoveLeft:
	oldCell	.req	r4			// The cell number you are moving from
	leftCell .req   r5			// The cell number to the left of crnt position
    cell	.req	r6			// What is in the cell (ex. wall)
    sqrAdrs .req	r7			// Holds address of the 2D array
	push	 {r4-r7,lr}
	
	ldr		r0,	=CharLocation	// Load address for location of character
	ldr		oldCell, [r0]		// Load location of character
	
	sub		leftCell, oldCell, #1	// Find value of cell to the left
	
	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	ldrb	cell, [sqrAdrs, leftCell]	// Load the value stored to left of player

	
	mov		r0, oldCell		// Move old cell number to r0
	mov		r1, leftCell	// Move new cell number to r1
	mov		r2, sqrAdrs		// Move address of the array to r2
	mov		r3, cell		// Move value of cell to r3
	
	bl		MoveCheck	// Check if you can move, and then move if possible
	
	.unreq	oldCell
	.unreq	leftCell
	.unreq	sqrAdrs
	.unreq	cell
	pop		{r4-r7,pc}
	
	
/* Checks can you move right, and moves you if you can
 * Args:
 *  none
 * Return:
 *  none
 */
.globl MoveRight
MoveRight:
	oldCell	.req	r4			// The cell number you are moving from
	rightCell .req    r5		// The cell number to the left of crnt position
    cell	.req	r6			// What is in the cell (ex. wall)
    sqrAdrs .req	r7			// Holds address of the 2D array
	push	 {r4-r7,lr}
	
	ldr		r0,	=CharLocation	// Load address for location of character
	ldr		oldCell, [r0]		// Load location of character
	
	add		rightCell, oldCell, #1	// Find value of cell to the right
	
	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	ldrb	cell, [sqrAdrs, rightCell]	// Load the value stored to right of player

	
	mov		r0, oldCell		// Move old cell number to r0
	mov		r1, rightCell	// Move new cell number to r1
	mov		r2, sqrAdrs		// Move address of the array to r2
	mov		r3, cell		// Move value of cell to r3
	
	bl		MoveCheck	// Check if you can move, and then move if possible
	
	.unreq	oldCell
	.unreq	rightCell
	.unreq	sqrAdrs
	.unreq	cell
	pop		{r4-r7,pc}

	
/* Checks can you move up, and moves you if you can
 * Args:
 *  none 
 * Return:
 *  none
 */
.globl MoveUp
MoveUp:
	oldCell	.req	r4			// The cell number you are moving from
	upCell  .req    r5			// The cell number above of current position
    cell	.req	r6			// What is in the cell (ex. wall)
    sqrAdrs .req	r7			// Holds address of the 2D array
	push	 {r4-r7,lr}
	
	ldr		r0,	=CharLocation	// Load address for location of character
	ldr		oldCell, [r0]		// Load location of character
	
	sub		upCell, oldCell, #16	// Find value of cell above you
	
	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	ldrb	cell, [sqrAdrs, upCell]	// Load the value stored above player

	
	mov		r0, oldCell		// Move old cell number to r0
	mov		r1, upCell	// Move new cell number to r1
	mov		r2, sqrAdrs		// Move address of the array to r2
	mov		r3, cell		// Move value of cell to r3
	
	bl		MoveCheck	// Check if you can move, and then move if possible
	
	.unreq	oldCell
	.unreq	upCell
	.unreq	sqrAdrs
	.unreq	cell
	pop		{r4-r7,pc}

	
/* Checks can you move down, and moves you if you can
 * Args:
 *  none
 * Return:
 *  none
 */
.globl MoveDown
MoveDown:
	oldCell	.req	r4			// The cell number you are moving from
	downCell .req    r5			// The cell number below current position
    cell	.req	r6			// What is in the cell (ex. wall)
    sqrAdrs .req	r7			// Holds address of the 2D array
	push	 {r4-r7,lr}
	
	ldr		r0,	=CharLocation	// Load address for location of character
	ldr		oldCell, [r0]		// Load location of character
	
	add		downCell, oldCell, #16	// Find value of cell below you
	
	ldr		sqrAdrs, =layoutArray	// Load the address of the 2D array
	ldrb	cell, [sqrAdrs, downCell]	// Load the value stored below player

	
	mov		r0, oldCell		// Move old cell number to r0
	mov		r1, downCell	// Move new cell number to r1
	mov		r2, sqrAdrs		// Move address of the array to r2
	mov		r3, cell		// Move value of cell to r3
	
	bl		MoveCheck	// Check if you can move, and then move if possible
	
	.unreq	oldCell
	.unreq	downCell
	.unreq	sqrAdrs
	.unreq	cell
	pop		{r4-r7,pc}


/* Checks can you move to given cell
 * Args:
 *  r0 - cell you came from
 *	r1 - cell you are going to 
 *  r2 - address of the array
 *	r3 - value of the cell
 * Return:
 *  none
 */
.globl MoveCheck
MoveCheck:
	oldCell .req	r4			// The cell number you are currently on
	newCell .req    r5			// New cell number you are trying to move to
    sqrAdrs .req	r6			// Holds address of the 2D array
    cell	.req	r7			// What the cell holds
	push	 {r4-r7,lr}
	
	mov		oldCell, r0		// Store value of old cell number from r0
	mov		newCell, r1		// Store value of new cell number from r1
	mov		sqrAdrs, r2		// Store address of the array from r2
	mov		cell,	 r3		// Store what the cell holds

	mov		r0, oldCell		// Move old cell number to r0
	mov		r1, newCell		// Move new cell number to r1
	mov		r2, sqrAdrs		// Move address of the array to r2
	
	cmp		cell, #0		// If 'grass' value is loaded branch to grass move
	beq		grassMove$
	
	cmp		cell, #1		// If 'wall' value is loaded branch to cant move
	beq		doneMove$

	cmp		cell, #2		// If 'key' value is loaded branch to key move
	beq		keyMove$

	cmp		cell, #3		// If 'door' value is loaded branch to cant move
	beq		doneMove$
	
	cmp		cell, #4		// If 'exit' value is loaded branch to cant move
	beq		doneMove$

grassMove$:
	bl		Moved			// Moved your character
	b 		doneMove$

keyMove$:
	bl		Moved			// Moved your character
	ldr		r0,	=KeyCount	// Load address for key count
	ldr		r1, [r0]		// Load value of key count
	add		r1, #1			// Add 1 (because you obtained a key)
	str		r1, [r0]		// Store the new value of the key
	
	bl		DrawKeys		// Draw the new amount of keys
	
	b		doneMove$
	
doneMove$:
	
	.unreq	oldcell
	.unreq	newCell
	.unreq	sqrAdrs
	.unreq 	cell
	pop		{r4-r7,pc}


/* If you can move at all use this
 * Args:
 *  r0 - cell you came from
 *	r1 - cell you are going to 
 *  r2 - address of the array
 * Return:
 *  none
 */
.globl Moved
Moved:
    oldCell	.req	r4		// Value of cell you're coming from
    newCell	.req	r5		// Value of cell you're going to
    sqrAdrs .req	r6		// Address of the array
	push	 {r4-r6,lr}
	
	mov		oldCell, r0		// Store the old cell number
	mov		newCell, r1		// Store the new cell number
	mov		sqrAdrs, r2		// Store address of the array
	
	mov		r0, #0			// Store value of the grass
	strb	r0, [sqrAdrs, oldCell]	// Write it to your old position
	
	mov		r0, #5			// Store value of your 'character'
	strb	r0, [sqrAdrs, newCell]	// Write it to your new position
	
	ldr		r0,	=CharLocation	// Load address for location of character
	str		newCell, [r0]		// Store new location of character
	
	mov		r0, oldCell		// Move the value of the old cell to be passed
	bl		CellPixels		// Get the x and y value for inital cell
	bl		DrawGrass		// Draw grass where you were

	bl		DrawStart		// Draw the start position if character isn't on it

	mov		r0, newCell		// Move the value of the new cell to be passed
	bl		CellPixels		// Get the x and y value for 'final' cell
	bl		DrawCharacter	// Draw the character where you are now
	
	bl		DrawGrid		// Draw the game grid
	
	bl		ActionSubtract	// Subtract one action
	
	.unreq	oldCell
	.unreq	newCell
	.unreq	sqrAdrs
	pop		{r4-r6,pc}	
	
/* Used to subtract the number of actions and check do you have any left.
 * If no actions left, will give you a you lose screen.
 * Args:
 *  none
 * Return:
 *  none
 */
.globl ActionSubtract
ActionSubtract:
	push	{lr}
	
	ldr		r0,	=ActionCount	// Load address for Action Counter
	ldr		r1, [r0]			// Load the number of Actions Remaining

	sub		r1, #1				// Subtract 1 action because did an action
	str		r1, [r0]			// Store the number of Actions Remaining
	
	cmp		r1, #0				// See are you out of moves	
	bne		actionSubDone$		// If you're not continue on otherwise...
	bl		YouLose				// Branch to you lose

actionSubDone$:
	
	bl		DrawActions
	
	pop		{pc}
