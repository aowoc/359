.section .data 
.align 4

/* All of the following set of data that store sentances are stored
 * 	as asciz since the method DrawSentance requires the 0 at the end
 */

.globl MainMenu
MainMenu:		
	.asciz 	"MAIN MENU"

.globl StartGame
StartGame:	
	.asciz 	"Start Game"

.globl QuitGame	
QuitGame:	
	.asciz "Quit Game"

.globl GameName 
GameName:	
	.asciz "A DUNGEON CRAWLER"

.globl Creators
Creators:	
	.asciz "BY: Adam Owoc & Cole McNish"

.globl mainMenuSelected 
mainMenuSelected:
	.int		0


.section .text

/* Draws the main menu items
 * Args:
 *  none	
 * Return:
 *  none
 */
.globl DrawMenus
DrawMenus:
	push {lr}
	
	/* Each of these small blocks of code load the x coordinate to r0
	 * y coordinate to r1 (of the top left corner of the text), then 
	 * load the color to r2, and the address of the text to be printed
	 * to r3. Then calls DrawSentance. 
	 * The values of x and y were judgement calls on what looks good,
	 * so they are not made 'constants'. 
	 */
	 
	// Draws the text "MAIN MENU"
	mov		r0, #160
	mov		r1, #200
	ldr		r2, =0xF0F0		// Pink
	ldr		r3,	=MainMenu
	bl		DrawSentance
	 
	// Draws the text "Start Game"
	mov		r0, #160
	mov		r1, #250
	ldr		r2, =0x0FF0		// Teal
	ldr		r3,	=StartGame
	bl		DrawSentance
	 
	// Draws the text "Quit Game"
	mov		r0, #160
	mov		r1, #300
	ldr		r2, =0x0FF0		// Teal
	ldr		r3,	=QuitGame
	bl		DrawSentance
	 
	// Draws the text "A DUNGEON CRAWLER"
	mov		r0, #400
	mov		r1, #100
	ldr		r2, =0x22F0		// Navy blue
	ldr		r3,	=GameName
	bl		DrawSentance
	 
	// Draws the text of who created the came
	mov		r0, #300
	mov		r1, #500
	ldr		r2, =0xAFA0		// Yellow
	ldr		r3,	=Creators
	bl		DrawSentance	
	
	
	// Set the selector on "Start Game"
	ldr		r0, =mainMenuSelected	// Load the address for the menu selection
	mov		r1, #1
	str		r1, [r0]			// Reset the menu selection
	bl		MainMenuSelect		// Draw the selector
	
	pop {pc}

/* Moves the main menu selector
 * Args:
 *  none
 * Return:
 *  none
 */
.globl MainMenuSelect
MainMenuSelect:
	selection	.req	r4	// What menu item is selected
	selectAdrs	.req	r5	// Address of selector integer
	push	{r4-r5, lr}
	
	ldr		selectAdrs, =mainMenuSelected	// Load address of selection
	ldr		selection, [selectAdrs]	// Load the selection
	
	cmp		selection, #0	// Test to see is StartGame selected
	beq		quitGameSelect$ // if it is branch to change the selection
	
startGameSelect$:
	ldr		r0,	=140			// Move the x coordinate in
	ldr		r1,	=250		// Move the y coordinate in
	ldr		r2, =0xF000		// Move the color in
	ldr		r3, =130		// Move width of the text
	bl		DrawSelector	// Draw the selector
	
	ldr		r0,	=140			// Move the x coordinate in
	ldr		r1,	=300		// Move the y coordinate in
	ldr		r2, =0x0000		// Move the color in
	ldr		r3, =120		// Move width of the text
	bl		DrawSelector	// Erase old selector
	
	mov		r0,	#0
	str		r0, [selectAdrs]	// Store the selection
	
	b		doneSelect$		// Done!
	
quitGameSelect$:
	ldr		r0,	=140			// Move the x coordinate in
	ldr		r1,	=300		// Move the y coordinate in
	ldr		r2, =0xF000		// Move the color in
	ldr		r3, =120		// Move width of the text
	bl		DrawSelector	// Draw the selector
	
	ldr		r0,	=140			// Move the x coordinate in
	ldr		r1,	=250		// Move the y coordinate in
	ldr		r2, =0x0000		// Move the color in
	ldr		r3, =130		// Move width of the text
	bl		DrawSelector	// Erase old selector
	
	mov		r0,	#1
	str		r0, [selectAdrs]	// Store the selection
	
doneSelect$:	

	.unreq	selection
	.unreq	selectAdrs
	pop		{r4-r5, pc}
