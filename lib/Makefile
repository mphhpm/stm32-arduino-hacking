##
##    Copyright (c) 2024 mphhpm.
##    Permission is hereby granted, free of charge, to any person obtaining
##    a copy of this software and associated documentation files (the "Software"),
##    to deal in the Software without restriction, including without limitation
##    the rights to use, copy, modify, merge, publish, distribute, sublicense,
##    and/or sell copies of the Software, and to permit persons to whom the Software
##    is furnished to do so, subject to the following conditions:
##
##    The above copyright notice and this permission notice shall be included in
##    all copies or substantial portions of the Software.
##
##    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
##    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
##    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
##    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
##    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
##    OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##
##    Changes
##    2-Feb-2024: mphhpm: initial version
##

include ../Makefile.toolchain
include ../Makefile.STM32F4xx
include ../Makefile.flags
include ../Makefile.Arduino

Q=@
LIBNAME     = lib$(PROJECT_ARDUINO_LIB).$(VARIANT)
BUILD_DIR   = $(OUTPUT_ARDUINO_LIBROOTDIR)/obj
DEPDIR      = $(BUILD_DIR)/.deps

##
## the very important startup file
LIBASFILES   = stm-arduino-lib/cores/arduino/stm32/startup_stm32yyxx.S
##
## stm32 wrapper files
LIBCPPFILES  = $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/SrcWrapper/src -type f -name "*.cpp" )))
LIBCPPFILES += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/SPI/src -type f -name "*.cpp")))
LIBCPPFILES += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/Wire/src -type f -name "*.cpp")))
LIBCPPFILES += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/cores -type f -name "*.cpp")))
LIBCPPFILES += $(sort $(wildcard $(shell $(FIND) STM32F411xE -type f -name "*.cpp" -follow)))
LIBCPPFILES += $(ADAFRUIT_CPPFILES)
#$(info $$(LIBCPPFILES) $(LIBCPPFILES))

LIBCFILES    = $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/SrcWrapper/src -type f -name "*.c")))
LIBCFILES   += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/SPI/src -type f -name "*.c")))
LIBCFILES   += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/libraries/Wire/src -type f -name "*.c")))
LIBCFILES   += $(sort $(wildcard $(shell $(FIND) stm-arduino-lib/cores -type f -name "*.c")))
LIBCFILES   += $(sort $(wildcard $(shell $(FIND) STM32F411xE -type f -name "*.c" -follow)))
#$(info $$(LIBCFILES) $(LIBCFILES))
LIBCFILES   += $(ADAFRUIT_CFILES)
##
## prepare the list of oobject files
LIBOBJS     = $(addprefix $(BUILD_DIR)/, $(sort $(notdir $(LIBASFILES:%.S=$(BUILD_DIR)/%.o))))
LIBOBJS    += $(addprefix $(BUILD_DIR)/, $(sort $(notdir $(LIBCPPFILES:%.cpp=$(BUILD_DIR)/%.o))))
LIBOBJS    += $(addprefix $(BUILD_DIR)/, $(sort $(notdir $(LIBCFILES:%.c=$(BUILD_DIR)/%.o))))
#$(info $$(LIBOBJS) $(LIBOBJS))

DEPFILES    = $(addprefix $(DEPDIR)/, $(notdir $(LIBASFILES:%.S=$(DEPDIR)/%.d)))
DEPFILES   += $(addprefix $(DEPDIR)/, $(notdir $(LIBCPPFILES:%.cpp=$(DEPDIR)/%.d)))
DEPFILES   += $(addprefix $(DEPDIR)/, $(notdir $(LIBCPPFILES:%.c=$(DEPDIR)/%.d)))

VPATH       = $(sort $(dir $(LIBASFILES) $(LIBCPPFILES) $(LIBCFILES)))
##
## prepare the path where to look for include files, assuming the folders containing source files contain include files as well
INCLUDES    = $(patsubst %,-I%, $(sort . $(dir $(LIBASFILES) $(LIBCPPFILES) $(LIBCFILES) $(ADAFRUIT_INCLUDE) $(shell $(FIND) stm-arduino-lib/cores -type f -name "*.h" -follow))))
##
## extend the search path with some other folders to look into
INCLUDES   += -Istm-arduino-lib/system/Drivers/CMSIS/Device/ST/$(VARIANT)/Include \
              -Istm-arduino-lib/system/Drivers/CMSIS/Device/ST/$(VARIANT)/Source/Templates/gcc \
              -Istm-tools/CMSIS/5.9.0/CMSIS/Core/Include \
              -Istm-arduino-lib/system/Drivers/$(VARIANT)_HAL_Driver/Inc/ -Istm-arduino-lib/system/$(VARIANT) \
              -Istm-arduino-lib/system/Drivers/$(VARIANT)_HAL_Driver/Src/ \
              -Istm-arduino-lib/variants/$(VARIANT)/"F411C(C-E)(U-Y)"
              
DEPFLAGS    = -MT $@ -MMD -MP -MF $(DEPDIR)/$(notdir $*).d
ADDFLAGS    = $(DEPFLAGS) $(INCLUDES) $(DEFINES)
ASFLAGS    += $(ADDFLAGS)
CPPFLAGS   += $(ADDFLAGS)
CFLAGS     += $(ADDFLAGS)
 
include ../Makefile.rules

all: $(OUTPUT_ARDUINO_LIBDIR)/$(LIBNAME).a

$(OUTPUT_ARDUINO_LIBDIR)/$(LIBNAME).a: $(DEPDIR) $(LIBOBJS)
	$(Q)printf "  [AR]    $(LIBNAME).a\n"
	$(Q)mkdir -p $(dir $@)
	$(Q)$(AR) $(ARFLAGS) "$@" $(LIBOBJS)

$(DEPDIR): 
	$(Q)mkdir -p $@

$(DEPFILES): $(DEPDIR)

clean:
	$(Q)$(RM) -rf $(OUTPUT_ARDUINO_LIBROOTDIR)

-include $(wildcard $(DEPFILES))
