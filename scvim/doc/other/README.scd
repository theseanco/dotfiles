
if you have previously used these ugens, make sure to delete pre-existing bhob*.scx and class files.  some filenames may have changed, so the old ones may not be overwritten.


put the files in the plugins folder into your sc3 plugins folder.  put the files in the classes folder into your SCClassLibrary folder.  put the files in the help folder in your sc3 Help folder.  restart SC3 or just rebuild the library (command-k).  


included are:

MoogLadder
RLPFD
Streson
NLFilt
NestedAllpass
DoubleNestedAllpass
LoShelf
HiShelf

Gendy4, 5
TGrains2
TGrains3
GaussTrig
LFBrownNoise0, 1, 2
TGaussRand
TBrownRand
TBetaRand
Dbrown2
Dgauss

PV_CommonMag
PV_CommonMul
PV_MagMinus
PV_MagScale
PV_MagGate
PV_XFade
PV_Morph
PV_SoftWipe
PV_Cutoff
PV_Compander

Henon2DN/L/C
HenonTrig
Standard2DN/L/C
StandardTrig
Gbman2DN/L/C
GbmanTrig
Lorenz2DN/L/C
LorenzTrig
Latoocarfian2DN/L/C
LatoocarfianTrig
Fhn2DN/L/C
FhnTrig

Phenon
Pstandard
Platoo
Plorenz
Pquad
PlinCong
Pgbman
Pfhn

issues: 
Plorenz does not have a normalize argument (it does it automatically) because it was always returning nil even when a default value of true (or false) was given.  this may be a bug related to the number of arguments?