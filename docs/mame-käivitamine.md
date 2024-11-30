# JUKU käivitamine MAME emulaatori abil

Alates [MAME versioonist 0.272](https://github.com/mamedev/mame/releases/tag/mame0272) on JUKU töökorras unarvara auväärses nimekirjas ning saad Eesti legendaarse kooliarvuti MAMEga omaenda töölaual käima lasta (veebiversiooni saad katsetada [siin](https://infoaed.ee/juku/)). Selleks tuleb:

1. Laadida alla [MAME emulaatori töölauaversioon](https://www.mamedev.org/release.html)
2. Paigutada [JUKU püsivara ZIP](https://github.com/infoaed/juku3000/raw/refs/heads/master/roms/juku.zip) allalaaditud MAME `roms` kataloogi
3. Käivitada MAME, valida süsteemiks JUKU E5104 ja EKDOS 2.30
4. Kinnitada, et JUKU käivitatakse vaikimisi püsivaraga RomBios 3.43m
5. Süsteemi omaduste kuvamise järel lastakse uunikumile vool sisse

Kuvarile ilmub püsimonitori teade `RomBios`, monitori versiooninumber ja viip `∗`, mille järel kutsuvalt vilgub sisestuskursor:

[![EKDOS 2.30 alglaadimine püsimonitorist Rombios 3.43m juhtklahvidega «T», «D», «D»](/images/jukubuut.gif)](https://commons.wikimedia.org/wiki/File:Juku_E5101_booting_up_EKDOS_2.30,_displaying_readme_file_on_screen.webm)

JUKU E5104 opsüsteemi EKDOS alglaadimiseks tuleb vajutada `T`, `D`, `D`, täpsemad opsüsteemi juhised [leiad siit](https://github.com/infoaed/juku3000/blob/master/docs/juku-k%C3%A4sud.md).

## Juku tarkvara käivitamine

Ent mis kasu on paljast opsüsteemist ilma tarkvarata? Tarkvara lisamiseks tuleb laadida alla mõni JUKU flopiketas nt Elektroonikamuuseumi [JUKU failivaramust](https://elektroonikamuuseum.ee/failid/juku/tarkvara/).

Flopiketta kasutamiseks tuleb see emuleeritud JUKUsse sisestada. Selleks on vaja lahti lukustada MAME süsteemiklahvid `Scroll Lock` abiga (tuntud ka kui `MAME Lock`), mille järel saab avada [MAME süsteemimenüü](https://docs.mamedev.org/usingmame/mamemenus.html) vajutades `Tab`.

Flopisid ehk `JUK` faile saab lisada `File Manageri` alt ja esimesteks katsetusteks võiks olla sobiv mõni flopi `JUKGAME`/`JUKPROG` seeriast, aga miks mitte ka veebiemulaatori [`GAME1.JUK`](https://infoaed.ee/juku/game1.juk) või [`PROG1.JUK`](https://infoaed.ee/juku/prog1.juk).

MAME flopimenüü | Kultusmäng INDY
:-------------------------:|:-------------------------:
[![Scroll Locki (tuntud ka kui MAME Lock) vajutamise järel saab TABiga avada MAME flopimenüü](/images/mame-flopimenyy.png)](https://docs.mamedev.org/usingmame/mamemenus.html)  |  [![](/images/indy-game.png)](https://elektroonikamuuseum.ee/juku_arvuti_tarkvara_mang_indy.html)

Sisestatud kettaid saad EKDOSis vahetada viiba järele kettatähise ja kooloni kirjutamisega (nt `A:` või `B:`), tarkvara ehk `COM`-laadefaile saad käivitada sisestades viiba järele soovitud programmi nime. Failide nimekirja kettal näitab käsklus `DIR`. Süsteemi töökorras olemise kontrolliks võid proovida, kas saad `GAME1.JUK` kettalt käima [tuntud JUKU mängu INDY](https://elektroonikamuuseum.ee/juku_arvuti_tarkvara_mang_indy.html).

JUKU tarkvara kataloogi koos kirjeldustega leiad [siit](tarkvara-kataloog.md).

Kui soovid katsetada JUKUl programmeerimist, võid lapata läbi [slaidid JUKU tarkvara ökosüsteemist](https://p6drad-teel.net/~p6der/juku-hingeelu_2024_videota.pdf) ning seejärel proovida ketast [`TERE.JUK`](https://github.com/infoaed/juku3000/raw/refs/heads/master/src/juhan/tere.juk).

----

_Kes minevikku ei mäleta, elab tulevikuta!_ -- Juhan Liiv
