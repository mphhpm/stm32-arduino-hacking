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
##    1-4-2024: mphhpm: initial version
Q=@
export PROJECT = stm32-arduino
export PROJECT_ROOTDIR=$(abspath .)
export BUILD_ROOTDIR=$(PROJECT_ROOTDIR)/build/$(PROJECT)
##
## set verbosity as required
Make=make
#export V= 99

all: build-project
	
build-project:
	$(Q)$(MAKE) -j 8 --directory $(TARGETPROJECT_DIR) all

clean-project:
	$(Q)$(MAKE) --directory $(TARGETPROJECT_DIR) clean

flash: build-project
	$(Q)$(MAKE) --directory $(TARGETPROJECT_DIR) flash
