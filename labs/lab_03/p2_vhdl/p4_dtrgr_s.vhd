-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY p4_dtrgr_s IS
    -- Описание входов и выходов устройства
    PORT (
        d : IN std_logic;
        l : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p4_dtrgr_s;

ARCHITECTURE p4_dtrgr_s_behaviour OF p4_dtrgr_s IS
    COMPONENT p1_nand2_b
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;

    COMPONENT p2_rstrgr_s
        PORT (
            s : IN std_logic;
            r : IN std_logic;
            q : INOUT std_logic;
            qb : INOUT std_logic
        );
    END COMPONENT;

    SIGNAL s:std_logic;
    SIGNAL r:std_logic;
BEGIN
    unit_1: p1_nand2_b  PORT MAP (d, l, s);
    unit_2: p1_nand2_b  PORT MAP (s, l, r);
    unit_3: p2_rstrgr_s PORT MAP (s, r, q, qb);
END p4_dtrgr_s_behaviour;

CONFIGURATION p4_dtrgr_s_configuration OF p4_dtrgr_s IS
    FOR p4_dtrgr_s_behaviour
        FOR unit_1, unit_2: p1_nand2_b
            USE ENTITY work.p1_nand2_b (p1_nand2_b_behaviour);
        END FOR;

        FOR unit_3: p2_rstrgr_s
            USE ENTITY work.p2_rstrgr_s (p2_rstrgr_s_behaviour);
        END FOR;
    END FOR;
END p4_dtrgr_s_configuration;
