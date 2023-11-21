LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l08p04s_mux16to1 IS
    PORT (
        x : IN std_logic_vector (15 DOWNTO 0);
        a : IN std_logic_vector (3 DOWNTO 0);
        enable : IN std_logic;
        output : OUT std_logic
    );
END l08p04s_mux16to1;

ARCHITECTURE l08p04s_mux16to1_behaviour OF l08p04s_mux16to1 IS
    COMPONENT l08p02b_mux4to1
        PORT (
            x0 : IN std_logic;
            x1 : IN std_logic;
            x2 : IN std_logic;
            x3: IN std_logic;
            a0 : IN std_logic;
            a1: IN std_logic;
            enable : IN std_logic;
            output : OUT std_logic
        );
    END COMPONENT;

    SIGNAL mux_1_output : std_logic;
    SIGNAL mux_2_output : std_logic;
    SIGNAL mux_3_output : std_logic;
    SIGNAL mux_4_output : std_logic;
BEGIN
    mux_1: l08p02b_mux4to1 PORT MAP (x(0), x(1), x(2), x(3), a(0), a(1), enable, mux_1_output);
    mux_2: l08p02b_mux4to1 PORT MAP (x(4), x(5), x(6), x(7), a(0), a(1), enable, mux_2_output);
    mux_3: l08p02b_mux4to1 PORT MAP (x(8), x(9), x(10), x(11), a(0), a(1), enable, mux_3_output);
    mux_4: l08p02b_mux4to1 PORT MAP (x(12), x(13), x(14), x(15), a(0), a(1), enable, mux_4_output);
    mux_5: l08p02b_mux4to1 PORT MAP (mux_1_output, mux_2_output, mux_3_output, mux_4_output, a(2), a(3), enable, output);
END l08p04s_mux16to1_behaviour;

CONFIGURATION l08p04s_mux16to1_configuration OF l08p04s_mux16to1 IS
    FOR l08p04s_mux16to1_behaviour
        FOR
            mux_1,
            mux_2,
            mux_3,
            mux_4,
            mux_5
        : l08p02b_mux4to1
            USE ENTITY work.l08p02b_mux4to1 (l08p02b_mux4to1_behaviour);
        END FOR;
    END FOR;
END l08p04s_mux16to1_configuration;
