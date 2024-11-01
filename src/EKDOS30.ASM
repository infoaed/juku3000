;****************************************
;					*
;    	52K EKDOS Version '2.30  '	*
;            ie CP/M BIOS		*
;					*
;  Compatible with Bootstrap Vers 4.X	*
;  Base disk format:  DEC RAINBOW 100	*
;					*
;       Written by 	A.Kaukver	*
;       Last update  	10.04.89	*
;					*
;     (c) EktaSoft 1987,1988,1989	*
;					*
;****************************************
;
; To create new version of BIOS:
; 1. MAC newbios $px	;create .HEX file
; 2. SID3 DOSGEN	;vers 3.4 required
; 3. #p185		;set breakpoint
; 4. #g			;read source (CCP,BDOS,BIOS) to 1000H
; 5. #rnewbios.hex,5C00 ;read new BIOS to 2600H
; 6. #xp		;type 188 (in hex)
; 7. #g			;write destination to disk
;
FALSE	EQU	0
TRUE	EQU	NOT FALSE
CONP	EQU	0E0H
MSIZE	EQU	52	    ;MEMORY SIZE KB 
BIAS	EQU	(MSIZE-20)*1024
CCP	EQU	3400H+BIAS  ;BASE OF CCP
BDOS	EQU	CCP+806H    ;BASE OF BDOS
BIOS	EQU	CCP+1600H   ;BASE OF BIOS
CDISK	EQU	4	    ;CURRENT DISK #
IOBYTE	EQU	3	    ;INTEL I/O BYTE
NSECTS	EQU	($-CCP)/128 ;SECTOR COUNT
;
ROM	EQU	0FF50H	; MONIT Cold start loader
FLOPPY	EQU	ROM+3	; MONIT Floppy Disk Handler
START	EQU	ROM+6	; Loader, <A> sect to CCP
RWFLOPPY EQU	ROM+9	; R/W floppy disk
RAMDISKSEL EQU	ROM+12	; Select RamDrive
PRINTCH EQU 	0FFEEH	; Print character
RDCHR	EQU	0FFD3H	; MONIT USART Input Routine  (TTI)
WRCHR	EQU	0FFD9H	; MONIT USART Output Routine (TTO)
CONSTA	EQU	0FF98H	; Console Status
CONCW	EQU	0FFB4H	; Console ComWord
;
NDISKS	EQU	3	; # of drives available
RDNo	EQU	2	; # of Ram Drive
VIARV	EQU	10	; # of r/w sector retryals
; DPB constants for 5" 96 TPI DSDD diskettes (2x80 tracks):
TRACKS	EQU	160	; 5"DD
BLKSIZ	EQU	4096	; block length
DIRTRK	EQU	2	; directory track # (3 if 5"SD)
BLOCKS	EQU	197	; (TRACKS-DIRTRK)*CPMSPT/(BLKSIZ/128)-1
DIRENT	EQU	128	; directory entries
DIRCHK	EQU	20H
;
; Monit Floppy Handler Interface
TYP	EQU     0D600H	 ; current disk type
DISKNO	EQU	TYP+1	 ; desired disk #
TRACK	EQU	TYP+2	 ; track #
SECTOR	EQU	TYP+4	 ; sector #
RQST	EQU	TYP+6	 ; request (last command)
DMAAD	EQU	TYP+7	 ; DMA address
ERRC	EQU	TYP+9	 ; status byte (ret code)
TYPEA	equ	TYP+10	 ; type of disk 0 (<A>)
typeb	equ	typea+1	 ; type of disk 1 (<B>)
sizea	equ	typ+12	 ; # of tracks per side of drive <A>
sizeb	equ	typ+13
ratea	equ	typ+14	 ; step rate for drive <A>
rateb	equ	typ+15
size	equ	typ+16	 ; size of current drive
rate	equ	typ+17	 ; step rate of current drive
fbi	equ	TYP+26	 ; area for BIOS r/w disk (23b)
verx	equ	TYP+21	 ; tr# in <A> on current side
SEKDSK	equ	fbi	 ;drive#
SEKTRK	equ	fbi+1MDISKPAR
	DW	0000H,ALL0M ;no check
