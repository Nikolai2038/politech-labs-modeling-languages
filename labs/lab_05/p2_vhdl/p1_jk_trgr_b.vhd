LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY p1_jk_trgr_b IS
    PORT (
        j : IN std_logic;
        k : IN std_logic;
        reset : IN std_logic;
        q : OUT std_logic
    );
END p1_jk_trgr_b;

ARCHITECTURE p1_jk_trgr_b_behaviour OF p1_jk_trgr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (reset, j, k) BEGIN
        IF reset = '1' THEN
            qs <= '0';
        ELSE
            IF j = '0' AND k = '0' THEN
                qs <= qs;
            ELSIF j = '0' AND k = '1' THEN
                qs <= '0';
            ELSIF j = '1' AND k = '0' THEN
                qs <= '1';
            ELSIF j = '1' AND k = '1' AND j'event THEN
                qs <= NOT qs;
            END IF;
        END IF;
    END PROCESS;

    q <= qs;
END p1_jk_trgr_b_behaviour;
