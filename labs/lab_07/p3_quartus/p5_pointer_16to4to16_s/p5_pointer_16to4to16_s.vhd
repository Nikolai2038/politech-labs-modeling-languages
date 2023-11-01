LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p5_pointer_16to4to16_s IS
    PORT (
        r  : IN  std_logic_vector (15 DOWNTO 0);
        ei : IN  std_logic;
        g  : OUT std_logic;
        eo : OUT std_logic;
        q  : OUT std_logic_vector (15 DOWNTO 0)
    );
END p5_pointer_16to4to16_s;

ARCHITECTURE p5_pointer_16to4to16_s_behaviour OF p5_pointer_16to4to16_s IS
    -- Шифратор
    COMPONENT p1_hpri_16to4_s IS
        PORT (
            q : IN std_logic_vector (15 DOWNTO 0);
            ei : IN std_logic;
            g : OUT std_logic;
            eo : OUT std_logic;
            a : OUT std_logic_vector (3 DOWNTO 0)
        );
    END COMPONENT;

    -- Дешифратор
    COMPONENT p5_dc_4to16 IS
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
    encoder: p1_hpri_16to4_s PORT MAP (r, ei, gs, eos, a);
    decoder: p5_dc_4to16   PORT MAP (a, gs, q);
END p5_pointer_16to4to16_s_behaviour;

CONFIGURATION p5_pointer_16to4to16_s_configuration OF p5_pointer_16to4to16_s IS
    FOR p5_pointer_16to4to16_s_behaviour
        FOR encoder : p1_hpri_16to4_s
            USE ENTITY work.p1_hpri_16to4_s (p1_hpri_16to4_s_behaviour);
        END FOR;
        FOR decoder : p5_dc_4to16
            USE ENTITY work.p5_dc_4to16 (p5_dc_4to16_behaviour);
        END FOR;
    END FOR;
END p5_pointer_16to4to16_s_configuration;