;
; *** Sector translate vectors, two 40 byte areas ***
;
TRANS:	DB	1,2,3,4,9,10,11,12
	DB	17,18,19,20,25,26,27,28
	DB	33,34,35,36,5,6,7,8
	DB	13,14,15,16,21,22,23,24
	DB	29,30,31,32,37,38,39,40
;
TRANS1:	DB	1,2,3,4,9,10,11,12
	DB	17,18,19,20,25,26,27,28
	DB	33,34,35,36,5,6,7,8
	DB	13,14,15,16,21,22,23,24
	DB	29,30,31,32,37,38,39,40
;
;--------------------------------------------------
;
;      *** DISK PARAMETER BLOCKS ***
;
; 5"DS,DD , 2x80 tracks, 1	 ;track#
SEKSEC	equ	fbi+3	 ;sector#
MEMADR	equ	fbi+20	 ;DMA addr
;
HSTWRT	EQU	FBI+10
HSTACT	EQU	FBI+9
UNACNT	EQU	FBI+11
RCOUNT	EQU	FBI+16
;
BdosAddr  equ	0FF64H	 ; pnt to BDOS addr
SAVEHL	  equ	0D300H-2
STAK	  equ	SAVEHL-2 ; tempor. stack
;
	ORG	BIOS
;
; ****  BIOS JUMP VECTOR TABLE  ****
;
	JMP	BOOT	  ;Cold Start
WBOOTE:	JMP	WARMSTART ;WARM START
	JMP	CONSTAT	  ;CONSOLE STATUS
	JMP	CONIN	  ;CONSOLE CHARACTER IN
	JMP	CONOUT	  ;CONSOLE CHARACTER OUT
	JMP	LIST	  ;LIST CHARACTER OUT
	JM0 s, 512 b sect, 4K block
;
;DPBLK:		
;	DW	40
;	DB	5	;BLOCK SHIFT
;	DB	31	;BLOCK MASK  4096B BLOCKS
;	DB	3
;	DW	BLOCKS-1
;	DW	DIRENT-1
;	DB	80H
;	DB	0
;	DW	DIRCHK
;	DW	2
;
;DPBLK1:
;	DW	40
;	DB	5	;BLOCK SHIFT
;	DB	31	;BLOCK MASK  4096B BLOCKS
;	DB	3
;	DW	BLOCKS-1
;	DW	DIRENT-1
;	DB	80H
;	DB	0
;	DW	DIRCHK
;	DW	2
;
;------------------------------------------------
;
;      *** DISK PARAMETER BLOCKS ***
;
; 5"DS,DD , 1x80 tracks, 10 s, 512 b sect, 2K block
;
DPBLK:		
	DW	40
	DP	RTNEMPTY  ;PUNCH NOT IMPLEMENTED
	JMP	RTNEMPTY  ;READER NOT IMPLEMENTED
	JMP	HOME	  ;MOVE DISK HEAD HOME
	JMP	SELDSK	  ;SELECT DISK
	JMP	SETTRK	  ;SET TRACK NUMBER
	JMP	SETSEC	  ;SET SECTOR NUMBER
	JMP	SETDMA	  ;SET DMA ADDRESS
	JMP	READ	  ;READ DISK
	JMP	WRITE	  ;WRITE DISK
	JMP	POLLPT	  ;RETURN LIST STATUS
	JMP	SECTRAN	  ;SECTOR TRANSLATE
; Added functions:
	jmp	ConOut	  ;doubled for resident mo64/40
			  ;reinstallation
;
NoofRamDisk:	DB	RDNo 	 ; Ram disk #, NB SDISK uses constant
				 B	4	;BLOCK SHIFT
	DB	15	;BLOCK MASK  2048B BLOCKS
	DB	1
	DW	0C2H
	DW	127
	DB	0C0H
	DB	0
	DW	32
	DW	2
