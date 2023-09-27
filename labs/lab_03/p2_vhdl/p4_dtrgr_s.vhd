LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY p4_dtrgr_s IS
    PORT(
        d : IN std_logic;
        l : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p4_dtrgr_s;

ARCHITECTURE behav OF p4_dtrgr_s IS
    COMPONENT p1_nand2_b
        PORT(
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;

    COMPONENT p2_rstrgr_s
        PORT(
            s : IN std_logic;
            r : IN std_logic;
            q : INOUT std_logic;
            qb : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    u1: p1_nand2_b  PORT MAP (d, l, s);
    u2: p1_nand2_b  PORT MAP (s, l, r);
    u3: p2_rstrgr_s PORT MAP (s, r, q, qb);
END behav;

CONFIGURATION con OF p4_dtrgr_s IS
    FOR behav
        FOR u1, u2: p1_nand2_b
            USE ENTITY work.p1_nand2_b (behavior);
        END FOR;

        FOR u3: p2_rstrgr_s
            USE ENTITY work.p2_rstrgr_s (behavior);
        END FOR;
    END FOR;
END con;