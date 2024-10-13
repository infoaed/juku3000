# Juku E5104 opsüsteemi käitamine

«Juku» sisselülitamisel ilmub kuvarile püsimonitori teade `RomBios`, monitori versiooninumber ja viip `∗`, mille järel kutsuvalt vilgub sisestuskursor:

[![EKDOS 2.30 alglaadimine püsimonitorist Rombios 3.43m juhtklahvidega «T», «D», «D»](/images/jukubuut.png)](https://commons.wikimedia.org/wiki/File:Juku_E5101_booting_up_EKDOS_2.30,_displaying_readme_file_on_screen.webm)

«Juku E5104» opsüsteemi EKDOS alglaadimiseks tuleb vajutada `T`, `D`, `D`, mis pikemalt lahtiseletatuna on:

1. paigutada lugemisseadmesse andmekandja opsüsteemiga
2. anda püsimonitorile juhis `T` opsüsteemi laadimiseks
3. sisestada opsüsteemi laadimiseks ümbrikkettalt `D`, võrgust `N` või lindilt `T`

Alglaadimise käigus loetakse opsüsteemi käsutöötlusprotsessor andmekandjalt muutmällu. Ümbrikkettalt laadimisel tuleb määrata ka süsteemiketta tüüp, milleks on kahepoolne ümbrikketas ehk juhis `D`. Eduka laadimise tulemusel ilmub ekraanile järgnevale sarnanev käivitusteade:

```
52K EKDOS 2.30

Drive assignments:  

<A> — 5" 786K  
<B> — 5" 786K
<C> — RAM disk 192K
```

Seejärel kuvatakse opsüsteemi valmisolekut väljendav viip `A>`, mis võimaldab [sisestada käske](#opsüsteemi-käsud) või [käivitada programme](#programmifailide-käivitamine). Näiteks võib alustuseks olla tark vaadata kettal paiknevate failide kataloogi käsuga `DIR` või lugeda kaasa pandud teadet sisestades `TYPE READ.ME`.

Viip on mistahes programmi poolt väljastatav teade, mis näitab, et programm ootab kasutaja edasisi juhiseid. Näiteks püsimonitori viiba `∗` järele `A` või `B` sisestamine käivitab miniassembleri või püsimälu BASIC-interpretaatori, `T` opsüsteemi alglaadimise [^1]. Eri programmidel on eri viibad, mille kasutamine on kirjeldatud nende juhendmaterjalis.

> Reaalaja süsteemide intellektuaalse terminali «Juku E5104»[^2] püsimälus sisalduv tarkvara koosneb monitorist, BASIC-keele interpretaatorist, miniassemblerist, andmeside draiveritest ja opsüsteemide alglaaduritest:
> 
> 1. Püsimonitor juhib andmetöötlust, võimaldab kontrollida ja muuta arvuti registrite ning mälu sisu ja tagab graafika programmeerimise vahendid.  
> 2. BASIC-keele interpretaator on vahend programmeerimise õppimiseks ja vähemnõudlike programmide kirjutamiseks.  
> 3. Miniassembler on kompaktne translaator vilunud programmeerija jaoks, ühtlasi vahend programmide silumiseks. Ei mahu koos BASICu interpretaatoriga korraga püsimällu, mistõttu saab neist korraga valida vaid ühe.  
> 4. Operatsioonisüsteemide alglaadurid on võimsama tarkvara eelpost püsimälus. Magnetofoni või diskett-salvesti ühendamisel saab sealt alglaadurite abil lugeda arvuti muutmällu vastavalt lindi-, võrgu- või kettaopsüsteemi.  
> 5. Andmeside draiver on tarkvara arvutipoolseim osa. Ülejaanud osa loetakse mällu välissalvestilt, seega peab arvutivõrgus olema vähemalt üks magnetofon või diskettsalvesti.  
>
> Põhitarkvara suhtes täiendava opsüsteemi käitamine hõlbustab info talletamist välissalvestile ning pakub kasutajale vahendeid, mis püsimonitoris puuduvad.[^3]

## Opsüsteemi käsud

Käsuprotsessor (KP) vahetab infot kasutaja ja operatsioonisüsteemi vahel. KP loeb ja töötleb klahvistikult sisestatud käsuridu. KP valmisolekut käsu sisestuseks väljendab viip `A>` (või sõltuvalt aktiivsest kettast `B>` või `C>`). KP sisaldab sõltuvalt opsüsteemi tüübist valiku sisefunktsioone või käsklusi:

`DIR` — mittesüsteemsete failide kataloogi esitus  
`DIRS` — süsteemsete failide kataloogi esitus  
`REN` — failide ümbernimetamine  
`ERA` — failide kustutamine  
`REST` — kustutatud failide taastamine  
`MEM` — üldinfo lindi kohta  
`TYPE` — tekstifaili väljastus ekraanile  
`USER` — kasutajanumbri valik  
`DUMP` — faili sisu väljastus 16-ndkoodis  
`SAVE` — mälu sisu salvestamine faili  
`OPEN` — lindi avamine  
`CLOSE` — lindi sulgemine  
`MONID` — väljumine monitori  
`BASIC` — püsimälus oleva BASIC-u käivitamine  
`LOAD` — faili laadimine lindilt muutmällu  
`RUN` — laaditud programmi käivitamine  

Andmeid säilitatakse välissalvestil failidena, mille tähistused on kujul:

`failinimi.EXT`

Failinimi sisaldab kuni kaheksa ja laiend (`EXT`) kuni kolm tärki ning neid eraldab teineteisest punkt. Laiend võib ka puududa. Failinimes ja laiendis ei tohi esineda: koma (`,`), semikoolon (`;`), koolon (`:`), küsimärk (`?`), tärn (`∗`), noolsulg (`<` või `>`), nurksulg (`[` või `]`). Mõningad kasutatavamad laiendid:

`ASM`, `MAC` — assemblerkeele lähtefail  
`BAS` — BASIC kompilaatori lähtefail  
`PAS` — PASCAL/MT+ translaaatori lähtefail  
`FOR` — F(ORTRAN)80 kompilaatori lähtefail  
`BAK` — tekstitoimeti varundusfail  
`PRN`, `LST` — listingufail  
`TXT` — tekstifail  
`HEX` — masina kood 16-ndkujul  
`$$$` — ajutine fail  
`COM` — käsu- ehk programmi- ehk laadefail  

Failid paiknevad lintidel või ketastel, mille lugemisseadme tähis on tähestiku täht ja selle järgnev koolon (nt `A:` või `B:`). Faili paiknemist lugemisseadmes oleval kettal märgitakse seadmetähise lisamisega failinime ette (`B:failinimi.EXT`).

Sisefunktsioonide `ERA`, `REST`, `DIR`, `DIRS` kasutamisel võib failinime ja laiendi sisestada kas üheselt või mitmeselt määratuna. Mitmeselt määra­miseks kasutatakse tähiseid `∗` ja `?`:

`?` — asendab failinimes või laiendis ühte märki, tähenduses «mis tahes märk sellel kohal»

`∗` — asendab failinime või laiendit, tähenduses «mis tahes nimi (laiend)»; tärn nime (laiendi) algusosa järel asendab järgnevat lõpuosa, tähen­duses «mis tahes lõpuosaga nimi (laiend)»

Vormingud `∗.∗` ja `????????.???` on sarnased. Siin ja edaspidi mõeldakse termini «failinimi» all üldiselt failinimest ja laiendist koosnevat faili identifikaatorit.

Näide:

> `A>` `ERA A??.∗` — kustutamisele kuuluvad kõik failid, mille nimi on 3 märki pikk ja algab sõltumata laiendist tähega `A`  
> `A>` `ERA B:A∗.COM` — kustutamisele kuuluvad kettalt `B:` kõik failid, mille nimi algab tähega `A` ja mille laiendiks on `COM`

## Programmifailide käivitamine

Valmisprogrammid on kirjutatud assembler- või kõrgkeeles ja transleeritud seejärel mikroprotsessori [KR580VM80A](https://en.wikipedia.org/wiki/KR580VM80A) täidetavasse masinakoodi.

Programmi- ehk laadefaile saab käivitada vastusena KP viibale `A>` opsüsteemi käsklustega samadel alustel. Programmi käivitamisel programminime järgi otsitakse andmekandjalt fail antud nimega ja laiendiga `COM`. Näiteks:

> `A>` `INDY`  

käivitab programmifaili, mis asub seadmesse `A:` sisestatud andmekandjal ja mille nimeks on `INDY.COM`. Programmifail laaditakse mällu alates tarbijaprogrammi tsooni (TT) algusest aadressil `100H` ning juhtimine antakse üle sellele aadressile, st programm alustab tööd. Kui programmifaili nimi kattub sisefunktsooni omaga, siis käivitatakse viimane. Olematu laadefaili puhul väljastatakse ekraanil järgmisele reale märk `?` ning programminimi.

Programminime järel saab sisestada ühe või kaks parameetrit (tavali­selt on parameetriks failinimi), st opsüsteemi viibale käsureaga vastamisel on kolm võimalikku kuju:

> `A>` `programminimi`  
> `A>` `programminimi parameeter1`  
> `A>` `programminimi parameeter1 parameeter2`  

KP moodustab nendest parameetritest süsteemiparameetrite tsooni (ST) ühe või kaks faili juhtplokki (FJP); parameetrite puudumisel täidetakse FJP-d tühikutega. Käsurea maksimaalne pikkus on 128 märki. Pärast sisestatud käsurea analüüsi salvestatakse 128-baidisesse otsemällupöörduse puhvrisse (OMP) programminimele järgnevast märgist algav käsurea osa. KP puhvri esimeses baidis (aadressil `80H`) on sisestatud sümbolite arv.

> Programmide silumisel ja katsetamisel on kasulik tunda süsteemi mälujaotust. JUKU opsüsteemide kasutamisel on see üldjoontes:
>
> | Aadress |                                                   |
> | ----------- | --------------------------------------------------|
> `0000` | Süsteemiparameetrite tsoon (ST)
>        | `0000`: `JMP CA03` (KP algusaadress)
>        | `0005`: `JMP BC06` (EKDOSi aadress)
>        | `005C`: Faili juhtblokk (FJB) #1
>        | `006C`: FJB #2
>        | `0080`: 128B otsemällupöörduse (OMP) puhver
> `0100` | Tarbijaprogrammide tsoon (TT)
> `B400` | Käsuprotsessor (KP)
>        | `BC06`: EKDOSi elik CP/Mi funktsioonid
>        | `CA03`: KP viiba käivitamise aadress
> `D600` | Süsteemiparameetrid
> `D800` | Videomälu, mälurežiimides 1-2 püsimälu lugemine
> `FD80` | Süsteemiparameetrid
>        | `FF26`: Võrgufunktsioonid
>        | `FF46`: Süsteemiväljad
>        | `FF68`: BIOSi põhifunktsioonid
>
> Tarbijatsoonis asuvad kasutajaprogrammid, mis on andmekandjalt mäl­lu laaditud. Näiteks teksti redigeerimise ajal sisaldab TT tekstitoimetit ja toimetatavat teksti ennast. Mälujaotus võib detailildes erineda sõltuvalt opsüsteemi tüübist ja versioonist, nt lindiopsüsteemi BLOS puhul lõpeb TT aadressil `BEFF`, `BF00`-`C7BF` asetseb täiendav 2KB OMP puhver ja `D200`-`D5FF` paikneb lindifailide kataloog.[^1][^2]

## Kasulikke juhtklahve

Käsureaga opereerimisel saab kasutada järgmisi juhtkoode (klahv `CTRL` ja samaaegselt klahvid):

`CTRL`+`S` — kuva ajutine peatamine  
`CTRL`+`C` — programmi töö katkestamine  
`CTRL`+`ESC` — programmi töö katkestamine, juhtimine üle aktiivsele viibale  
`CTRL`+`SHIFT`+`ESC` — programmi töö katkestamine, juhtimine üle monitorile  
`CTRL`+`Z` — sisendi lõpp (`PIP` ja `SED`)  
`CTRL`+`X` — rea kustutus ja kursor rea algusesse  
`CTRL`+`H` — (= tagasinool) kursori tagasilüke, märgi kustutusega  
`CTRL`+`J` — (= reavahetus) lõpetab sisestuse  
`CTRL`+`M` — (= tagastus) lõpetab sisestuse  
`RETURN` — tagastusklahv lõpetab sisestuse  

Opsüsteemi vaikimisi käitumist saab lülitada paojadade abil (klahv `ESC`, seejärel klahvid ja `RETURN`):

`ESC` `M` `0` — 40x24 kuvalaotus  
`ESC` `M` `1` — 53x24 kuvalaotus  
`ESC` `M` `2` — 64x20 kuvalaotus (võimalik on ka 80x24 laotus[^4])  
`ESC` `0` — klahvivajutuse helisignaali keelamine  
`ESC` `1` — klahvivajutuse helisignaali lubamine  
`ESC` `2` — ekraani kerimise keelamine  
`ESC` `3` — ekraani kerimise lubamine  
`ESC` `4` — kursori peitmine  
`ESC` `5` — kursori näitamine  
`ESC` `:` — ekraani sujuva kerimise režiim  
`ESC` `;` — ekraani hüppelise kerimise režiim  

Ekraanil oleva saab kustutada ja liikuda tagasi algusse paojadaga `ESC` `L` või juhtkoodiga `SHIFT`+`ERASE`.

_Ülalolev on peamiselt lühendatud ja üldistatud versioon esimeses viites toodud lindiopsüsteemi juhendist. Kohandatud juhend püüab võimaluste piires järgida algse juhendi stiili ja terminoloogiat._

[^1]: [Mikroarvuti «JUKU» kasutamisjuhend](https://arti.ee/juku/Mikroarvuti%20Juku%20E5101%20kasutamisjuhend%201988%20%28168lk%2C%20eesti%20k%29.pdf) (1988), opsüsteemi üldkirjeldus lk 20jj, mälujaotus lk 31jj hälbib EKDOSi omast, aga on informatiivne, sellest ja opsüsteemi käsklustest täpsemalt lk 46jj  
[^2]: [Интеллектуальный терминал для систем реального времени E5104](https://elektroonikafoorum.com/thread-690-post-4165.html#pid4165) (1988), ajakohaseim mälutabel 1. raamatus lk 25  
[^3]: [Mikroarvuti JUKU](ekta_juku.pdf) (1987), tarkvara kirjeldus lk 13jj  
[^4]: [JUKU PC UTILITIES DISK #4](https://github.com/infoaed/juku3000/blob/master/docs/ekdos230.txt#L91-L112) (1989), 80x24 ekraanirežiimi kohta märkus 1  