;
DPBLK1:
	DW	40
	DB	4
	DB	15
	DB	1
	DW	0C2H
	DW	127
	DB	0C0H
	DB	0
	DW	32
	DW	2
;
;------------------------------------------------
;
MDISKPAR:		; RAM DRIVE, 1K block
	DW	128	;sec per track
	DB	3
	DB	7
	DB	0
	DW	191	;# of blocks ( to modify )
	DW	63	;# of files
	DB	0C0H	;ALLOC 0
	DB	0	;ALLOC 1
	DW	0	;CHECK SIZE
	DW	0	;TRACK OFFSET
;
;       *** END OF FIXED TABLES ***
;; RDNo, not contents of this addr
DPHAddr:	DW	DPBASE   ; base addr for SETSYS program
ABTAddr:	DW	ABText   ; ^ to ShowSys text (2x13 bytes)
VersNo:		DW	VersTxt	 ; ^ to 6 byte Version # area (chars)
Atype:		DB	0	 ; Type of drive <A>
Btype:		DB	0
CCPSectors:	DB	5	 ; # of sectors under CCP (17-types 1,2)
Asize:		DB	80	 ; tracks per size of drive <A>
Bsize:		DB	80
Arate:		DB	1	 ; step rate const of drive <A>
Brate:		DB	1
;Arate:		DB	0	 ; step rate const of drive <A>
;Brate:		DB	0
BDORR:		DB	1	 ; sh
POLLPT:
RTNEMPTY:
	XRA A	;NOT READY
	RET	;NOT REAL.
;
;*****************************************
;	 C O L D    S T A R T		 *
;*****************************************
;
BOOT:			; Cold start
	lhld	BdosAddr ;^BdosAddr:=BDOS
	lxi	d,BDOS
	mov	m,e
	inx	h
	mov	m,d
;
	lhld	Atype	;Init ROM based Floppy Handler
	shld	Typea
	mov	a,l
	sta	TYP
	lhld	Asize
	shld	Sizea
	mov	e,l
	lhld	Arate
	shld	Ratea
	mov	d,l
	xchg
	shld	Size	;current drive (<A>)
;
	XRA	A
	STA	CDISK
	CALL	RamDiskSel ; <Aow "ARI-text" (0-no >0-yes)
BDORC:		DB	ViArv    ; # of retryals on disk R/W error
;
; *** FIXED DATA TABLES FOR TWO 5"DD or 5"/8" DS/SS DISKS ***
;
; *** DISK PARAMETER HEADER FOR DISK 00 ( <A> ) ***
;
DPBASE:	DW	TRANS,0000H
	DW	0000H,0000H
	DW	DIRBF,DPBLK
	DW	CHK00,ALL00
;DISK PARAMETER HEADER FOR DISK 01 ( <B> )
	DW	TRANS1,0000H
	DW	0000H,0000H
	DW	DIRBF,DPBLK1
	DW	CHK01,ALL01
;DISK PARAMETER HEADER FOR DISK 02 ( <C> - RAM DRIVE )
	DW	0000H,0000H ;no translate
	DW	0000H,0000H
	DW	DIRBF,>=0,exists ?
	ORA	A
	JZ	SysText
	lxi	h,CText   ;Ram drive not available
	mvi	m,0C3H	  ;JMP GOCPM
	lxi	d,GOCPM
	inx	h
	mov	m,e
	inx	h
	mov	m,d
SysText:
        CALL	TYPE
	DB	1bh,'L'
 	DB	'52K EKDOS '
VersTxt:
        DB	'2.30/R'	;6 byte text area
;	DB	'2.30  '
	DB	13,10,10
	DB	'Drive assignments:',13,10,10
; Fixed structure ( 13 b text,13,10, 13 b text,13,10 ) area:
ABText:	
;	DB	'<A> - 5" 786K',13,10
;	DB	'<B> - 5" 786K',13,10
	DB	'<A> - 5" 386K',13,10
	DB	'<B> - 5" 386K',13,10
 	DB	0
CText:	
	CALL	TYPE
	DB	'<C> - RAM disk 192K'
	db	13,10,10,0	;EOT
	JMP	GOCPM
