

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ : in  STD_LOGIC;
           SWcnt :     in  STD_LOGIC;
           SWOnOff :   in  STD_LOGIC;
           LED :       out STD_LOGIC_VECTOR (3 downto 0);
           CA :        out STD_LOGIC;
           CB :        out STD_LOGIC;
           CC :        out STD_LOGIC;
           CD :        out STD_LOGIC;
           CE :        out STD_LOGIC;
           CF :        out STD_LOGIC;
           CG :        out STD_LOGIC;
           AN :        out STD_LOGIC_VECTOR (7 downto 0);
           BTNC :      in  STD_LOGIC;
           AUD_PWM :   out STD_LOGIC;
           AUD_SD :    out STD_LOGIC;
           JA :    out STD_LOGIC);
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

  -- Internal clock enable
  signal s_en  : std_logic;         --enable
  signal s_cnt : std_logic_vector(4 - 1 downto 0);  --counter signal
  signal s_f_disp: natural:= 0;                     --chossen freqency signal from pwm to driver
  signal s_PWM  : std_logic;                         --pwm signal out

begin
  --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 100000000
      )
      port map(
          clk   => CLK100MHZ,
          reset => BTNC,
          ce_o  => s_en,
          cnt_OnOff_i => SWOnOff
      );

  --------------------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
     generic map(
          g_CNT_WIDTH => 4
      )
      port map(
          clk      => CLK100MHZ,
          reset    => BTNC,
          en_i     => s_en,
          cnt_up_i => SWcnt,
          cnt_o    => s_cnt
      );
  --------------------------------------------------------------------
  --PWM
    PWM : entity work.PWM
      port map(
          clk   => CLK100MHZ,
          reset => BTNC,
          freq_step_i => s_cnt,
          PWM_o => s_PWM,
          f_disp_o  => s_f_disp 
      );

  --------------------------------------------------------------------
  --segment driver
    driver_seg_4 : entity work.driver_7seg_4digits
      port map(
          clk        => CLK100MHZ,
          reset      => BTNC,
          d_f_i => s_f_disp,            -- freqency disp natural signal to driver frequency input 
          
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG,
         
          dig_o(7 downto 0) => AN(7 downto 0)
      );

 -- Connect one common anode to 3.3V
 --   AN <= b"1111_1110";
    AUD_SD <= '1';      --enable audio
    JA <= s_PWM;        --diagnostics
    AUD_PWM <= s_PWM;   --pwm to audio output
end architecture Behavioral;