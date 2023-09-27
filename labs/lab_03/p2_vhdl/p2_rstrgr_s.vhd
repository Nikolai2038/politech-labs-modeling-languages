LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY p2_rstrgr_s IS
    PORT(
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p2_rstrgr_s;

ARCHITECTURE behav OF p2_rstrgr_s IS
    -- описание используемого компонента
    COMPONENT p1_nand2_b
        PORT(
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- указание u1,p1_notandомпонента notand
    u1: p1_nand2_b
    -- указание входов и выхода для u1
    PORT MAP (s, qb, q);

    u2: p1_nand2_b
    PORT MAP (q, r, qb);
END behav;

CONFIGURATION con OF p2_rstrgr_s IS
    FOR behav
        FOR u1, u2: p1_nand2_b
            -- определяет интеp1_notandи модель компонента notand
            USE ENTITY work.p1_nand2_b (behavior);
        END FOR;
    END FOR;
END con;