	org	100h
;*****************************************
;* Programm hiire torkimiseks:           *
;*					 *
;*             << HINT >>  		 *
;*					 *
;*	  Vakstu & JUKU3000 2024	 *
;*         Serial No. A-0002-01 	 *
;*****************************************
;
boot	equ	0000h	;Bdos entry point
;
;	RomBios functions
TTStat	equ	0ffc7h	;Keyboard status
TTCon	equ	0ffcdh	;Send message to console
TTO	equ	0ffd9h	;Console output
IntSRV	equ	0ff89h	;Interrupt serve
LineL	equ	320/8	;Line length in bytes
InitV	equ	0d81fh	;Initial video mem pos
;
;	Other
CR	equ	0dh	;carriage return
LF	equ	0ah	;line feed
ESC	equ	1bh	;escape code
;
Hiir:	lxi	b,tere	;Print start message
	call	ttcon	;to console and hide cursor
	lxi	d,int6	;Display port status
	mvi	a,6	;to interrupt 6
	call	intsrv	;start serving
MLoop:	call	ttstat	;Check for pressed keys
	jz	mloop	;Main loop if not pressed
	lxi	d,0	;Clear
	mvi	a,6	;interrupt 6
	call	intsrv	;from now &
	lxi	b,clear	;clear screen and restore cursor
	call	ttcon	;before exiting
	jmp	boot	;and reboot
;
Int6:	in	80h	;Get mouse status
	mvi	d,8	;Counter restart
	lxi	b,home	;move cursor home
	call	ttcon
	lhld	pos	;Position of graph
Loop:	ral		;Rotate status left
	push	a	;Original mouse byte
	jc	onepr	;if carry then print a 1
	mvi	a,'0'	;else print
	call	tto	;a '0' to console (maybe slow)
	mvi	a,0	;empty pixels
	jmp	graph	;draw graph
Onepr:	mvi	a,'1'	;print a '1'
	call	tto	;to console (maybe slow)
	mvi	a,0ffh	;8 full pixels
Graph:	mov	b,h
	mov	c,l
	stax	b	;Graph on screen
	pop	a	;restore original mouse byte
	inx	h	;Screen next 8 pixels
	dcr	d	;decrement counter
	jnz	loop	;rotate more if counter not zero
;
	lhld	pos	;Position of graph
	mvi	b,0
	mvi	c,LineL
	dad	b	;Add line length
	mov	d,h
	mov	e,l
	mvi	a,80h
	sub	l
	mvi	a,0fdh
	sbb	h
	jnc	cont	;Still lower than max
	lxi	d,initv	;Back to first line
Cont:	mov	h,d
	mov	l,e
	shld	pos	;Store new pos
        ret
;
;	Data area
;
Pos:	dw	initv
;max:	dw	0d800h+320*240/8 ; = FD80
Tere:	db	esc,'4',esc,'L',esc,'M0','???????? <- Mouse status',cr,lf,cr,lf
	db	esc,''''
	db	'=============================',cr,lf
	db	'# Testing INT6,             #',cr,lf
	db	'#    the mouse interrupt... #',cr,lf
	db	'=============================',cr,lf
	db	esc,'(',0
;Clear:	db	esc,'5', esc,'L',0
;Clear:	db	esc,'5',0
Clear:	db	esc,'B',esc,'B',esc,'B',esc,'B',esc,'B',esc,'B',esc,'B',esc,'5',0
Home:	db	esc,'H',0
	end