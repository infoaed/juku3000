# Juku E5104 opsüsteemi käitamine

«Juku» sisselülitamisel ilmub kuvarile püsimonitori teade `RomBios`, monitori versiooni number ja viip `*`.

Viip on programmi poolt väljastatav teade, mis näitab, et programm ootab kasutaja edasisi direktiive (nt direktiiv «A» käivitab püsimälu BASIC-interpretaatori või miniassembleri, direktiiv «T» opsüsteemi alglaadimise). Eri programmidel on erinevad viibad, mis on kirjeldatud nende kasutamisjuhistes.

Reaalaja süsteemide intellektuaalse terminali «Juku E5104» püsimälus opsüsteemist sõltumatult sisalduv põhitarkvara koosneb püsimonitorist, BASIC-keele interpretaatorist, miniassemblerist, andmeside draiveritest ja opsüsteemide alglaaduritest. Operatsioonisüsteem hõlbustab informatsiooni talletamist välissalvestile ja pakub arvuti kasutajale teenuseid, mida püsimonitor ei paku. [^1]

Opsüsteemi alglaadimist püsimonitorist näitlikustakse videos:

[![EKDOS 2.30 alglaadimine püsimonitorist Rombios 2.43m direktiividega «T», «D», «D»](/images/jukubuut.png)](https://commons.wikimedia.org/wiki/File:Juku_E5101_booting_up_EKDOS_2.30,_displaying_readme_file_on_screen.webm)

Alglaadimiseks tuleb vajutada klaviatuuril «T», «D», «D», mis pikemalt lahtiseletatuna on:

1. sisestada lugemisseadmesse andmekandja opsüsteemiga
2. sisestada monitori direktiiv «T»

Seejärel tuleb valida opsüsteemi alglaadimise viis, ümbrikkettalt laadimiseks «D», võrgust laadimiseks «N» ja lindilt laadimiseks «T». Alglaadimise käigus loetakse käsutöötlusprotsessor andmekandjalt muutmällu. Ümbrikkettalt laadimisel tuleb valida süsteemiketta tüüp, milleks on kahepoolne ümbrikketas ehk direktiiv «D». Eduka laadimise lõppedes ilmub ekraanile järgnevale sarnane tekst:

```
52K EKDOS 2.30

Drive assignments:  

<A> — 5" 786K  
<B> — 5" 786K
<C> — RAM DISK 192K
```

Sellele järgneb süsteemi valmisoleku tähis (viip) `A>`.

## Opsüsteemi käsud

Käsuprotsessor (KP) vahetab infot kasutaja ja operatsioonisüsteemi vahel. [^2] KP loeb ja töötleb klaviatuurilt sisestatud käsuridu. KP valmisolekut käsu sisestuseks näitab teade `A>` (või sõltuvalt aktiivsest kettast `B>` või `C>`). KP sisaldab sõltuvalt opsüsteemi tüübist valiku sisefunktsioone:

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

Faile tähistatakse järgmiselt:

`failinimi.EXT`

Failinimi sisaldab kuni kaheksa ja laiend (`EXT`) kolm tärki ning neid eraldab üksteisest punkt. Laiend võib ka puududa. Failinimes ja laiendis ei tohi esineda järgmised märgid: koma (`,`), semikoolon (`;`), koolon (`:`), küsimärk (`?`), tärn (`*`), noolsulg (`<` või `>`), nurksulg (`[` või `]`). Mõningad kasutatavamad laiendid:

`ASM`, `MAC` — assemblerkeele lähtefail  
`BAS` — BASIC kompilaatori lähtefail  
`PAS` — PASCAL/MT+ translaaatori lähtefail  
`FOR` — F(ORTRAN)80 kompilaatori lähtefail  
`BAK` — Tekstitoimeti varundusfail  
`PRN`, `LST` — listingufail  
`TXT` — tekstifail  
`HEX` — masina kood 16-ndkujul  
`$$$` — ajutine fail  
`COM` — käsu- ehk programmi- ehk laadefail  

Failid paiknevad ketastel, mille tähis on tähestiku täht ja selle järgnev koolon (nt `A:` või `B:`). Faili paiknemist kettal märgitakse kettatähise lisamisega failinime ette (`B:failinimi.EXT`).

Sisefunktsioonide `ERA`, `REST`, `DIR`, `DIRS` kasutamisel võib failinime ja laiendi sisestada kas üheselt või mitmeselt määratuna. Mitmeselt määra­miseks kasutatakse tähiseid `*` ja `?`:

`?` — asendab failinimes või laiendis ühte märki, tähenduses «mis tahes märk sellel kohal»

`*` — asendab failinime või laiendit, tähenduses «mis tahes nimi (laiend)»; tärn nime (laiendi) algusosa järel asendab järgnevat lõpuosa, tähen­duses «mis tahes lõpuosaga nimi (laiend)»

Vormingud `*.*` ja `????????.???` on sarnased. Siin ja edaspidi mõeldakse termini «failinimi» all üldiselt failinimest ja laiendist koosnevat faili identifikaatorit.

Näide:

> `ERA A??.*` — kustutamisele kuuluvad kõik failid, mille nimi on 3 märki pikk ja algab sõltumata laiendist tähega `A`  
> `ERA B:A*.COM` — kustutamisele kuuluvad kettalt `B:` kõik failid, mille nimi algab tähega `A` ja mille laiendiks on `COM`

## Programmifailide käivitamine

Vastuseks süsteemi valmidusteatele (viibale) sisestatakse käsurida (3 võimalikku kuju):

> `programminimi`  
> `programminimi parameeter1`  
> `programminimi parameeter1 parameeter2`  

Programminimi on sisefunktsiooni nimi või kasutajaprogrammi nimi. Kui käsureas on sisefunktsioon, siis see täidetakse. Vastasel korral otsitakse kataloogist laadefaili:

> `programminimi.COM`

Sellise nimega programmifaili leidmisel (eeldatakse `COM` laiendit, mida sisestama ei pea) laaditakse see alates tarbijaprogrammi tsooni algusest (TT aadres­sist 100H) mällu ja käivitatakse. Olematu laadefaili puhul väljastatakse ekraanil järgmisele reale märk `?` ning programminimi.

Programminime järel saab sisestada ühe või kaks parameetrit (tavali­selt on parameetriks failinimi). KP moodustab nendest parameetritest süsteemiparameetrite tsooni (ST) ühe või kaks faili juhtplokki (FJP); parameetrite puudumisel täidetakse FJP-d tühikutega. Käsurea maksimaalne pikkus on 128 märki. Pärast sisestatud käsurea analüüsi salvestatakse 128-baidisesse otsemällupöörduse puhvrisse (OMP) programminimele järgnevast märgist algav käsurea osa. KP puhvri esimeses baidis (aadressil 80H) on sisestatud sümbolite arv.

Käsureaga opereerimisel saab kasutada järgmisi juhtkoode (klahv CTRL ja täht):

CTRL S — kuva ajutine peatamine  
CTRL C — programmi töö katkestamine  
CTRL ESC — programmi töö katkestamine, juhtimine üle aktiivsele viibale  
CTRL SHIFT ESC — programmi töö katkestamine, juhtimine üle monitorile  
CTRL Z — sisendi lõpp (`PIP` ja `SED`)  
CTRL H — kursori tagasilüke, märgi kustutusega  
CTRL X — rea kustutus ja kursor rea algusesse  
CTRL M — (= tagastus) lõpetab sisestuse  
CTRL J — (= reavahetus) lõpetab sisestuse  
`<RETURN>` — tagastusklahv lõpetab sisestuse  

[^1]: [Mikroarvuti JUKU](ekta_juku.pdf) (1987) lk 13jj  
[^2]: [Mikroarvuti «JUKU» kasutamisjuhend](https://arti.ee/juku/Mikroarvuti%20Juku%20E5101%20kasutamisjuhend%201988%20%28168lk%2C%20eesti%20k%29.pdf) (1988) lk 46jj  
