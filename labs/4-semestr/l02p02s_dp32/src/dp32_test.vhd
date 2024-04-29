-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity dp32_test is
end dp32_test;

architecture structure of dp32_test is
    component clock_gen
        port (
            phi1, phi2 : out std_logic;
            reset : out std_logic
        );
    end component;
    component dp32
        port (
            d_bus : inout bus_bit_32 bus;
            a_bus : out bit_32;
            read, write : out std_logic;
            fetch : out std_logic;
            ready : in std_logic;
            phi1, phi2 : in std_logic;
            reset : in std_logic
        );
    end component;
    component memory
        port (
            d_bus : inout bus_bit_32 bus;
            a_bus : in bit_32;
            read, write : in std_logic;
            ready : out std_logic
        );
    end component;
    signal d_bus : bus_bit_32 bus;
    signal a_bus : bit_32;
    signal read, write : std_logic;
    signal fetch : std_logic;
    signal ready : std_logic;
    signal phi1, phi2 : std_logic;
    signal reset : std_logic;

begin
    cg : clock_gen
    port map(phi1 => phi1, phi2 => phi2, reset => reset);
    proc : dp32
    port map(
        d_bus => d_bus, a_bus => a_bus,
        read => read, write => write, fetch => fetch,
        ready => ready,
        phi1 => phi1, phi2 => phi2, reset => reset);
    mem : memory
    port map(
        d_bus => d_bus, a_bus => a_bus,
        read => read, write => write, ready => ready);

end structure;

configuration dp32_behaviour_test of dp32_test is
    for structure
        for cg : clock_gen
            use entity work.clock_gen(behaviour)
            generic map(Tpw => 8 ns, Tps => 2 ns);
        end for;
        for mem : memory
            use entity work.memory(behaviour);
        end for;
        for proc : dp32
            use entity work.dp32(behaviour);
        end for;
    end for;
end dp32_behaviour_test;
