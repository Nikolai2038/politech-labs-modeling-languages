LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l08p04s_mux64to1 IS
    PORT (
        x : IN std_logic_vector (63 DOWNTO 0);
        a : IN std_logic_vector (5 DOWNTO 0);
        enable : IN std_logic;
        output : OUT std_logic
    );
END l08p04s_mux64to1;

ARCHITECTURE l08p04s_mux64to1_behaviour OF l08p04s_mux64to1 IS
    COMPONENT l08p04s_mux16to1
        PORT (
            x : IN std_logic_vector (15 DOWNTO 0);
            a : IN std_logic_vector (3 DOWNTO 0);
            enable : IN std_logic;
            output : OUT std_logic
        );
    END COMPONENT;

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

    SIGNAL mux16to1_1_output : std_logic;
    SIGNAL mux16to1_2_output : std_logic;
    SIGNAL mux16to1_3_output : std_logic;
    SIGNAL mux16to1_4_output : std_logic;
BEGIN
    mux16to1_1: l08p04s_mux16to1 PORT MAP (x(15 DOWNTO 0), a(3 DOWNTO 0), enable, mux16to1_1_output);
    mux16to1_2: l08p04s_mux16to1 PORT MAP (x(31 DOWNTO 16), a(3 DOWNTO 0), enable, mux16to1_2_output);
    mux16to1_3: l08p04s_mux16to1 PORT MAP (x(47 DOWNTO 32), a(3 DOWNTO 0), enable, mux16to1_3_output);
    mux16to1_4: l08p04s_mux16to1 PORT MAP (x(63 DOWNTO 48), a(3 DOWNTO 0), enable, mux16to1_4_output);

    mux4to1: l08p02b_mux4to1 PORT MAP (mux16to1_1_output, mux16to1_2_output, mux16to1_3_output, mux16to1_4_output, a(4), a(5), enable, output);
END l08p04s_mux64to1_behaviour;

CONFIGURATION l08p04s_mux64to1_configuration OF l08p04s_mux64to1 IS
    FOR l08p04s_mux64to1_behaviour
        FOR
            mux16to1_1,
            mux16to1_2,
            mux16to1_3,
            mux16to1_4
        : l08p04s_mux16to1
            USE ENTITY work.l08p04s_mux16to1 (l08p04s_mux16to1_behaviour);
        END FOR;

        FOR mux4to1: l08p02b_mux4to1
            USE ENTITY work.l08p02b_mux4to1 (l08p02b_mux4to1_behaviour);
        END FOR;
    END FOR;
END l08p04s_mux64to1_configuration;
