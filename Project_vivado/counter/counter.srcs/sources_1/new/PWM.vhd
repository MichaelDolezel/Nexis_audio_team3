----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2022 22:08:01
-- Design Name: 
-- Module Name: PWM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PWM is
    Port ( freq_step_i : in STD_LOGIC_VECTOR(4 - 1 downto 0);   --freqency step/speed to choose from table of clk speeds
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           PWM_o : out STD_LOGIC;               --PWM signal output
           f_disp_o : out natural:= 0);         --output number of chosen frequency
           
end PWM;

architecture Behavioral of PWM is
    signal cnt_local : natural:= 0;         --loop of 100 to play bits of period
    signal s_bpwm : std_logic_vector(100 - 1 downto 0); --100 bits of period
    signal ctn_pwm_loc : natural:= 0;       --freqency
    signal clk_loop : natural:= 0;          --num of clocks => frequency
   
begin
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
                        PWM_o <=  s_bpwm(cnt_local);    --postupne jeden po druhem prochazoo sinus bity
                        cnt_local <= cnt_local + 1;     --postupne posita nahoru kazdou nastupnou hranu                                      
                    end if;
                    ctn_pwm_loc <= 0;
                end if;
        end if;
    end process p_cnt_up_down;
end Behavioral;
