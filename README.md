# Nexys mono audio and PWM

### Team members

* Michael Doležel (responsible for Read me and presentation)
* Josepe Komár (responsible programming support consutant)
* Jan Gross (responsible main superior senior daddy programmer)

### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Presentation](#Presentation)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Nexys board mono audio output and PWM sound generation. Generate basic signals and/or audio samples.

<a name="hardware"></a>

## Hardware description

We used Nexys A7-50T board whitch is a ready-to-use digital circuit development platform designed to bring additional industry applications into the classroom environment. The Artix-7 FPGA is optimized for high-performance logic, and offers more capacity, higher performance, and more resources than earlier designs. With its large, high-capacity FPGA and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, a temperature sensor, MEMs digital microphone, speaker amplifier, and plenty of I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.

For our audio output we used PWM module and Mono audio output inside of Nexys A7-50T
### PWM
A pulse-width modulated (PWM) signal is a chain of pulses at some fixed frequency, with each pulse potentially having a different width.
In our project we defined PWM as series of ones and zeroes to simulate sin wave with averadge voltage power

![PWM_sin](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/cdd420cd77fd5c92d149b2df3138ece0ead66427/Images/PWMsin.gif)
![PWM](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/530bbdf4d08f2d4a06117ef1224f8c023a193075/Images/pwm.png)
 
 This how we defined PWM sin signal in our code
 ```
 s_bpwm <= "0000011000000111100001111110001111111100111111111111111111110011111111000111111000011110000001100000";
 ```
This signal is sended to mono audio output
![PWM_RUN](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/d698a5aaf73def34203ece4286601769a9bacf8b/Images/PWM_run.png)
*click for higher quality*




### Mono audio output
The on-board audio jack is driven by a Sallen-Key Butterworth Low-pass 4th Order Filter that provides mono audio output. The circuit of the low-pass filter is shown in lower Figure. A digital input is in our case pulse-width modulated (PWM) open-drain signal produced by the FPGA. The signal needs to be driven low for logic ‘0’ and left in high-impedance for logic ‘1’.

![audio_output](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/ad62c287599a18863b616133deb6df3945e61855/Images/audio_out.png)

from our PWM output we sending digital signal to AUD_PWM and then sound of specified frequenci is created 

<a name="modules"></a>

## VHDL modules description and simulations
<a name="top"></a>

### VHDL SCHEME
![audio_output](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/d698a5aaf73def34203ece4286601769a9bacf8b/Images/Scheme.png)
*click for higher quality*

### Clock enable
![Clock enable](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/bd8b3f53d76be3a4d1693efeadb40d7b3a84344a/Images/Clock_enable.png)

```
important code;
 ```
 
 
### Counter up down
![Counter up down](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/bd8b3f53d76be3a4d1693efeadb40d7b3a84344a/Images/counter%20up%20down.png)

```
important code;
 ```


### PWM
![PWM](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/bd8b3f53d76be3a4d1693efeadb40d7b3a84344a/Images/PWM_module.png)

```
important code;
 ```


## TOP module description and simulations
Top module 
![Top module]()

```
important code 1;
 ```
 
 
```
important code 2;
 ```
 
 ```
important code 3;
 ```




## Presentation video

<a name="Presentation"></a>

This is link to our presentation [Presentation](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

## References

1. We gathered some info about Nexis modules from this reference manual [Nexys A7 Reference Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
