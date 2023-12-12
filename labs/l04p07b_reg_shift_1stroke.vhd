-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

ENTITY l04p07b_reg_shift_1stroke IS
    -- Описание входов и выходов устройства
    PORT (
        d : IN std_logic;
        c : IN std_logic;
        r : IN std_logic;
        q1 : OUT std_logic;
        q2 : OUT std_logic;
        q3 : OUT std_logic;
        q4 : OUT std_logic
    );
END l04p07b_reg_shift_1stroke;

ARCHITECTURE l04p07b_reg_shift_1stroke_behaviour OF l04p07b_reg_shift_1stroke IS
    SIGNAL qs1:std_logic;
    SIGNAL qs2:std_logic;
    SIGNAL qs3:std_logic;
    SIGNAL qs4:std_logic;
BEGIN
    PROCESS (c, r) BEGIN
        IF r = '0' THEN
            qs1 <= '0';
            qs2 <= '0';
            qs3 <= '0';
            qs4 <= '0';
        ELSE
            IF c = '1' THEN
                qs1 <= d;
                qs3 <= qs2;
            ELSE
                qs2 <= qs1;
                qs4 <= qs3;
            END IF;
        END IF;
    END PROCESS;

    q1 <= qs1;
    q2 <= qs2;
    q3 <= qs3;
    q4 <= qs4;
END l04p07b_reg_shift_1stroke_behaviour;
