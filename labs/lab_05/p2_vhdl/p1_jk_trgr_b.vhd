LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY p1_jk_trgr_b IS
    PORT (
        j : IN std_logic;
        k : IN std_logic;
        q1 : OUT std_logic;
        q2 : OUT std_logic
    );
END p1_jk_trgr_b;

ARCHITECTURE p1_jk_trgr_b_behaviour OF p1_jk_trgr_b IS
    SIGNAL qs1:std_logic;
    SIGNAL qs2:std_logic;
BEGIN
    PROCESS BEGIN
        IF r = '0' THEN
            qs1 <= '0';
            qs3 <= '0';
        ELSE
            IF c1 = '1' THEN
                qs1 <= d;
                qs3 <= qs2;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (c2, r) BEGIN
        IF r = '0' THEN
            qs2 <= '0';
            qs4 <= '0';
        ELSE
            IF c2 = '1' THEN
                qs2 <= qs1;
                qs4 <= qs3;
            END IF;
        END IF;
    END PROCESS;

    q1 <= qs1;
    q2 <= qs2;
    q3 <= qs3;
    q4 <= qs4;
END p1_jk_trgr_b_behaviour;
