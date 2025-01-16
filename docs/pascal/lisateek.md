# Pascal/MT+ lisateekide pakett arvutile "JUKU"

```
                   *****  Nõo 1990  *****






               PASCAL/MT+ LISATEEKIDE PAKETT

                      ARVUTILE "JUKU".



                                         Autor: I.Jentson

                                                Nõo KK AK


```

## Eessõna

Paketi kasutamine eeldab algteadmisi keelest Pascal  ja 
oskust  töötada Pascal/MT+ translaatoriga.  Pascali algteadmiste
omandamiseks võib kasutada näiteks õppevahendit  [^2],
aga sobib ka ükskõik milline Pascalit käsitlev raamat. Arvutil
"Juku" töötava Pascal/MT+ kasutamise kohta  on  vähesel 
määral informatsiooni teoses [^1], täpsem ülevaade kasutamisest ja
Pascal/MT+ erinevustest standartsest Pascalist antakse teoses [^3].

Paketi  tegemisel on püütud tagada funktsiooninimetuste 
kokkulangevus  Turbo Pascali sarnaste funktsioonidega.



## 1. Ülevaade teekidest


Pascal/MT+ lisateegid sisaldavad protseduure ja  funktsioone
graafiliseks  tööks arvuti "JUKU"  kuvari  ekraanil, 
samuti teksti kuvareziimi valimiseks ning ketaste,  taimeri, 
printeri, "hiirega" töötamiseks jm.

Kõigi nende protseduuride ja funktsioonide kasutamiseks 
veendu järgmiste failide olemasolus :

     Graph.H        Graph.ERL
     Screen.H       Screen.ERL
     Utilit.H       Utilit.ERL
     Sprite.H1      Sprite.H2      Sprite.ERL
     Disk.H         Disk.ERL

Failis SPRITE.H1 on tüübikirjeldused  spraidiprotseduuridele:

```
Type _pointer = ^byte;         
          pic = record             Spraiti iseloomustavad:
                    x : integer;   asukoha x - koordinaat
                    y : integer;           y - koordinaat
                 xdim : byte;      x - mõõde ( pixelid/8+1 )
                 ydim : byte;      y - mõõde
                place : _pointer;  asukoht mälus
                shift : _pointer   nihe (ära puutu!)
               end;
        bfail = file of byte;
```

Ülejäänud .H laiendiga failides hoitakse paketis olevate funktsioonide ja protseduuride pascalkeelseid kirjeldusi, 
failides laiendiga .ERL hoitakse nende linkimiseks kõlblikke 
mooduleid.


Järgmised protseduurid ja funktsioonid on teekides:

     Graafikateek:                           ( Graph )

     BOX                 CIRCLE              INVSCR
     LINE                LINETO              LINEREL             
     MOVETO              MOVEREL             PUTPIXEL            
     SETHGR              SETTEXT

     Kuva vormingu teek:                     ( Screen )

     CLREOLN             CLREOSCR            CLRSCR
     CLOSEWND            CURSOFF             CURSON
     DOWN                GOTOXY              HOME
     INVERSE             KBEEPOFF            KBEEPON
     LEFT                NORMAL              OPENWND
     READKEY             RIGHT               SCREEN
     SCROLOFF            SCROLON             UP
     WHEREXY

     Varia:                                  ( Utilit )

     INITPR              MOUSE               PRCHR
     RANDOM              RSTTIMER            SOUND
     TIMER               VOLUME

     Spraiditeek:                            ( Sprite )

     GETMEM              GETPIC              LOADPIC
     MOVEPIC             PUTPIC

     Kettateek:                              ( Disk )

     READDISK            SELECTDISK          SETDMA
     SETSECTOR           SETTRACK            #### `WRITE`


## 2. Teekide kasutamine


### 2.1  Täiendused kasutajaprogrammis

Oma  programmi  tuleb  lisada  lisateegi  protseduuride 
jaoks tüübi- ja protseduurikirjeldused.  Selleks kasutatakse 
kompileerimisreziimi võtit $I, mille abil lisatakse programmile .H laiendiga failide pascalkeelsed tekstid.

NÄIDE:

```
program näide;
(*$I a:sprite.h1 *)          lisatakse tüübikirjeldused

......                       kasutajaprogrammi märgendite,
......                       konstantide, tüüpide ja
......                       muutujate kirjeldamine

(*$I a:sprite.h2 *)          lisatakse protseduuride
(*$I a:graph.h *)            kirjeldused

......                       kasutaja protseduuride ja   
......                       funktsioonide kirjeldused

begin
......                       põhiprogramm
......
end.
```


### 2.2 Linkimine

Tuleb  lisada  vastav .ERL laiendiga fail  linkimiskäsu 
parameetrite loetelusse:

```
LINKMT NÄIDE,SPRITE,GRAPH,PASLIB/S
```

## 3. Protseduurid ja funktsioonid

Iga funktsiooni ja protseduuri kohta on esitatud informatsioon
järgmisel kujul:


    FUNKTSIOONI_NIMI

     Kirjeldus:  Pascalkeelne fn-i kirjeldus.

    Kasutamine:  Fn-i väljakutsumise kuju. Parameetrite tüü-
                 bid on esitatud kirjelduses, lisaks sellele 
                 on kasutatud järgmist kodeeringut parameet-
                 ri esitähe järgi:
                  n - täisarvuline avaldis;
                  c - märgitüüpi avaldis;
                  m - täisarvuline muutuja;
                  l - loogiline muutuja;
                  b - baitidest koosneva faili muutuja;
                  p - spraiditüüpi ( pic ) muutuja.

       Tegevus:  Fn-i tegevuse ja parameetrite selgitus.

        Märkus:  Kui fn-l on mingisuguseid iseärasusi,  siis 
                 juhitakse sellele tähelepanu. Samuti viida-
                 takse vajaduse korral teistele funktsiooni-
                 dele.




### 3.1 Graafikateek (`GRAPH`)

#### `SETHGR`

     Kirjeldus:  Procedure SetHgr;

    Kasutamine:  SetHgr;

       Tegevus:  Graafikareziimi valimine.

        Märkus:  Kõik protseduurid, mis kasutavad monitori-
                 funktsioone, ei tööta selles reziimis.

                 Vt. ka SetText.

                 
#### `SETTEXT`

     Kirjeldus: Procedure SetText;

    Kasutamine: SetText;

       Tegevus: Tekstireziimi valimine. Selles reziimis saab 
                kasutada monitorifunktsioone.

        Märkus: Graafikaprotseduurid  ei tööta selles rezii-
                mis.

                Vt. ka SetHgr.









#### `PUTPIXEL`

     Kirjeldus: Procedure PutPixel( X,Y,Mood:Integer );

    Kasutamine: PutPixel(nx,ny,nm);
                
       Tegevus: Ühe punkti kujutamine  ekraanil. Punkt kuju
                tatakse ekraanile vastavalt koordinaatidele
                X ja Y.  MOOD  võib olla  0 või 1.  Ekraanil 
                juba  olevale  punktile  uue  pealepanemisel  
                moodiga 1 korral punkt kaob,  0 korral  jääb 
                alles. X-koordinaat võib omada väärtusi 0-st 
                kuni  319-ni  ja y-koordinaat väärtusi  0-st 
                kuni 239-ni. Ekraani piiridest üles- või al-
                lapoole jäävate koordinaatide korral tegevus  
                puudub,  vasakule või paremale jäävate koor-
                dinaatide  korral kujutatakse punkt  ekraani 
                vastasservale. Väärtused X ja Y säilitatakse 
                graafilise kursori väärtustena.

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).



#### `LINE`

     Kirjeldus: Procedure Line( X1,Y1,X2,Y2,Mood:Integer );

    Kasutamine: Line(nx1,ny1,nx2,ny2,nm);

       Tegevus: Joone kujutamine  ekraanil. Joon kujutatakse
                alguspunktiga  X1,Y1 ja lõpp-punktiga X2,Y2.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).

#### `CIRCLE`

     Kirjeldus: Procedure Circle( X,Y,R,Mood:Integer );

    Kasutamine: Circle(nx,ny,nr,nm);

       Tegevus: Ringi kujutamine ekraanil.  Ring kujutatakse
                ekraanile keskpunktiga X, Y ja raadiusega R. 
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).









