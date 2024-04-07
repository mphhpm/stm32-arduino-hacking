:: Run this as adminstrator
@echo creating links

@mklink /D arduino-lib %HOMEDRIVE%%HOMEPATH%\Documents\Arduino
@mklink /D stm-arduino-lib %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\hardware\stm32\2.7.0
@mklink /D stm-tools %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\tools
@mklink /D STM32F411xE %LOCALAPPDATA%\Arduino15\packages\STMicroelectronics\hardware\stm32\2.7.0\variants\STM32F4xx\F411C(C-E)(U-Y
