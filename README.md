# stm32-arduino-hacking
```
ssd1306 display with a blackpill board stm32f411 

```
## Helpful documents
```
RM0383 Reference manual STM32F411xC/E advanced Arm®-based 32-bit MCUs
STM32F411xC STM32F411xE Arm® Cortex®-M4 32b MCU+FPU, 125 DMIPS, 512KB Flash, 128KB RAM, USB OTG FS, 11 TIMs, 1 ADC, 13 comm. interfaces
```

## Tools ##
```
os : windows
to be installed :
    make, gcc & friends : https://xpack.github.io/dev-tools/arm-none-eabi-gcc
    ide : https://www.eclipse.org
    arduino : www.arduino.cc
    st-link : https://www.st.com/en/development-tools/st-link-v2.html, alixepress
```

## Folders ###
```
Project
  +---src
  |    +---arduino project folder [e.g. ssd1306_128x32s], rename *.ino to *.cpp
  |    
  +---lib
  |    +--arduino-lib        [soft link to the arduino libraries folder, e.g. mklink /D arduino-lib %HOMEDRIVE%%HOMEPATH%\Documents\Arduino]
  |    +--stm-arduino-lib    [soft link to the stm32 wrapper folder, e.g.  mklink /D stm-arduino-lib %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\hardware\stm32\2.7.0]
  |    +--stm-tools          [soft link to the stm32 tools folder, e.g.  mklink /D stm-tools %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\tools]
  |    +--STM32F411xE        [soft link to STM32F411xE variant specific definitions folder, e.g. mklink /D STM32F411xE %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\hardware\stm32\2.7.0\variants\STM32F4xx\F411C(C-E)(U-Y)]
                             since some tools have some dificulties to keep up with the very creative naming of folders e.g. F411C(C-E)(U-Y)
  |
  +---build
       +--stm32-arduino      build output of the projects
       |    +--ssd1306_128x32s
       |
       +--stm32-arduino-lib
            +--variant       [e.g. stm32f4xx]
                 +--lib      arduino library the projects to be linked to
```

# Eclipse #
```
Import the project into eclipse as 'Makefile project with existing code' and re-insert the build targets manually as they get removed during the import
Change the C/C++ build environment variables according to your setup
```
Happy hacking
```
