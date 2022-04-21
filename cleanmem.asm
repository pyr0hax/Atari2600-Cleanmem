	processor 6502
	
	seg code	; Define segment of where the code starts
	org $F000	; Define the code origin at $F000

Start:
	sei		; Disable interrupts
	cld		; Disable the BCD decimal math mode
	ldx #$FF	; Loads the X register with #$FF
	txs		; Transfer X register to (s)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the page Zero region ($00 to $FF)
; Meaning the entire RAM and also the entire TIA Registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	lda #0		; A = 0
	ldx #$FF	; X = #$FF
MemLoop:
	sta $0,X	; Store the value of A inside of memory address $0 + X
	dex		; X--
	bne MemLoop	; Loop until X is equal to zero (z-flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC
	.word Start	; Reset vector at $FFFC (Where the program starts)
	.word Start	; INterrupt vector at $FFFW (Unused in the VCS)

