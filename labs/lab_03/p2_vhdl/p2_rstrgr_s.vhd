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
    -- Описание используемого компонента
    COMPONENT p1_nand2_b
        PORT(
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- Указание u1 и u2 как компонентов p1_nand2_b, а также указание их входов и выходов
    u1: p1_nand2_b PORT MAP (s, qb, q);
    u2: p1_nand2_b PORT MAP (q, r, qb);
END behav;

CONFIGURATION con OF p2_rstrgr_s IS
    FOR behav
        FOR u1, u2: p1_nand2_b
            -- Определяет интерфейс и модель компонента p1_nand2_b
            USE ENTITY work.p1_nand2_b (behavior);
        END FOR;
    END FOR;
END con;