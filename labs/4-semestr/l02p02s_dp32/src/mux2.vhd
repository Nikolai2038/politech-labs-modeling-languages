-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity mux2 is
    generic (
        width : positive;
        Tpd : time := unit_delay
    );
    port (
        i0, i1 : in std_logic_vector(width - 1 downto 0);
        y : out std_logic_vector(width - 1 downto 0);
        sel : in std_logic
    );
end mux2;

architecture behaviour of mux2 is
begin
    with sel select
        y <= i0 after Tpd when '0',
        i1 after Tpd when '1',
        (others => 'Z') after Tpd when others;
end behaviour;
