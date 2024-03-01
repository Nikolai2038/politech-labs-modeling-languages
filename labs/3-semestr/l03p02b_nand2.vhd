-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

-- Имя файла должно совпадать с указанным тут названием
ENTITY l03p02b_nand2 IS
    -- Описание входов и выходов устройства
    -- - IN - выход
    -- - OUT - выход
    -- - INOUT - двунаправленный сигнал
    PORT (
        a : IN std_logic;
        b : IN std_logic;
        c : INOUT std_logic
    );
END l03p02b_nand2;

ARCHITECTURE l03p02b_nand2_behaviour OF l03p02b_nand2 IS
BEGIN
    c <= NOT (a AND b);
END l03p02b_nand2_behaviour;