;
;*****************************************
;        W A R M   S T A R T		 *
;*****************************************
;
WARMSTART:
	LXI	SP,100H
	lhld	BdosAddr ; is there some resident pr's
	lxi	d,BDOS
	inx	h
	mov	a,m	 ; get MSB
	cmp	d
	jz	wretry	 ; load if not
	ora	a	 ; load if CTRL+SHIFT+ESC
	jnz	GoCPM	 ; don't load CCP if is res part
WRetry:	lda	CCPSectors
	call	START
	ora	a	 ; OK ?
	jz	GoCPM
	call	A '
Sub4:	db	'##' 
	db	13,10
	db	'Abort,Retry,Ignore ?',0
	call	CONIN
	ani	0dfh
	push	psw
	mov	c,a
	call	BIOS+0CH
	pop	psw	; < A - char
	ret
;
SubRead: db	'Read '
SubWrite:db	'Write'
;
phex:	mov	b,a	;>A - to two 'hex' char
	rrc		;>HL- dest addr
	rrc
	rrc
	rrc
	call	pnib
	mov	m,a
	inx	h
	mov	a,b
	call	pnib
	mov	m,a
	ret
pnib:	ani	0fh
	cpi	10
	jnc	pn1
	adi	'0'
	ret
pn1:	adi	'7'
	ret
;
TYPE:
	POP	H
TYPE1:	MOV	A,M	;CHR. OUT
	ora	a	;ETX?
	JZ	TYPE2
	MOV	C,A
	shld	MYHL	;MO64RI
	jmp	WRetry	 ; retry in all cases
;
;***************************************************
; "Include BIOSUSER.ASM" , what allows to	   *
;	1. show user prompt			   *
;	2. run programs from USER 0		   *
;***************************************************
;
CCPCONOUT	EQU	CCP+8CH
GETUSER		EQU	CCP+113H
CCPGETDISK	EQU	CCP+1D0H
CCPRESUME	EQU	CCP+38BH
CCPEXIT		EQU	CCP+388H
CHARMATCH	EQU	BDOS+77CH-6
UNUSEDBYTES	EQU	13	
RESUMEPOINT	EQU	BDOS+761H-6
BDOSEXITPOINT	EQU	BDOS+75EH-6
;
prompt:	call	Ge or others don't hold <HL>
	CALL	BIOS+0CH ;BIOS 5. jump, CONOUT holds <HL>
	lhld	MYHL
	INX	H
	JMP	TYPE1
TYPE2:	PCHL
;
;      **** Console #0 Routines
;
;CONST:	JMP	CONSTA	;RET 255 IF READY, 0 IF NOT IN A
;
MYHL:	ds	2	;to hold contents of <HL> register
			;in some cases
;
DoFunction:		;Can't destroy <A> and <C>
	shld	SaveHL	;hold <HL>
	xchg
	xthl		;hold <DE>
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	xchg
	shld	FUNC	;call addr
	xchg
	xthl
	xchg
	lxi	h,0
	dad	sp
	shld	STAK
	lxi	sp,STAK
	dtUser
	ora	a
	jz	Promte
	cpi	10
	jnc	U2Digits
	adi	30h
U1Digits:
	call	CCPConOut
Promte:	call	CCPGetDisk
	jmp	CCPResume
U2Digits:
	adi	30H-10
	push	psw
	mvi	a,'1'
	call	CCPConOut
	pop	psw
	jmp	U1Digits
;
publc:	mov	a,b	 ;DE-name of file
	ora	a	 ;HL-dir entry
	jnz	NoPublic ;B-char count
	ldax	d
	cpi	0E5h
	jz	NoPublic
	mov	a,m
	ora	a
	jz	CharMatch
NoPublic:
	mov	a,b
	cpi	UnusedBytes
	jmp	ResumePoint
;
GOCPM:	
			;Modify CCP and BDOS
	XRA	A
	STA	HSTACT
	STA	HSTWRT
	STA	UNACb	0CDH	; CD is call
