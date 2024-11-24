; kompileerimiseks
; 1. ASM TERE
; 2. LOAD TERE
	org	100h
	lxi	b,Tere
	call	0ffcdh  ; TTCon
	jmp	0h      ; EKDOS
Tere:	db	'Tere, Juhan!',0dh,0ah,0
	end
