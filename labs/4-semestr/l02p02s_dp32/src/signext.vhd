-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity signext_8_32 is
    generic (
        Tpd : time := unit_delay
    );
    port (
        a : in bit_8;
        b : out bus_bit_32 bus;
        en : in std_logic
    );
end signext_8_32;

architecture behaviour of signext_8_32 is
begin
    b_driver : process (en, a)
    begin
        if en = '1' then
            b(7 downto 0) <= a after Tpd;
            if a(7) = '1' then
                b(31 downto 8) <= X"FFFF_FF" after Tpd;
            else
                b(31 downto 8) <= X"0000_00" after Tpd;
            end if;
        else
            b <= null after Tpd;
        end if;
    end process b_driver;
end behaviour;
