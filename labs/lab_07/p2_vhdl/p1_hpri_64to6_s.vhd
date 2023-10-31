LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_hpri_64to6_s IS
    PORT (
        q : IN std_logic_vector (63 DOWNTO 0);
        ei : IN std_logic;
        a : OUT std_logic_vector (5 DOWNTO 0)
    );
END p1_hpri_64to6_s;

ARCHITECTURE p1_hpri_64to6_s_behaviour OF p1_hpri_64to6_s IS
    COMPONENT p1_hpri_8to3_b
        PORT (
            q : IN std_logic_vector (7 DOWNTO 0);
            ei : IN std_logic;
            a : OUT std_logic_vector (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL q_first_decoder : std_logic_vector (7 DOWNTO 0);
    SIGNAL q_first_decoder_invert : std_logic_vector (7 DOWNTO 0);
BEGIN
    decoder_1: p1_hpri_8to3_b PORT MAP (a(5 DOWNTO 3), ei, q_first_decoder);

    q_first_decoder_invert <= not q_first_decoder;

    decoder_2: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(0), q(7 DOWNTO 0));
    decoder_3: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(1), q(15 DOWNTO 8));
    decoder_4: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(2), q(23 DOWNTO 16));
    decoder_5: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(3), q(31 DOWNTO 24));
    decoder_6: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(4), q(39 DOWNTO 32));
    decoder_7: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(5), q(47 DOWNTO 40));
    decoder_8: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(6), q(55 DOWNTO 48));
    decoder_9: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(7), q(63 DOWNTO 56));
END p1_hpri_64to6_s_behaviour;

CONFIGURATION p1_hpri_64to6_s_configuration OF p1_hpri_64to6_s IS
    FOR p1_hpri_64to6_s_behaviour
        FOR
            decoder_1,
            decoder_2,
            decoder_3,
            decoder_4,
            decoder_5,
            decoder_6,
            decoder_7,
            decoder_8,
            decoder_9
        : p1_hpri_8to3_b
            USE ENTITY work.p1_hpri_8to3_b (p1_hpri_8to3_b_behaviour);
        END FOR;
    END FOR;
END p1_hpri_64to6_s_configuration;
