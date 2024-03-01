-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY l03p04s_dtrgr IS
    -- Описание входов и выходов устройства
    PORT (
        d : IN std_logic;
        l : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END l03p04s_dtrgr;

ARCHITECTURE l03p04s_dtrgr_behaviour OF l03p04s_dtrgr IS
    COMPONENT l03p02b_nand2
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;

    COMPONENT l03p02s_rstrgr
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
    unit_1: l03p02b_nand2  PORT MAP (d, l, s);
    unit_2: l03p02b_nand2  PORT MAP (s, l, r);
    unit_3: l03p02s_rstrgr PORT MAP (s, r, q, qb);
END l03p04s_dtrgr_behaviour;

CONFIGURATION l03p04s_dtrgr_configuration OF l03p04s_dtrgr IS
    FOR l03p04s_dtrgr_behaviour
        FOR unit_1, unit_2: l03p02b_nand2
            USE ENTITY work.l03p02b_nand2 (l03p02b_nand2_behaviour);
        END FOR;

        FOR unit_3: l03p02s_rstrgr
            USE ENTITY work.l03p02s_rstrgr (l03p02s_rstrgr_behaviour);
        END FOR;
    END FOR;
END l03p04s_dtrgr_configuration;
