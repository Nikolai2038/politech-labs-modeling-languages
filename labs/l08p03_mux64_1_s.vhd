LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_mux64_1_s IS
    PORT (
        x : IN std_logic_vector (63 DOWNTO 0);
        a : IN std_logic_vector (7 DOWNTO 0);
        enable : IN std_logic;
        output : OUT std_logic
    );
END p1_mux64_1_s;

ARCHITECTURE p1_mux64_1_s_behaviour OF p1_mux64_1_s IS
    COMPONENT p1_mux4_1_b
        PORT (
            x : IN std_logic_vector (3 DOWNTO 0);
            a : IN std_logic_vector (1 DOWNTO 0);
            enable : IN std_logic;
            output : OUT std_logic
        );
    END COMPONENT;

    SIGNAL a_1 : std_logic_vector (2 DOWNTO 0);
    SIGNAL a_2 : std_logic_vector (2 DOWNTO 0);
    SIGNAL g_1: std_logic;
    SIGNAL g_2: std_logic;
    SIGNAL eo_1: std_logic;
    SIGNAL eo_2: std_logic;
BEGIN
    mux_1: p1_mux4_1_b PORT MAP (q(15 DOWNTO 8), ei, g_1, eo_1, a_1);
    mux_2: p1_mux4_1_b PORT MAP (q(7 DOWNTO 0), eo_1, g_2, eo_2, a_2);

    a(2 DOWNTO 0) <= a_1 OR a_2;
    a(3) <= ei AND NOT eo_1;
    g <= g_1 OR g_2;
    eo <= eo_1 AND eo_2;
END p1_mux64_1_s_behaviour;

CONFIGURATION p1_mux64_1_s_configuration OF p1_mux64_1_s IS
    FOR p1_mux64_1_s_behaviour
        FOR
            mux_1,
            mux_2
        : p1_mux4_1_b
            USE ENTITY work.p1_mux4_1_b (p1_mux4_1_b_behaviour);
        END FOR;
    END FOR;
END p1_mux64_1_s_configuration;