#### `BOX`

     Kirjeldus: Procedure Box( X1,Y1,X2,Y2,Mood:Integer );

    Kasutamine: Box(nx1,ny1,nx2,ny2,nm);

       Tegevus: Ristküliku kujutamine  ekraanil. Ristkülikut
                kujutatakse ekraanil nii, et punktid koordi-
                naatidega X1, Y1 ja  X2, Y2 tähistavad rist-
                küliku  vastastikku  diagonaalis  asetsevaid
                nurki.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).



#### `LINETO`

     Kirjeldus: Procedure LineTo( X,Y,Mood:Integer );

    Kasutamine: LineTo(nx,ny,nm);

       Tegevus: Joone kujutamine ekraanil.  Joon kujutatakse
                ekraanile alguspunktiga, mille  määrab graa-
                filine kursor, ja lõpp-punktiga X, Y.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).

                Vt. ka MoveTo, LineRel, MoveRel.




#### `MOVETO`

     Kirjeldus: Procedure MoveTo( X,Y:Integer );

    Kasutamine: MoveTo(nx,ny);

       Tegevus: Graafikakursori koordinaadid saavad  väärtu-
                seks X, Y.

                Vt. ka LineTo, LineRel, MoveRel.


#### `LINEREL`

     Kirjeldus: Procedure LineRel( DX,DY,Mood:Integer );

    Kasutamine: LineRel(ndx,ndy,nm);

       Tegevus: Joone kujutamine  ekraanil. Joon kujutatakse
                ekraanile  alguspunktiga, mille määrab graa-
                filine kursor, ja lõpp-punktiga, mille koor-
                dinaadid saadakse  alguspunkti koordinaatide
                ja parameetrite DX ja DY vastaval liitmisel.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).

                Vt. ka LineTo, MoveTo, MoveRel.


#### `MOVEREL`

     Kirjeldus: Procedure MoveRel( DX,DY:Integer );

    Kasutamine: MoveRel(ndx,ndy);

       Tegevus: Graafikakursori  koordinaatide uuteks  väär-
                tusteks  saavad vanad väärtused liita vasta-
                valt DX ja DY.

                Vt. ka LineTo, MoveTo, LineRel.


#### `INVSCR`

     Kirjeldus: Procedure InvScr;

    Kasutamine: InvScr;

       Tegevus: Ekraani inverteerimine.

        Märkus: Töötab graafikareziimis.
                ( vt. SetHgr ).





### 3.2 Spraiditeek (`SPRITE`)


#### `LOADPIC`

     Kirjeldus: Procedure LoadPic( Var Fail:Bfail;
                                   Var Buf:pic );
    Kasutamine: LoadPic(bf,pb);

       Tegevus: Andmete lugemine  failist spraidimuutujasse.
                Eelnevalt graafikaredaktoriga  GTR loodud ja
                spraidina salvestatud  ning antud programmis
                ASSIGN direktiiviga defineeritud fail ( lai-
                endiga .PCC ) loetakse mällu.  Pildi mõõtmed
                on piiratud vaba mälu mahuga. Kui tagastatud
                spraidimuutuja   asukohta  viitava  elemendi
                buf.place  väärtus  on  0, siis  antud pildi
                jaoks jäi mälust puudu.


#### `GETPIC`

     Kirjeldus: Procedure GetPic( X,Y,DX,DY:Integer;
                                  Var Buf:Pic );

    Kasutamine: GetPic(nx,ny,ndx,ndy,pb);

       Tegevus: Spraidi lugemine ekraanilt. Spraidimuutujas-
                se  loetakse  ekraanilt   ristkülikukujuline 
                ala,  mille  vasak ülemine nurk asub punktis 
                X,Y ja küljepikkused on vastavalt DX ja DY.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).


#### `PUTPIC`

     Kirjeldus: Procedure PutPic( Buf:Pic;
                                  X,Y,Delta,Mood:Integer );

    Kasutamine: PutPic(pb,nx,ny,nd,nm);

       Tegevus: Spraidi paigutamine ekraanile. Sprait paigu-
                tatakse  kuvari ekraanile  nii,  et  spraidi 
                vasak ülemine nurk asub punktis koordinaati-
                dega  X  ja Y.  DELTA  näitab  taustkujutise 
                originaali  asukoha  nihet  ekraani   alguse 
                suhtes (harilikult DELTA=0). 
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).


