

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW :   in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           AUD_PWM : out STD_LOGIC );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

  -- Internal clock enable
--  signal s_en  : std_logic;
  -- Internal counter
--  signal s_cnt : std_logic_vector(4 - 1 downto 0);



begin

  --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clk_en0 : entity work.clock_enable
--      generic map(
--          g_MAX => 25000000
--      )
      port map(
          clk   => CLK100MHZ, 
          reset => BTNC
--          btn_fUP => BTNU,
--          btn_fDOWN => BTND
--          ce_o  => s_en
      );

  --------------------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity
  bin_pwm0 : entity work.cnt_up_down
--     generic map(
--          g_CNT_WIDTH => 4
--      )
      port map(
          clk       => CLK100MHZ,
          reset     => BTNC,
          PWM_o     => AUD_PWM
--          en_i      => s_en,
--          cnt_up_i  => SW,
--          cnt_o     => s_cnt
      );





end architecture Behavioral;
