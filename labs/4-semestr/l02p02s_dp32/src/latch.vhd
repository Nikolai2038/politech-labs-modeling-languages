-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity latch is
    generic (
        width : positive;
        Tpd : time := unit_delay
    );
    port (
        d : in std_logic_vector(width - 1 downto 0);
        q : out std_logic_vector(width - 1 downto 0);
        en : in std_logic
    );
end latch;

architecture behaviour of latch is
begin
    process (d, en)
    begin
        if en = '1' then
            q <= d after Tpd;
        end if;
    end process;
end behaviour;
