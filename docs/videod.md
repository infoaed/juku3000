# JUKU videote korrektne salvestamine

Põhiline on valida JUKU ekraanivideote autentseks kuvamiseks mõni kasutatava kuvaresolutsiooni täisarvu kordne. Kui JUKU vaikimisi resolutsioon on 320x240, siis võimalikud on resolutsooonid:

* 640x480
* 960x720
* 1280x960
* 1600x1200
* ...

Kui JUKU programm kasutab mõnda vaikimisi lahutusest erinevat resolutsiooni (nt 384x200, 400x192, 256x192 vmt), tuleks mõistagi valida selle kordne.

[Kasutades MAME sisemist ekraanivideo salvestamist](https://docs.mamedev.org/usingmame/defaultkeys.html) (Scroll Lock -> Left Control+Left Shift+F12) on kõige lihtsam määrata [salvestamise parameetrid](https://docs.mamedev.org/commandline/commandline-all.html#mame-commandline-snapsize) käsurealt, nt `-snapsize 960x720` ja lisaks `-nosnapbilinear`, sest tahame säilitada video pikselilise stuktuuri ega taha näha fontidel/graafikal udustatud servasid (sama asi kasutajaliideses `General Settings` -> `Advanced Options` -> `Bilinear filtering for snapshots`).

Selge JUKU&nbsp;&nbsp;&nbsp; |  Udune JUKU
:-------------------------:|:-------------------------:
![pilt](https://github.com/user-attachments/assets/a42086ab-e781-4b09-97e4-03299d99d6cf) | ![pilt](https://github.com/user-attachments/assets/6b213717-2d28-4402-a6c8-f7f3d53d3cac)

Siiski võib olla jõudluse mõttes tark piirduda parameetriga `-snapsize auto`, jätta video skaleerimata ja kasutadagi arhiveerimiseks algset resolutsiooni. Sel juhul saab video teisendada eksponeerimiseks vajalikku resolutsiooni näiteks [FFmpegi abil](http://trac.ffmpeg.org/wiki/Scaling#Specifyingscalingalgorithm):

```
ffmpeg -i mame_originaal.avi -vf scale=960:720 -sws_flags neighbor eksponeeritav_video.mp4
```

FFMPEG parameetritest `-sws_flags neighbor` keelab skaleerimisel udustavate filtrite kasutamise samamoodi nagu MAME võti `-nosnapbilinear`. Sõltuvalt video kasutamise otstarbest võib olla vaja lisada muid parameetreid, nt Twitter/X tahab, et videod oleks kindlas värvirežiimis `-pix_fmt yuv420p`.

Ilmselt on enamikus tõsistest tööriistadest sarnased valikud olemas, kuid MAME enda vahendite kasutamine on kõige kindlam -- eriti head jõudlust vajavatel juhtudel saab kasutada ka [`record` ja `playback` vahendeid](https://docs.mamedev.org/commandline/commandline-all.html#core-state-playback-options).
