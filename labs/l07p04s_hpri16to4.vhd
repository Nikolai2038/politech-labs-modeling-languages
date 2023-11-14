LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l07p04s_hpri16to4 IS
    PORT (
        q : IN std_logic_vector (15 DOWNTO 0);
        ei : IN std_logic;
        g : OUT std_logic;
        eo : OUT std_logic;
        a : OUT std_logic_vector (3 DOWNTO 0)
    );
END l07p04s_hpri16to4;

ARCHITECTURE l07p04s_hpri16to4_behaviour OF l07p04s_hpri16to4 IS
    COMPONENT l07p03b_hpri8to3
        PORT (
            q : IN std_logic_vector (7 DOWNTO 0);
            ei : IN std_logic;
            g : OUT std_logic;
            eo : OUT std_logic;
            a : OUT std_logic_vector (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a_1 : std_logic_vector (2 DOWNTO 0);
    SIGNAL a_2 : std_logic_vector (2 DOWNTO 0);
    SIGNAL g_1: std_logic;
    SIGNAL g_2: std_logic;
    SIGNAL eo_1: std_logic;
    SIGNAL eo_2: std_logic;
BEGIN
    encoder_1: l07p03b_hpri8to3 PORT MAP (q(15 DOWNTO 8), ei, g_1, eo_1, a_1);
    encoder_2: l07p03b_hpri8to3 PORT MAP (q(7 DOWNTO 0), eo_1, g_2, eo_2, a_2);

    a(2 DOWNTO 0) <= a_1 OR a_2;
    a(3) <= ei AND NOT eo_1;
    g <= g_1 OR g_2;
    eo <= eo_1 AND eo_2;
END l07p04s_hpri16to4_behaviour;

CONFIGURATION l07p04s_hpri16to4_configuration OF l07p04s_hpri16to4 IS
    FOR l07p04s_hpri16to4_behaviour
        FOR
            encoder_1,
            encoder_2
        : l07p03b_hpri8to3
            USE ENTITY work.l07p03b_hpri8to3 (l07p03b_hpri8to3_behaviour);
        END FOR;
    END FOR;
END l07p04s_hpri16to4_configuration;
