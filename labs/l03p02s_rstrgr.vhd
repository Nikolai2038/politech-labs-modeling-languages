-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY p2_rstrgr_s IS
    -- Описание входов и выходов устройства
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p2_rstrgr_s;

ARCHITECTURE p2_rstrgr_s_behaviour OF p2_rstrgr_s IS
    -- Формальное описание используемого компонента
    COMPONENT p1_nand2_b
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- Указание unit_1 и unit_2 как компонентов p1_nand2_b, а также указание их входов и выходов
    unit_1: p1_nand2_b PORT MAP (s, qb, q);
    unit_2: p1_nand2_b PORT MAP (q, r, qb);
END p2_rstrgr_s_behaviour;

CONFIGURATION p2_rstrgr_s_configuration OF p2_rstrgr_s IS
    FOR p2_rstrgr_s_behaviour
        FOR unit_1, unit_2: p1_nand2_b
            -- Определяет интерфейс и модель компонента p1_nand2_b
            -- work - текущая рабочая директория
            USE ENTITY work.p1_nand2_b (p1_nand2_b_behaviour);
        END FOR;
    END FOR;
END p2_rstrgr_s_configuration;
