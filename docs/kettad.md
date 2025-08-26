# Kuidas lugeda/kirjutada JUKU ketaste tõmmiseid?

__Aastal 2022 ei olnud veel avalikult dokumenteeritud, millega ja kuidas lugeda JUKU kahepoolseid flopisid ja huvilised katsetasid kettatõmmiste lugemist eri tööriistadega, saavutades mõnedega neist ka osalist edu. Allolev on kogemuslugu sellest, kuidas võtsin kätte ja närisin end läbi JUKU flopiketta andmevormingust, mida selle käigus õppisin ja pidasin vajalikuks avalikkusega jagada. Lugu on hiljem täiendatud üldistava raamistuse ja tehniliste soovitustega lõpuosas.__

JUKU 786/788 kB kettad on kahepoolsed topelttihedusega (DSDD) kettad, millel on kummalgi poolel 80 rada, mis on jaotatud 40 sektorisse, millest igaüks mahutab 128 baiti. See teeb kokku 2x80 = 160 rada, 40x128 = 5120 baiti ehk 5 kB ja kokku ketta suuruseks 160x5120 = 819 200 baiti ehk 819 kB. Lugemise teeb keerukaks, et need baidid pole talletatud sisu mõttes mitte järjest, vaid "[segamini paisatud](https://www.seasip.info/Cpm/skew.html)". Seetõttu ei või seda võtta järjestikuse 819 kB andmekogumina ja selle osiste olemasolu ignoreerida, vaid tuleb segadus selle eri taseme põhjusest lähtuvalt likvideerida.

