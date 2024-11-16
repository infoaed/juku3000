	org	100h
boot	equ	0000h	;Bdos entry point
;
;	RomBios functions
TTStat	equ	0ffc7h	;Keyboard status
TTCon	equ	0ffcdh	;Send message to console
TTO	equ	0ffd9h	;Console output
OUThex	equ	0ffdch	;Out hex byte
;
;	Other
cr	equ	0dh	;carriage return
lf	equ	0ah	;line feed
esc	equ	1bh	;escape code
dcol	equ	0fh	;default column
;
Hiir:	lxi	b,pais	;Print start message
	call	ttcon	;to console
MLoop:	lxi	b,col
	call	ttcon
coln:	mvi	a,dcol
	mov	b,a	;m3leta
	sbi	0ah
	jnc	kymn
	mvi	a,30h
	mov	c,b
	jmp	kuva
kymn:	mov	c,a
	mvi	a,31h
kuva:	call	tto
	mov	a,c
	adi	30h
yhel:	call	tto
	;call	outhex
	mov	a,b	;meenuta
	lxi	b,home	;move cursor home
	call	ttcon
	out	4
	in	5
	push	a
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
	pop	a
	mov	b,a
	mvi	h,0c0h
	ana	h
	jz	kyll
	mov	a,b
	mvi	h,080h
	ana	h
	jz	alla
	mov	a,b
	mvi	h,040h
	ana	h
	jnz	mloop
yles:	lda	coln+1
	inr	a
	mvi	h,0fh
	ana	h
	sta	coln+1
	jmp	mloop
alla:	lda	coln+1
	dcr	a
	mvi	h,0fh
	ana	h
	sta	coln+1
	jmp	mloop
kyll:	lxi	b,clear	;clear screen
	call	ttcon	;before exiting
	jmp	boot	;and reboot
;
;	Data area
;
pais:	db	esc,'0',esc,'L',esc,'M0','            <- Tulp ja 8255 port B',cr,lf,cr,lf,cr,lf
	db	esc,''''
	db	'=============================',cr,lf
	db	'# Klahvistiku diagnostika   #',cr,lf
	db	'# SHIFT/CTRL = tulp +/-     #',cr,lf
	db	'# SHIFT+CTRL = aitab jamast #',cr,lf
	db	'=============================',cr,lf
	db	esc,'(',0
clear:	db	esc,'1', esc,'=) ',0
home:	db	esc,'H',0
col:	db	esc,'= )',0
	end
