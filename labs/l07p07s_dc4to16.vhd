LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l07p07s_dc4to16 IS
    PORT (
        a : IN std_logic_vector (3 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (15 DOWNTO 0)
    );
END l07p07s_dc4to16;

ARCHITECTURE l07p07s_dc4to16_behaviour OF l07p07s_dc4to16 IS
    COMPONENT l06p03b_dc3to8
        PORT (
            a : IN std_logic_vector (2 DOWNTO 0);
            enabled : IN std_logic;
            q : OUT std_logic_vector (7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL qs1 : std_logic;
    SIGNAL qs2 : std_logic;
BEGIN
    qs1 <= (NOT a(3)) AND enabled;
    qs2 <= a(3) AND enabled;

    decoder_1: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), qs1, q(7 DOWNTO 0));
    decoder_2: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), qs2, q(15 DOWNTO 8));
END l07p07s_dc4to16_behaviour;

CONFIGURATION l07p07s_dc4to16_configuration OF l07p07s_dc4to16 IS
    FOR l07p07s_dc4to16_behaviour
        FOR
            decoder_1,
            decoder_2
        : l06p03b_dc3to8
            USE ENTITY work.l06p03b_dc3to8 (l06p03b_dc3to8_behaviour);
        END FOR;
    END FOR;
END l07p07s_dc4to16_configuration;
