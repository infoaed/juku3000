	org	100h
boot	equ	0000h	;Bdos entry point
;
;	RomBios functions
ttstat	equ	0ffc7h	;Keyboard status
ttcon	equ	0ffcdh	;Send message to console
outhexb	equ	0ffdch	;Out hex byte
outhex	equ	0ffdfh	;Out hex word
tmcnt	equ	0ffa1h	;Timer reset/read
;
;	Other
cr	equ	0dh	;carriage return
lf	equ	0ah	;line feed
esc	equ	1bh	;escape code
tim	equ	17h	;8253 timer
;
	lxi	b,pais	;Start message
	call	ttcon	;To console
;
reset:	mvi	e,0
	call	tmcnt	;Reset timer
;
mloop:	call	ttstat	;Check for pressed keys
	jnz	action	;choose action
	mvi	e,0ffh
	call	tmcnt
	mov	b,d
	mov	c,e
	call	outhex	;hexis n3itamine
	lxi	b,space
	call	ttcon
	;mvi	a,00000000b
	;out	tim
	;lhld	0d463h
	in	tim-3
	call	outhexb
	mov	b,a
	in	tim-3
	mov	c,a
	;call	outhex
	lxi	b,space
	call	ttcon
	mvi	a,01000000b
	out	tim
	;lhld	0d463h
	in	tim-2
	mov	b,a
	in	tim-2
	mov	c,a
	;call	outhex
	lxi	b,space
	call	ttcon
	mvi	a,10000000b
	out	tim
	;lhld	0d463h
	in	tim-1
	mov	b,a
	in	tim-1
	mov	c,a
	;call	outhex
	lxi	b,home	;move cursor home
	call	ttcon
	jmp	mloop
;
action:	mvi	d,esc
	cmp	d
	jz	kyll	;exit on esc
	jmp	reset	;timer reset otherwise
;
kyll:	lxi	b,clear	;clear screen
	call	ttcon	;before exiting
	jmp	boot	;and reboot
;
;	Data area
;
pais:	db	esc,27h ; ''' 
	db	'P~sivara TIMCNT loenduri test 2025',cr,lf
	db	esc,'(',cr,lf
	db	'Katkestamiseks ESC, nullimiseks muu!'
	db	cr,lf,0
space:	db	' ',0
clear:	db	cr,lf,0
home:	db	cr,lf,esc,'A',0
	end
