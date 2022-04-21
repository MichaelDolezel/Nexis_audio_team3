------------------------------------------------------------
--
-- N-bit Up/Down binary counter.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2019-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for n-bit counter
------------------------------------------------------------
entity cnt_up_down is
--    generic(
--       g_CNT_WIDTH : natural := 4 -- Number of bits for counter    NEJAK SE ZBAVIT§§§§§§§§§§§§§§§        
--    );
    port(
        clk       : in  std_logic;  -- Main clock
        reset     : in  std_logic;  -- on off
        btn_fUP   : in  std_logic;  -- btn for incrementing frequency
        btn_fDOWN : in  std_logic;  -- btn for decrementing frequency
--        en_i      : in  std_logic;  -- Enable input
--        cnt_up_i  : in  std_logic;  -- Direction of the counter
--        cnt_o     : out std_logic_vector(g_CNT_WIDTH - 1 downto 0);
        PWM_o       : out std_logic
    );
end entity cnt_up_down;

------------------------------------------------------------
-- Architecture body for n-bit counter
------------------------------------------------------------
architecture behavioral of cnt_up_down is

    -- Local counter
--    signal s_cnt_local : unsigned(g_CNT_WIDTH - 1 downto 0);

    signal s_cnt_local : natural:= 0;
    signal s_cnt_btn_locUP : natural:= 0;
    signal s_cnt_btn_locDW : natural:= 0;
    signal s_bpwm : std_logic_vector(100 - 1 downto 0);
    signal s_freq : natural:= 0;
    signal s_ctn_pwm_loc : natural:= 0;
    signal clk_loop : natural:= 0;
    

begin
    --------------------------------------------------------
    -- p_cnt_up_down:
    -- Clocked process with synchronous reset which implements
    -- n-bit up/down counter.
    --------------------------------------------------------
    p_cnt_up_down : process(clk)
    begin
        
        s_bpwm <= "1111110000111111111111111111100111111110011111100001111000000110000000110000000001100000000111100000";
        if rising_edge(clk) then    -- Synchronous process
--reset  
            if (reset = '1') then                       -- High active reset 
                s_cnt_local <= 0;                       -- Clear local counter
                PWM_o       <= '0';                    -- Set output to low
                s_freq      <= 1;
            end if;    
--ON OFF

--fequency up              
            if (btn_fUP = '1') then
                s_cnt_btn_locUP <= s_cnt_btn_locUP + 1;
                if (s_cnt_btn_locUP = 50000000) then        --local freq counter pocita do 100M pro delay 0.5s pri 100MHz clk
                    s_freq <= s_freq + 1;                   -- increment frequency
                    s_cnt_btn_locUP <= 0;                    --reset local freq counter
                end if;
            else
                s_cnt_btn_locUP <= 0;
            end if;    
--fequency down            
            if (btn_fDOWN = '1') then
                s_cnt_btn_locDW <= s_cnt_btn_locDW + 1;
                if (s_cnt_btn_locDW = 50000000) then        --local freq counter pocita do 100M pro delay 0.5s pri 100MHz clk
                    s_freq <= s_freq - 1;                   -- decrement frequency
                    s_cnt_btn_locDW <= 0;                    --reset local freq counter
                end if;
            else
                s_cnt_btn_locDW <= 0;
            end if;
                
                
            if   (s_freq = 1) then clk_loop <= 10000;
            elsif(s_freq = 2) then clk_loop <= 5000;
            elsif(s_freq = 3) then clk_loop <= 3333;
            elsif(s_freq = 4) then clk_loop <= 2000;
            elsif(s_freq = 5) then clk_loop <= 1250;
            elsif(s_freq = 6) then clk_loop <= 1000;
            elsif(s_freq = 7) then clk_loop <= 500;
            elsif(s_freq = 8) then clk_loop <= 333;
            elsif(s_freq = 9) then clk_loop <= 200;
            elsif(s_freq = 10) then clk_loop <= 125;
            elsif(s_freq = 11) then clk_loop <= 100;
            elsif(s_freq = 12) then clk_loop <= 67;           
            else  
                clk_loop <= 1000;
                s_freq <= 6;
            end if;    
--            case s_freq is
--              when 1    =>  clk_loop <= 10000;
--              when 2    =>  clk_loop <= 5000;
--              when 3    =>  clk_loop <= 3333;
--              when 4    =>  clk_loop <= 2000;
--              when 5    =>  clk_loop <= 1250;
--              when 6    =>  clk_loop <= 1000;
--              when 7    =>  clk_loop <= 500;
--              when 8    =>  clk_loop <= 333;
--              when 9    =>  clk_loop <= 200;
--              when 10   =>  clk_loop <= 125;
--              when 11   =>  clk_loop <= 100;
--              when 12   =>  clk_loop <= 367;
--              when others =>  clk_loop <= 10000;
--            end case;    
--pwm step by step of s_bpwm    
            s_ctn_pwm_loc <= s_ctn_pwm_loc + 1;
                if (s_ctn_pwm_loc = clk_loop) then
                    if (s_cnt_local = 100) then
                        s_cnt_local <= 1;                            
                    else
                        PWM_o <=  s_bpwm(s_cnt_local);   --postupne jeden po druhem prochazoo sinus bity
                        s_cnt_local <= s_cnt_local + 1; --postupne posita nahoru kazdou nastupnou hranu                    
                    end if;
                    s_ctn_pwm_loc <= 0;
                end if;
        end if;
    end process p_cnt_up_down;

    -- Output must be retyped from "unsigned" to "std_logic_vector"
--    cnt_o <= std_logic_vector(s_cnt_local);

end architecture behavioral;