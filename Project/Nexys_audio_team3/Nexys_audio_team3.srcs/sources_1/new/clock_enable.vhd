

library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

------------------------------------------------------------
-- Entity declaration for clock enable
------------------------------------------------------------
entity clock_enable is
    generic(
        g_MAX : natural := 10  -- Number of clk pulses to
                               -- generate one enable signal
                               -- period
    );  -- Note that there IS a semicolon between generic 
        -- and port sections
    port(
        clk   : in  std_logic; -- Main clock
        reset : in  std_logic; -- Synchronous reset
        ce_o  : out std_logic  -- Clock enable pulse signal
    );
end entity clock_enable;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------
architecture Behavioral of clock_enable is

    -- Local counter
    signal s_cnt_local : natural;

begin
    --------------------------------------------------------
    -- p_clk_ena:
    -- Generate clock enable signal. By default, enable signal
    -- is low and generated pulse is always one clock long.
    --------------------------------------------------------
    p_clk_ena : process(clk)
    begin
        if rising_edge(clk) then    -- Synchronous process

            if (reset = '1') then   -- High active reset
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '0'; -- Set output to low

            -- Test number of clock periods
            elsif (s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '1'; -- Generate clock enable pulse

            else
                s_cnt_local <= s_cnt_local + 1;
                ce_o        <= '0';
            end if;
        end if;
    end process p_clk_ena;

end architecture Behavioral;


--library ieee;               -- Standard library
--use ieee.std_logic_1164.all;-- Package for data types and logic operations
--use ieee.numeric_std.all;   -- Package for arithmetic operations

--------------------------------------------------------------
---- Entity declaration for clock enable
--------------------------------------------------------------
--entity clock_enable is
--    generic(
--        g_MAX : natural := 10  -- Number of clk pulses to
--                               -- generate one enable signal
--                               -- period
--    );  -- Note that there IS a semicolon between generic 
--        -- and port sections
--    port(
--        clk   : in  std_logic; -- Main clock
--        reset : in  std_logic; -- Synchronous reset
--        ce_o  : out std_logic  -- Clock enable pulse signal
        
--    );
--end entity clock_enable;

--------------------------------------------------------------
---- Architecture body for clock enable
--------------------------------------------------------------
--architecture Behavioral of clock_enable is

--    -- Local counter
--    signal s_cnt_local : natural:= 0;
--    signal s_bpwm : std_logic_vector(100 - 1 downto 0);

--begin
--    --------------------------------------------------------
--    -- p_clk_ena:
--    -- Generate clock enable signal. By default, enable signal
--    -- is low and generated pulse is always one clock long.
--    --------------------------------------------------------
--    p_clk_ena : process(clk)
--    begin
--        s_bpwm <= "1111110000111111111111111111100111111110011111100001111000000110000000110000000001100000000111100000";
--        if rising_edge(clk) then    -- Synchronous process

--            if (reset = '1') then   -- High active reset
--                s_cnt_local <= 0;   -- Clear local counter
--                ce_o        <= '0'; -- Set output to low
       
--            elsif (s_cnt_local = 100) then
--                s_cnt_local <= 0;                            
--            else
--                ce_o <=  s_bpwm(s_cnt_local);   --postupne jeden po druhem prochazoo sinus bity
--                s_cnt_local <= s_cnt_local + 1; --postupne posita nahoru kazdou nastupnou hranu                    
--            end if;
            
            
--        end if;
--    end process p_clk_ena;

--end architecture Behavioral;









--            elsif (s_cnt_local >= (g_MAX - 1)) then
                --s_cnt_local <= s_cnt_local + 1;   -- Clear local counter

            -- Test number of clock periods
--            elsif (s_cnt_local >= (g_MAX - 1)) then
--                s_cnt_local <= 0;   -- Clear local counter
--                ce_o        <= '1'; -- Generate clock enable pulse

--            else
--                s_cnt_local <= s_cnt_local + 1;
--                ce_o        <= '0';
--            end if;