-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY l03p02b_rstrgr IS
    -- Описание входов и выходов устройства
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : OUT std_logic;
        qb : OUT std_logic
    );
END l03p02b_rstrgr;

ARCHITECTURE l03p02b_rstrgr_behaviour OF l03p02b_rstrgr IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (s, r) BEGIN
        IF s = '1' THEN
            IF r = '1' THEN
                qs <= qs;
            ELSE
                qs <= '0';
            END IF;
        ELSE
            qs <= '1';
        END IF;
    END PROCESS;

    q <= qs;
    qb <= NOT qs;
END l03p02b_rstrgr_behaviour;