FUNC:	ds	2
	lhld	STAK
	sphl
	lhld	SaveHL
	ret

CONSTAT:
	call	DoFunction
	dw	CONSTA
	ret
;
CONIN:
	call	DoFunction
	dw	RDCHR
	ret
;
CONOUT:
	MOV     A,C
	call	DoFunction
	dw	WRCHR
	ret
;
LIST:
	MOV	A,C
	call	DoFunction
	dw	PrintCh
	ret
;
;  I/0 DRIVERS FOR  SINGLE/DOUBLE SIDED DISKS
;
;  FIRMWARE COMMANDS (SEE MONIT MANUAL )
DKRD	EQU	11H	;READ TO BUFFER
DKWR	EQU	12H	;WRITE FROM BUFFER
DKST	EQU	10H	;DISK STATUS
;
HOME:			;MOVE TO TRK 00
	LDA	HSTWRT
	ONT
	mvi	a,0C3H	;JMP
	sta	CCPExit
	sta	BdosExitPoint
	lxi	h,Prompt
	shld	CCPExit+1
	lxi	h,Publc
	shld	BdosExitPoint+1
;GOCPM:
	MVI	A,0C3H	;C3 IS JMP
	STA	0	;FOR JMP TO BDOS
	LXI	H,WBOOTE
	SHLD	1	;SET ADDRESS FIELD FOR JMP
	STA	5	;JMP TO BDOS
	lhld	BdosAddr
	mov	e,m
	inx	h
	mov	d,m
	xchg
	SHLD	6	;SET ADDRESS FIELD
	LXI	B,80H	;DEFAULT DMA ADDRESS
	CALL	SETDMA
;
	LHLD	CONCW
	MVI	M,0	;SET CONSOLE ROUTINES FOR DISK OS
;
	LDA	CDISK	;select default drive
	MOV	C,A
	CALL	SELDSK	;TYP:=f(<C>RA	A
	JNZ	HOM1
	STA	HSTACT	
HOM1:	MVI	C,0	;TRACK	00
	CALL	SETTRK
	RET
;
SELTYP:
	lhld	typea	;NB Not Atype, for allowing SETSYS program
			;to modify in Handler area
	mov	a,c
	sta	SEKDSK	;Current drive #
	ora	a
	mov	a,l	;<A>
	jz	dsveel
	mov	a,h	;<B>
dsveel:	sta	TYP
	ret
;
SELDSK:			;SELECT DISK IN REG C
	lxi	h,0	;error return code
	shld	MYHL
	call	DoFunction
	dw	SDisk
	lhld	MYHL	;get return code
	ret
;
SDisk:	
	MOV	A,C
	CPI	NDISKS	;WITHIN RANGE?
	RP		;NO CARRY IF NOT
;
	call	S)
	JMP	CCP	;<C>=CURRENT DRIVE #
;
ARI:
	db	3eh	;(MVI A)
arx:	db	0	;will be contained 11H/12H
	lxi	h,SubRead
	lxi	d,5
	cpi	12H	;write sector ?
	jnz	movesub
	dad	d
movesub:lxi	b,Sub1
s1lp:	mov	a,m
	stax	b
	inx	h
	inx	b
	dcr	e
	jnz	s1lp
	lxi	h,Sub2	;Error #
	lda	ERRC
	call	phex
	lxi	h,Sub3	;Track #
	lda	TRACK
	call	phex
	lxi	h,Sub4	;Sector #
	lda	seksec	;logical sec #
	call	phex
;
	call	TYPE
	db	13,10
	db	'Disk '
Sub1:	db	'..... error #'
Sub2:	db	'## - Track '
Sub3:	db	'## SectELTYP	;SEKDSK:=current drive #
	mov	a,c
	cpi	RDNo	;RamDriveNumber
	jnz	FindHeader
RDSelect:
	call	RamDiskSel ;holds <C>
	ora	a
	rm		;if not implemented
