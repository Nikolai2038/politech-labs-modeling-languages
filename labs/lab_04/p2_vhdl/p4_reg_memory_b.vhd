-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY p4_reg_memory_b IS
    -- Описание входов и выходов устройства
    PORT (
        x1 : IN std_logic;
        x2 : IN std_logic;
        x3 : IN std_logic;
        x4 : IN std_logic;
        write : IN std_logic;
        reset : IN std_logic;
        read : IN std_logic;
        q1 : OUT std_logic;
        q2 : OUT std_logic;
        q3 : OUT std_logic;
        q4 : OUT std_logic;
        q5 : OUT std_logic;
        q6 : OUT std_logic;
        q7 : OUT std_logic;
        q8 : OUT std_logic
    );
END p4_reg_memory_b;

ARCHITECTURE p4_reg_memory_b_behaviour OF p4_reg_memory_b IS
    SIGNAL qs1:std_logic;
    SIGNAL qs2:std_logic;
    SIGNAL qs3:std_logic;
    SIGNAL qs4:std_logic;
    SIGNAL qs5:std_logic;
    SIGNAL qs6:std_logic;
    SIGNAL qs7:std_logic;
    SIGNAL qs8:std_logic;
BEGIN
    PROCESS (write, reset) BEGIN
        IF reset = '0' THEN
            qs1 <= '0';
            qs3 <= '0';
            qs5 <= '0';
            qs7 <= '0';
        ELSE
            IF write = '1' THEN
                qs1 <= x1;
                qs3 <= x2;
                qs5 <= x3;
                qs7 <= x4;
            END IF;
        END IF;

        qs2 <= qs1 AND read;
        qs4 <= qs3 AND read;
        qs6 <= qs5 AND read;
        qs8 <= qs7 AND read;
    END PROCESS;

    q1 <= qs1;
    q2 <= qs2;
    q3 <= qs3;
    q4 <= qs4;
    q5 <= qs5;
    q6 <= qs6;
    q7 <= qs7;
    q8 <= qs8;
END p4_reg_memory_b_behaviour;
