.section .text


/* Moves the game menu selector
 * Args:
 *  none
 * Return:
 *  r0 - 0 if player returned back to game
 *	   - 1 if player restart game
 *	   - 2 if player quit game (main menu)
 */
.globl InGameMenuControl
InGameMenuControl:
	push	{lr}
	
gameMenuControllerRead$:	
	bl	ExtraLongDelayLoop	// Delay loop so user doesn't double click
	bl	ReadFromCont		// read SNES
	ldr	r1, =0xFFFF		// full mask
	teq	r0, r1			// test if no buttons are pressed
	beq	gameMenuControllerRead$	// read controller again when no buttons are pressed

	ldr	r1, =0xFFF7		// mask for bit [3]
	teq	r0, r1			// test if 'start' was pressed
	beq	inGameMenuStartPress$

	ldr	r1, =0xFEFF		// mask for bit [8]
	teq	r0, r1			// test if 'a' was pressed 
	beq	inGameMenuAPress$

	ldr	r1, =0xFFEF		// mask for bit [4]
	teq	r0, r1			// test if 'up' was pressed
	beq	inGameMenuChangeSelection$

	ldr	r1, =0xFFDF		// mask for bit [5]
	teq	r0, r1			// test if 'down' was pressed
	beq	inGameMenuChangeSelection$

	b	gameMenuControllerRead$	// branch if none of these buttons are being pressed by themselves
		
inGameMenuStartPress$:
	bl 		DrawBoard		// Redraw the board
	mov		r0, #0			// Return #0 
	b		gameMenuDone$	// Finish the method

inGameMenuAPress$:
	ldr		r0, =inGameSelected		// Load adddress of what is selected in the menu
	ldr		r1, [r0]				// Load what is actually selected
	
	cmp		r1, #0					// See if restart game is selected
	bne		gameMenuQuitGame$		// Otherwise selection is to quit game

  gameMenuRestartGame$:
	bl		NewBoard		// Reset the board
	bl		DrawBoard		// Draw the new board

	mov		r0, #1			// Return #0
	b		gameMenuDone$	// Finish the method

  gameMenuQuitGame$:	
	bl		ClearScreen		// Clear the screen
	bl		DrawMenus		// Draw the main menu
	mov		r0, #2			// Return #2
	b		gameMenuDone$	// Finish the method
	
inGameMenuChangeSelection$:
	bl		MoveGameMenuSelect	// Change what the selector is on
	b		gameMenuLetGo$		// Wait till no buttons are pressed
		
gameMenuLetGo$:
	bl	LongDelayLoop	// Delay loop so user doesn't double click
	bl	ReadFromCont	// Read from the controller
	ldr	r1, =0xFFFF		// Load the value when no buttons are pressed
	teq	r0, r1			// Compare value when no buttons pressed to what we got from controller
	bne	gameMenuLetGo$	// Until no buttons pressed loop back up
	b	gameMenuControllerRead$ // After no buttons are pressed check for next button
		
gameMenuDone$:	
	
	pop		{pc}
	
	
/* Moves the main menu selector
 * Args:
 *  none
 * Return:
 *  r0 - 0 if player start game
 *	   - 1 if player quit game 
 */
.globl MainMenuControl
MainMenuControl:
	push	{lr}
	
mainMenuControllerRead$:	
	bl	LongDelayLoop	// Delay loop so user doesn't double click
	bl	ReadFromCont		// read SNES
	ldr	r1, =0xFFFF		// full mask
	teq	r0, r1			// test if no buttons are pressed
	beq	mainMenuControllerRead$	// read controller again when no buttons are pressed

	ldr	r1, =0xFEFF		// mask for bit [8]
	teq	r0, r1			// test if 'a' was pressed 
	beq	mainMenuAPress$

	ldr	r1, =0xFFEF		// mask for bit [4]
	teq	r0, r1			// test if 'up' was pressed
	beq	mainMenuChangeSelection$

	ldr	r1, =0xFFDF		// mask for bit [5]
	teq	r0, r1			// test if 'down' was pressed
	beq	mainMenuChangeSelection$

	b	mainMenuControllerRead$	// branch if none of these buttons are being pressed by themselves
		
mainMenuAPress$:
	ldr		r0, =mainMenuSelected	// Load adddress of what is selected in the menu
	ldr		r1, [r0]				// Load what is actually selected

	cmp		r1, #0					// See if restart game is selected
	bne		mainMenuQuitGame$		// Otherwise selection is to quit game

  mainMenuStartGame$:
	mov		r0, #0				
	b		mainMenuDone$

  mainMenuQuitGame$:	
	bl		ClearScreen
	mov		r0, #1
	b		mainMenuDone$
	
mainMenuChangeSelection$:
	bl		MainMenuSelect
	b		mainMenuLetGo$
		
