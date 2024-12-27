; kompileerimiseks
; 1. ASM TERE
; 2. LOAD TERE
	org	100h
	lxi	b,Tere
	jmp	0ffcdh  ; TTCon
Tere:	db	'Tere, Juhan!',0dh,0ah,0
	end

