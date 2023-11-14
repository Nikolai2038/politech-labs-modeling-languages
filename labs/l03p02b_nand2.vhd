-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

-- ��� ����� ������ ��������� � ��������� ��� ���������
ENTITY p1_nand2_b IS
    -- �������� ������ � ������� ����������
    -- - IN - �����
    -- - OUT - �����
    -- - INOUT - ��������������� ������
    PORT (
        a : IN std_logic;
        b : IN std_logic;
        c : INOUT std_logic
    );
END p1_nand2_b;

ARCHITECTURE p1_nand2_b_behaviour OF p1_nand2_b IS
BEGIN
    c <= NOT (a AND b);
END p1_nand2_b_behaviour;
