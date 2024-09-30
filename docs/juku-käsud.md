# Juku E5101 opsüsteemi käitamine

Operatsioonisüsteem hõlbustab informatsiooni säilitamist ja pakub arvuti kasutajale muidki teenuseid. Opsüsteemi alglaadimiseks tuleb:

1. sisestada lugemisseadmesse andmekandja operatsioonisüsteemiga
2. sisestada monitori direktiiv «T»

Seejärel tuleb valida opsüsteemi alglaadimise viis, flopikettalt laadimiseks «D», võrgust laadimiseks «N» ja lindilt laadimiseks «T». Alglaadimise käigus loetakse käsutöötlusprotsessor andmekandjalt muutmällu. Eduka laadimise lõppedes flopikettalt ilmub ekraanile sarnane tekst:

```
52K EKDOS 2.30  
Drive assignments:  

<A> — 5" 786K  
<B> — 5" 786K
<C> — RAM DISK 192K
```

Sellele järgneb süsteemi valmisoleku tähis (viip) `A>`.

## Opsüsteemi käsud

Käsuprotsessor (KP) vahetab infot kasutaja ja operatsioonisüsteemi vahel. KP loeb ja töötleb klaviatuurilt sisestatud käsuridu. KP valmisolekut käsu sisestuseks näitab teade `A>`. KP sisaldab sõltuvalt opsüsteemist valiku sisefunktsioone:

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

Failinimi sisaldab kuni kaheksa ja laiend (`EXT`) kolm tärki ning neid eraldab üksteisest punkt. Laiend võib ka puududa. Failinimes ja laiendis ei tohi esineda järgmised märgid: koma (`,`), semikoolon (`;`), koolon (`:`), küsimärk (`?`), tärn (`*`), noolsulg(`<` või `>`). Mõningad kasutatavamad laiendid:

`ASM`, `MAC` — assemblerkeele lähtefail  
`BAS` — BASIC kompilaatori lähtefail  
`PAS` — PASCAL/MT+ translaaatori lähtefail  
`FOR` — F(ORTRAN)80 kompilaatori lähtefail  
`BAK` — Tekstitoimeti varundusfail  
`PRN`, `LST` — listingufail  
`TXT` — tekstifail  
`HEX` — masina kood 16-ndkujul  
`$$$` — ajutine fail  
`COM` — käsu- ehk laadefail  

Sisefunktsioonide `ERA`, `REST`, `DIR`, `DIRS` kasutamisel võib failinime ja laiendi sisestada kas üheselt või mitmeselt määratuna. Mitmeselt määra­miseks kasutatakse tähiseid `*` ja `?`:

`?` — asendab failinimes või laiendis ühte märki, tähenduses «mis tahes märk sellel kohal»

`*` — asendab failinime või laiendit, tähenduses «mis tahes nimi (laiend)»; tärn nime (laiendi) algusosa järel asendab järgnevat lõpuosa, tähen­duses «mis tahes lõpuosaga nimi (laiend)»

Vormingud `*.*` ja `????????.???` on sarnased. Järgnevates peatükkides mõeldakse mõiste «failinimi» all failinimest ja laiendist koosnevat faili identifikaatorit.

Näide:

> `ERA A??.*` — kustutamisele kuuluvad kõik failid, mille nimi on 3 märki pikk ja algab sõltumata laiendist tähega `A`  
> `ERA A*.COM` — kustutamisele kuuluvad kõik failid, mille nimi algab tähega `A` ja mille laiendiks on `COM`

## Programmifailide käivitamine

Vastuseks süsteemi valmidusteatele (viibale) sisestatakse käsurida (3 võimalikku kuju):

> `programminimi`  
> `programminimi parameeter1`  
> `programminimi parameeter1 parameeter2`  

Programminimi on sisefunktsiooni nimi või kasutaja programmi nimi. Kui käsureas on sisefunktsioon, siis see täidetakse. Vastasel korral otsitakse kataloogist laadefaili:

> `programminimi.COM`

Sellise nimega programmifaili leidmisel (eeldatakse `COM` laiendit, mida sisestama ei pea) laaditakse see alates TT algusest (aadres­sist 100H) mällu ja käivitatakse. Olematu laadefaili puhul väljastatakse ekraanil järgmisele reale märk `?` ning programminimi.

Programminime järel saab sisestada ühe või kaks parameetrit (tavali­selt on parameetriks failinimi). KP moodustab nendest parameetritest ST-sse ühe või kaks faili juhtplokki; parameetrite puudumisel täidetakse FJP-d tühikutega. Käsurea maksimaalne pikkus on 128 märki. Pärast sisestatud käsurea analüüsi salvestatakse 128-baidisesse OMP puhvrisse programminimele järgnevast märgist algav käsurea osa. KP puhvri esimeses baidis (aadressil 80H) on sisestatud sümbolite arv.

Käsurea sisestamisel saab kasutada järgmisi juhtkoode (klahv CTRL ja täht):

CTRL S — kuva ajutine peatamine  
CTRL Z — sisendi lõpp (`PIP` ja `SED`)  
CTRL H — kursori tagasilüke, märgi kustutusega  
CTRL X — rea kustutus ja kursor rea algusesse  
CTRL M — (= tagastus) lõpetab sisestuse  
CTRL J — (= reavahetus) lõpetab sisestuse  
`<RETURN>` — tagastusklahv lõpetab sisestuse  

_Koostatud "[Mikroarvuti «JUKU» kasutamisjuhendi](https://arti.ee/juku/Mikroarvuti%20Juku%20E5101%20kasutamisjuhend%201988%20%28168lk%2C%20eesti%20k%29.pdf)" lk 24jj põhjal._
