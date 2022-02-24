#!../../bin/linux-x86_64/MC2000B

#- You may have to change MC2000B to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/MC2000B.dbd"
MC2000B_registerRecordDeviceDriver pdbbase

## Load record instances
epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/MC2000BApp/Db")
epicsEnvSet ("PREFIX", "SLAC:MC2000B:")
epicsEnvSet ("PORT", "serial1")


drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","115200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")
asynSetTraceIOMask("serial1",0,ESCAPE)
asynSetTraceMask("serial1",0,DRIVER|ERROR)

dbLoadRecords ("${TOP}/MC2000BApp/Db/MC2000B.db", "P=$(PREFIX), PORT=serial1")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:MC2000B:")
dbLoadRecords ("$(SSCAN)/db/scan.db", "P=$(PREFIX),MAXPTSI=2000,MAXPTS2=200,MAXPTS3=20,MAXPTS4=10,MAXPTSH=10")
#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=quan"
