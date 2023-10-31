LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p2_dc_6to64_s IS
    PORT (
        a : IN std_logic_vector (5 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (63 DOWNTO 0)
    );
END p2_dc_6to64_s;

ARCHITECTURE p2_dc_6to64_s_behaviour OF p2_dc_6to64_s IS
    COMPONENT p1_dc_3to8_b
        PORT (
            a : IN std_logic_vector (2 DOWNTO 0);
            enabled : IN std_logic;
            q : OUT std_logic_vector (7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL q_first_decoder : std_logic_vector (7 DOWNTO 0);
    SIGNAL q_first_decoder_invert : std_logic_vector (7 DOWNTO 0);
BEGIN
    decoder_1: p1_dc_3to8_b PORT MAP (a(5 DOWNTO 3), enabled, q_first_decoder);

    q_first_decoder_invert <= not q_first_decoder;

    decoder_2: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(0), q(7 DOWNTO 0));
    decoder_3: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(1), q(15 DOWNTO 8));
    decoder_4: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(2), q(23 DOWNTO 16));
    decoder_5: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(3), q(31 DOWNTO 24));
    decoder_6: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(4), q(39 DOWNTO 32));
    decoder_7: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(5), q(47 DOWNTO 40));
    decoder_8: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(6), q(55 DOWNTO 48));
    decoder_9: p1_dc_3to8_b PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(7), q(63 DOWNTO 56));
END p2_dc_6to64_s_behaviour;

CONFIGURATION p2_dc_6to64_s_configuration OF p2_dc_6to64_s IS
    FOR p2_dc_6to64_s_behaviour
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
        : p1_dc_3to8_b
            USE ENTITY work.p1_dc_3to8_b (p1_dc_3to8_b_behaviour);
        END FOR;
    END FOR;
END p2_dc_6to64_s_configuration;