;
FindHeader:		;compute proper disk parameter
			;header addr
	MOV	L,C	;L=DISK NUMBER 0,1,2
	MVI	H,0	;HIGH ORDER ZERO
	DAD	H	;*2L
	DAD	H	;*4L
	DAD	H	;*8L
	DAD	H	;*16L (SIZE OF EACH HEADER)
	LXI	D,DPBASE
	DAD	D	;HL=DPBASE(DISKNO*16)
	SHLD	MYHL
	RET
;
SETTRK:			;SET TRK GIVEN BY REG C
	MOV	A,C
	STA	SEKTRK
	RET
;
SETSEC:
	MOV	A,C	;SET SECTOR GIVEN BY REG C
	STA	SEKSEC
	RET
;
SECTRAN:	;TRANSLATE SECTOR GIVEN BY BC USING THE
		;TRANSLATE TABLE GIVEN BY DE
	XCHG
	DAD	B
	mov	a,h	;don't translate if DE=0
	ora	a
	rz
	MOV	L,M
	MVI	H,0
	RET
;
SETDMA:			;DMA ADDR GIVEN BY REGS BC
	MOV	L,C	;LOW ORDER ADDRESS
	MOV	H,B	;HIGH ORDER ADDRESS
	SHLD	MEMADR	;SAVE ADDR IN IO VECTOR
	RET
;
READ:	MVI	A,DKRD	;READ SECTOR
	JMP	RWDISK
;
WRITE:	MVI	A,DKWR	;WRITE SECTOR
RWDISK:	sta	arx
	LDA	BDORC
	STA	RCOUNT
REPEAT:	LDA	arx
	CALL	DOFUNCTION
	DW	RWFLOPPY
	LXI	H,ERRC
	CALL	VERF	;VIRUS CHECK
	MOV	A,M
	ORA	A
	RZ
	XRA	A
	STA	HSTACT	;PREPARE RETRYAL
	LDA	BDORR
	ORA	A
	MOV	A,M
	RZ		;DON'T DISTURB USER
	CALL	ARI
	CPI	'R'
	JZ	REPEAT
	CPI	'I'
	MVI	A,0
	RZ
	LDA	ERRC	;RET WITH ERROR CODE
	RET		
;
VERF:	LDA	DISKNO
	CPI	RDNO	;RAM DRIVE
	RNC
	LXI	D,VERX
	ADD	E	;NO CARRY QUARANTEED
	MOV	E,A
	LDA	TRACK+1 ;DESIRED T# ON SIDE
	MOV	B,A
	LDAX	D	;REALLY SEEK'ed
	CMP	B
	RZ
	INR	M
	RET
;
;THE REMAINDER OF THE CBIOS IS RESERVED UNITIALIZED
;DATA AREA,AND DOES NOT NEED TO BE A PART OF THE
;SYSTEM MEMORY IMAGE (THE SPACE MUST BE AVAILABLE,
;HOWEVER, BETWEEN "BEGDAT" AND "ENDDAT").
;
;SCRATCH RAM AREA FOR BDOS USE
;
	ORG	BIOS+8*128
;
BEGDAT	EQU	$	;BEGINNING OF DATA AREA
DIRBF:	DS	128	;SCRATCH DIRECTORY AREA
ALL00:	DS	32	;ALLOCATION VECTOR 0 , =MaxBlocks/8 + 1
ALL01:	DS	32	;ALLOCATION VECTOR 1
ALL0M:	DS	25	;ALLOCATION VECTOR 2 (RAM DRIVE)
;ALL02:	DS	32
;ALL03:	DS	32
CHK00:	DS	32	; = MaxDIRENTries/4
CHK01:	DS	32	;area for check changed diskettes
;CHK02:	DS	16
;CHK03:	DS	16
ENDDAT	EQU	$	;END OF DATA AREA
;
;------------------------------------------------------------
; A few words about history:
;
; TEMPBUF: DS	128	;For Ram drive D380-D3FF
;
; 53K EKDOS Vers.2.26 / xxx : FREE RAM UP TO D37FH
;			    D400H-D5FFH - 512 b for ROM based
;			    Floppy Handler 512 b buffer
;			    same for BootStrap stack.
	END
