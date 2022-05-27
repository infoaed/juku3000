# Kuidas lugeda/kirjutada Juku ketaste sisu?

Juku 786/788kB kettad on kahepoolsed topelttihedusega (DSDD) kettad, millel on kummalgi pool 80 rada, millest igaüks koosneb 40 sektorist, mis koosneb 40 blokist, millest igaüks mahutab 32 baiti. See teeb kokku 2x80 = 160 rada, 40 x 40 x 32 = 5120 baiti ja kokku ketta suuruseks 160x512 = 819 200 baiti. Lugemise teeb keerukaks, kuna need baidid pole talletatud sisu mõttes mitte järjest, vaid segamini paisatud. Seetõttu ei või seda võtta järjestikuse 819kB andmekogumina ja selle osiste olemasolu ignoreerida, vaid tuleb segadus selle eri taseme põhjusest lähtuvalt likvideerida.

FDMAINT             |  DEC Rainbow 100
:-------------------------:|:-------------------------:
![FDMAINT ketast kontrollimas, väljast sisse ja üks pool korraga](/images/disk5.png)  |  ![DEC Rainbow 100 manuaal](/images/rainbow-logo.png)

Ketta loogilise bloki suurus on 4096 ja selliseid mahub kogu ketta mahu sisse 819200/4096 = 200. Kui eeldada, et neist üks on kasutusel failide kateloogimise blokiks ja kaks reserveeritud süsteemi buutimiseks, siis jääb järgi 200-3 = 197. Seega on Juku ketta kasutatav maht 197x4096 = 806 912 baiti, mis on omakorda 806912/1024 = 788 kB.

## Juku ketaste spetsiifiline topeltsegadus

