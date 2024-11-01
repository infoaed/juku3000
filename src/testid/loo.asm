        org	100h
bdos    equ     5h
fcbd    equ     05ch
        jmp     program
        db      0dh
tere:   db      01bh,27h,'Juku 3000',01bh,28h,' faili loomine [11.06.2022]',0ah,0dh,0ah,0dh,'$'
err:    db      'VIGA ','$'
res:    db      'EDU ','$'
crlft:  db      0ah,0dh,'$'
program:
        lxi     d,tere
        mvi     c,9
        call    bdos
        lxi     d,fcb
        mvi     c,22    ; make
        call    bdos
        call    dispr
        lxi     d,fcb
        mvi     c,16    ; close
        call    bdos
        call    dispr
        ret
dispr:
        lxi     d,res
        ora     a
        jz      done
        lxi     d,err
done:   push    b
        mvi     c,9
        call    bdos
        pop     b
        mov     a,c
        call    outhx
        lxi     d,crlft
        mvi     c,9
        call    bdos
        ret
outhx:
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
fcb:	db	0
        db      'TXT     '
	db	'   '
        dw      0,0,0,0
        dw      0,0,0,0
txt:    dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
        dw      01a1ah,01a1ah,01a1ah,01a1ah,01a1ah,01a1ah
