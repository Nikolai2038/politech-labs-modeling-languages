-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

-- ��� ����� ������ ��������� � ��������� ��� ���������
ENTITY my_011_lab_03_nand2 IS
    -- �������� ������ � ������� ����������
    -- - IN - �����
    -- - OUT - �����
    -- - INOUT - ��������������� ������
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
