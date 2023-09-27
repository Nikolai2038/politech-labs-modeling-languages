-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

-- Имя файла должно совпадать с указанным тут названием
ENTITY p1_nand2_b IS
    -- Описание входов и выходов устройства
    -- - IN - выход
    -- - OUT - выход
    -- - INOUT - двунаправленный сигнал
    PORT(
        a : IN std_logic;
        b : IN std_logic;
        c : INOUT std_logic
    );
END p1_nand2_b;

ARCHITECTURE behavior OF p1_nand2_b IS
BEGIN
    c <= NOT (a AND b);
END behavior;
