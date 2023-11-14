-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

ENTITY p2_rstrgr_s IS
    -- �������� ������ � ������� ����������
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p2_rstrgr_s;

ARCHITECTURE p2_rstrgr_s_behaviour OF p2_rstrgr_s IS
    -- ���������� �������� ������������� ����������
    COMPONENT p1_nand2_b
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- �������� unit_1 � unit_2 ��� ����������� p1_nand2_b, � ����� �������� �� ������ � �������
    unit_1: p1_nand2_b PORT MAP (s, qb, q);
    unit_2: p1_nand2_b PORT MAP (q, r, qb);
END p2_rstrgr_s_behaviour;

CONFIGURATION p2_rstrgr_s_configuration OF p2_rstrgr_s IS
    FOR p2_rstrgr_s_behaviour
        FOR unit_1, unit_2: p1_nand2_b
            -- ���������� ��������� � ������ ���������� p1_nand2_b
            -- work - ������� ������� ����������
            USE ENTITY work.p1_nand2_b (p1_nand2_b_behaviour);
        END FOR;
    END FOR;
END p2_rstrgr_s_configuration;
