----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2022 23:15:16
-- Design Name: 
-- Module Name: tb_PWM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_PWM is

end tb_PWM;

architecture Behavioral of tb_PWM is
   
    constant c_CLK_100MHZ_PERIOD : time    := 1 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_PWM        : std_logic;
    signal s_freq_step  : std_logic_vector(4 - 1 downto 0);
    
begin
    -- Connecting testbench signals with cnt_up_down entity
    -- (Unit Under Test)
    uut_cnt : entity work.PWM
--        generic map(
----            g_CNT_WIDTH  => c_CNT_WIDTH
--        )
        port map(
            clk      => s_clk_100MHz,
            reset    => s_reset,
            PWM_o     => s_PWM,
            freq_step_i    => s_freq_step
        );

     p_clk_gen : process
    begin
        while now < 1500 us loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
     p_reset_gen : process
    begin
        s_reset <= '0'; wait for 5 ns;
        -- Reset activated
        s_reset <= '1'; wait for 10 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
     p_stimulus : process
    begin
        -- Enable counting
        wait for 500 us;
        s_freq_step     <= "0100";
        wait for 500 us;
        s_freq_step     <= "0101";

--        s_freq_step <= "0010";
--        wait for 600 ns;
--        s_freq_step     <= "0011";

        wait;
    end process p_stimulus;

end Behavioral;