mainMenuLetGo$:
	bl	LongDelayLoop	// Delay loop so user doesn't double click
	bl	ReadFromCont	// Read from the controller
	ldr	r1, =0xFFFF		// Load the value when no buttons are pressed
	teq	r0, r1			// Compare value when no buttons pressed to what we got from controller
	bne	mainMenuLetGo$	// Until no buttons pressed loop back up
	b	mainMenuControllerRead$ // After no buttons are pressed check for next button
		
mainMenuDone$:	
	
	pop		{pc}
	
	
	
/* Controls the player inside the game
 * Args:
 *  none
 * Return:
 *  none
 */
.globl GameControl
GameControl:
	push	{lr}
	
playerControl$:
		bl	LongDelayLoop	// Delay loop so user doesn't double click
		bl	ReadFromCont	// read SNES
		ldr	r1, =0xFFFF		// full mask
		teq	r0, r1			// test if no buttons are pressed
		beq	playerControl$		// read controller again when no buttons are pressed

		ldr	r1, =0xFFF7		// mask for bit [3]
		teq	r0, r1			// test if 'start' was pressed
		beq	startPress$

		ldr	r1, =0xFEFF		// mask for bit [8]
		teq	r0, r1			// test if 'a' was pressed 
		beq	aPress$

		ldr	r1, =0xFFEF		// mask for bit [4]
		teq	r0, r1			// test if 'up' was pressed
		beq	upPress$

		ldr	r1, =0xFFDF		// mask for bit [5]
		teq	r0, r1			// test if 'down' was pressed
		beq	downPress$

		ldr	r1, =0xFFBF		// mask for bit [6]
		teq	r0, r1			// test if 'left' was pressed
		beq	leftPress$

		ldr	r1, =0xFF7F		// mask for bit [7]
		teq	r0, r1			// test if 'right' was pressed
		beq	rightPress$

		b	playerControl$		// branch if none of these buttons are being pressed by themselves
			
  startPress$:
	bl		DrawInGameMenu		// Draw the in game menu
	bl		InGameMenuControl	// Make the controller control the in game menu

	cmp		r0, #0			// If 0 was returned then "start" was pressed again
	beq		letGo$			// So just resume game play
		
	cmp		r0, #1			// If 1 was returned that means player hit "restart game"
	beq		playerControl$	// New game redrawn, and now let controller control it
		
	cmp		r0, #2			// If 2 was returned that means player hit "quit game"
	beq		mainMenu$		// So go to the main menu
		
	b 		letGo$			// Wait till no buttons are pressed
		
  aPress$:
	bl	ActionKey		// Try to unlock a door or exit door
	b	letGo$			// Wait till no buttons are pressed

  upPress$:
	bl	MoveUp			// Move player up is possible
	b	letGo$			// Wait till no buttons are pressed

  downPress$:
	bl	MoveDown		// Move player down if possible
	b	letGo$			// Wait till no buttons are pressed

  leftPress$:
	bl	MoveLeft		// Move player left if possible
	b	letGo$			// Wait till no buttons are pressed

  rightPress$:
	bl	MoveRight		// Move player right if possible
	b	letGo$			// Wait till no buttons are pressed
		
letGo$:
		bl	LongDelayLoop	// Delay loop so user doesn't double click
		bl	ReadFromCont	// Read from the controller
		ldr	r1, =0xFFFF		// Load the value when no buttons are pressed
		teq	r0, r1			// Compare value when no buttons pressed to what we got from controller
		bne	letGo$			// Until no buttons pressed loop back up to letGo$
		b	playerControl$	// After no buttons pressed check for next button
	
	pop {pc}
	
	
	
/* Delay loop so that player doesn't accidently click a few times in a row
 * Args:
 *  none
 * Return:
 *  none
 */
.globl LongDelayLoop
LongDelayLoop:
	push	{r4-r5,lr}
	
	mov	r4, #0		// Move 0 into counter
	ldr	r5, =100000 // Set how many time to loop (the larger the longer the delay)
delayLoopLoop$:
	add	r4, #1		// Add to counter
	cmp	r4, r5		// Compare to how many times to loop
	blo	delayLoopLoop$	// Branch till done the loop r5 times
	
	pop		{r4-r5,pc}
	
/* Extra long delay loop used for start menu
 * Args:
 *  none
 * Return:
 *  none
 */
.globl ExtraLongDelayLoop
ExtraLongDelayLoop:
	push	{r4-r5,lr}
	
	mov	r4, #0		// Move 0 into counter
	ldr	r5, =1000000 // Very large delay
extraDelayLoopLoop$:
	add	r4, #1		// Add to counter
	cmp	r4, r5		// Compare to how many times to loop
	blo	extraDelayLoopLoop$	// Branch till done the loop r5 times
	
	pop		{r4-r5,pc}
	