#### `MOVEPIC`

     Kirjeldus: Procedure MovePic( Var Buf:Pic;
                                   DX,DY,Mood:Integer );

    Kasutamine: MovePic(nb,ndx,ndy,nm);

       Tegevus: Spraidi liigutamine ekraanil.  Eelnevalt ku-
                vari  ekraanile paigutatud spraiti  liiguta-
                takse  parameetritega DX ja DY määratud suu-
                nas.
                Parameetri Mood tähendust on seletatud prot-
                seduuri PutPixel juures. 

        Märkus: Töötab graafikareziimis ja ekraanireziimides
                0 ja 1 ( vt. SetHgr ja Screen ).


#### `GETMEM`

     Kirjeldus: Function GetMem( N:Integer ):_Pointer;

    Kasutamine: Var Pnt:_Pointer;
                ...
                Pnt:=GetMem(nx);

       Tegevus: Mälu eraldamine. Kui leidub N baiti vaba mä-
                lu,  siis reserveeritakse see ja funktsiooni 
                väärtusena  tagastatakse  sellele  mäluosale 
                osutav viit. Kui vaba mälu ei leidu, siis on 
                viida väärtus 0.





### 3.3 Kuvavorminguteek (`SCREEN`)



#### `CLRSCR`

     Kirjeldus: Procedure ClrScr;

    Kasutamine: ClrScr;

       Tegevus: Puhastatakse  ekraan ja viiakse kursor koor-
                dinaatidele 0,0.


#### `CLREOSCR`

     Kirjeldus: Procedure ClrEoScr;

    Kasutamine: ClrEoScr;

       Tegevus: Puhastatakse ekraan alates kursori asukohast
                kuni ekraani lõpuni.



#### `CLREOLN`

     Kirjeldus: Procedure ClrEoLn;

    Kasutamine: ClrEoLn;

       Tegevus: Puhastatakse ekraan alates kursori asukohast
                kuni rea lõpuni.



#### `SCROLON`

     Kirjeldus: Procedure ScrolOn;

    Kasutamine: ScrolOn;

       Tegevus: Lubatakse kuva kerimine.



#### `SCROLOFF`

     Kirjeldus: Procedure ScrolOff;

    Kasutamine: ScrolOff;

       Tegevus: Keelatakse kuva kerimine.



#### `CURSON`

     Kirjeldus: Procedure CursOn;

    Kasutamine: CursOn;

       Tegevus: Lubada kursori näitamine.



#### `CURSOFF`

     Kirjeldus: Procedure CursOff;

    Kasutamine: CursOff;

       Tegevus: Keelata kursori näitamine.


#### `GOTOXY`

     Kirjeldus: Procedure GotoXY( X,Y:Integer );

    Kasutamine: GotoXY(nx,ny);

       Tegevus: Kursori paigutamine koordinaatidele X,Y.
                X-koordinaat  võib omada väärtusi 0-st  kuni 
                (ekraani laius - 1)-ni ja  y-koordinaat 0-st 
                kuni (ekraani kõrgus - 1)-ni.


#### `HOME`

     Kirjeldus: Procedure Home;

    Kasutamine: Home;

       Tegevus: Kursori paigutamine koordinaatidele 0,0  ehk 
                ekraani vasakusse ülemisse nurka.



#### `LEFT`

     Kirjeldus: Procedure Left;

    Kasutamine: Left;

       Tegevus: Kursorit  liigutatakse ühe märgi võrra vasa-
                kule.



#### `RIGHT`

     Kirjeldus: Procedure Right;

    Kasutamine: Right;

       Tegevus: Kursorit liigutatakse ühe märgi võrra  pare-
                male.



#### `UP`

     Kirjeldus: Procedure Up;

    Kasutamine: Up;

       Tegevus: Kursorit liigutatakse ühe rea võrra ülesse.



#### `DOWN`

     Kirjeldus: Procedure Down;

    Kasutamine: Down;

       Tegevus: Kursorit liigutatakse ühe rea võrra alla.



