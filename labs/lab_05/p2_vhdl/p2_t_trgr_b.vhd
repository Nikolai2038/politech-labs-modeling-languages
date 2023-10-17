LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY p2_t_trgr_b IS
    PORT (
        t : IN std_logic;
        reset : IN std_logic;
        q : OUT std_logic
    );
END p2_t_trgr_b;

ARCHITECTURE p2_t_trgr_b_behaviour OF p2_t_trgr_b IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (reset, t) BEGIN
        IF reset = '1' THEN
            qs <= '0';
        ELSE
            IF t = '1' AND t'event THEN
                qs <= NOT qs;
            ELSE
                qs <= qs;
            END IF;
        END IF;
    END PROCESS;

    q <= qs;
END p2_t_trgr_b_behaviour;
