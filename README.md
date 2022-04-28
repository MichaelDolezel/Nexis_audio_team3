# Nexys mono audio and PWM

### Team members

* Michael Doležel (Reponsible for Read me and presentation)
* Josepe Komár (Responsible programing display and assistence)
* Jan Gross (Responsible main programmer)

### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Seven segment display](#7seg)
* [Presentation](#Presentation)
* [Conclusion](#Conclusion)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Nexys board mono audio output and PWM sound generation. Generate basic signals and/or audio samples.
- [x] Programm PWM 
- [x] Send PWM signal to nexis mono audio output 
- [x] Play frequency from audio output 
- [X] Use switches to change frequency
- [X] Use display to show which frequency is is played

<a name="hardware"></a>

## Hardware description

![NEXIS](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/55c8a85e83d038743d6e73572ef6b09657bc0c3a/Images/NEXIS.webp)

We used Nexys A7-50T board which is a ready-to-use digital circuit development platform designed to bring additional industry applications into the classroom environment. The Artix-7 FPGA is optimized for high-performance logic and offers more capacity, higher performance, and more resources than earlier designs. With its large, high-capacity FPGA and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, a temperature sensor, MEMs digital microphone, speaker amplifier, and plenty of I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.

For our audio output, we used a PWM module and Mono audio output inside of Nexys A7-50T

### PWM
A pulse-width-modulated (PWM) signal is a chain of pulses at some fixed frequency, with each pulse potentially having a different width. In our project, we defined PWM as a series of ones and zeroes to simulate sin wave with average voltage power

![PWM_sin](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/cdd420cd77fd5c92d149b2df3138ece0ead66427/Images/PWMsin.gif)

![PWM](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/530bbdf4d08f2d4a06117ef1224f8c023a193075/Images/pwm.png)
 
 This how we defined PWM sin signal in our code
 ```
 s_bpwm <= "0000011000000111100001111110001111111100111111111111111111110011111111000111111000011110000001100000";
 ```
This signal is sended to mono audio output
![PWM_RUN](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/d698a5aaf73def34203ece4286601769a9bacf8b/Images/PWM_run.png)
*click for higher quality*


This is our PWM to SIN wave measured by oscilloscope
![PWM_RUN](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/cd30675920f1173972ab62ab81257ebf6e5db358/Images/SIN_osc.png)


### Mono audio output
The on-board audio jack is driven by a Sallen-Key Butterworth Low-pass 4th Order Filter that provides mono audio output. The circuit of the low-pass filter is shown in lower Figure. A digital input is in our case pulse-width modulated (PWM) open-drain signal produced by the FPGA. The signal needs to be driven low for logic ‘0’ and left in high-impedance for logic ‘1’.

![audio_output](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/ad62c287599a18863b616133deb6df3945e61855/Images/audio_out.png)

from our PWM output we sending digital signal to AUD_PWM and then sound of specified frequenci is created 

<a name="modules"></a>

## VHDL modules description and simulations
<a name="top"></a>

### VHDL SCHEME
![audio_output](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/main/Images/schematic1.png)
*click for higher quality*

### Clock enable

dwdawdawdawdawda

![Clock enable](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/main/Images/clock_enable1.png)

![tb_clock_enable](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/58db1edd96f7bf318f3bdf637d427c6af9df9508/Images/tb_clock_enable%20.png)

 
 
### Counter up down

awdawdawdawdawd 

![Counter up down](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/main/Images/cnt_up_down1.png)

![tb_cnt_up_down](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/58db1edd96f7bf318f3bdf637d427c6af9df9508/Images/tb_cnt_up_down.png)



### PWM

wdawdasegrftjtzj

![PWM](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/main/Images/PWM1.png)

![PWM_RUN](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/d698a5aaf73def34203ece4286601769a9bacf8b/Images/PWM_run.png)


```
   s_bpwm <= "0000011000000111100001111110001111111100111111111111111111110011111111000111111000011110000001100000";

    p_cnt_up_down : process(clk)
    begin                
        if rising_edge(clk) then    -- Synchronous process
--reset  
            if (reset = '1') then                       -- High active reset 
                cnt_local <= 0; -- Clear all bits
                PWM_o       <= '0';                    -- Set output to low
            end if; 
--            
            if   (freq_step_i = "0001") then clk_loop <= 10000; f_disp_o <= 100;            
            elsif(freq_step_i = "0010") then clk_loop <= 5000;  f_disp_o <= 200;
            elsif(freq_step_i = "0011") then clk_loop <= 3333;  f_disp_o <= 300;
            elsif(freq_step_i = "0100") then clk_loop <= 2000;  f_disp_o <= 500;
            elsif(freq_step_i = "0101") then clk_loop <= 1250;  f_disp_o <= 800;
            elsif(freq_step_i = "0110") then clk_loop <= 1000;  f_disp_o <= 1000;
            elsif(freq_step_i = "0111") then clk_loop <= 500;   f_disp_o <= 2000;
            elsif(freq_step_i = "1000") then clk_loop <= 200;   f_disp_o <= 5000;
            elsif(freq_step_i = "1001") then clk_loop <= 125;   f_disp_o <= 8000;
            elsif(freq_step_i = "1010") then clk_loop <= 100;   f_disp_o <= 10000;
            elsif(freq_step_i = "1011") then clk_loop <= 67;    f_disp_o <= 15000;       
            else  
                clk_loop <= 1000; f_disp_o <= 1000;
            end if;    
--   
            ctn_pwm_loc <= ctn_pwm_loc + 1;             --frequency when to play 100 bits
                if (ctn_pwm_loc = clk_loop) then
                    if (cnt_local = 100) then
                        cnt_local <= 1;                            
                    else
                        PWM_o <=  s_bpwm(cnt_local);    --reads bits one after another
                        cnt_local <= cnt_local + 1;     --increment every loop                                  
                    end if;
                    ctn_pwm_loc <= 0;
                end if;
        end if;
    end process p_cnt_up_down;
 ```

### Seven segment display

![8-digit driver testbench for 7seg](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/12781211ea2ced8741e33b7a120736073e1b5053/Images/8-digit%20driver%20testbench%20for%207seg%20.png)

![8digit addon](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/12781211ea2ced8741e33b7a120736073e1b5053/Images/8digit%20addon.png)

## TOP module description and simulations
Top module 
![Top module] ()

```
important code 1;
 ```
 
 
```
important code 2;
 ```
 
 ```
important code 3;
 ```
 
 ## Seven segment display
<a name="7seg">
 
On the left is number from the table below and on the right part is a frequency
 
 ###### For 100Hz
 
![7segm_100Hz](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/f28a9680544e8c146b08051935da4f34bbadbde0/Images/7segm_100Hz.jpg)
 
 ###### For 15000 Hz
 
![7segm_1500Hz](https://github.com/MichaelDolezel/Nexys_audio_team3/blob/1f049542906e1784e22b6be0b1a1250f6f9281da/Images/7segm_15000Hz.jpg)
 
 
| **number on 7seg** | **frequency [Hz]** |**period [s]** | 
| :-: | :-: | :-: |
| 1 | 100 | 0,01 |
| 2 | 200 | 0,005 |
| 3 | 300 | 0,0033 |
| 4 | 500 | 0,002 |
| 5 | 800 | 0,00125 |
| 6 | 1000 | 0,001 |
| 7 | 2000 | 0,0005 |
| 8 | 5000 | 0,0002 | 
| 9 | 8000 | 0,000125 |
| a | 10000 | 0,0001 |
| b | 15000 | 0,000066 |

 
 
 
 ```
important code;
 
 ```
 
 
 
 

 
 
 
 
 
 
 
 

<a name="Presentation"></a>
## Presentation video  

This is link to our presentation [Presentation](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

 <a name="Conclusion"></a>
 
## Conclusion
 
 
 erfqawefawsefwefwsergwergergergr
 fgergerg
 erg
 erg
 erg
 ergerg
 edrger
 gerg
 
 
<a name="references"></a>

## References

1. We gathered some info about Nexis modules from this reference manual [Nexys A7 Reference Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
