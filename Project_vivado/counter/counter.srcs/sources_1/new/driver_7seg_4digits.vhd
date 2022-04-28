------------------------------------------------------------
--
-- Driver for 4-digit 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        d_f_i   : in natural:= 0;       --driver frequency input
        -- Cathode values for individual segments
        seg_o   : out std_logic_vector(7 - 1 downto 0);
        -- Common anode signals to individual displays
        dig_o   : out std_logic_vector(8 - 1 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en2  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt2 : std_logic_vector(3 - 1 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(4 - 1 downto 0);
    -- Internal signals for display segments
    signal s_data0 :   std_logic_vector(4 - 1 downto 0);
    signal s_data1 :   std_logic_vector(4 - 1 downto 0);
    signal s_data2 :   std_logic_vector(4 - 1 downto 0);
    signal s_data3 :   std_logic_vector(4 - 1 downto 0);
    signal s_data4 :   std_logic_vector(4 - 1 downto 0);
    signal s_data5 :   std_logic_vector(4 - 1 downto 0);
    signal s_data6 :   std_logic_vector(4 - 1 downto 0);
    signal s_data7 :   std_logic_vector(4 - 1 downto 0);

begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable2 entity generates 
    -- an enable pulse every 4 ms
    clk_en2 : entity work.clock_enable2
        generic map(
            g_MAX => 200000
            -- for TESTBENCH g_MAX => 4 !!!!
        )
        port map(
            clk     => clk,
            reset   => reset,
            ce2_o    => s_en2
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit
    -- down counter
    bin_cnt2 : entity work.cnt_up_down2
        generic map(
            g_CNT_WIDTH => 3
        )
        port map(
            clk     => clk,
            reset   => reset,
            en2_i    => s_en2,
            cnt_up2_i => '0',
            cnt2_o   => s_cnt2      
        );
        
    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment
    -- display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );
----------------------------------------------- Definitoins of display numvers
    p_data : process(clk)
    begin
            if (d_f_i = 100) then    --100
              s_data0 <= "0000"; -- 0        --   0
              s_data1 <= "0000"; -- 0        --   0
              s_data2 <= "0001"; -- 1        --   1 =>100 from bottom up
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000"; -- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0001"; -- 1           -- table rov
            end if; 
            if (d_f_i = 200) then    --200
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0010"; -- 2
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0010"; -- 2
            end if;          
            if (d_f_i = 300) then    --300
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0011"; -- 3
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0011"; -- 3
            end if;
            if (d_f_i = 500) then    -- 500
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0101"; -- 5
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0100"; -- 4
            end if;
            if (d_f_i = 800) then    --800
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "1000"; -- 8
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0101"; -- 5
            end if;
            if (d_f_i = 1000) then    --1000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "0001"; -- 1           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0110"; -- 6
            end if;
            if (d_f_i = 2000) then    -- 2000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "0010"; -- 2           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "0111"; -- 7
            end if;             
            if (d_f_i = 5000) then    -- 5000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "0101"; -- 5           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "1000"; -- 8
            end if;            
            if (d_f_i = 8000) then    -- 8000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "1000"; -- 8           
              s_data4 <= "0000"; -- 0
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "1001"; -- 9
            end if;            
            if (d_f_i = 10000) then    -- 10000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "0000"; -- 0           
              s_data4 <= "0001"; -- 1
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "1010"; -- 10
            end if;           
            if (d_f_i = 15000) then    -- 15000
              s_data0 <= "0000"; -- 0
              s_data1 <= "0000"; -- 0
              s_data2 <= "0000"; -- 0
              s_data3 <= "0101"; -- 5           
              s_data4 <= "0001"; -- 1
              s_data5 <= "0000";-- 0
              s_data6 <= "0000"; -- 0
              s_data7 <= "1011"; -- 11
            end if;
    end process p_data;

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_hex <= s_data0;             
                dig_o <= "11111110";
            else
                case s_cnt2 is
                    when "111" =>
                        s_hex <= s_data7;                        
                        dig_o <= "01111111";                   
                    when "110" =>
                        s_hex <= s_data6;                
                        dig_o <= "10111111";                       
                    when "101" =>
                        s_hex <= s_data5;                     
                        dig_o <= "11011111";
                    when "100" =>
                        s_hex <= s_data4;                   
                        dig_o <= "11101111";                   
                    when "011" =>
                        s_hex <= s_data3;                      
                        dig_o <= "11110111";                   
                    when "010" =>
                        s_hex <= s_data2;                     
                        dig_o <= "11111011";                  
                    when "001" =>
                        s_hex <= s_data1;                      
                        dig_o <= "11111101";           
                    when others =>
                        s_hex <= s_data0;                     
                        dig_o <= "11111110";
                end case;
            end if;
        end if;
    end process p_mux;
end architecture Behavioral;
