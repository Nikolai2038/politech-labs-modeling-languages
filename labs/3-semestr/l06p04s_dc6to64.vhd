LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l06p04s_dc6to64 IS
    PORT (
        a : IN std_logic_vector (5 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (63 DOWNTO 0)
    );
END l06p04s_dc6to64;

ARCHITECTURE l06p04s_dc6to64_behaviour OF l06p04s_dc6to64 IS
    COMPONENT l06p03b_dc3to8
        PORT (
            a : IN std_logic_vector (2 DOWNTO 0);
            enabled : IN std_logic;
            q : OUT std_logic_vector (7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL q_first_decoder : std_logic_vector (7 DOWNTO 0);
    SIGNAL q_first_decoder_invert : std_logic_vector (7 DOWNTO 0);
BEGIN
    decoder_1: l06p03b_dc3to8 PORT MAP (a(5 DOWNTO 3), enabled, q_first_decoder);

    q_first_decoder_invert <= not q_first_decoder;

    decoder_2: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(0), q(7 DOWNTO 0));
    decoder_3: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(1), q(15 DOWNTO 8));
    decoder_4: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(2), q(23 DOWNTO 16));
    decoder_5: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(3), q(31 DOWNTO 24));
    decoder_6: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(4), q(39 DOWNTO 32));
    decoder_7: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(5), q(47 DOWNTO 40));
    decoder_8: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(6), q(55 DOWNTO 48));
    decoder_9: l06p03b_dc3to8 PORT MAP (a(2 DOWNTO 0), q_first_decoder_invert(7), q(63 DOWNTO 56));
END l06p04s_dc6to64_behaviour;

CONFIGURATION l06p04s_dc6to64_configuration OF l06p04s_dc6to64 IS
    FOR l06p04s_dc6to64_behaviour
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
        : l06p03b_dc3to8
            USE ENTITY work.l06p03b_dc3to8 (l06p03b_dc3to8_behaviour);
        END FOR;
    END FOR;
END l06p04s_dc6to64_configuration;
