LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_hpri_64to6_s IS
    PORT (
        q : IN std_logic_vector (63 DOWNTO 0);
        ei : IN std_logic;
        g : OUT std_logic;
        eo : OUT std_logic;
        a : OUT std_logic_vector (5 DOWNTO 0)
    );
END p1_hpri_64to6_s;

ARCHITECTURE p1_hpri_64to6_s_behaviour OF p1_hpri_64to6_s IS
    COMPONENT p1_hpri_8to3_b
        PORT (
            q : IN std_logic_vector (7 DOWNTO 0);
            ei : IN std_logic;
            g : OUT std_logic;
            eo : OUT std_logic;
            a : OUT std_logic_vector (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL q_first_encoder : std_logic_vector (7 DOWNTO 0);
    SIGNAL q_first_encoder_invert : std_logic_vector (7 DOWNTO 0);
BEGIN
    encoder_1: p1_hpri_8to3_b PORT MAP (a(5 DOWNTO 3), ei, q_first_encoder);

    q_first_encoder_invert <= not q_first_encoder;

    encoder_2: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(0), q(7 DOWNTO 0));
    encoder_3: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(1), q(15 DOWNTO 8));
    encoder_4: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(2), q(23 DOWNTO 16));
    encoder_5: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(3), q(31 DOWNTO 24));
    encoder_6: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(4), q(39 DOWNTO 32));
    encoder_7: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(5), q(47 DOWNTO 40));
    encoder_8: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(6), q(55 DOWNTO 48));
    encoder_9: p1_hpri_8to3_b PORT MAP (a(2 DOWNTO 0), q_first_encoder_invert(7), q(63 DOWNTO 56));
END p1_hpri_64to6_s_behaviour;

CONFIGURATION p1_hpri_64to6_s_configuration OF p1_hpri_64to6_s IS
    FOR p1_hpri_64to6_s_behaviour
        FOR
            encoder_1,
            encoder_2,
            encoder_3,
            encoder_4,
            encoder_5,
            encoder_6,
            encoder_7,
            encoder_8,
            encoder_9
        : p1_hpri_8to3_b
            USE ENTITY work.p1_hpri_8to3_b (p1_hpri_8to3_b_behaviour);
        END FOR;
    END FOR;
END p1_hpri_64to6_s_configuration;
