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
;
;	Other
cr	equ	0dh	;carriage return
lf	equ	0ah	;line feed
esc	equ	1bh	;escape code
;
Hiir:	lxi	b,pais	;Print start message
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
Int6:	in	80h	;Get mouse status
	mvi	d,8	;Counter restart
	lxi	b,home	;move cursor home
	call	ttcon
Loop:	ral		;Rotate status left
	mov	b,a	;Save status
	jc	onepr	;if carry then print a 1
	mvi	a,'0'	;else print
	call	tto	;a '0'
	jmp	check	;check counter
onepr:	mvi	a,'1'	;print a '1'
	call	tto	;to console
check:	dcr	d	;decrement counter
	mov	a,b	;restore status byte
	jnz	loop	;rotate more if counter not zero
        ret
;
;	Data area
;
pais:	db	esc,'4',esc,'L',esc,'M0','???????? <- Mouse status',cr,lf,cr,lf,cr,lf
	db	esc,''''
	db	'========================================'
	db	'# Testing INT6, the mouse interrupt:   #'
	db	'#                                      #'
	db	'#              << HINT >>              #'
	db	'#                                      #'
	db	'#        Vakstu & JUKU3000 2024        #'
	db	'#         Serial No. A-0002-01         #'
	db	'========================================'
	db	esc,'(',0
clear:	db	esc,'5', esc,'L',0
home:	db	esc,'H',0
	end