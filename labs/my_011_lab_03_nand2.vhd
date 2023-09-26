-- Подключение библиотеки ieee
LIBRARY ieee;

-- Использование библиотечного модуля, содержащего дополнительные типы переменных
USE ieee.std_logic_1164.ALL;

-- Имя файла должно совпадать с указанным тут названием
ENTITY my_011_lab_03_nand2 IS
    -- Описание входов и выходов устройства
    -- - IN - выход
    -- - OUT - выход
    -- - INOUT - двунаправленный сигнал
    PORT(
        a : IN std_logic;
        b : IN std_logic;
        c : OUT std_logic
    );
END my_011_lab_03_nand2;

ARCHITECTURE my_011_lab_03_nand2_behaviour OF my_011_lab_03_nand2 IS
BEGIN
    c <= NOT ( a AND b );
END my_011_lab_03_nand2_behaviour;