#### `WHEREXY`

     Kirjeldus: Procedure WhereXY( Var X,Y:Integer );

    Kasutamine: WhereXY(mx,my);

       Tegevus: Tagastatakse kursori koordinaadid.




#### `INVERSE`

     Kirjeldus: Procedure Inverse;

    Kasutamine: Inverse;

       Tegevus: Järgnev tekst kujutatakse inversioonis.



#### `NORMAL`

     Kirjeldus: Procedure Normal;

    Kasutamine: Normal;

       Tegevus: Järgnev tekst kujutatakse normaalselt.


#### `SCREEN`

     Kirjeldus: Procedure Screen( N:Integer );

    Kasutamine: Screen(nn);

       Tegevus: Valitakse reziim teksti kuvamiseks:
                    N = 0  ->  40x24 märki
                    N = 1  ->  53x24 märki
                    N = 2  ->  64x20 märki 



#### `OPENWND`

     Kirjeldus: Procedure OpenWnd( X1,Y1,X2,Y2:Integer );

    Kasutamine: OpenWnd(nx1,ny1,nx2,ny2);

       Tegevus: "Akna"  avamine.  Ekraani  reziimides 1 ja 2 
                peavad X1 ja (X2+1) jaguma 4-ga. 
                ( Vt. Screen )



#### `CLOSEWND`

     Kirjeldus: Procedure CloseWnd;

    Kasutamine: CloseWnd;

       Tegevus: "Akna" sulgemine.



#### `READKEY`







     Kirjeldus: Function ReadKey:Integer;

    Kasutamine: Var Code:Integer;
                ...
                Code:=ReadKey;

       Tegevus: Klaviatuurilt lugemise funktsioon.  Kui kla-
                viatuuril  on  vajutatud  mõnele  sõrmisele, 
                siis funktsiooni väärtuseks on vastava märgi 
                kood, vastasel juhul on väärtuseks 0.


#### `KBEEPON`

     Kirjeldus: Procedure KBeepOn;

    Kasutamine: KBeepOn;

       Tegevus: Lubatakse  sõrmiste vajutamiste heliga  kvi-
                teerimine.



#### `KBEEPOFF`

     Kirjeldus: Procedure KBeepOff;

    Kasutamine: KBeepOff;

       Tegevus: Keelatakse  sõrmiste vajutamiste heliga kvi-
                teerimine.




### 3.4  Varia (`UTILIT`)


#### `RSTTIMER`

     Kirjeldus: Procedure RstTimer;

    Kasutamine: RstTimer;

       Tegevus: Taimeri nullimine  ja  käivitamine stopperi-
                reziimis.



#### `TIMER`

     Kirjeldus: Function Timer:Integer;

    Kasutamine: Var Clock:Integer;
                ...
                Clock:=Timer;

       Tegevus: Funktsioon taimeri seisu lugemiseks.  Funkt-
                sioon  tagastab stopperireziimis  käivitatud 
                taimeri (vt.  RstTimer ) registri  väärtuse, 
                mille 1 ühik = 20 millisekundiga.




#### `MOUSE`

     Kirjeldus: Procedure Mouse( Var Ud,Rud,Rl,Rrl,
                                     Lsw,Rsw:Boolean );

    Kasutamine: Mouse(lud,lrud,lrl,lrrl,llsw,lrsw);

       Tegevus: "Hiire" info lugemine. 
                Ud  - viimane liikumine üles-alla sihis;
                         ( T - alla, F - üles )
                Rud - jooksev liikumine üles-alla sihis;
                         ( T - liigub, F - ei liigu )
                Rl  - viimane liikumine horisontaalsihis;
                         ( T - paremale, F - vasakule )
                Rrl - jooksev liikumine horisontaalis;
                Rsw - parema nupu olek;
                Lsw - vasaku nupu olek.

        Märkus: Kui  "hiir" ei ole arvuti konfiguratsioonis, 
                siis põhjustab selle protseduuri poole pöör-
                dumine arvuti "kinni jooksmise".



