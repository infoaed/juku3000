![JUKU 3000](https://raw.githubusercontent.com/infoaed/juku3000/master/images/juku3000.jpg)
# Mis on juku3000?

**Meie eesmärk on lasta tulevatel põlvedel elavalt kogeda Eesti arvutite esiajalugu — legendaarne 1990ndate kooliarvuti JUKU peab olema kasutatav ka aastal 3000!**

Kui sa ei tea, mis on JUKU, siis on aeg heita pilk [Vikipeediasse](https://et.wikipedia.org/wiki/Juku_(arvuti)), [Elektroonikamuuseumi](https://elektroonikamuuseum.ee/juku_arvuti_lugu.html) või tutvuda meie [JUKU ajajoonega](docs/ajajoon.md).

Selle saidi üldhuvitav sisu on tehtud kättesaadavaks aadressil [j3k.infoaed.ee](https://j3k.infoaed.ee/), lähtekoodi kataloogist võib lisaks leida [mõned huvitavad testprogrammid](src).

Kuigi füüsilisi JUKUsid toodeti 1990ndatel tuhandeid, on tänapäeval lihtsam JUKU kogemusest osa saada emulaatori vahendusel, mis jookseb [tavalises arvutis](dos/mame-käivitamine.md) või isegi [veebibrauseris](https://infoaed.ee/juku):

* [MAME](docs/mame-käivitamine.md) on JUKU emuleerimise kullastandard, mida saab [proovida ka veebis](https://infoaed.ee/juku) (klahvilaotuse leiad [siit](https://infoaed.ee/juku/layout.html) ja käivitamiseks vajaliku RomBios 3.43m/JBASIC 1.1 püsivara [siit](roms))
* [Универсальный эмулятор](http://bashkiria-2m.narod.ru/index/fajly/0-11) (emuleerib 80% ulatuses nii [Jukut](https://et.wikipedia.org/wiki/Juku_(arvuti)) kui [Iskra 1080 Tartut](https://et.wikipedia.org/wiki/Tartu_(arvuti)), sj konfifailid täiendatavad, audio ja ketaste toe saab vajadusel konfida, aga Jukul puuduvad täiendavad graafika- ja tekstirežiimid, lähtekood suletud -- soovitatav kasutada üldjuhul emuleerimiseks MAMEt, aga see emulaator koos oma siluri ja seadetega on hea võrdlusmaterjal) 
* [EMU80](https://github.com/vpyk/emu80v4) (vaba lähtekoodiga kergekaaluline kandidaat, mida mugandada Juku jt sama pere kiipide emuleerimiseks)
* [PCjs Project](https://www.pcjs.org/) sisaldab JUKU emuleerimise [algmeid](https://github.com/jeffpar/pcjs/tree/master/machines/pcx80/juku)

Valik lühijuhendeid:

* [JUKU E5104 opsüsteemi käitamine](docs/juku-k%C3%A4sud.md)
* [JUKU videote korrektne salvestamine](docs/videod.md)
* [JUKU ketaste lugemine/kirjutamine libdsk/cpmtools abil](docs/kettad.md)

Juku opsüsteem EKDOS:

* [EKDOS 2.30](https://p6drad-teel.net/~p6der/ekdos230.zip) (väljalase detsember 1989, [teade](docs/ekdos230.txt))
  * [Lähtekood](src/EKDOS30.ASM), vrd CP/M 2.2 [mugandamise juhised Digital Researchilt](http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch6.htm)
* [EKDOS 2.29](https://p6drad-teel.net/~p6der/ekdos229.zip) (väljalase 05.01.1988)

## Projekti tekkelugu

> See siin oli algselt häkatoniprojekt, mida dokumenteeritakse allpool -- praeguseks on olemas [LVLup muuseum](https://et.wikipedia.org/wiki/LVLup) ja arvutimuuseumid [Tallinnas](https://et.wikipedia.org/wiki/Arvutimuuseum) ja [Tartu Ülikooli arvutiteaduse instituudi juures](https://et.wikipedia.org/wiki/Tartu_%C3%9Clikooli_arvutimuuseum), kelle koostöös sellised asjad võiks teoks saada. Järgneb ajalooline tekst...

### Elamused ja ekspositsioonid 22.09-24.09 2017

Muuseumid tahaks panna välja Jukude, ZX Spectrumide, Atarite, Amigate, Commodorede, Iskrate, Yamahade, Tartute, Entelite jne näitusi koos toonase tarkvara/mängudega, aga sellega on üks suur probleem — kui külastajad neid arvuteid ka puudutada tohivad, siis kipuvad uunikumid purunema. Aga mis mõte on arvutitel, kui neid näppida ei või?

Lahenduseks on ehitada tänapäevastest komponentidest arvutisüsteem, mis pakub toonastele arvutitele sarnast kasutuskogemust, kuid on tänapäeva kasutajale piisavalt intuitiivne ning lollikindel, et sellest võiks igapäevaselt üle käia koolijütside hordid.

### Tiimi liikmed

* (nimed eemaldatud)

## Mida selleks vaja on?

* Emulaatoreid, palju emulaatoreid. Juku EKDOSi emuleerimine koos kõigi liidestega ei ole ühe õhtu projekt, aga enamike vanade levinud platvormide jaoks on olemas emulaatorid. Neid saab kasutada.
* Tarkvara, palju kõvaketastele, diskettidele, kassettidele ja lintidele kinni jäänud tarkvara, eriti seda, mis on mugandatud, häkitud või lausa toodetud maarahva poolt maarahvale kasutamiseks. Kas sul on tarkvara, mis ei jookse ühelgi teadaoleval tänapäeva arvutisüsteemil? Kirjutasid ise 1990datel arvutimänge? Saada see meile, me mõtleme välja, kuidas sellele elu sisse puhuda.
* Riistvarakomplekt, kus on vana kooli CRT monitor, arhailise moega vastupidav klaviatuur ning legendaarne juhtpult Joystick!
* Kasutajaliidese pealiskiht, mis võimaldab valida eri emulaatorite, nende mängude vahel.
* Muuseumikiht, mis võimaldab tutvuda arvutimängude esijaloo kultuuri- ja tehnotasutaga. Öövalve arvutuskeskuses? Kalevi tänava mängude tuba? Kooli Juku-klassi võti? Zeroday kräkid hollandi BBSist 2600-baud modemiga Eesti Telefoni kulul? BBSummer ja ee.kevad? Mudamängija sokid ATI terminali klaviatuuril? Kogu see etnograafiline materjal väärib kogumist ja tulevastele põlvedele jutustamist.

## Kuidas selleni jõuda?

Esimene samm astutakse 22.-24. septembril 2017 Tartus Garage48 häkatonil ["Elamused ja ekspositsioonid"](http://garage48.org/events/garage48-elamused-ja-ekspositsioonid). Kui sa tunned huvi, tahad anda nõu, aidata kaasa või lihtsalt jagada oma mälestusi vmt, siis võta ühendust tramm@infoaed.ee või +372 55643754 — meile on kasu, kui saad häkatonilt läbi tulla, et meiega sel teemal lihtsalt suhelda, aga veel parem kui liitud meie tiimiga, et luua prototüüp, mis võiks leida kasutamist päris muuseumis päris näitustel. Katsenäituse plaanime läbi viia juba novembri alguses, kui ERMis toimub tänapäeva digitaalsele muuseumitööle keskenduv konverents ["Open licences, open content, open data: tools for developing digital humanities"](http://dh.org.ee/category/events/dhe2017/), kus esineb ka Soome esimese arvutimängumuuseumi üks võtmeisik Outi Penninkangas.
