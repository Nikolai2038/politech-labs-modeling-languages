-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

ENTITY l03p02s_rstrgr IS
    -- �������� ������ � ������� ����������
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END l03p02s_rstrgr;

ARCHITECTURE l03p02s_rstrgr_behaviour OF l03p02s_rstrgr IS
    -- ���������� �������� ������������� ����������
    COMPONENT l03p02b_nand2
        PORT (
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- �������� unit_1 � unit_l03p02b_nand2������� p1_nand2_b, � ����� �������� �� ������ � �������
    unit_1: l03p02b_nand2 PORT MAP (s, qb, q);
    unit_2: l03p02b_nand2 PORT MAP (q, r, qb);
END l03p02s_rstrgr_behaviour;

CONFIGURATION l03p02s_rstrgr_configuration OF l03p02s_rstrgr IS
    FOR l03p02s_rstrgr_behaviour
        FOR unit_1, unit_2: l03p02b_nand2
            -- ���������� ����l03p02b_nand2���� ���������� p1_nand2_b
            -- work - ������� ������� ����������
            USE ENTITY work.l03p02b_nand2 (l03p02b_nand2_behaviour);
        END FOR;
    END FOR;
END l03p02s_rstrgr_configuration;
