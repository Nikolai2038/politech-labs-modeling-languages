-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY l03p02s_rstrgr IS
    -- Описание входов и выходов устройства
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END l03p02s_rstrgr;

ARCHITECTURE l03p02s_rstrgr_behaviour OF l03p02s_rstrgr IS
    -- Формальное описание используемого компонента
    COMPONENT l03p02b_nand2
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- Указание unit_1 и unit_l03p02b_nand2онентов p1_nand2_b, а также указание их входов и выходов
    unit_1: l03p02b_nand2 PORT MAP (s, qb, q);
    unit_2: l03p02b_nand2 PORT MAP (q, r, qb);
END l03p02s_rstrgr_behaviour;

CONFIGURATION l03p02s_rstrgr_configuration OF l03p02s_rstrgr IS
    FOR l03p02s_rstrgr_behaviour
        FOR unit_1, unit_2: l03p02b_nand2
            -- Определяет интеl03p02b_nand2дель компонента p1_nand2_b
            -- work - текущая рабочая директория
            USE ENTITY work.l03p02b_nand2 (l03p02b_nand2_behaviour);
        END FOR;
    END FOR;
END l03p02s_rstrgr_configuration;
