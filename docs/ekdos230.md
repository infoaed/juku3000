# JUKU PC Utilities Disk #4

```
*******************************************
*                                         *
*        === Last minute news ! ===       *
*               December '89              *
*                                         *
*                  From                   *
*        JUKU PC UTILITIES DISK #4        *
*              you will find:             *
*                                         *
* 1. A new version of EKDOS number 2.30 ! *
* 2. New drivers  for  Epson and  Compu ! *
* 3. A various set of exciting utilities! *
*                                         *
*              (c) ekta 1989              *
*                                         *
*******************************************
```

``FX800   .COM`` - Epson     FX-800 driver  
``COMPU   .COM`` - Compute Mate 160 driver  
``SEIKO   .COM`` - Seikosha  SP-800 driver  
 
``FDMAINT .COM`` - Floppy Disk Maintenance program  
``JCM     .COM`` - JUKU Copy Master  
``JCM     .HLP`` - Instructions to JCM  
``CF      .COM`` - Copy File for 1(2) drive computers  
``CF      .HLP`` - Instructions to CF  
``SED80   .COM`` - Screen Editor ( for mode 80 x 25 )  
``SDEL    .COM`` - Selective Delete  
``SETS    .COM`` - Set file(s) status (SETS *.* $r/o)  
``PRT     .COM`` - Print file utility  
``PRT     .DOC`` - Instructions to PRT  
``MIC     .COM`` - (Micro) Screen Editor  
``MIC     .HLP`` - Instructions to MIC  
``SK      .COM`` - SideKicK (resident, mode 40 x 24 )  

``MODX    .COM`` - Driver for mode 80 x 25 ( NOTE 1 )  
``LF      .COM`` - Font loader for MODX  
``ASCII   .   ­`` - font file, ASCII Character Set  
``EST     .   ­`` - font file, Estonian Character Set  
``RUS     .   ­`` - font file, Cyrillic Character Set  

``MDUMP   .COM`` - Memory Dump  
``MED     .COM`` - Memory Editor  
``SYSINFO .COM`` - System Information  
``JSET    .COM`` - Set Floppy Disk parameters  
``KUVA    .COM`` - Screen Centering  
``KULT    .COM`` - Disk Test program  
``KULT    .HLP`` - Instructions to KULT  

``RESIDENT.DOC`` - Instructions to writing resident  
``­            ­``   programs  
``JLOAD   .LDR`` - System part for resident programs  
``LINK    .COM`` - MP/M Link program vers 1.3  

``ME      .COM`` - Music Editor   
``ME      .DOC`` - Instructions to ME and PLAYER  
``PLAYER  .ERL`` - Driver for sound generation  

``DEMO    .COM`` - Audio-Video-Text program  
``­            ­``   presentation  
``DEMO    .HLP`` - DEMO help file  
``DEMO    .DOC`` - Instructions to DEMO  
``DEMOS   .COM`` - A-V-T program preparation  
``DEMOS   .DOC`` - Instructions to DEMOS  
 
``EKDOS30 .ASM`` - Source text of BIOS of EKDOS  

``DOCTOR  .COM`` - Disk Editor & Diagnostics  
``POWER   .COM`` - POWER 3.03 (c) by Pavel Breder  
``MIT     .COM`` - Communications utility ( RS232 )  
``MAC     .COM`` - Macro Assembler   
``WSJ     .COM`` - WordStar, installed to 64x20 mode  
``WSMSGS  .OVR``  
``WSOVLY1 .OVR``  

``XONIX   .COM`` - Game "XONIX"   (40x24 mode)  
``SNAKE   .COM`` - Game "SNAKE"   (40x24 mode)  
``SNAKE   .DAT``  
``CHESS   .COM`` - Chess program  (40x24 mode)  
``BUGABOO .COM`` - Game "BUGABOO" (40x24 mode)  
``BUGABOO .DAT``  
``BUGABOO .MSG``  
``BUGABOO .TAB``  
``CATCHUM .COM`` - Game "CATCHUM" (80x25 mode)  
``CATCHUM .DAT``  
``LADDER  .COM`` - Game "LADDER"  (80x25 mode)  
``LADDER  .DAT``  
``MUSAM   .COM`` - Piano program  
``CAL     .COM`` - Floating point calculator  

```
================================================
NOTE 1 ! : Ekraanireziim 80 x 25 
================================================
  1. A>MODX  -  laadida residentne  draiver, mis
        omakorda käivitab automaatselt fondilaa-
        duri LF. Failid ASCII ja  EST sisaldavad
        5 x 7  tähegeneraatori   koodivahemikule
        20H...7FH (laadimisel vastata küsimusele
        "Estonian/Russian  table  ?"  E-ga) ning
        fail RUS vahemikule C0H...FFH (vasta R).
  2. Käivitada 80x25  reziimi  vajav   programm,
     näiteks SED80 , origin.  WS või Multiplan ,
     CATCHUM , LADDER vms.
  3. A>LF    - võimaldab laadida uut  fonti  või
        suurendada vaba mälu mahtu  (f.-n RESET)
        laetud fondi väljaviskamise  teel -  sel
        juhul kasutatakse püsimälus olevat 6 x 9
        tähegeneraatorit.
  4.Tagasi reziimidesse 40x24 , 53x24  ja  64x20
    saab ainult läbi totaalse RESET'i (CTRL+ESC+
    SHIFT).
================================================
```

```
================================================
NOTE 2!
================================================
    Kes veel ei tea , siis nüüd saab  teada , et
   ekraanireziimi saab peale programmi MODE  va-
   hetada ka opsüsteemi tasemel ,  vajutades  A>
   järel järjestikku ESC , M , n , RETURN  , kus
        n = 0 viib reziimi 40 x 24 ,
        n = 1 - 53 x 24 ja
        n = 2 - 64 x 20 .
================================================
```

## Vaata ka

* [Ketta rekonstrueeritud tõmmis](tarkvara-kataloog.md/#j3kutil4) (J3K 2025)