#### `INITPR`

     Kirjeldus: Function InitPr:Boolean;

    Kasutamine: if Not InitPr then WriteLn('Viga!');

       Tegevus: Initsialiseerib  paralleelvärati  printeriga
                suhtlemiseks  ja kontrollib printeri tööval-
                midust.  Kui printer ei ole külge  ühendatud 
                või sisse lülitatud, tagastatakse tõeväärtus 
                FALSE.



#### `PRCHR`

     Kirjeldus: Procedure PrChr( Ch:Char );

    Kasutamine: PrChr('a'); PrChr(chr(13)); PrChr(cc);

       Tegevus: Printerile saadetakse  parameetriga määratud
                märk.

        Märkus: Eelnevalt on  vajalik  kasutada  funktsiooni
                InitPr.


#### `SOUND`

     Kirjeldus: Procedure Sound( Freq,Delay:Integer );

    Kasutamine: Sound(nf,nd);

       Tegevus: Käivitab  helisagedusgeneraatori parameetri-
                ga  Freq määratud sagedusel ja Delay-ga mää-
                ratud kestvusega millisekundites.



#### `VOLUME`

     Kirjeldus: Procedure Volume( V:Integer );

    Kasutamine: Volume(nv);

       Tegevus: Määrab helisignaali tugevuse. Kui V=0, siis
                on heli nõrk, kui V>0, siis tugev.




#### `RANDOM`

     Kirjeldus: Function Random( Range:Integer ):Integer;

    Kasutamine: Var Arv:Integer;
                ...
                Arv:=Random(Random(nr));

       Tegevus: Funktsioon tagastab arvu,  mis omab väärtust 
                0-st kuni (Range - 1)-ni. Arvude juhuslikkus 
                sõltub parameetrist Range ja funktsiooni ka-
                sutamise ajast.




### 3.5  Kettateek (`DISK`)


#### `SELECTDISK`

     Kirjeldus: Procedure SelectDisk( Ds:Char );

    Kasutamine: SelectDisc('B');

       Tegevus: Muudab aktiivseks parameetriga näidatud 
                kettaseadme.



#### `SETTRACK`

     Kirjeldus: Procedure SetTrack( Tr:Integer );

    Kasutamine: SetTrack(ntr);

       Tegevus: Määrab kettal raja, millega opereeritakse.



#### `SETSECTOR`

     Kirjeldus: Procedure SetSector( Sc:Integer );

    Kasutamine: SetSector(nsc);

       Tegevus: Määrab  kettal  loogilise  sektori,  millega 
                opereeritakse.



#### `SETDMA`

     Kirjeldus: Procedure SetDma( M:Integer );

    Kasutamine: Var Buf:Array [ 0..127 ] of Byte;
                ...
                SetDma( Addr(Buf) );

       Tegevus: Määrab aadressi, mida kasutatakse info puhv-
                rina  ketta lugemis- ja salvestamisoperatsi-
                oonides.  Puhvri suurus peab olema  vähemalt 
                128 baiti.


               
#### `READDISK`

     Kirjeldus: Procedure ReadDisk;

    Kasutamine: ReadDisk;

       Tegevus: Protseduuridega SetTrack ja SetSector määra-
                tud  kohast kettal loetakse 128 baiti  infot 
                ja  salvestatakse mällu protseduuriga SetDma 
                määratud kohta.



#### `WRITEDISK`

     Kirjeldus: Procedure WriteDisk;

    Kasutamine: WriteDisk;

       Tegevus: Protseduuriga  SetDma määratud kohast  mälus 
                loetakse  128  baiti infot ja  salvestatakse 
                kettale protseduuridega SetTrack ja  SetSec-
                tor määratud kohta.




```
============================================================

  Kui  käesoleva  paketiga töötades tekkib  küsimusi  või 
               leiate vigu, palun pöörduge:

                    202440 Tartumaa Nõo
                Nõo Keskkooli Arvutuskeskus
                       Indrek Jentson

============================================================
```

### Kasutatud kirjandus

[^1]: Интеллектуальный терминал для систем реального времени E5104. Программное обеспеченйе. Кнйга 3.

[^2]: Rein Jürgenson. Programmeerimine Pascalkeeles. Tln.Valgus 1985.

[^3]: Pascal/MT+ Release 5 User's Guide. Third Edition. (c) 1980,1981 by MT MicroSYSTEMS.

