TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += MC2000BSupport

# Compile and add code to the support library
MC2000BSupport_SRCS += xxxRecord.c
MC2000BSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
MC2000BSupport_SRCS += dbSubExample.c
MC2000BSupport_SRCS += devMC2000BVersion.c
MC2000BSupport_SRCS += MC2000BHello.c
MC2000BSupport_SRCS += initTrace.c

MC2000BSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = MC2000BVersion.h
# Macro name
GENVERSIONMACRO = MC2000BVERSION

# Build the IOC application
PROD_IOC = MC2000B

# MC2000B.dbd will be created and installed
DBD += MC2000B.dbd

# MC2000B.dbd will include these files:
MC2000B_DBD += base.dbd
MC2000B_DBD += xxxSupport.dbd
MC2000B_DBD += dbSubExample.dbd
MC2000B_DBD += devMC2000BVersion.dbd
MC2000B_DBD += MC2000BHello.dbd
MC2000B_DBD += initTrace.dbd
MC2000B_DBD += asyn.dbd
MC2000B_DBD += drvAsynIPPort.dbd
MC2000B_DBD += drvAsynSerialPort.dbd
MC2000B_DBD += calc.dbd
MC2000B_DBD += stream-scalcout.dbd
MC2000B_DBD += stream.dbd
MC2000B_DBD += asSupport.dbd

# MC2000B_registerRecordDeviceDriver.cpp derives from MC2000B.dbd
MC2000B_SRCS += MC2000B_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
MC2000B_SRCS_DEFAULT += MC2000BMain.cpp
MC2000B_SRCS_vxWorks += -nil-

# Link in the code from our support library
MC2000B_LIBS += MC2000BSupport
MC2000B_LIBS += asyn
MC2000B_LIBS += calc
MC2000B_LIBS += autosave
MC2000B_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into MC2000BSupport
    sncExample_SNCFLAGS += +r
    MC2000B_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    MC2000BSupport_SRCS += sncExample.stt
    MC2000BSupport_LIBS += seq pv
    MC2000B_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    MC2000B_LIBS += qsrv
    MC2000B_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    MC2000B_DBD += PVAServerRegister.dbd
    MC2000B_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
MC2000B_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devMC2000BVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
