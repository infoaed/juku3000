# JUKU käivitamine MAME emulaatoris

Alates [MAME versioonist 0.272](https://github.com/mamedev/mame/releases/tag/mame0272) on JUKU töökorras unarvara auväärses nimekirjas[^1] ning saad Eesti legendaarse kooliarvuti suurema jukerdamiseta oma töölaual käima lasta (veebiversioon proovimiseks [siin](https://infoaed.ee/juku/)). Selleks tuleb:

1. Laadida alla [MAME emulaatori töölauaversioon](https://www.mamedev.org/release.html)
2. Paigutada [JUKU püsivara ZIP](https://github.com/infoaed/juku3000/raw/refs/heads/master/roms/juku.zip) allalaaditud MAME `roms` kataloogi
3. Käivitada MAME, valida süsteemiks JUKU E5104 ja EKDOS 2.30
4. Kinnitada, et JUKU käivitatakse vaikimisi püsivaraga RomBios 3.43m
5. Süsteemi omaduste kuvamise järel lastakse uunikumile vool sisse

Kuvarile ilmub püsimonitori teade `RomBios`, monitori versiooninumber ja viip `∗`, mille järel kutsuvalt vilgub sisestuskursor:

[![EKDOS 2.30 alglaadimine püsimonitorist Rombios 3.43m juhtklahvidega «T», «D», «D»](/images/jukubuut.gif)](https://commons.wikimedia.org/wiki/File:Juku_E5101_booting_up_EKDOS_2.30,_displaying_readme_file_on_screen.webm)

JUKU E5104 opsüsteemi EKDOS alglaadimiseks tuleb vajutada `T`, `D`, `D`, täpsemad opsüsteemi juhised [leiad siit](juku-k%C3%A4sud.md).

## Tarkvara käivitamine

Ent mis kasu on opsüsteemist tarkvarata? JUKU [3](https://elektroonikamuuseum.ee/juku_arvuti_tarkvara.html)+[1](ekdos230.md) süsteemiketast koos tarkvaraga on MAME tarkvaranimekirjast leitavad alates versioonist 0.274, täiendavat tarkvara leiab Elektroonikamuuseumi [JUKU failivaramust](https://elektroonikamuuseum.ee/failid/juku/tarkvara/).

Flopiketta kasutamiseks tuleb see emuleeritud JUKUsse sisestada. Selleks on vaja lahti lukustada MAME süsteemiklahvid `Scroll Lock` abiga (tuntud ka kui `MAME Lock`), mille järel saab avada [MAME süsteemimenüü](https://docs.mamedev.org/usingmame/mamemenus.html) vajutades `Tab`.

Flopisid ehk `JUK`-faile saab lisada `File Manageri` alt ja vaikimisi saab valida eri JUKU süsteemikettaid MAME tarkvaranimekirjast (_software list_), rohkem tarkvara ja mänge leiab `JUKGAME`/`JUKPROG` seeriast. Emulaatori valmimise puhul andsime välja ka [JUKU 3000 mängude ketta 2024](mängude-ketas-2024.md), mis jäädvustab 2024. aasta novembri veebiemulaatori [`GAME1.JUK`](https://infoaed.ee/juku/game1.juk) ketta seisu. JUKU-aegset pildimaterjali ja kasutajaprogramme leiab veebiemulaatori kettalt [`PROG1.JUK`](https://infoaed.ee/juku/prog1.juk).

MAME flopimenüü | Mängude ketas 2024
:-------------------------:|:-------------------------:
[![Scroll Locki (tuntud ka kui MAME Lock) vajutamise järel saab TABiga avada MAME flopimenüü](/images/mame-flopimenyy.png)](https://docs.mamedev.org/usingmame/mamemenus.html)  |  [![Emulaatori valmimise puhul anti välja Juku 3000 mängude ketas 2024](/images/j3k-games2024f.png)](mängude-ketas-2024.md)

Aktiivset ketast saad EKDOSis vahetada viiba järele kettatähise ja kooloni kirjutamisega (nt `A:` või `B:`), tarkvara ehk `COM`-laadefaile saad käivitada sisestades viiba järele soovitud programmi nime. Failide nimekirja kettal näitab käsklus `DIR`. Süsteemi töökorras olemise kontrolliks võid proovida, kas saad `GAME1.JUK` kettalt käima [tuntud JUKU mängu INDY](https://et.wikipedia.org/wiki/Indy_looking_for_Jewels...).

JUKU tarkvara kataloogi koos kirjeldustega leiad [siit](tarkvara-kataloog.md), ketastega ümberkäimise tehnilise juhendi [siit](kettad.md).

Üldiselt on tark esimese asjana MAMEs lülitada JUKU puhul välja kõik _bilinear filtering_ sätted, mis sobivad udusema pildiga telekamängude jaoks, kuid mitte kooliarvutile (nt `General Settings` -> `Video Options` alt, ära unusta pärast üldmenüüst valida `Save Settings`).

Kui teed JUKU mängudest või tarkvarast ekraanivideoid, siis [tee neid õigesti](videod.md)!

Kui soovid katsetada JUKUl programmeerimist, võid lapata läbi [slaidid JUKU tarkvara ökosüsteemist](https://p6drad-teel.net/~p6der/juku-hingeelu_2024_videota.pdf) ning seejärel proovida kompilaatorite-linkurite koondketast [`TERE.JUK`](https://github.com/infoaed/juku3000/raw/refs/heads/master/src/juhan/tere.juk).

[^1]: _Kes minevikku ei mäleta, elab tulevikuta!_ -- Juhan Liiv
