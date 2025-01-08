	org	100h
boot	equ	0000h	;Bdos entry point
;
;	RomBios functions
TTStat	equ	0ffc7h	;Keyboard status
TTCon	equ	0ffcdh	;Send message to console
OUThex	equ	0ffdfh	;Out hex word
TMCnt	equ	0ffa1h	;Timer reset/read
;
;	Other
cr	equ	0dh	;carriage return
lf	equ	0ah	;line feed
esc	equ	1bh	;escape code
;
	lxi	b,pais	;Start message
	call	ttcon	;To console
;
reset:	mvi	e,0
	call	TMCnt	;Reset timer
;
mloop:	call	ttstat	;Check for pressed keys
	jnz	action	;choose action
	mvi	e,0ffh
	call	TMCnt
	mov	b,d
	mov	c,e
	call	outhex	;hexis n3itamine
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
pais:	db	esc,''''
	db	'P~sivara TIMCNT loenduri test 2025',cr,lf
	db	esc,'(',cr,lf
	db	'Katkestamiseks ESC, nullimiseks muu!'
	db	cr,lf,0
clear:	db	cr,lf,0
home:	db	cr,lf,esc,'A',0
	end