Juku EKDOS 2.30 lähtekoodi päises on [dokumenteeritud rasvases kirjas](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM), et ketta formaadi aluseks on [DEC Rainbow 100](http://www.bitsavers.org/pdf/dec/rainbow/QV069-GZ_Rainbow_100+_100B_Technical_Documentation_Apr85.pdf) flopiformaat. Lähtekood annab ka teada ülejäänud [juba mainitud parameetrid](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM#L51-L57):

```
; DPB constants for 5" 96 TPI DSDD diskettes (2x80 tracks):
TRACKS	EQU	160	; 5"DD
BLKSIZ	EQU	4096	; block length
DIRTRK	EQU	2	; directory track # (3 if 5"SD)
BLOCKS	EQU	197	; (TRACKS-DIRTRK)*CPMSPT/(BLKSIZ/128)-1
DIRENT	EQU	128	; directory entries
DIRCHK	EQU	20H
```

Juba DEC Rainbow 100 on [ajalooliselt tunnustatud peavalu](https://en.wikipedia.org/wiki/Rainbow_100#Problems), sest selle paisktabel ei ühildu teiste tootjate standarditega. Juku kasutab/viitab Rainbow kettaformaati ilmselt pigem juhuslikel põhjustel või kuna selle kettalugeja ühendas kaks ühepoolset kettalugejat ja sobis seega teatud määral koodidoonoriks -- igatahes Juku paisktabel veel omal moel eksootiline ja on [samuti leitav lähtekoodist](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM#L80-L93):

```
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
```

Ilmselt lähtub see formaliseering andmete tegelikust paiknemisest flopikettal, sest on näha, et paisktabel ehk _skew table_ on tegelikult viiestest blokkidest koosnev ja selle lihtsustatud väljendus oleks `1,3,5,7,9,2,4,6,8,10`. Mis on sisuliselt siis, et sektoreid loetakse üle ühe nii, et 5 paarituarvulise järjekorranumbriga ja siis sama ala kohta 5 paarisarvulise järjekorranumbriga sektorit. Sellist järjest lugemise vältimist oli omal ajal väidetavalt vaja, et arvutid kettalt tulevaid andmeid [ikka töödelda jõuaks](https://www.autometer.de/unix4fun/z80pack/cpm2/ch6.htm#Section_6.6) ja puhvrid ei hakkaks üle ajama:

> "Standard CP/M systems are shipped with a skew factor of 6, where six physical sectors are skipped between each logical read operation. This skew factor allows enough time between sectors for most programs to load their buffers without missing the next sector. In particular computer systems that use fast processors, memory, and disk subsystems, the skew factor might be changed to improve overall response."

Ilmselgelt on tänapäeva mõistes tegu tarbetu abinõuga ning seetõttu ei tee me midagi halba, kui paisktabelit lihtsustame. Küll aga ei piisa, kui söödame selle paisktabeli [cmptoolsile](https://www.mankier.com/5/diskdefs), sest Juku kettaformaadil on veel teine standardist hälbiv iseärasus, mis tähendab, et kettal kirjutatakse ühe poole rajad täis ja siis minnakes teise poole radu kirjutama ketta teisest servast. [Tavapärane on kirjutada neid](https://www.mankier.com/5/libdskrc) kordamööda ühele ja teisele poolele või hakata rajanumbritega ühte kettaserva jõudes nendega teiselt poolelt tagasi tulema.

Seega on Juku ketastel tavapäraste ketaste suhtes segadus kahes mõttes, esiteks paisktabeli tõttu ja teiseks radade paigutuse tõttu kettal.

## Millega ja mispidi neid siis lugeda?

Tegelikult [cpmtools](http://www.moria.de/~michael/cpmtools/) koos [libdsk](https://www.seasip.info/Unix/LibDsk/) kettaseadetega loeb Juku diskid edukalt välja. Mõlemad on olemas kõigile viisakatele tänapäeva opsüsteemidele, aga peab veenduma, kas cpmtoolsi seadetes ehk ülal viidatud diskdef failis saab viidata libdski seadetes määratletud libdskrc kirjetele. Sisuliselt on vaja teha kahte asja:

1. Tuleb `.libdiskrc` failis määratleda kettatõmmis kui kahe lugemispeaga loetav, st parameeter `heads = 2` ja silindrite arvuks määrata ühe poole radade arv `cylinders = 80`. Parameeter, mis määrab kettapooltele kirjutatavate radade järjekorra peab ütlema, et neid kirjutatakse ketta väljast sissepoole liikudes samas suunas ja kui üks pool saab täis, siis jätkatakse teise poolega uuesti väljast sissepoole ehk parameeter `sides = outout`. Kettatõmmise tüübi nimeks määrame Juku ehk paneme pealkirjaks `[juku]`.

2. Tuleb cpmtoolsi `diskdefs` failis määratleda sobiv radade ja sektorite arv, määratleda eriotstarbelised rajad nagu süsteemile määratud kaks rada parameetriga `boottrk 2` ja failide asukohti kettal kirjeldav rada parameetriga `maxdir 128`. Ütlasi tuleb ütelda `diskdefs` failis osutada, et kasutataks libdsk geomeetriat kettapoolte lugemiseks, seda teeb parameeter `libdsk:format juku`. Siin tuleb nüüd määratleda ka paisktabel ja seda on võimalik määratledes nii nagu seda teeb EKDOSi lähtekood või lihtsustada nii, nagu ülal osutasin.

Kui alustuseks vaadata Juku enda utiliite, siis need näitavad ketta eri parameetreid üpris erinevalt:

STAT             |  KULT              |  DOCTOR
:-------------------------:|:-------------------------:|:-------------------------:
![STAT näitab 40 sektorit raja kohta](/images/disk.png) | ![KULT näitab ka paisktabelit](/images/disk4.png) | ![Software Soulutions DISK EDITOR & DIAGNOSTICS annab kõige põhjalikuma ülevaate (aga ei erista 32 baidiseid blokke)](/images/disk2.png)

Juku algupärasele füüsilisele laotusele truuks jäädes peaksime määrama `.libdiskrc` failis parameetrid ilmselt nii:

```
[juku-origin]
description = Juku E5101 5.25" DSDD (2 x 80 x 40 * 40 * 32)
sides = outout
cylinders = 80
heads = 2
secsize = 128
sectors = 40
datarate = DD
```

Samamoodi austades algset paisktabelit peaks olema `diskdefs` kirje (küll tuleb tabeli väärtused muuta nullist algavaks):

```
# Juku E5101 original (DEC Rainbow 100 feat DSDD)
diskdef juku-origin
  seclen 128
  tracks 160
  sectrk 40
  blocksize 4096
  skewtab 0,1,2,3,8,9,10,11,16,17,18,19,24,25,26,27,32,33,34,35,4,5,6,7,12,13,14,15,20,21,22,23,28,29,30,31,36,37,38,39
  boottrk 2
  maxdir 128
  os 2.2
  libdsk:format juku-origin
end
```

Kui lihtsustame aga paisktabeli ja ignoreerime ajaloolisi füüsilisi blokke, siis peaks sobima vastavalt:

```
[juku]
description = Juku E5101 5.25" DSDD (2 x 80 x 10 * 512)
sides = outout
cylinders = 80
heads = 2
secsize = 512
sectors = 10
datarate = DD
```

Ja cpmtoolsi `diskdefs`:

```
# Juku E5101 \w optimized skew (DEC Rainbow 100 feat DSDD)
diskdef juku
  seclen 512
  tracks 160
  sectrk 10
  blocksize 4096
  skewtab 0,2,4,6,8,1,3,5,7,9
  boottrk 2
  maxdir 128
  os 2.2
  libdsk:format juku
end
```

Teoreetiliselt võiks `libdsk` formaati ka ignoreerida, aga siis tuleks paisktabelis ära tuua kõik ketta sektorid, mis teeks tabeli umbes 160x10x4 = 6kB pikkuseks -- mis ei ole küll tänapeäva mõistes maailmalõpp, aga cpmtools ei pruugi vaikimisi nii pikka tabelit seedida.

## Lõppseis ja töö viljad

Lõpptulemus näeb cpmtoolsi `fsed.cpm -f juku-origin ORIG.CPM` ekraanil välja nii:

Info (I)             |  Datamap (M)              |  Kataloogikirje (0x5000)
:-------------------------:|:-------------------------:|:-------------------------:
![Juku E5101 algupärase laotuse infotabel](/images/info-origin.png) | ![Algupärase laotuse andmekaart](/images/datamap-origin.png) | ![Ketta sisu peaks aga algupärase/optimeeritud versiooni puhul juhul sama olema](/images/data.png)

Ühtlasi peaks töötama käsud, millega brausida ketaste sisu ja kopeerida faile sisse ja välja:

```
cpmls -f juku DISK.CPM
cpmls -f juku -licF DISK.CPM
cpmcp -f juku GAMES.CPM 0:*.* jukugames
cpmcp -f juku GAMESX.CPM INDY/INDY.* 0:
```

Kui määrata `juku` keskkonnamuutujas `CPMTOOLSFMT` vaikimisi formaadiks, siis võib `-f juku` ka ära jätta:

```
CPMTOOLSFMT="juku"
export CPMTOOLSFMT
```

Ühesõnaga, on küll mõnevõrra tüütu kaevuda ajalooliste kettaformaatide iseärasustesse, kuid mõningase pusimise ja loomkatsete tulemusel saab ka maailma kõige unikaalsema formaadiga CP/M kettaformaadi loetud. Juku tunnustuseks võib ütelda, et tõenäoliselt pole kunagi eksisteerinud ühtegi teist arvutisüsteemi, mis oleks ilma pusserdamiseta Juku kettaid suutnud lugeda -- seega kaksteist punkti ja ugrikrüpto eriauhind teadurile, kes selle välja mõtles!

P. S. Füüsilistest ketastest tõmmiste tegemine on ka huvitav, aga eraldi kirjatükki vääriv teema.
