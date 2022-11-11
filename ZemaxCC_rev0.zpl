

!various housekeeping tasks
n = NSUR()

! scale is used to convert lens units to microns. Default is mm (units=0)
scale=1000
units = unit()
if units==0 then scale=1000   # mm
if units==1 then scale=10000  # cm
if units==2 then scale=25400  # inches
if units==3 then scale=1000000  # meters
  
pi = 3.1415926535897932384626433832795

primWave = PWAV()
wavlen = WAVL(primWave)

! collect user inputs 

input1 = PVHX()
input2 = PVHY()
input3 = PVPX()
input4 = PVPY()
input5 = PVEX()
input6 = PVEY()

! assignments
! ray A
rayASurf = input1
rayAfield = input2
rayAraynum = input3
!ray B
rayBSurf = input4
rayBfield = input5
rayBraynum = input6

! block of code to get normalized field coordinates
maxfield = MAXF()

! --------------------- RAY A TRACE -----------------------------
fieldX = FLDX(rayAfield)/maxfield
fieldY = FLDY(rayAfield)/maxfield

pupilX = 0
pupilY = 0

if (rayAraynum==2)
    pupilX = 0
    pupilY = 1
endif

if (rayAraynum==3)
    pupilX = 0
    pupilY = -1
endif

if (rayAraynum==4)
    pupilX = 1
    pupilY = 0
endif

if (rayAraynum==5)
    pupilX = -1
    pupilY = 0
endif

raytrace fieldX, fieldY, pupilX, pupilY, primWave

zA = RAGZ(rayAsurf)
yA = RAGY(rayAsurf)
cost = RAGN(rayAsurf)
sint = RAGM(rayAsurf)

! ------------------- RAY B TRACE -------------------
fieldX = FLDX(rayBfield)/maxfield
fieldY = FLDY(rayBfield)/maxfield

pupilX = 0
pupilY = 0

if (rayBraynum==2)
    pupilX = 0
    pupilY = 1
endif

if (rayBraynum==3)
    pupilX = 0
    pupilY = -1
endif

if (rayBraynum==4)
    pupilX = 1
    pupilY = 0
endif

if (rayBraynum==5)
    pupilX = -1
    pupilY = 0
endif

raytrace fieldX, fieldY, pupilX, pupilY, primWave

zB = RAGZ(rayBsurf)
yB = RAGY(rayBsurf)

dist = cost * (yB-yA) - sint * (zB-zA)

OPTRETURN 0, dist
!OPTRETURN 1, zA ! return the Z a intercept 
!OPTRETURN 2, yA ! return the Y A intercept
!OPTRETURN 3, cost ! return the N direction cosine of ray A
!OPTRETURN 4, sint ! return the M direction cosine of ray B
!OPTRETURN 5, zB ! return the Z b intercept
!OPTRETURN 6, yB ! return the y b intercept

! TODO: figure out how to write a function within a macro and
!       functionalize the above block
! TODO: assign x, y, z, l, m, and n coords to variables
! TODO: do calculation as in JMRCC
! TODO: report output