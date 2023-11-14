-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

-- ��� ����� ������ ��������� � ��������� ��� ���������
ENTITY l03p02b_nand2 IS
    -- �������� ������ � ������� ����������
    -- - IN - �����
    -- - OUT - �����
    -- - INOUT - ��������������� ������
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
