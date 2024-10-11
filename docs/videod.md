# JUKU videote korrektne salvestamine

Põhiline on valida JUKU ekraanivideote autentseks kuvamiseks mõni kasutatava kuvaresolutsiooni kordne. Kui JUKU vaikimisi resolutsioon on 320x240, siis võimalikud on resolutsooonid:

* 640x480
* 960x720
* 1280x960
* 1600x1200
* ...

Kui JUKU programm kasutab mõnda vaikimisi lahutusest erinevat resolutsiooni, tuleks mõistagi valida selle kordne.

[Kasutades MAME sisemist ekraanivideo salvestamist](https://docs.mamedev.org/usingmame/defaultkeys.html) (Scroll Lock -> Left Control+Left Shift+F12) on kõige lihtsam määrata [salvestamise parameetrid](https://docs.mamedev.org/commandline/commandline-all.html#mame-commandline-snapsize) käsurealt, nt `-snapsize 960x720` ja lisaks `-nosnapbilinear`, sest tahame säilitada video pikselilise stuktuuri ega taha näha fontidel/graafikal udustatud servasid.

Siiski võib olla jõudluse mõttes tark piirduda parameetriga `-snapsize auto`, jätta video skaleerimata ja kasutadagi arhiveerimiseks algset resolutsiooni. Sel juhul saab video teisendada eksponeerimiseks vajalikku resolutsiooni näiteks [FFmpegi abil](http://trac.ffmpeg.org/wiki/Scaling#Specifyingscalingalgorithm):

> `ffmpeg -i mame_originaal.avi -vf scale=960:720 -sws_flags neighbor eksponeeritav_video.mp4`

FFMPEG parameetritest `-sws_flags neighbor` keelab skaleerimisel udustavate filtrite kasutamise samamoodi nagu MAME võti `-nosnapbilinear`.
