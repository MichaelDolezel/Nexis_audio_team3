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
* [Video](#video)
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



### Mono audio output

<a name="modules"></a>

## VHDL modules description and simulations

Write your text here.

<a name="top"></a>

## TOP module description and simulations

Write your text here.

<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

1. Write your text here.
