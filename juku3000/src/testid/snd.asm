        org	100h
bdos    equ     5h
ttcon   equ     0ffcdh
ttclr   equ     0ffd0h
outhx   equ     0ffdch
outhx2  equ     0ffdfh
crlf    equ     0ffcah
blpvol  equ     0ffb0h
blp     equ     0ff86h
;        call    ttclr
        jmp     program
        db      0dh
tere:   db      01bh,27h,'Juku 3000',01bh,28h,' helitest [5.06.2022]',0ah,0dh,0ah,0dh,'$'
blvt:   db      'VOL ','$'
blpt:   db      'BLEEP ','$'
crlft:  db      0ah,0dh,'$'
program:
        di
        lxi     d,tere
        mvi     c,9
        call    bdos
;
        mvi     a,0ffh
nxt:    push    a
        adi     96h
        call    vol
        pop     a
        push    a
        mov     d,a
        mov     e,0
        call    bleep
        pop     a
        dcr     a
        jnz     nxt
        push    a
        adi     96h
        call    vol
        pop     a
        mov     d,a
        mov     e,0
        call    bleep
;
        ei
        ret
vol:
        push    a
        lxi     d,blvt
        mvi     c,9
        ;call    bdos
        pop     a
        push    a
        ;call    bioshx
        pop     a        
        call    blpvol
        lxi     d,crlft
        mvi     c,9
        ;call    bdos       
        ret
bleep:
        push    d
        lxi     d,blpt
        mvi     c,9
        ;call    bdos
;        call    ttcon
        pop     d
        mov     a,d
        ani     32
        sui     32
        ora     a
        jnz     over
        lxi     d,0
over:
        push    d
        mov     a,d
        ;call    bioshx
        pop     d
        push    d
        mov     a,e
        ;call    bioshx
;        call    outhx2
        pop     d
        mvi     a,1
	call	blp
        lxi     d,crlft
        mvi     c,9
        ;call    bdos
;        call    wait
	ret
wait:
        lxi     d,0002h
        jmp     idle
more:
        dcx     d
        mvi     a,10h
        dcr     a
        jnz     $-1
idle:
        mov     a,d
        ora     a
        jnz     more
        mov     a,e
        ora     a
        jnz     more
        ret
bioshx:
        push    a
        ani     0f0h
        rrc
        rrc
        rrc
        rrc
        mvi     c,2
        call    biosn
        pop     a
        push    a
        ani     0fh
        mvi     c,2
        call    biosn
        pop     a
        ret
biosn:  
        cpi     9
        jc      addnum
        adi     7
addnum:
        adi     30h
        mov     e,a
        call    bdos
        ret
        end
 