-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity clock_gen is
    -- Set the delays
    generic (
        Tpw : time := 8 ns;
        Tps : time := 2 ns
    );
    port (
        phi1, phi2 : out std_logic;
        reset : out std_logic
    );
end clock_gen;

architecture behaviour of clock_gen is
    -- Will be 20 ns
    constant clock_period : time := 2 * (Tpw + Tps);
begin
    reset_driver :
    -- After 0 ns from start, "reset" will be '1'.
    -- After 48 ns from start, "reset" will be '0'.
    -- So only after 48 ns the program will start.
    -- If "reset" is still "1", then something went wrong.
    reset <= '1', '0' after 2 * clock_period + Tpw;
    clock_driver : process
    begin
        -- After 0 ns from start, "phi1" will be '1'.
        -- After 8 ns from start, "phi1" will be '0'.
        phi1 <= '1', '0' after Tpw;
        -- After 10 ns from start, "phi2" will be '1'
        -- After 18 ns from start, "phi2" will be '0'
        phi2 <= '1'after Tpw + Tps, '0' after Tpw + Tps + Tpw;
        -- Wait for 20 ns from start, then repeat all again
        wait for clock_period;
    end process clock_driver;
end behaviour;
