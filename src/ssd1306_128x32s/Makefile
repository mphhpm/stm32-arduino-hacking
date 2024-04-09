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
Q=@


##
## toolchain
include ../../Makefile.toolchain
include ../../Makefile.flags
include ../../Makefile.rules
include ../../Makefile.STM32F4xx
include ../../Makefile.Arduino


PROJECT        = ssd1306_128x32s
OUTPUT_ROOTDIR = $(BUILD_ROOTDIR)/$(PROJECT)
OUTPUT_DIR     = $(OUTPUT_ROOTDIR)/lib
BUILD_DIR      = $(OUTPUT_ROOTDIR)/obj
DEPDIR         = $(BUILD_DIR)/.deps
##
## find the various Adafruit soucre files, leave the examples aside
CPPFILES  = $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_BusIO -type f -name "*.cpp" | $(GREP) -vw examples)))
CPPFILES += $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_GFX_Library -type f -name "*.cpp" | $(GREP) -vw examples)))
CPPFILES += $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_SSD1306 -type f -name "*.cpp" | $(GREP) -vw examples)))

CFILES    = $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_BusIO -type f -name "*.c" | $(GREP) -vw examples)))
CFILES   += $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_GFX_Library -type f -name "*.c" | $(GREP) -vw examples)))
CFILES   += $(sort $(wildcard $(shell $(FIND) ../../lib/arduino-lib/Adafruit_SSD1306 -type f -name "*.c" | $(GREP) -vw examples)))
##
## project files to compile
INOFILES += ssd1306_128x32_i2c.ino
CPPFILES += SrcWrapper.cpp
#$(info $$(CPPFILES) $(CPPFILES))

LDLIBS     += -lstm32-arduino-lib.$(VARIANT)
##
## mcu specific script
LDSCRIPT    = $(PROJECT_ROOTDIR)/lib/stm-arduino-lib/variants/$(VARIANT)/"F411C(C-E)(U-Y)"/ldscript.ld
LDFLAGS     = -T$(LDSCRIPT)
LDFLAGS    += $(ARCH)
LDFLAGS    += -mthumb "@./build.opt"
LDFLAGS    += -Wl,--nostdlib
LDFLAGS    += -specs=nano.specs -specs=nosys.specs
LDFLAGS    += -Wl,--gc-sections -Wl,-Map,$(OUTPUT_DIR)/$(PROJECT).map -L $(OUTPUT_ARDUINO_LIBDIR)
LDFLAGS    += -Wl,--defsym=LD_FLASH_OFFSET=0x0 -Wl,--defsym=LD_MAX_SIZE=524288 -Wl,--defsym=LD_MAX_DATA_SIZE=131072 
LDFLAGS    += -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common
##
## dependencies
DEPFILES  = $(addprefix $(DEPDIR)/, $(notdir $(CFILES:%.c=$(DEPDIR)/%.d) $(CPPFILES:%.cpp=$(DEPDIR)/%.d) $(INOFILES:%.ino=$(DEPDIR)/%.d)))
DEPFLAGS  = -MT $@ -MMD -MP -MF $(DEPDIR)/$(notdir $*).d
##
## search path
VPATH     = $(sort $(dir $(CFILES) $(CPPFILES) $(INOFILES)))
INCLUDES  = $(patsubst %,-I%, $(sort .  $(dir $(CPPFILES) $(CFILES) $(INOFILES) $(shell $(FIND) . -type f -name '*.h*'))))
INCLUDES += $(ARDUINO_INCLUDES_SEARCHDIR)
##
## compiler flags
CPPFLAGS += $(DEPFLAGS) 
CPPFLAGS += $(INCLUDES) $(DEFINES) -DSSD1306_NO_SPLASH
CFLAGS   += $(INCLUDES) $(DEFINES) -DSSD1306_NO_SPLASH
##
## determine object files to be generated
OBJS  = $(addprefix $(BUILD_DIR)/, $(sort $(notdir $(CFILES:%.c=$(BUILD_DIR)/%.o) $(CPPFILES:%.cpp=$(BUILD_DIR)/%.o) $(INOFILES:%.ino=$(BUILD_DIR)/%.o))))
#$(info $$(OBJS) $(OBJS))

include ../../Makefile.rules

all: $(OUTPUT_DIR)/$(PROJECT).bin

$(OUTPUT_DIR)/$(PROJECT).elf: $(DEPDIR) $(OBJS)
	$(Q)printf "  [LD]\t$(notdir $@)\n"
	$(Q)$(shell $(MKDIR) -p $(dir $@))
	$(Q)$(LD) $(TGT_LDFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@

$(DEPDIR): 
	$(Q)$(shell $(MKDIR) -p $@)

$(DEPFILES): $(DEPDIR)

clean:
	$(Q)printf "\t[CLEAN]\n"
	$(Q)$(shell $(RM) -rf $(BUILD_DIR) $(OUTPUT_DIR))

-include $(wildcard $(DEPFILES))

