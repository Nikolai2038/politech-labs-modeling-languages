LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY p5_dtr_b IS
    PORT(
        d : IN std_logic;
        l : IN std_logic;
        q : INOUT std_logic
    );
END p5_dtr_b;

ARCHITECTURE behav OF p5_dtr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (d, l)
    BEGIN
        IF l='1' THEN
            qs <= qs;
        ELSE
            qs <= d;
        END IF;
    END PROCESS;
    q <= qs;
END behav;