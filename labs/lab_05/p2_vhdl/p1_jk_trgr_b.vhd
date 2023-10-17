LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY p1_jk_trgr_b IS
    PORT (
        j : IN std_logic;
        k : IN std_logic;
        reset : IN std_logic;
        clock : IN std_logic;
        q : OUT std_logic
    );
END p1_jk_trgr_b;

ARCHITECTURE p1_jk_trgr_b_behaviour OF p1_jk_trgr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (reset, j, k, clock) BEGIN
        IF reset = '1' THEN
            qs <= '0';
        ELSIF clock = '1' AND clock'event THEN
            IF j = '0' AND k = '0' THEN
                qs <= qs;
            ELSIF j = '0' AND k = '1' THEN
                qs <= '0';
            ELSIF j = '1' AND k = '0' THEN
                qs <= '1';
            ELSIF j = '1' AND k = '1' THEN
                qs <= NOT qs;
            END IF;
        ELSE
            qs <= qs;
        END IF;
    END PROCESS;

    q <= qs;
END p1_jk_trgr_b_behaviour;
