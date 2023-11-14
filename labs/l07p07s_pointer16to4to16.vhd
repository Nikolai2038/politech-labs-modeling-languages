LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l07p07s_pointer16to4to16 IS
    PORT (
        r  : IN  std_logic_vector (15 DOWNTO 0);
        ei : IN  std_logic;
        g  : OUT std_logic;
        eo : OUT std_logic;
        q  : OUT std_logic_vector (15 DOWNTO 0)
    );
END l07p07s_pointer16to4to16;

ARCHITECTURE l07p07s_pointer16to4to16_behaviour OF l07p07s_pointer16to4to16 IS
    -- Шифратор
    COMPONENT l07p04s_hpri16to4
        PORT (
            q : IN std_logic_vector (15 DOWNTO 0);
            ei : IN std_logic;
            g : OUT std_logic;
            eo : OUT std_logic;
            a : OUT std_logic_vector (3 DOWNTO 0)
        );
    END COMPONENT;

    -- Дешифратор
    COMPONENT l07p07s_dc4to16
        PORT (
            a : IN std_logic_vector (3 DOWNTO 0);
            enabled : IN std_logic;
            q : OUT std_logic_vector (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a  : std_logic_vector (3 DOWNTO 0);
    SIGNAL gs  : std_logic;
    SIGNAL eos : std_logic;
BEGIN
    encoder: l07p04s_hpri16to4 PORT MAP (r, ei, gs, eos, a);
    decoder: l07p07s_dc4to16   PORT MAP (a, gs, q);
    g <= gs;
    eo <= eos;
END l07p07s_pointer16to4to16_behaviour;

CONFIGURATION l07p07s_pointer16to4to16_configuration OF l07p07s_pointer16to4to16 IS
    FOR l07p07s_pointer16to4to16_behaviour
        FOR encoder : l07p04s_hpri16to4
            USE ENTITY work.l07p04s_hpri16to4 (l07p04s_hpri16to4_behaviour);
        END FOR;

        FOR decoder : l07p07s_dc4to16
            USE ENTITY work.l07p07s_dc4to16 (l07p07s_dc4to16_behaviour);
        END FOR;
    END FOR;
END l07p07s_pointer16to4to16_configuration;