Töö teevad ära [cpmtools](http://www.moria.de/~michael/cpmtools/) ja [libdsk](https://www.seasip.info/Unix/LibDsk/) käsikäes ning vajalikud konfifailid on:

* [diskdefs](https://github.com/infoaed/juku3000/blob/master/src/diskdefs) (võib käia nt `/etc/cpmtools` või `/usr/local/share` alla)
* [libdskrc](https://github.com/infoaed/juku3000/blob/master/src/libdskrc) (võib käia nt `/usr/local/share/LibDsk` alla või kodukataloogi kujul `.libdskrc`)

Aga huvilistele ka veidi pikemalt köögipoolest...

FDMAINT             |  DEC Rainbow 100
:-------------------------:|:-------------------------:
![FDMAINT ketast kontrollimas, väljast sisse ja üks pool korraga](/images/disk5.png)  |  ![DEC Rainbow 100 manuaal](/images/rainbow-logo.png)

JUKU jaoks fundamentaalsel opsüsteemi tasemel lähtutakse CP/M-i [128-baidisest sektorisuurusest](https://en.wikipedia.org/wiki/CP/M#Basic_Input_Output_System), mis tähendab, et rajad on kettal jagatud 40 sektorisse ja iga rada on 40x128 = 5120 baiti. Füüsilisel JUKU flopil on rajad aga jagatud 10 sektorisse, millest lähtuvalt [arvutatakse ja kirjutatakse sektorite vahele andmete kontrollsummad](https://en.wikipedia.org/wiki/Modified_frequency_modulation#MFM_coding). See tähendab, et füüsilisel kettal on CP/M-i 128-baidised sektorid omakorda koondatud neljakaupa 512 baidistesse sektoritesse, st raja maht on 10x4x128 = 10x512 = 5120 baiti. Kuna andmete kodeerimine/dekodeerimine flopi magnetpinnalt on [korraldatud riistvara tasemel](https://en.wikipedia.org/wiki/Western_Digital_FD1771), siis ei pea andmetõmmiste töötlemisel füüsilise flopiketta omadustele tähelepanu pöörama ja võib piirduda _andmete vorminguga_, mis on kättesaadav JUKU opsüsteemi tasemel.

Ketta loogilise ploki suurus on 4096 baiti, igasse sellisesse plokki mahub 32 sektorit, loogilisi plokke mahub kogu ketta mahu sisse 819200/4096 = 200. Kui eeldada, et neist üks on kasutusel failide kataloogimise plokiks ja kaks rada on reserveeritud süsteemi buutimiseks, siis jääb järgi 819200 - 2x5120 - 4096 = 808 960 baiti. Loogilisi plokke mahub kettale seega 808960/4096 = 197,5, aga poolikut plokki keegi kettale kirjutama ei hakka ja seega on JUKU ketta kasutatav maht 197x4096 = 806 912 baiti, mis on omakorda 806912/1024 = 788 kB. Kuna loogilise ploki maht on 32x128 = 4096 baiti ja füüsilise raja maht on 40x128 = 5120 baiti, siis isegi kui üks on neist on lihtsalt 4 kB ja teine 5 kB, siis kettaga toimetamise eri tasmetel eri ühikutega opereerimine muudab üldpildi kettatõmmiste töötlemisel segaseks ning teeb keerukamaks andmete struktuuri tuletamise nende sisust.

## JUKU ketaste spetsiifiline topeltsegadus

JUKU EKDOS 2.30 lähtekoodi päises on [dokumenteeritud rasvases kirjas](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM), et ketta formaadi aluseks on [DEC Rainbow 100](http://www.bitsavers.org/pdf/dec/rainbow/QV069-GZ_Rainbow_100+_100B_Technical_Documentation_Apr85.pdf) flopiformaat. Lähtekood annab ka teada ülejäänud [juba mainitud parameetrid](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM#L51-L57):

```
; DPB constants for 5" 96 TPI DSDD diskettes (2x80 tracks):
TRACKS	EQU	160	; 5"DD
BLKSIZ	EQU	4096	; block length
DIRTRK	EQU	2	; directory track # (3 if 5"SD)
BLOCKS	EQU	197	; (TRACKS-DIRTRK)*CPMSPT/(BLKSIZ/128)-1
DIRENT	EQU	128	; directory entries
DIRCHK	EQU	20H
```

Need vastavad üldjoontes ülal tehtud arvutustele, kuigi kommentaaris toodud tehte `(TRACKS-DIRTRK)*CPMSPT/(BLKSIZ/128)-1` tulemuseks oleks tegelikult 196,5, mis on justkui ümardatud ülespoole ja saadud 197. Koodis kasutatud väärtus on küll korrektne, aga see eksitav tehe võib selgitada, miks vahepeal tuuakse JUKU flopiketta kasutatavaks mahuks 786 kB, sest 196,5x4096 = 804864 baiti, mille järel 804864/1024 = 786 kB. Reaalsuses mahub aga JUKU flopile pool plokki rohkem kui tavapärane 788 kB, aga see pool plokki jääb opsüsteemile reeglina kättesaamatuks ning seda võib kasutada salajaste sõnumite talletamiseks.

Kuna JUKU flopid ei ole andmete keerulise struktuuri tõttu loetavad tavapäraste CP/M-i kettatõmmiste töötlemise tööriistade jaoks, siis tasub panna tähele, et juba DEC Rainbow 100 on [ajalooliselt tunnustatud peavalu](https://en.wikipedia.org/wiki/Rainbow_100#Problems), sest selle paisktabel ei ühildunud teiste tootjate standarditega. JUKU kasutab/viitab Rainbow kettaformaati ilmselt pigem juhuslikel põhjustel või kuna selle kettalugeja ühendas kaks ühepoolset kettalugejat ning sobis seega teatud määral koodidoonoriks -- igatahes JUKU paisktabel tundub peale vaadates veel omal moel eksootiline ja on [samuti leitav lähtekoodist](https://github.com/infoaed/juku3000/blob/master/src/EKDOS30.ASM#L80-L93):

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

Kui lähemalt vaadata, siis on näha, et selline paisktabel ehk _skew table_ koosneb tegelikult neljastest plokkidest nagu `1,2,3,4` või `33,34,35,36` ja tabeli lihtsustatud väljendus oleks õigupoolest `1,3,5,7,9,2,4,6,8,10`. Selline oleks paisktabel, kui see määratleda lähtuvalt JUKU flopide 4x128 = 512-baidistest [füüsilistest sektoritest](https://cowlark.com/fluxengine/doc/disk-juku.html). Algne paisktabel väljendab aga sisuliselt seda, et sektoreid loetakse üle ühe nii, et neli paarituarvulise järjekorranumbriga ja siis sama ala kohta neli paarisarvulise järjekorranumbriga 128-baidist CP/M-i sektorit. Sellist järjest lugemise vältimist oli omal ajal väidetavalt vaja, et arvutid kettalt tulevaid andmeid [ikka töödelda jõuaks](https://www.autometer.de/unix4fun/z80pack/cpm2/ch6.htm#Section_6.6) ja puhvrid ei hakkaks üle ajama:

> "Standard CP/M systems are shipped with a skew factor of 6, where six physical sectors are skipped between each logical read operation. This skew factor allows enough time between sectors for most programs to load their buffers without missing the next sector. In particular computer systems that use fast processors, memory, and disk subsystems, the skew factor might be changed to improve overall response."

Ilmselgelt on tänapäeva mõistes tegu tarbetu abinõuga ning seetõttu ei tee me midagi halba, kui paisktabelit lihtsustame. Küll aga ei piisa, kui söödame lihtsustatud või lihtsustamata paisktabeli [cmptoolsile](https://www.mankier.com/5/diskdefs), sest kuigi ketta algus loetakse enam-vähem, siis esimestest failidest edasi läheb kõik juba parajaks segapudruks.

Kui seda putru aga lähemalt vaadelda, selgub et JUKU kettaformaadil veel teine standardist hälbiv iseärasus, mis ei seostu üldse paisktabelitega ja muudab kettad tavalisi CP/M-i kettalid lugevatele tööriistadele arusaamatuks. Nimelt kirjutatakse JUKU ketta ühe poole rajad täis ja siis minnakse teise poole radu kirjutama uuesti algusest, st ketta teisest servast. [Tavapärane on kirjutada radu](https://www.mankier.com/5/libdskrc) kordamööda ühele ja teisele poolele või hakata rajanumbritega ühte kettaserva jõudes nendega teiselt poolelt tagasi tulema. Seega on JUKU ketastel tavapäraste ketaste suhtes segadus kahes mõttes, esiteks paisktabeli tõttu ja teiseks radade paigutuse tõttu kettal. Ette rutates võib ütelda, et algselt keerukana tundunud paisktabel osutub radade segaduse lahendamise järel õigupoolest täiesti standardseks.

## Millega ja mispidi neid siis lugeda?

Tegelikult [cpmtools](http://www.moria.de/~michael/cpmtools/) koos [libdsk](https://www.seasip.info/Unix/LibDsk/) kettaseadetega loeb JUKU diskid edukalt välja. Mõlemad on olemas kõigile viisakatele tänapäeva opsüsteemidele, aga peab veenduma, kas cpmtoolsi seadetes ehk ülal viidatud `diskdef` failis saab viidata libdski seadetes määratletud `.libdskrc` kirjetele. Sisuliselt on vaja teha kahte asja:

1. Tuleb `.libdiskrc` failis määratleda kettatõmmis kui kahe lugemispeaga loetav, st parameeter `heads = 2` ja silindrite arvuks määrata ühe poole radade arv `cylinders = 80`. Kettapooltele kirjutatavate radade järjekorra kohta peab ütlema, et neid kirjutatakse ketta väljast sissepoole liikudes samas suunas ja kui üks pool saab täis, siis jätkatakse teise poolega uuesti väljast sissepoole ehk parameeter `sides = outout`. Kettatõmmise tüübi nimeks määrame JUKU ehk paneme pealkirjaks `[juku]`.

2. Tuleb cpmtoolsi `diskdefs` failis määratleda sobiv radade ja sektorite arv, määratleda eriotstarbelised rajad nagu süsteemile määratud kaks rada parameetriga `boottrk 2` ja failide asukohti kettal kirjeldav rada parameetriga `maxdir 128`. Ütlasi tuleb `diskdefs` failis osutada, et kasutataks libdsk geomeetriat kettapoolte lugemiseks ning seda teeb parameeter `libdsk:format juku`. Siin tuleb nüüd määratleda ka paisktabel ja seda on võimalik määratleda EKDOSi lähtekoodi viisil või lihtsustada nii, nagu ülal osutasin.

Kui alustuseks vaadata JUKU enda utiliite, siis need näitavad ketta eri parameetreid samuti üpris erinevalt:

STAT             |  KULT              |  DOCTOR
:-------------------------:|:-------------------------:|:-------------------------:
![STAT näitab 40 sektorit raja kohta](/images/disk.png) | ![KULT näitab ka paisktabelit](/images/disk4.png) | ![Software Soulutions DISK EDITOR & DIAGNOSTICS annab kõige põhjalikuma ülevaate (aga ei erista 32 baidiseid plokke)](/images/disk2.png)

JUKU CP/M-il põhinevale 128-baidisele sektorisuurusele truuks jäädes peaksime määrama `.libdiskrc` failis parameetrid ilmselt nii:

```
[juku-origin]
description = JUKU E5101 5.25" DSDD (2 x 80 x 40 * 128)
sides = outout
cylinders = 80
heads = 2
secsize = 128
sectors = 40
datarate = DD
```

Samamoodi austades algset paisktabelit peaks olema `diskdefs` kirje (küll tuleb tabeli väärtused muuta nullist algavaks):

```
# JUKU E5101 original (DEC Rainbow 100 feat DSDD)
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

Kui lihtsustame aga paisktabeli ja ühendame CP/M-i 128-baidised sektorid neljakaupa üheks 512-baidiseks füüsiliseks sektoriks, siis peaks sobima vastavalt:

```
[juku]
description = JUKU E5101 5.25" DSDD (2 x 80 x 10 * 512)
sides = outout
cylinders = 80
heads = 2
secsize = 512
sectors = 10
datarate = DD
```

Ja cpmtoolsi `diskdefs` lühendatud paisktabeliga on lõpuks ketta poolte lugemise segaduse eemaldamise järel täiesti tavaline paiskfaktor väärtusega 2 ehk `skew 2`:

```
# JUKU E5101 \w optimized skew (DEC Rainbow 100 feat DSDD)
diskdef juku
  seclen 512
  tracks 160
  sectrk 10
  blocksize 4096
  skew 2
  #skewtab 0,2,4,6,8,1,3,5,7,9
  boottrk 2
  maxdir 128
  os 2.2
  libdsk:format juku
end
```

Teoreetiliselt võiks `libdsk` formaati ka ignoreerida, aga siis tuleks kirjeldada kõik sektorid ja nende plokid ühel rajal ning paisktabelis ära tuua need kõigi sektorite kohta, mis teeks tabeli umbes 160x10x4 ≈ 6 kB pikkuseks -- mis ei ole küll tänapeäva mõistes päris maailmalõpp, aga cpmtools ei pruugi vaikimisi nii pikka tabelit seedida. Teine võimalus on, et doonoriks sobib mõni _acorn_ libdsk formaat, mis on üks väheseid, milles `outout` lugemisviis kasutusel olla olnud (vt ["used by some Acorn formats [and JUKU]"](https://www.mankier.com/5/libdskrc#Parameters)).

## Lõppseis ja töö viljad

Lõpptulemus näeb cpmtoolsi `fsed.cpm -f juku-origin ORIG.CPM` ekraanil välja nii:

Info (I)             |  Datamap (M)              |  Kataloogikirje (0x5000)
:-------------------------:|:-------------------------:|:-------------------------:
![JUKU E5101 algupärase laotuse infotabel](/images/info-origin.png) | ![Algupärase laotuse andmekaart](/images/datamap-origin.png) | ![Ketta sisu peaks aga algupärase/optimeeritud versiooni puhul juhul sama olema](/images/data.png)

Ühtlasi peaks töötama kõik [cpmtoolsi käsud](http://www.moria.de/~michael/cpmtools/), millega brausida ketaste sisu ning teha failioperatsioone kopeerimisest kustutamiseni:

```
cpmls -f juku DISK.CPM
cpmls -f juku -licF DISK.CPM
cpmcp -f juku GAMES.CPM 0:*.* jukugames
cpmcp -f juku GAMESX.CPM jukugames/INDY.* 0:
```

Kui määrata `juku` keskkonnamuutujas `CPMTOOLSFMT` vaikimisi formaadiks, siis võib `-f juku` ka ära jätta:

```
CPMTOOLSFMT="juku"
export CPMTOOLSFMT
```

Toetatud kettatüüpide ja -vormingute nimekirju _libdsk_ poolel näitavad `dskutil -types` ja `dskutil -formats`, _cpmtools_ lubatud formaatide nimekirja ei paista väljastavat ja nendega tuleb tutvuda `diskdefs` seadistusfaili tasemel. Õigupoolest on JUKU ketaste lugemiseks täiendavate _libdsk_ vahenditeta vaja _cmptoolsi_ lähtekoodi täiendada vaid ühe reaga kahes funktsioons, mis juhendaks neid otsima radu kettatõmmisel õigest kohast ja sellise täiendusega [CpmtoolsGUI](http://star.gmobb.jp/koji/cgi/wiki.cgi?page=CpmtoolsGUI) JUKU versiooni leiab [siit](http://infoaed.ee/juku/CpmtoolsGUI_JUKU.zip).

Alates [2025. aasta juulist](https://github.com/davidgiven/fluxengine/pull/796) suudab ilma lisapingutusteta töödelda JUKU kettaid ka [Fluxengine'i arendusversioon](https://github.com/davidgiven/fluxengine/releases/tag/dev).

On küll mõnevõrra tüütu kaevuda ajalooliste kettaformaatide iseärasustesse, kuid mõningase pusimise ja loomkatsete tulemusel saab ka maailma kõige unikaalsema CP/M kettaformaadi loetud. JUKU tunnustuseks võib ütelda, et tõenäoliselt pole kunagi eksisteerinud ühtegi teist arvutisüsteemi, mis oleks ilma pusserdamiseta JUKU kettaid suutnud lugeda -- seega kaksteist punkti ja ugrikrüpto eriauhind teadurile, kes selle vormingu välja mõtles!

P. S. Füüsilistest ketastest tõmmiste tegemine on ka huvitav, aga eraldi kirjatükki vääriv teema.
