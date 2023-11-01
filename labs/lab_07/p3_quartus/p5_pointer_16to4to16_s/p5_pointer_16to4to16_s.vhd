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
    COMPONENT p2_dc_6to64_s IS
        PORT (
            a : IN std_logic_vector (5 DOWNTO 0);
            enabled : IN std_logic;
            q : OUT std_logic_vector (63 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a  : std_logic_vector (3 DOWNTO 0);
    SIGNAL gs  : std_logic;
    SIGNAL eos : std_logic;
BEGIN
    encoder: p1_hpri_16to4_s PORT MAP (r, ei, gs, eos, a);
    decoder: p2_dc_6to64_s   PORT MAP (a, gs, q, gs, eos);
END p5_pointer_16to4to16_s_behaviour;

CONFIGURATION p5_pointer_16to4to16_s_configuration OF p5_pointer_16to4to16_s IS
    FOR p5_pointer_16to4to16_s_behaviour
        FOR encoder : p1_hpri_16to4_s
            USE ENTITY work.p1_hpri_16to4_s (p1_hpri_16to4_s_behaviour);
        END FOR;
        FOR decoder : p2_dc_6to64_s
            USE ENTITY work.p2_dc_6to64_s (p2_dc_6to64_s_behaviour);
        END FOR;
    END FOR;
END p5_pointer_16to4to16_s_configuration;
