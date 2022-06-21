	org	100h
;*****************************************
;* Programm hiire torkimiseks:           *
;*					 *
;*             << HIIR >>  		 *
;*					 *
;*     Vakstu Laboratories Ltd. 1991     *
;*         Serial No. A-0002-01 	 *
;*****************************************
;
boot	equ	0000h	;Bdos entry point
;
;	RomBios functions
TTStat	equ	0ffc7h	;Keyboard status
TTCon	equ	0ffcdh	;Send message to console
TTO	equ	0ffd9h	;Console output
;
;	Other
cr	equ	0dh	;carriage return
lf	equ	0ah	;line feed
esc	equ	1bh	;escape code
;
Hiir:	lxi	b,pais	;Print start message
	call	ttcon	;to console
MLoop:	lxi	b,home	;move cursor home
	call	ttcon
	in	80h	;Get mouse status
	mvi	c,8	;Counter restart
Loop:	ral		;Rotate status left
	mov	b,a	;Save status
	jc	onepr	;if carry then print a 1
	mvi	a,'0'	;else print
	call	tto	;a '0'
	jmp	check	;check counter
onepr:	mvi	a,'1'	;print a '1'
	call	tto	;to console
check:	dcr	c	;decrement counter
	mov	a,b	;restore status byte
	jnz	loop	;rotate more if counter not zero
	call	ttstat	;Check for pressed keys
	jz	mloop	;Main loop if not pressed
	lxi	b,clear	;clear screen
	call	ttcon	;before exiting
	jmp	boot	;and reboot
;
;	Data area
;
pais:	db	esc,'L',esc,'M0','         <- Mouse status',cr,lf,cr,lf,cr,lf
	db	esc,''''
	db	'========================================'
	db	'# Program for mouse testing:           #'
	db	'#                                      #'
	db	'#             << HIIR >>               #'
	db	'#                                      #'
	db	'#    Vakstu Laboratories Ltd. 1991     #'
	db	'#         Serial No. A-0002-01         #'
	db	'========================================'
	db	esc,'(',0
clear:	db	esc,'L',0
home:	db	esc,'H',0
	end