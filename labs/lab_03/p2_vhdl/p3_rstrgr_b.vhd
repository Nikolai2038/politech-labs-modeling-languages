-- ����������� ���������� ieee
LIBRARY ieee;

-- ������������� ������������� ������, ����������� �������������� ���� ����������
USE ieee.std_logic_1164.ALL;

ENTITY p3_rstrgr_b IS
    -- �������� ������ � ������� ����������
    PORT (
        s : IN std_logic;
        r : IN std_logic;
        q : OUT std_logic;
        qb : OUT std_logic
    );
END p3_rstrgr_b;

ARCHITECTURE p3_rstrgr_b_behaviour OF p3_rstrgr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (s, r) BEGIN
        IF s = '1' THEN
            IF r = '1' THEN
                qs <= qs;
            ELSE
                qs <= '0';
            END IF;
        ELSE
            qs <= '1';
        END IF;
    END PROCESS;

    q <= qs;
    qb <= NOT qs;
END p3_rstrgr_b_behaviour;
