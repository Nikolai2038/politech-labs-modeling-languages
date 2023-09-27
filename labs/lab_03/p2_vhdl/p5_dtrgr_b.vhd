LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY p5_dtrgr_b IS
    PORT (
        d : IN std_logic;
        l : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END p5_dtrgr_b;

ARCHITECTURE p5_dtrgr_b_behaviour OF p5_dtrgr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (d, l) BEGIN
        IF l = '1' THEN
            qs <= qs;
        ELSE
            qs <= d;
        END IF;
    END PROCESS;

    q <= qs;
    qb <= NOT qs;
END p5_dtrgr_b_behaviour;